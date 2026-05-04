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
<<<<<<< HEAD
=======
        s.top_servises_status,
>>>>>>> 49d7cd4 (initial push from server)
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

<<<<<<< HEAD
    // ✅ LOG
    console.log("ROWS =>", rows);
=======

>>>>>>> 49d7cd4 (initial push from server)

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
<<<<<<< HEAD
    return res.redirect(`/servises/${req.params.id}`);
=======
    return res.redirect(`/service/${req.params.id}`);
>>>>>>> 49d7cd4 (initial push from server)
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
<<<<<<< HEAD
    return res.redirect(`/servises/${status ?? 1}`);
=======
    return res.redirect(`/service/${status ?? 1}`);
>>>>>>> 49d7cd4 (initial push from server)

  } catch (err) {
    console.log("STORE SERVICE ERROR:", err);
    req.session.error = "Something went wrong!";
<<<<<<< HEAD
    return res.redirect(`/servises/${status ?? 1}`);
=======
    return res.redirect(`/service/${status ?? 1}`);
  }
}




export async function updateService(req, res) {
  try {
    const {
      service_id,
      title,
      description,
      price,
      status,
      faqs,
      old_image,
      faq_q,
      faq_a
    } = req.body;

    /* ---------------- IMAGE ---------------- */
    const folderName = "serviceImage";
    let imagePath = old_image || null;

    if (req.file) {
      imagePath = `${folderName}/${req.file.filename}`;
    }

    /* ---------------- FAQS ---------------- */
    let faqsArray = [];

    // Case 1: frontend sends JSON string
    if (faqs && faqs.trim() !== "") {
      try {
        const parsed = JSON.parse(faqs);
        if (Array.isArray(parsed)) {
          faqsArray = parsed;
        }
      } catch {}
    }

    // Case 2: frontend sends faq_q[] & faq_a[]
    if (
      faqsArray.length === 0 &&
      Array.isArray(faq_q) &&
      Array.isArray(faq_a)
    ) {
      faq_q.forEach((q, i) => {
        if (q && faq_a[i]) {
          faqsArray.push({
            id: i + 1,
            question: q,
            answer: faq_a[i]
          });
        }
      });
    }

    const faqsJson = JSON.stringify(faqsArray);

    /* ---------------- UPDATE DB ---------------- */
    await db.query(
      `
      UPDATE services SET
        title = ?,
        description = ?,
        image = ?,
        price = ?,
        faqs = ?,
        status = ?
      WHERE id = ?
      `,
      [
        title,
        description,
        imagePath,
        price,
        faqsJson,
        status,
        service_id
      ]
    );

    req.session.success = "Service updated successfully!";
    return res.redirect(`/service/${status}`);

  } catch (err) {
    req.session.error = "Something went wrong!";
    return res.redirect("back");
>>>>>>> 49d7cd4 (initial push from server)
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
<<<<<<< HEAD
    return res.redirect(`/servises/${status}`);
=======
    return res.redirect(`/service/${status}`);
>>>>>>> 49d7cd4 (initial push from server)

  } catch (err) {
    console.log("SERVICE STATUS UPDATE ERROR:", err);
    req.session.error = "Something went wrong!";
    return res.redirect("back");
  }
}


<<<<<<< HEAD
=======

export async function updateTopServicesStatus(req, res) {
  try {
    const { id } = req.params;
    const { top_services_status } = req.query;

    if (!id || top_services_status === undefined) {
      req.session.error = "Invalid request!";
      return res.redirect(`/service/0`);
    }

    // 🔎 If activating as Top Service
    if (top_services_status == 1) {

      const [rows] = await db.query(
        `
        SELECT COUNT(*) as total
        FROM services
        WHERE top_servises_status = 1
        AND id != ?
        `,
        [id]
      );

      if (rows[0].total >= 6) {
        req.session.error =
          "Maximum 6 services can be selected as Top Services!";
        return res.redirect(`/service/1`);
      }
    }

    await db.query(
      `
      UPDATE services
      SET top_servises_status = ?
      WHERE id = ?
      `,
      [top_services_status, id]
    );

    req.session.success =
      top_services_status == 1
        ? "Service added to Top Services successfully!"
        : "Service removed from Top Services successfully!";

    // ✅ Same redirect style as service status
    return res.redirect(`/service/1`);

  } catch (err) {
    console.log("TOP SERVICE STATUS UPDATE ERROR:", err);
    req.session.error = "Something went wrong!";
    return res.redirect(`/service/0`);
  }
}



>>>>>>> 49d7cd4 (initial push from server)
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

<<<<<<< HEAD
    return res.redirect(`/servises/${status}`);
=======
    return res.redirect(`/service/${status}`);
>>>>>>> 49d7cd4 (initial push from server)

  } catch (err) {
    console.log("SERVICE DELETE ERROR:", err);
    req.session.error = "Something went wrong!";
    return res.redirect("back");
  }
}

