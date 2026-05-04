import db from "../config/database.js";
import fs from "fs";
import path from "path";
/* ===========================
   ALL SERVICEMAN LIST
=========================== */

/* ===========================
   ALL SERVICEMAN LIST
=========================== */
export const allServiceman = async (req, res) => {
  try {
    const perPage = parseInt(req.query.perPage) || 8;
    const page = parseInt(req.query.page) || 1;
    const offset = (page - 1) * perPage;

    const { from = "", to = "", search = "" } = req.query;
    const status = req.params.status || req.query.status || "";

    /* ================= CATEGORY FROM GET ================= */
    const selectedCategories = req.query.categories
      ? Array.isArray(req.query.categories)
        ? req.query.categories
        : [req.query.categories]
      : [];

    let where = "WHERE 1 ";
    let values = [];

    /* ================= DATE FILTER ================= */
    if (from && to) {
      where += " AND DATE(s.created_at) BETWEEN ? AND ? ";
      values.push(from, to);
    }

    /* ================= STATUS FILTER ================= */
    if (status === "1") {
      where += " AND s.login_status = 1 ";
    } else if (status === "0") {
      where += " AND s.login_status = 0 ";
    } else if (status === "3") {
      where += " AND s.online_status = 0 ";
    } else if (status === "4") {
      where += " AND s.online_status = 1 ";
    }

    /* ================= SEARCH ================= */
    if (search && search.trim() !== "") {
      const clean = search.trim();
      const parts = clean.split(/\s+/);

      const conditions = [];
      const localValues = [];

      conditions.push(`s.mobile LIKE ?`);
      localValues.push(`%${clean}%`);

      conditions.push(`s.first_name LIKE ?`);
      localValues.push(`%${clean}%`);

      conditions.push(`s.last_name LIKE ?`);
      localValues.push(`%${clean}%`);

      if (parts.length >= 2) {
        conditions.push(`(s.first_name LIKE ? AND s.last_name LIKE ?)`);
        localValues.push(`%${parts[0]}%`, `%${parts[1]}%`);
      }

      where += ` AND ( ${conditions.join(" OR ")} ) `;
      values.push(...localValues);
    }

    /* ================= CATEGORY FILTER (LIKE BASED) ================= */
    if (selectedCategories.length > 0) {
      selectedCategories.forEach((catId) => {
        where += ` AND (
          s.service_category LIKE ? OR
          s.service_category LIKE ? OR
          s.service_category LIKE ? OR
          s.service_category = ?
        )`;

        values.push(
          `[${catId},%`,
          `%,${catId},%`,
          `%,${catId}]`,
          `${catId}`
        );
      });
    }

    /* ================= COUNT ================= */
    const [[{ total }]] = await db.query(
      `SELECT COUNT(DISTINCT s.id) AS total FROM serviceman s ${where}`,
      values
    );

    /* ================= DATA ================= */
 const [rows] = await db.query(
  `
  SELECT 
    s.*,
    (
      SELECT GROUP_CONCAT(srv.title ORDER BY srv.title SEPARATOR ', ')
      FROM services srv
      WHERE FIND_IN_SET(
        srv.id,
        REPLACE(REPLACE(REPLACE(s.service_category,'[',''),']',''),' ','')
      )
    ) AS service_name
  FROM serviceman s
  ${where}
  ORDER BY s.id DESC
  LIMIT ? OFFSET ?
  `,
  [...values, perPage, offset]
);

    /* ================= ACTIVE CATEGORIES ================= */
    const [categories] = await db.query(`
      SELECT id, name
      FROM categories
      WHERE status = 1
      ORDER BY name ASC
    `);
    
   

    return res.render("serviceman/allServiceman", {
      title: "Serviceman List",
      servicemen: rows,
      categories,
      selectedCategories,
      total,
      page,
      perPage,
      totalPages: Math.ceil(total / perPage),
      from,
      to,
      status,
      search,
      isFiltered: Boolean(
        from || to || status || search || selectedCategories.length
      ),
    });

  } catch (err) {
    console.error("❌ SERVICEMAN LIST ERROR:", err);

    return res.render("serviceman/allServiceman", {
      title: "Serviceman List",
      servicemen: [],
      categories: [],
      selectedCategories: [],
      total: 0,
      page: 1,
      perPage: 8,
      totalPages: 1,
      from: "",
      to: "",
      status: "",
      search: "",
      isFiltered: false,
      error: "Something went wrong!",
    });
  }
};





export const deleteServiceman = async (req, res) => {
  try {
    const { id } = req.params;

    if (!id) {
      req.session.error = "Invalid ID!";
      return res.redirect("back");
    }

    // 🔥 1. GET SERVICEMAN DATA
    const [[serviceman]] = await db.query(
      `SELECT profile_photo, aadhaar_front, aadhaar_back 
       FROM serviceman WHERE id = ?`,
      [id]
    );

    if (!serviceman) {
      req.session.error = "Serviceman not found!";
      return res.redirect("back");
    }

    // 🔥 2. DELETE FILE FUNCTION
    const deleteFile = (filePath) => {
      if (!filePath) return;

      const fullPath = path.join(process.cwd(), filePath);

      if (fs.existsSync(fullPath)) {
        fs.unlinkSync(fullPath);
        console.log("🗑 Deleted:", fullPath);
      }
    };

    // 🔥 3. DELETE ALL FILES
    deleteFile(serviceman.profile_photo);
    deleteFile(serviceman.aadhaar_front);
    deleteFile(serviceman.aadhaar_back);

    // 🔥 4. DELETE FROM DB
    await db.query(`DELETE FROM serviceman WHERE id = ?`, [id]);

    req.session.success = "Serviceman deleted successfully!";
    return res.redirect("/serviceman");

  } catch (err) {
    console.log("DELETE SERVICEMAN ERROR:", err);
    req.session.error = "Something went wrong!";
    return res.redirect("back");
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
