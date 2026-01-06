import db from "../config/database.js";

export const loginPage = (req, res) => {
  res.render("login", {
    layout: false,
    title: "Login Page",
    error: null      
  });
};


export const loginSubmit = async (req, res) => {
  const { email, password } = req.body;

  // ❌ Empty validation
  if (!email || !password) {
    return res.json({
      success: false,
      message: "Email and password are required"
    });
  }

  try {
    // 🔍 Step 1: check email exists
    const [emailRows] = await db.query(
      "SELECT id, name, email, image, password FROM adminuser WHERE email = ? LIMIT 1",
      [email]
    );

    // ❌ Email not found → both invalid
    if (!emailRows || emailRows.length === 0) {
      return res.json({
        success: false,
        message: "Invalid email and password"
      });
    }

    // ❌ Email correct but password wrong
    if (emailRows[0].password !== password) {
      return res.json({
        success: false,
        message: "Invalid password"
      });
    }

    // ✅ Login success
    req.session.admin = {
      id: emailRows[0].id,
      name: emailRows[0].name,
      email: emailRows[0].email,
      image: emailRows[0].image
    };

    return res.json({
      success: true,
      redirect: "/dashboard"
    });

  } catch (err) {
    return res.json({
      success: false,
      message: "Something went wrong!"
    });
  }
};


export const dashboard = async (req, res) => {
  try {

    const [[servicemanCounts]] = await db.query(`
      SELECT
        COUNT(*) AS total_serviceman,
        SUM(CASE WHEN login_status = 1 THEN 1 ELSE 0 END) AS active_serviceman,
        SUM(CASE WHEN login_status = 0 THEN 1 ELSE 0 END) AS inactive_serviceman,
        SUM(CASE WHEN online_status = 0 THEN 1 ELSE 0 END) AS online_serviceman,
        SUM(CASE WHEN online_status = 1 THEN 1 ELSE 0 END) AS offline_serviceman
      FROM serviceman
    `);

    const [[categoryCounts]] = await db.query(`
      SELECT
        COUNT(*) AS total_category,
        SUM(CASE WHEN status = 0 THEN 1 ELSE 0 END) AS inactive_category
      FROM categories
    `);

    const [[subcategoryCounts]] = await db.query(`
      SELECT
        COUNT(*) AS total_subcategory,
        SUM(CASE WHEN status = 0 THEN 1 ELSE 0 END) AS inactive_subcategory
      FROM subcategories
    `);

    const [[servicesCounts]] = await db.query(`
      SELECT
        COUNT(*) AS total_services,
        SUM(CASE WHEN status = 0 THEN 1 ELSE 0 END) AS inactive_services
      FROM services
    `);

    /* ===============================
       SERVICE ORDER COUNTS
    =============================== */
    const [[serviceOrderCounts]] = await db.query(`
      SELECT
        SUM(CASE WHEN service_status = 5 THEN 1 ELSE 0 END) AS completed_services,
        SUM(CASE WHEN service_status < 5 THEN 1 ELSE 0 END) AS ongoing_services
      FROM service_order
    `);
    
    const [[usersCounts]] = await db.query(`
      SELECT
        COUNT(*) AS total_users,
        SUM(CASE WHEN status = 0 THEN 1 ELSE 0 END) AS inactive_users
      FROM users
    `);
    
   const [[jobApplicationCounts]] = await db.query(`
  SELECT COUNT(*) AS total_job_request
  FROM job_request
`);


    return res.render("dashboard", {
      title: "Dashboard",
      admin_name: req.session?.admin_name || "Admin",

      // Serviceman
      total_serviceman: servicemanCounts.total_serviceman || 0,
      active_serviceman: servicemanCounts.active_serviceman || 0,
      inactive_serviceman: servicemanCounts.inactive_serviceman || 0,
      online_serviceman: servicemanCounts.online_serviceman || 0,
      offline_serviceman: servicemanCounts.offline_serviceman || 0,

      // Category
      total_category: categoryCounts.total_category || 0,
      inactive_category: categoryCounts.inactive_category || 0,

      // Subcategory
      total_subcategory: subcategoryCounts.total_subcategory || 0,
      inactive_subcategory: subcategoryCounts.inactive_subcategory || 0,

      // Services
      total_services: servicesCounts.total_services || 0,
      inactive_services: servicesCounts.inactive_services || 0,

      // Service Orders
      completed_services: serviceOrderCounts.completed_services || 0,
      ongoing_services: serviceOrderCounts.ongoing_services || 0,
      
       total_users: usersCounts.total_users || 0,
      inactive_users: usersCounts.inactive_users || 0,
      total_job_request: jobApplicationCounts.total_job_request || 0
      
    });

  } catch (error) {
    console.error("DASHBOARD ERROR:", error);

    return res.render("dashboard", {
      title: "Dashboard",
      admin_name: req.session?.admin_name || "Admin",

      total_serviceman: 0,
      active_serviceman: 0,
      inactive_serviceman: 0,
      online_serviceman: 0,
      offline_serviceman: 0,

      total_category: 0,
      inactive_category: 0,

      total_subcategory: 0,
      inactive_subcategory: 0,

      total_services: 0,
      inactive_services: 0,

      completed_services: 0,
      ongoing_services: 0,
      total_user: 0,
      inactive_users:0,
      total_job_request:0
    });
  }
};



export const logout = (req, res) => {
  req.session.destroy(err => {
    if (err) {
      console.log("Logout Error:", err);
      return res.redirect("/dashboard");
    }
    res.redirect("/login");
  });
};



export const editProfile = async (req, res) => {
  const adminId = req.params.id;
  try {
    const [rows] = await db.query(
      "SELECT id, name, email, image, password FROM adminuser WHERE id = ? LIMIT 1",
      [adminId]
    );

    if (rows.length === 0) {
      return res.send("Admin not found!");
    }

    return res.render("editProfile", {
      title: "Edit Profile",
      data: rows[0]
    });

  } catch (err) {
    console.log("Profile Fetch Error:", err);
    res.send("Error loading profile");
  }
};




export const updateProfile = async (req, res) => {
  const adminId = req.params.id;
  const { name, email, password } = req.body;

  const folderName = "profileImage";
  let newImage = null;

  if (req.file) {
    newImage = `${folderName}/${req.file.filename}`;
  }

  try {
    let sql = `
      UPDATE adminuser SET 
        name = ?, 
        email = ?, 
        password = ?
    `;

    const values = [name, email, password];

    if (newImage) {
      sql += `, image = ?`;
      values.push(newImage);
    }

    sql += ` WHERE id = ?`;
    values.push(adminId);

    await db.query(sql, values);

   
    req.session.admin.name = name;
    req.session.admin.email = email;
    if (newImage) {
      req.session.admin.image = newImage;
    }

    req.session.success = "Profile updated successfully!";

    return res.redirect(`/editProfile/${adminId}`);

  } catch (err) {
    console.log("Update Error:", err);
    req.session.error = "Something went wrong!";
    return res.redirect(`/editProfile/${adminId}`);
  }
};



