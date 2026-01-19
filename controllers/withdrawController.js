import db from "../config/database.js";
import { nowIST } from "../utils/dateParser.js";

/* =====================================
   DRIVER WITHDRAW REQUEST LIST
====================================== */
export const DriverWithdrawRequest = async (req, res) => {
  try {
    const perPage = parseInt(req.query.perPage) || 8;
    const page = parseInt(req.query.page) || 1;
    const offset = (page - 1) * perPage;

    const { from, to } = req.query;
    const { status } = req.params; // 👈 1 | 2 | 3 | undefined

    let where = "WHERE user_type = 3";
    let values = [];

    /* =========================
       STATUS FILTER (numeric)
    ========================= */
    let statusValue = null;

    if (status !== undefined) {
      const s = Number(status);

      if (s === 1) statusValue = 0; // Pending
      else if (s === 2) statusValue = 1; // Approved
      else if (s === 3) statusValue = 2; // Rejected

      if (statusValue !== null) {
        where += " AND status = ?";
        values.push(statusValue);
      }
    }

    /* =========================
       DATE FILTER
    ========================= */
    if (from && to) {
      where += " AND DATE(created_at) BETWEEN ? AND ?";
      values.push(from, to);
    }

    /* =========================
       COUNT
    ========================= */
    const [[{ total }]] = await db.query(
      `SELECT COUNT(*) AS total FROM withdraw_service ${where}`,
      values
    );

    /* =========================
       DATA
    ========================= */
    const [rows] = await db.query(
      `
      SELECT *
      FROM withdraw_service
      ${where}
      ORDER BY id DESC
      LIMIT ? OFFSET ?
      `,
      [...values, perPage, offset]
    );

    return res.render("withdraw/driverwithdraw", {
      title: "Driver Withdraw Requests",
      requests: rows,
      total,
      perPage,
      page,
      totalPages: Math.ceil(total / perPage),
      from,
      to,
      isFiltered: Boolean(from && to),
      currentStatus: status || null, // 👈 EJS ke liye
      type: 3
    });

  } catch (err) {
    console.error("Withdraw Fetch Error:", err);
    req.session.error = "Something went wrong!";
    return res.redirect("/driver-withdraw-request");
  }
};

/* =====================================
   UPDATE WITHDRAW STATUS
===================================== */
export const updateWithdrawRequest = async (req, res) => {
  try {
    const { id } = req.params;
    const { status, reason, type } = req.query;
    const updatedAt = nowIST();

    /* =========================
       FETCH REQUEST (id + type)
    ========================= */
    const [rows] = await db.query(
      `
      SELECT id, user_id, amount, status
      FROM withdraw_service
      WHERE id = ? AND user_type = ?
      `,
      [id, type]
    );

    if (rows.length === 0) {
      req.session.error = "Withdraw request not found!";
      return res.redirect(`/driver-withdraw-request?type=${type}`);
    }

    const { user_id, amount, status: currentStatus } = rows[0];

    /* =========================
       APPROVE
    ========================= */
    if (Number(status) === 1) {

      // already approved safeguard
      if (currentStatus == 1) {
        req.session.error = "Already approved!";
        return res.redirect(`/driver-withdraw-request?type=${type}`);
      }

      await db.query(
        `
        UPDATE withdraw_service
        SET status = 1,
            updated_at = ?
        WHERE id = ? AND user_type = ?
        `,
        [updatedAt, id, type]
      );

      req.session.success = "Withdraw request approved successfully!";
    }

    /* =========================
       REJECT (REFUND WALLET)
    ========================= */
    if (Number(status) === 2) {

      // already rejected safeguard
      if (currentStatus == 2) {
        req.session.error = "Already rejected!";
        return res.redirect(`/driver-withdraw-request?type=${type}`);
      }

      /* 1️⃣ Wallet refund */
      await db.query(
        `
        UPDATE driver_registration
        SET wallet = wallet + ?
        WHERE id = ?
        `,
        [amount, user_id]
      );

      /* 2️⃣ Update withdraw status */
      await db.query(
        `
        UPDATE withdraw_service
        SET status = 2,
            rejected_reason = ?,
            updated_at = ?
        WHERE id = ? AND user_type = ?
        `,
        [reason, updatedAt, id, type]
      );

      req.session.success =
        "Withdraw request rejected and amount refunded to wallet!";
    }

    return res.redirect(`/driver-withdraw-request?type=${type}`);

  } catch (error) {
    console.error("Withdraw Update Error:", error);
    req.session.error = "Something went wrong!";
    return res.redirect(`/driver-withdraw-request?type=${req.query.type}`);
  }
};





/* =====================================
   SERVICEMAN WITHDRAW REQUEST LIST
===================================== */
export const ServicemanWithdrawRequest = async (req, res) => {
  try {
    const perPage = parseInt(req.query.perPage) || 8;
    const page = parseInt(req.query.page) || 1;
    const offset = (page - 1) * perPage;

    const { from, to } = req.query;
    const { status } = req.params; // 1 | 2 | 3 | undefined

    let where = "WHERE user_type = 2";
    let values = [];

    /* STATUS FILTER */
    let statusValue = null;
    if (status !== undefined) {
      const s = Number(status);
      if (s === 1) statusValue = 0; // Pending
      else if (s === 2) statusValue = 1; // Approved
      else if (s === 3) statusValue = 2; // Rejected

      if (statusValue !== null) {
        where += " AND status = ?";
        values.push(statusValue);
      }
    }

    /* DATE FILTER */
    if (from && to) {
      where += " AND DATE(created_at) BETWEEN ? AND ?";
      values.push(from, to);
    }

    const [[{ total }]] = await db.query(
      `SELECT COUNT(*) AS total FROM withdraw_service ${where}`,
      values
    );

    const [rows] = await db.query(
      `
      SELECT *
      FROM withdraw_service
      ${where}
      ORDER BY id DESC
      LIMIT ? OFFSET ?
      `,
      [...values, perPage, offset]
    );

    return res.render("withdraw/servicemanwithdraw", {
      title: "Serviceman Withdraw Requests",
      requests: rows,
      total,
      perPage,
      page,
      totalPages: Math.ceil(total / perPage),
      from,
      to,
      isFiltered: Boolean(from && to),
      currentStatus: status || null,
      type: 2
    });

  } catch (err) {
    console.error("Serviceman Withdraw Fetch Error:", err);
    req.session.error = "Something went wrong!";
    return res.redirect("/serviceman-withdraw-request");
  }
};


/* =====================================
   UPDATE SERVICEMAN WITHDRAW STATUS
===================================== */
export const updateServicemanWithdrawRequest = async (req, res) => {
  try {
    const { id } = req.params;
    const { status, reason, type } = req.query;
    const updatedAt = nowIST();

    const [rows] = await db.query(
      `
      SELECT id, user_id, amount, status
      FROM withdraw_service
      WHERE id = ? AND user_type = ?
      `,
      [id, type]
    );

    if (!rows.length) {
      req.session.error = "Withdraw request not found!";
      return res.redirect("/serviceman-withdraw-request");
    }

    const { user_id, amount, status: currentStatus } = rows[0];

    /* APPROVE */
    if (Number(status) === 1) {
      if (currentStatus == 1) {
        req.session.error = "Already approved!";
        return res.redirect("/serviceman-withdraw-request");
      }

      await db.query(
        `
        UPDATE withdraw_service
        SET status = 1, updated_at = ?
        WHERE id = ? AND user_type = ?
        `,
        [updatedAt, id, type]
      );

      req.session.success = "Withdraw approved successfully!";
    }

    /* REJECT */
    if (Number(status) === 2) {
      if (currentStatus == 2) {
        req.session.error = "Already rejected!";
        return res.redirect("/serviceman-withdraw-request");
      }

      // Wallet refund
      await db.query(
        `
        UPDATE serviceman
        SET wallet = wallet + ?
        WHERE id = ?
        `,
        [amount, user_id]
      );

      await db.query(
        `
        UPDATE withdraw_service
        SET status = 2,
            rejected_reason = ?,
            updated_at = ?
        WHERE id = ? AND user_type = ?
        `,
        [reason, updatedAt, id, type]
      );

      req.session.success = "Withdraw rejected & wallet refunded!";
    }

    return res.redirect("/serviceman-withdraw-request");

  } catch (err) {
    console.error("Serviceman Withdraw Update Error:", err);
    req.session.error = "Something went wrong!";
    return res.redirect("/serviceman-withdraw-request");
  }
};

