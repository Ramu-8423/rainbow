import db from "../config/database.js";




export const allUsers = async (req, res) => {
  try {
    const perPage = parseInt(req.query.perPage) || 8;
    const page = parseInt(req.query.page) || 1;
    const offset = (page - 1) * perPage;

    const { from, to, status } = req.query;

    let where = "WHERE 1 ";
    let values = [];

    // DATE FILTER
    if (from && to) {
      where += "AND DATE(created_at) BETWEEN ? AND ? ";
      values.push(from, to);
    }

    // STATUS FILTER
    if (status === "1") {
      where += "AND status = 1 ";
    } else if (status === "0") {
      where += "AND status = 0 ";
    }

    // COUNT
    const [[{ total }]] = await db.query(
      `SELECT COUNT(*) AS total FROM users ${where}`,
      values
    );

    // DATA
    const [rows] = await db.query(
      `SELECT * FROM users ${where}
       ORDER BY id DESC 
       LIMIT ? OFFSET ?`,
      [...values, perPage, offset]
    );

    return res.render("users/allUsers", {
      title: "Users List",
      users: rows,
      total,
      page,
      perPage,
      totalPages: Math.ceil(total / perPage),
      from,
      to,
      status,                    // ⭐ send status to EJS
      isFiltered: Boolean(from && to),
    });

  } catch (err) {
    return res.render("users/allUsers", {
      title: "Users List",
      users: [],
      total: 0,
      page: 1,
      perPage: 8,
      totalPages: 1,
      error: "Something went wrong!"
    });
  }
};




export const updateUserStatus = async (req, res) => {
  try {
    const id = req.params.id;
    const status = parseInt(req.query.status);
    const reason = req.query.reason || null;

    if (!id || isNaN(status)) {
      req.session.error = "Invalid request.";
      return res.redirect("/all-users");
    }

    let sql = "";
    let params = [];

    // Changing to Active
    if (status === 1) {
      sql = "UPDATE users SET status = ?, reason = NULL WHERE id = ?";
      params = [1, id];

      req.session.success = "User activated successfully.";
    }

    // Changing to Inactive
    else if (status === 0) {
      sql = "UPDATE users SET status = ?, reason = ? WHERE id = ?";
      params = [0, reason, id];

      req.session.success = "User deactivated successfully.";
    }

    await db.query(sql, params);

    return res.redirect("/all-users");

  } catch (err) {
    console.log("Status Update Error:", err);
    req.session.error = "Something went wrong while updating status.";
    return res.redirect("/all-users");
  }
};





export const jobApplication = async (req, res) => {
  try {
    const perPage = 8;
    const page = parseInt(req.query.page) || 1;
    const offset = (page - 1) * perPage;

    const { from, to } = req.query;

    let where = "";
    let values = [];

    // If date filter applied
    if (from && to) {
      where = "WHERE DATE(created_at) BETWEEN ? AND ?";
      values.push(from, to);
    }

    // Total count
    const [[{ total }]] = await db.query(
      `SELECT COUNT(*) AS total FROM job_request ${where}`,
      values
    );

    // Pagination data fetch
    const [rows] = await db.query(
      `SELECT * FROM job_request 
       ${where}
       ORDER BY id DESC 
       LIMIT ? OFFSET ?`,
      [...values, perPage, offset]
    );

    return res.render("users/jobApplications", {
      title: "Job Applications",
      jobs: rows,
      total,
      perPage,
      page,
      totalPages: Math.ceil(total / perPage),
      from,
      to,
      isFiltered: Boolean(from && to)  // UI logic
    });

  } catch (err) {
    console.log("Job Application Fetch Error:", err);

    return res.render("users/jobApplications", {
      title: "Job Applications",
      jobs: [],
      total: 0,
      perPage: 8,
      page: 1,
      totalPages: 1,
      error: "Something went wrong!"
    });
  }
};




export const allCategories = async (req, res) => {
  try {
    const perPage = parseInt(req.query.perPage) || 8;
    const page = parseInt(req.query.page) || 1;
    const offset = (page - 1) * perPage;

    const { status } = req.query;

    let where = "WHERE 1 ";
    let values = [];

    // STATUS FILTER
    if (status === "1") where += "AND status = 1 ";
    if (status === "0") where += "AND status = 0 ";

    // COUNT
    const [[{ total }]] = await db.query(
      `SELECT COUNT(*) AS total FROM categories ${where}`,
      values
    );

    // DATA FETCH
    const [rows] = await db.query(
      `SELECT * FROM categories ${where}
       ORDER BY id DESC
       LIMIT ? OFFSET ?`,
      [...values, perPage, offset]
    );

    return res.render("categories/allCategories", {
      title: "Categories",
      categories: rows,
      total,
      page,
      perPage,
      totalPages: Math.ceil(total / perPage),
      status,
    });

  } catch (err) {
    console.log("Category Error:", err);
    return res.render("categories/allCategories", {
      title: "Categories",
      categories: [],
      total: 0,
      page: 1,
      perPage: 8,
      totalPages: 1,
    });
  }
};


export const updateCategoryStatus = async (req, res) => {
  try {
    const id = req.params.id;
    const status = req.query.status;

    await db.query(
      `UPDATE categories SET status = ? WHERE id = ?`,
      [status, id]
    );

    return res.redirect("/categories");

  } catch (err) {
    console.log("Status Update Error:", err);
     return res.redirect("/categories");
  }
};






// 1) SUBCATEGORIES PAGE LOAD (EJS)
export const subcategoriesPage = async (req, res) => {
  try {
    // all categories for dropdown
    const [categories] = await db.query(
      "SELECT id, name FROM categories WHERE status = 1 ORDER BY name ASC"
    );

    return res.render("categories/subcategories", {
      title: "Subcategories",
      categories
    });

  } catch (err) {
    console.log("PAGE LOAD ERROR:", err);
    return res.render("categories/subcategories", {
      title: "Subcategories",
      categories: [],
      error: "Something went wrong!"
    });
  }
};


export const subcategoriesListAjax = async (req, res) => {
  try {
    const { category_id, search } = req.query;

    const perPage = parseInt(req.query.perPage) || 8;
    const page = parseInt(req.query.page) || 1;
    const offset = (page - 1) * perPage;

    let where = "WHERE 1 ";
    let values = [];

    // CATEGORY FILTER
    if (category_id && category_id !== "0") {
      where += "AND s.category_id = ? ";
      values.push(category_id);
    }

    // SEARCH FILTER
    if (search && search.trim() !== "") {
      where += "AND s.name LIKE ? ";
      values.push(`%${search}%`);
    }

    // TOTAL COUNT
    const [[{ total }]] = await db.query(
      `SELECT COUNT(*) AS total 
       FROM subcategories s 
       ${where}`,
      values
    );

    // FETCH DATA
  const [rows] = await db.query(
  `SELECT 
      s.*, 
      c.name AS category_name, 
      c.image AS category_image
    FROM subcategories s
    JOIN categories c ON c.id = s.category_id
    ${where} AND c.status = 1
    ORDER BY s.id DESC
    LIMIT ? OFFSET ?`,
  [...values, perPage, offset]
);


    return res.json({
      success: true,
      data: rows,
      total,
      totalPages: Math.ceil(total / perPage),
      perPage
    });

  } catch (err) {
    console.log("AJAX ERROR:", err);
    return res.json({
      success: false,
      message: "Error loading subcategories"
    });
  }
};





export const subcategoryStatusUpdate = async (req, res) => {
  try {
    const id = req.params.id;
    const status = req.query.status;

    await db.query(
      `UPDATE subcategories SET status = ? WHERE id = ?`,
      [status, id]
    );

   return res.redirect("/subcategories");
  

  } catch (err) {
    console.log("Status Update Error:", err);
     return res.redirect("/categories");
  }
};


export const addCategory = async (req, res) => {
  try {
    const { name } = req.body;

    const folderName = "categories";  // important
    let imagePath = null;

    // If image uploaded
    if (req.file) {
      imagePath = `${folderName}/${req.file.filename}`;
    }

    if (!name || !imagePath) {
      req.session.error = "Category name or image missing!";
      return res.redirect("/categories");
    }

    await db.query(
      `INSERT INTO categories (name, image, status, created_at)
       VALUES (?, ?, 1, NOW())`,
      [name, imagePath]
    );

    req.session.success = "Category added successfully!";
    res.redirect("/categories");

  } catch (err) {
    console.log("CATEGORY ADD ERROR:", err);
    req.session.error = "Something went wrong!";
    res.redirect("/categories");
  }
};




export const addSubcategory = async (req, res) => {
  try {
    const { category_id, name } = req.body;

    const folderName = "subcategories";  // ⭐ same style as categories
    let imagePath = null;

    // Image Upload Handling
    if (req.file) {
      imagePath = `${folderName}/${req.file.filename}`;
    }

    // Field Validation
    if (!category_id || !name || !imagePath) {
      req.session.error = "All fields are required!";
      return res.redirect("/subcategories");
    }

    // DB Insert
    await db.query(
      `INSERT INTO subcategories (category_id, name, image, status, created_at)
       VALUES (?, ?, ?, 1, NOW())`,
      [category_id, name, imagePath]
    );

    req.session.success = "Subcategory added successfully!";
    return res.redirect("/subcategories");

  } catch (err) {
    console.log("SUBCATEGORY ADD ERROR:", err);
    req.session.error = "Something went wrong!";
    return res.redirect("/subcategories");
  }
};
