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

    // 🔹 SERVICES DATA
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

    // 🔹 ALL CATEGORIES
    const [categories] = await db.query(
      `
      SELECT id, name, image
      FROM categories
      WHERE status = 1
      ORDER BY id DESC
      `
    );

    // 🔹 ALL SUBCATEGORIES
    const [subcategories] = await db.query(
      `
      SELECT id, category_id, name, image
      FROM subcategories
      WHERE status = 1
      ORDER BY id DESC
      `
    );

    // ✅ LOG
    console.log("ROWS =>", rows);

    return res.render("Service/allservises", {
      title: "All Services",
      services: rows,

      // 🔹 NEW DATA (ADDED ONLY)
      categories,
      subcategories,

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


export async function getSubcategoriesByCategory(req, res) {
  try {
    const { category_id } = req.params;

    if (!category_id) {
      return res.json([]);
    }

    const [rows] = await db.query(
      `
      SELECT id, name
      FROM subcategories
      WHERE category_id = ?
        AND status = 1
      ORDER BY name ASC
      `,
      [category_id]
    );

    return res.json(rows);

  } catch (err) {
    console.log("Subcategory AJAX Error:", err);
    return res.json([]);
  }
}


export async function storeService(req, res) {
  try {
    const {
      category_id,
      subcategory_id,
      title,
      description,
      price,
      status,
      faqs
    } = req.body;

    const folderName = "serviceImage";
    let imagePath = null;

    // 🖼 Image Upload Handling
    if (req.file) {
      imagePath = `${folderName}/${req.file.filename}`;
    }

    // ✅ FAQs SAFE HANDLING
    let faqsJson = JSON.stringify([]);

    if (faqs) {
      try {
        const parsed = JSON.parse(faqs);
        faqsJson = Array.isArray(parsed)
          ? JSON.stringify(parsed)
          : JSON.stringify([]);
      } catch {
        faqsJson = JSON.stringify([]);
      }
    }

    // 🧾 DB INSERT (MATCHING COLUMNS & VALUES)
    await db.query(
      `
      INSERT INTO services
      (
        category_id,
        subcategory_id,
        title,
        description,
        image,
        price,
        faqs,
        status,
        created_at
      )
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())
      `,
      [
        category_id,
        subcategory_id,
        title,
        description,
        imagePath,
        price,
        faqsJson,
        status ?? 1
      ]
    );

    // ✅ SUCCESS
    req.session.success = "Service added successfully!";
    return res.redirect(`/servises/${status ?? 1}`);

  } catch (err) {
    console.log("STORE SERVICE ERROR:", err);
    req.session.error = "Something went wrong!";
    return res.redirect(`/servises/${status ?? 1}`);
  }
}



export async function updateServiceStatus(req, res) {
  try {
    const { id } = req.params;
    const { status } = req.query;

    // ❌ invalid request
    if (!id || status === undefined) {
      req.session.error = "Invalid request!";
      return res.redirect("back");
    }

    // ✅ ONLY STATUS UPDATE
    await db.query(
      `
      UPDATE services
      SET status = ?
      WHERE id = ?
      `,
      [status, id]
    );

    // ✅ SUCCESS MESSAGE
    req.session.success =
      status == 1
        ? "Service activated successfully!"
        : "Service deactivated successfully!";

    // 🔁 redirect same listing
    return res.redirect(`/servises/${status}`);

  } catch (err) {
    console.log("SERVICE STATUS UPDATE ERROR:", err);
    req.session.error = "Something went wrong!";
    return res.redirect("back");
  }
}


export async function deleteService(req, res) {
  try {
    const { id } = req.params;
    const { status } = req.query;

    if (!id || status === undefined) {
      req.session.error = "Invalid request!";
      return res.redirect("back");
    }

    await db.query(
      `DELETE FROM services WHERE id = ?`,
      [id]
    );

    req.session.success = "Service deleted successfully!";

    return res.redirect(`/servises/${status}`);

  } catch (err) {
    console.log("SERVICE DELETE ERROR:", err);
    req.session.error = "Something went wrong!";
    return res.redirect("back");
  }
}

