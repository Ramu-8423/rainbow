import db from "../config/database.js";

export const allPayments = async (req, res) => {
  try {
    const perPage = parseInt(req.query.perPage) || 10;
    const page = parseInt(req.query.page) || 1;
    const offset = (page - 1) * perPage;

    const { payment_type } = req.params;
    const { startDate, endDate, search } = req.query;

    let where = "WHERE module_type = ?";
    let values = [2];

    if (payment_type) {
      where += " AND payment_type = ?";
      values.push(payment_type);
    }

    if (startDate && endDate) {
      where += " AND DATE(created_at) BETWEEN ? AND ?";
      values.push(startDate, endDate);
    }

    if (search) {
      where += " AND (transaction_id LIKE ? OR user_id LIKE ?)";
      values.push(`%${search}%`, `%${search}%`);
    }

    const [[{ total }]] = await db.query(
      `SELECT COUNT(*) AS total FROM paying ${where}`,
      values
    );

    const [rows] = await db.query(
      `
      SELECT 
        id,
        user_id,
        amount,
        platform_fee,
        final_amount,
        payment_type,
        transaction_id,
        status,
        module_type,
        created_at
      FROM paying
      ${where}
      ORDER BY id DESC
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
      search
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

    // 🔒 FIXED: Service module
    let where = "WHERE module_type = ?";
    let values = [1]; 

    if (payment_type) {
      where += " AND payment_type = ?";
      values.push(payment_type);
    }

    if (startDate && endDate) {
      where += " AND DATE(created_at) BETWEEN ? AND ?";
      values.push(startDate, endDate);
    }

    if (search) {
      where += " AND (transaction_id LIKE ? OR user_id LIKE ?)";
      values.push(`%${search}%`, `%${search}%`);
    }

    /* =========================
       TOTAL COUNT
    ========================= */
    const [[{ total }]] = await db.query(
      `SELECT COUNT(*) AS total FROM paying ${where}`,
      values
    );

    /* =========================
       DATA FETCH
    ========================= */
    const [rows] = await db.query(
      `
      SELECT 
        id,
        user_id,
        amount,
        platform_fee,
        final_amount,
        payment_type,
        transaction_id,
        status,
        module_type,
        created_at
      FROM paying
      ${where}
      ORDER BY id DESC
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
      search
    });

  } catch (error) {
    console.error("allServicePayments ERROR:", error);
    req.session.error = "Something went wrong!";
    return res.redirect("/service_payments");
  }
};
