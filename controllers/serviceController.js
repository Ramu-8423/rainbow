import db from "../config/database.js";

export const allServisesa = async (req, res) => {
  try {
    const perPage = parseInt(req.query.perPage) || 8;
    const page = parseInt(req.query.page) || 1;
    const offset = (page - 1) * perPage;

    const { from, to } = req.query;
    const status = req.params.id; // 🔹 id = status

    let where = "WHERE s.status = ?";
    let values = [status];

    if (from && to) {
      where += " AND DATE(s.created_at) BETWEEN ? AND ?";
      values.push(from, to);
    }

    // 🔹 TOTAL COUNT
    const [[{ total }]] = await db.query(
      `
      SELECT COUNT(*) AS total
      FROM services s
      INNER JOIN categories c ON c.id = s.category_id
      INNER JOIN subcategories sc ON sc.id = s.subcategory_id
      ${where}
      `,
      values
    );

    // 🔹 DATA WITH JOIN
    const [rows] = await db.query(
      `
      SELECT 
        s.id,
        s.title,
        s.description,
        s.image AS service_image,
        s.price,
        s.rating,
        s.faqs,
        s.status,
        s.created_at,

        c.id AS category_id,
        c.name AS category_name,
        c.image AS category_image,

        sc.id AS subcategory_id,
        sc.name AS subcategory_name,
        sc.image AS subcategory_image

      FROM services s
      INNER JOIN categories c ON c.id = s.category_id
      INNER JOIN subcategories sc ON sc.id = s.subcategory_id

      ${where}
      ORDER BY s.id DESC
      LIMIT ? OFFSET ?
      `,
      [...values, perPage, offset]
    );

    // ✅ ONLY THIS LOG
    console.log("ROWS =>", rows);

    return res.render("Service/allservises", {
      title: "All Services",
      services: rows,
      total,
      perPage,
      page,
      totalPages: Math.ceil(total / perPage),
      from,
      to,
      isFiltered: Boolean(from && to),
      status
    });

  } catch (err) {
    console.log("Services Fetch Error:", err);
    req.session.error = "Something went wrong!";
    return res.redirect(`/servises/${req.params.id}`);
  }
};
