import db from "../config/database.js";

/* ===========================
   ALL SERVICEMAN LIST
=========================== */
export const allServiceman = async (req, res) => {
  try {
    const perPage = parseInt(req.query.perPage) || 8;
    const page = parseInt(req.query.page) || 1;
    const offset = (page - 1) * perPage;

    const { from, to, status } = req.query;

    let where = "WHERE 1 ";
    let values = [];

    // DATE FILTER
    if (from && to) {
      where += "AND DATE(s.created_at) BETWEEN ? AND ? ";
      values.push(from, to);
    }

    // STATUS FILTER (login_status)
    if (status === "1") {
      where += "AND s.login_status = 1 ";
    } else if (status === "0") {
      where += "AND s.login_status = 0 ";
    }

    /* ================= COUNT ================= */
    const [[{ total }]] = await db.query(
      `
      SELECT COUNT(DISTINCT s.id) AS total
      FROM serviceman s
      LEFT JOIN categories c
        ON JSON_CONTAINS(s.service_category, CAST(c.id AS JSON))
      ${where}
      `,
      values
    );

    /* ================= DATA ================= */
    const [rows] = await db.query(
      `
      SELECT 
        s.*,
        GROUP_CONCAT(DISTINCT c.name ORDER BY c.name SEPARATOR ', ') 
          AS service_name
      FROM serviceman s
      LEFT JOIN categories c
        ON JSON_CONTAINS(s.service_category, CAST(c.id AS JSON))
      ${where}
      GROUP BY s.id
      ORDER BY s.id DESC
      LIMIT ? OFFSET ?
      `,
      [...values, perPage, offset]
    );

    return res.render("serviceman/allServiceman", {
      title: "Serviceman List",
      servicemen: rows,
      total,
      page,
      perPage,
      totalPages: Math.ceil(total / perPage),
      from,
      to,
      status,
      isFiltered: Boolean(from && to),
    });

  } catch (err) {
    console.log("SERVICEMAN LIST ERROR:", err);
    return res.render("serviceman/allServiceman", {
      title: "Serviceman List",
      servicemen: [],
      total: 0,
      page: 1,
      perPage: 8,
      totalPages: 1,
      error: "Something went wrong!"
    });
  }
};


/* ===========================
   UPDATE SERVICEMAN STATUS
=========================== */
export const updateServicemanStatus = async (req, res) => {
  try {
    const id = req.params.id;
    const status = parseInt(req.query.status);
    const reason = req.query.reason || null;

    if (!id || isNaN(status)) {
      req.session.error = "Invalid request.";
      return res.redirect("/serviceman");
    }

    let sql = "";
    let params = [];

    // ACTIVATE
    if (status === 1) {
      sql = `
        UPDATE serviceman
        SET login_status = ?, reject_reasion = NULL
        WHERE id = ?
      `;
      params = [1, id];
      req.session.success = "Serviceman activated successfully.";
    }

    // DEACTIVATE
    else if (status === 0) {
      sql = `
        UPDATE serviceman
        SET login_status = ?, reject_reasion = ?
        WHERE id = ?
      `;
      params = [0, reason, id];
      req.session.success = "Serviceman deactivated successfully.";
    }

    await db.query(sql, params);
    return res.redirect("/serviceman");

  } catch (err) {
    console.log("SERVICEMAN STATUS ERROR:", err);
    req.session.error = "Something went wrong!";
    return res.redirect("/serviceman");
  }
};
