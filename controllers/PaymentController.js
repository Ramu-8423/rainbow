import db from "../config/database.js";



export const allPayments = async (req, res) => {
  try {
    const perPage = parseInt(req.query.perPage) || 10;
    const page = parseInt(req.query.page) || 1;
    const offset = (page - 1) * perPage;

    const { payment_type } = req.params;
    const { startDate, endDate, search } = req.query;

    let where = "WHERE p.module_type = ?";
    let values = [2];

    if (payment_type) {
      where += " AND p.payment_type = ?";
      values.push(payment_type);
    }

    if (startDate && endDate) {
      where += " AND DATE(p.created_at) BETWEEN ? AND ?";
      values.push(startDate, endDate);
    }

    if (search) {
      where += " AND (p.transaction_id LIKE ? OR p.user_id LIKE ?)";
      values.push(`%${search}%`, `%${search}%`);
    }

    /* 🔢 TOTAL COUNT */
    const [[{ total }]] = await db.query(
      `SELECT COUNT(*) AS total FROM paying p ${where}`,
      values
    );

    /* 📦 MAIN DATA */
    const [rows] = await db.query(
      `
      SELECT
        p.id,
        p.user_id,
        p.amount,
        p.platform_fee,
        p.final_amount,
        p.payment_type,
        p.transaction_id,
        p.status,
        p.module_type,
        p.created_at,

        /* 🧠 DRIVER NAME (FINAL) */
        CASE
          WHEN p.payment_type = 5 THEN
            CONCAT(dr_direct.first_name, ' ', dr_direct.last_name)
          ELSE
            CONCAT(dr_from_order.first_name, ' ', dr_from_order.last_name)
        END AS driver_name,

        CASE
          WHEN p.payment_type = 5 THEN dr_direct.mobile
          ELSE dr_from_order.mobile
        END AS driver_mobile,

        CASE
          WHEN p.payment_type = 5 THEN dr_direct.profile_photo
          ELSE dr_from_order.profile_photo
        END AS driver_profile_photo

      FROM paying p

      /* ✅ CASE 1: payment_type = 5 → user_id = driver_id */
      LEFT JOIN driver_registration dr_direct
        ON dr_direct.id = p.user_id
        AND p.payment_type = 5

      /* ✅ CASE 2: payment_type IN (1,2,3) → cab_orders → driver */
      LEFT JOIN cab_orders co
        ON co.id = p.service_order_id
        AND p.payment_type IN (1,2,3)

      LEFT JOIN driver_registration dr_from_order
        ON dr_from_order.id = co.driver_id

      ${where}
      ORDER BY p.id DESC
      LIMIT ? OFFSET ?
      `,
      [...values, perPage, offset]
    );

    return res.render("payments/allPayments", {
      title: "All Payments",
      transactions: rows,
      total,
      perPage,
      page,
      totalPages: Math.ceil(total / perPage),

      paymet_by: payment_type || null,
      startDate,
      endDate,
      search,
      BASE_URL: process.env.BASE_URL
    });

  } catch (error) {
    console.error("allPayments ERROR:", error);
    req.session.error = "Something went wrong!";
    return res.redirect("/all_payments");
  }
};





export const allServicePayments = async (req, res) => {
  try {
    const perPage = parseInt(req.query.perPage) || 10;
    const page = parseInt(req.query.page) || 1;
    const offset = (page - 1) * perPage;

    const { payment_type } = req.params;
    const { startDate, endDate, search } = req.query;

    let where = "WHERE p.module_type = ?";
    let values = [1];

    if (payment_type) {
      where += " AND p.payment_type = ?";
      values.push(payment_type);
    }

    if (startDate && endDate) {
      where += " AND DATE(p.created_at) BETWEEN ? AND ?";
      values.push(startDate, endDate);
    }

    if (search) {
      where += " AND (p.transaction_id LIKE ? OR p.user_id LIKE ?)";
      values.push(`%${search}%`, `%${search}%`);
    }

    /* =========================
       TOTAL COUNT
    ========================= */
    const [[{ total }]] = await db.query(
      `SELECT COUNT(*) AS total FROM paying p ${where}`,
      values
    );

    /* =========================
       DATA FETCH (SERVICEMAN LOGIC)
    ========================= */
    const [rows] = await db.query(
      `
      SELECT
        p.id,
        p.user_id,
        p.amount,
        p.platform_fee,
        p.final_amount,
        p.payment_type,
        p.transaction_id,
        p.status,
        p.module_type,
        p.created_at,

        /* 👨‍🔧 SERVICEMAN NAME */
        CASE
          WHEN p.payment_type = 5 THEN
            CONCAT(sm_direct.first_name, ' ', sm_direct.last_name)
          ELSE
            CONCAT(sm_from_order.first_name, ' ', sm_from_order.last_name)
        END AS serviceman_name,

        CASE
          WHEN p.payment_type = 5 THEN sm_direct.mobile
          ELSE sm_from_order.mobile
        END AS serviceman_mobile,

        CASE
          WHEN p.payment_type = 5 THEN sm_direct.profile_photo
          ELSE sm_from_order.profile_photo
        END AS serviceman_profile_photo

      FROM paying p

      /* ✅ CASE 1: payment_type = 5 → user_id = serviceman_id */
      LEFT JOIN serviceman sm_direct
        ON sm_direct.id = p.user_id
        AND p.payment_type = 5

      /* ✅ CASE 2: payment_type IN (1,2,3) → service_order → serviceman */
      LEFT JOIN service_order so
        ON so.id = p.service_order_id
        AND p.payment_type IN (1,2,3)

      LEFT JOIN serviceman sm_from_order
        ON sm_from_order.id = so.serviceman_id

      ${where}
      ORDER BY p.id DESC
      LIMIT ? OFFSET ?
      `,
      [...values, perPage, offset]
    );

    return res.render("payments/servicePayments", {
      title: "Service Payments",
      transactions: rows,
      total,
      perPage,
      page,
      totalPages: Math.ceil(total / perPage),

      paymet_by: payment_type || null,
      startDate,
      endDate,
      search,

      BASE_URL: process.env.BASE_URL
    });

  } catch (error) {
    console.error("allServicePayments ERROR:", error);
    req.session.error = "Something went wrong!";
    return res.redirect("/service_payments");
  }
};





export const UserPayments = async (req, res) => {
  try {
    const perPage = parseInt(req.query.perPage) || 10;
    const page = parseInt(req.query.page) || 1;
    const offset = (page - 1) * perPage;

    const { startDate, endDate, search } = req.query;

    /* 🔒 FIXED CONDITIONS
       module_type = 1 (service)
       payment_type = 4 (user wallet / service payment)
    */
    let where = "WHERE p.module_type = 1 AND p.payment_type = 4";
    let values = [];

    if (startDate && endDate) {
      where += " AND DATE(p.created_at) BETWEEN ? AND ?";
      values.push(startDate, endDate);
    }

    if (search) {
      where += " AND (p.transaction_id LIKE ? OR p.user_id LIKE ?)";
      values.push(`%${search}%`, `%${search}%`);
    }

    /* =========================
       TOTAL COUNT
    ========================= */
    const [[{ total }]] = await db.query(
      `SELECT COUNT(*) AS total FROM paying p ${where}`,
      values
    );

    /* =========================
       DATA FETCH (WITH USERS)
    ========================= */
    const [rows] = await db.query(
      `
      SELECT
        p.id,
        p.user_id,
        p.amount,
        p.platform_fee,
        p.final_amount,
        p.payment_type,
        p.transaction_id,
        p.status,
        p.module_type,
        p.created_at,

        /* 👤 USER DETAILS */
        CONCAT(u.name, ' ', u.last_name) AS user_name,
        u.phone AS user_mobile

      FROM paying p
      LEFT JOIN users u
        ON u.id = p.user_id

      ${where}
      ORDER BY p.id DESC
      LIMIT ? OFFSET ?
      `,
      [...values, perPage, offset]
    );

    return res.render("payments/UserPayments", {
      title: "Service User Payments",
      transactions: rows,
      total,
      perPage,
      page,
      totalPages: Math.ceil(total / perPage),

      startDate,
      endDate,
      search
    });

  } catch (error) {
    console.error("allServiceUserPayments ERROR:", error);
    req.session.error = "Something went wrong!";
    return res.redirect("/service_payments");
  }
};
