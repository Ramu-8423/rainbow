import db from "../config/database.js";

export const loginPage = (req, res) => {
  res.render("login", {
    layout: false,
    title: "Login Page",
    error: null
  });
};


export const redirectIfLoggedIn = (req, res, next) => {
  if (req.session && req.session.admin) {
    return res.redirect("/dashboard");
  }
  next();
};


export const loginSubmit = async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.json({
      success: false,
      message: "Email and password are required"
    });
  }

  try {
    const [emailRows] = await db.query(
      "SELECT id, name, email, image, password, session_version FROM adminuser WHERE email = ? LIMIT 1",
      [email]
    );

    if (!emailRows || emailRows.length === 0) {
      return res.json({
        success: false,
        message: "Invalid email and password"
      });
    }

    if (emailRows[0].password !== password) {
      return res.json({
        success: false,
        message: "Invalid password"
      });
    }

    req.session.admin = {
      id: emailRows[0].id,
      name: emailRows[0].name,
      email: emailRows[0].email,
      image: emailRows[0].image,
      session_version: emailRows[0].session_version
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

export const logout = (req, res) => {
  req.session.destroy(err => {
    if (err) {
      console.log("Logout Error:", err);
      return res.redirect("/dashboard");
    }
    res.redirect("/");
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
        password = ?,
        session_version = session_version + 1
    `;

    const values = [name, email, password];

    if (newImage) {
      sql += `, image = ?`;
      values.push(newImage);
    }

    sql += ` WHERE id = ?`;
    values.push(adminId);

    await db.query(sql, values);

    //// ✅ current user ko alive rakho
    const [verRows] = await db.query(
      "SELECT session_version FROM adminuser WHERE id = ? LIMIT 1",
      [adminId]
    );

    // 🔐 current session ka version update
    req.session.admin.session_version = verRows[0].session_version;
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


export const dashboard = async (req, res) => {
  try {
    /* ===============================
       DATE FILTER
    =============================== */
    const { from, to } = req.query;

    let dateCondition = "";
    let dateParams = [];

    if (from && to) {
      dateCondition = "WHERE created_at BETWEEN ? AND ?";
      dateParams = [`${from} 00:00:00`, `${to} 23:59:59`];
    }

    /* ===============================
       SERVICEMAN COUNTS
    =============================== */
    const [[servicemanCounts]] = await db.query(
      `
      SELECT
        COUNT(*) AS total_serviceman,
        SUM(CASE WHEN login_status = 1 THEN 1 ELSE 0 END) AS active_serviceman,
        SUM(CASE WHEN login_status = 0 THEN 1 ELSE 0 END) AS inactive_serviceman,
        SUM(CASE WHEN online_status = 1 THEN 1 ELSE 0 END) AS online_serviceman,
        SUM(CASE WHEN online_status = 0 THEN 1 ELSE 0 END) AS offline_serviceman
      FROM serviceman
      ${dateCondition}
    `,
      dateParams
    );

    /* ===============================
       DRIVER COUNTS
    =============================== */
    const [[driverCounts]] = await db.query(
      `
      SELECT
        COUNT(*) AS total_driver,
        SUM(CASE WHEN login_status = 1 THEN 1 ELSE 0 END) AS active_driver,
        SUM(CASE WHEN login_status = 0 THEN 1 ELSE 0 END) AS inactive_driver,
        SUM(CASE WHEN online_status = 1 THEN 1 ELSE 0 END) AS online_driver,
        SUM(CASE WHEN online_status = 0 THEN 1 ELSE 0 END) AS offline_driver,
        SUM(
          CASE
            WHEN personal_information_status = 1
             AND vehicle_info_status = 1
             AND driver_licence_status = 1
             AND aadhaar_pan_status = 1
             AND required_certificates_status = 1
             AND vehicle_documents_status = 1
            THEN 1 ELSE 0
          END
        ) AS total_register_pending_doc
      FROM driver_registration
      ${dateCondition}
    `,
      dateParams
    );

    /* ===============================
       JOB REQUEST
    =============================== */
    const [[jobApplicationCounts]] = await db.query(
      `
      SELECT COUNT(*) AS total_job_request
      FROM job_request
      ${dateCondition}
    `,
      dateParams
    );

    /* ===============================
       CATEGORY / SUBCATEGORY / SERVICES
    =============================== */
    const [[categoryCounts]] = await db.query(
      `
      SELECT
        COUNT(*) AS total_category,
        SUM(CASE WHEN status = 0 THEN 1 ELSE 0 END) AS inactive_category
      FROM categories
      ${dateCondition}
    `,
      dateParams
    );

    const [[subcategoryCounts]] = await db.query(
      `
      SELECT
        COUNT(*) AS total_subcategory,
        SUM(CASE WHEN status = 0 THEN 1 ELSE 0 END) AS inactive_subcategory
      FROM subcategories
      ${dateCondition}
    `,
      dateParams
    );

    const [[servicesCounts]] = await db.query(
      `
      SELECT
        COUNT(*) AS total_services,
        SUM(CASE WHEN status = 0 THEN 1 ELSE 0 END) AS inactive_services
      FROM services
      ${dateCondition}
    `,
      dateParams
    );

    /* ===============================
       SERVICE ORDERS
    =============================== */
    const [[serviceOrderCounts]] = await db.query(
      `
      SELECT
        SUM(CASE WHEN service_status = 5 THEN 1 ELSE 0 END) AS completed_services,
        SUM(CASE WHEN service_status < 5 THEN 1 ELSE 0 END) AS ongoing_services
      FROM service_order
      ${dateCondition}
    `,
      dateParams
    );

    /* ===============================
       USERS
    =============================== */
    const [[usersCounts]] = await db.query(
      `
      SELECT
        COUNT(*) AS total_users,
        SUM(CASE WHEN status = 0 THEN 1 ELSE 0 END) AS inactive_users
      FROM users
      ${dateCondition}
    `,
      dateParams
    );

    /* ===============================
       WITHDRAW REQUESTS
    =============================== */
    const [[withdrawCounts]] = await db.query(
      `
      SELECT
        SUM(CASE WHEN user_type = 2 AND status = 0 THEN 1 ELSE 0 END) AS pending_serviceman_withdraw,
        SUM(CASE WHEN user_type = 3 AND status = 0 THEN 1 ELSE 0 END) AS pending_driver_withdraw
      FROM withdraw_service
      ${dateCondition}
    `,
      dateParams
    );

    /* ===============================
       CAB ORDERS
    =============================== */
    const [[orderCounts]] = await db.query(
      `
      SELECT
        SUM(CASE WHEN order_status BETWEEN 0 AND 7 THEN 1 ELSE 0 END) AS total_orders,
        SUM(CASE WHEN order_status = 5 THEN 1 ELSE 0 END) AS completed_orders,
        SUM(CASE WHEN order_status = 6 THEN 1 ELSE 0 END) AS cancelled_by_user,
        SUM(CASE WHEN order_status = 7 THEN 1 ELSE 0 END) AS cancelled_by_driver,
        SUM(CASE WHEN order_status = 8 THEN 1 ELSE 0 END) AS cancelled_by_system
      FROM cab_orders
      ${dateCondition}
    `,
      dateParams
    );

    /* ===============================
       FINAL RENDER
    =============================== */
    return res.render("dashboard", {
      title: "Dashboard",
      admin_name: req.session?.admin_name || "Admin",

      from,
      to,

      total_serviceman: servicemanCounts.total_serviceman || 0,
      active_serviceman: servicemanCounts.active_serviceman || 0,
      inactive_serviceman: servicemanCounts.inactive_serviceman || 0,
      online_serviceman: servicemanCounts.online_serviceman || 0,
      offline_serviceman: servicemanCounts.offline_serviceman || 0,

      total_driver: driverCounts.total_driver || 0,
      active_driver: driverCounts.active_driver || 0,
      inactive_driver: driverCounts.inactive_driver || 0,
      online_driver: driverCounts.online_driver || 0,
      offline_driver: driverCounts.offline_driver || 0,
      total_register_pending_doc: driverCounts.total_register_pending_doc || 0,

      total_job_request: jobApplicationCounts.total_job_request || 0,

      total_category: categoryCounts.total_category || 0,
      inactive_category: categoryCounts.inactive_category || 0,

      total_subcategory: subcategoryCounts.total_subcategory || 0,
      inactive_subcategory: subcategoryCounts.inactive_subcategory || 0,

      total_services: servicesCounts.total_services || 0,
      inactive_services: servicesCounts.inactive_services || 0,

      completed_services: serviceOrderCounts.completed_services || 0,
      ongoing_services: serviceOrderCounts.ongoing_services || 0,

      total_users: usersCounts.total_users || 0,
      inactive_users: usersCounts.inactive_users || 0,

      pending_driver_withdraw: withdrawCounts.pending_driver_withdraw || 0,
      pending_serviceman_withdraw: withdrawCounts.pending_serviceman_withdraw || 0,

      total_orders: orderCounts.total_orders || 0,
      completed_orders: orderCounts.completed_orders || 0,
      cancelled_by_user: orderCounts.cancelled_by_user || 0,
      cancelled_by_driver: orderCounts.cancelled_by_driver || 0,
      cancelled_by_system: orderCounts.cancelled_by_system || 0
    });
  } catch {
    return res.render("dashboard", { title: "Dashboard" });
  }
};





