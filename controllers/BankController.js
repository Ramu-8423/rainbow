import db from "../config/database.js";
import { parseIST, nowIST } from "../utils/dateParser.js";

/* =========================
   BANK DETAILS LIST
========================= */
export const getBankDetails = async (req, res) => {
  try {
    const perPage = parseInt(req.query.perPage) || 8;
    const page = parseInt(req.query.page) || 1;
    const offset = (page - 1) * perPage;

    const { from, to } = req.query;
    const { type } = req.params;

    let where = "WHERE type = ?";
    let values = [type];

    if (from && to) {
      where += " AND DATE(datetime) BETWEEN ? AND ?";
      values.push(from, to);
    }

    const [[{ total }]] = await db.query(
      `SELECT COUNT(*) AS total FROM bank_details ${where}`,
      values
    );

    const [rows] = await db.query(
      `SELECT * FROM bank_details
       ${where}
       ORDER BY id DESC
       LIMIT ? OFFSET ?`,
      [...values, perPage, offset]
    );

    return res.render("bankinfo/bankdetails", {
      title: "Bank Details",
      banks: rows,
      total,
      perPage,
      page,
      totalPages: Math.ceil(total / perPage),
      from,
      to,
      isFiltered: Boolean(from && to),
      type
    });

  } catch (err) {
    console.log("Bank Details Fetch Error:", err);
    req.session.error = "Something went wrong!";
    return res.redirect(`/bank-details/${req.params.type}`);
  }
};


/* =========================
   BANK UPDATE REQUEST LIST
========================= */
export const getBankUpdateRequests = async (req, res) => {
  try {
    const perPage = parseInt(req.query.perPage) || 8;
    const page = parseInt(req.query.page) || 1;
    const offset = (page - 1) * perPage;

    const { from, to } = req.query;
    const { type } = req.params;

    let where = "WHERE type = ?";
    let values = [type];

    if (from && to) {
      where += " AND DATE(created_at) BETWEEN ? AND ?";
      values.push(from, to);
    }

    const [[{ total }]] = await db.query(
      `SELECT COUNT(*) AS total FROM bank_details_update_requests ${where}`,
      values
    );

    const [rows] = await db.query(
      `SELECT * FROM bank_details_update_requests
       ${where}
       ORDER BY id DESC
       LIMIT ? OFFSET ?`,
      [...values, perPage, offset]
    );

    return res.render("bankinfo/updateRequests", {
      title: "Bank Update Requests",
      requests: rows,
      total,
      perPage,
      page,
      totalPages: Math.ceil(total / perPage),
      from,
      to,
      isFiltered: Boolean(from && to),
      type
    });

  } catch (err) {
    console.log("Bank Update Request Fetch Error:", err);
    req.session.error = "Something went wrong!";
    return res.redirect(`/bank-update-request/${req.params.type}`);
  }
};


/* =========================
   APPROVE / REJECT REQUEST
========================= */
export const updateRequestStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status, reason, type } = req.query;

    // ✅ IST datetime
    const createdAt = nowIST();

    /* =========================
       FETCH EXACT REQUEST
    ========================= */
    const [reqRows] = await db.query(
      `
      SELECT 
        id,
        user_id,
        type,
        bank_name,
        account_number,
        account_holder_name,
        ifsc_code
      FROM bank_details_update_requests
      WHERE id = ? AND type = ?
      LIMIT 1
      `,
      [id, type]
    );

    if (reqRows.length === 0) {
      req.session.error = "Request not found!";
      return res.redirect(`/bank-update-request/${type}`);
    }

    const {
      user_id,
      bank_name,
      account_number,
      account_holder_name,
      ifsc_code
    } = reqRows[0];

    /* =========================
       ✅ APPROVE
    ========================= */
    if (Number(status) === 1) {

      await db.query(
        `
        UPDATE bank_details
        SET
          bank_name = ?,
          account_number = ?,
          re_account_number = ?,
          account_holder_name = ?,
          ifsc_code = ?,
          updated_at = ?
        WHERE user_id = ? AND type = ?
        `,
        [
          bank_name,
          account_number,
          account_number,
          account_holder_name,
          ifsc_code,
          createdAt,
          user_id,
          type
        ]
      );

      await db.query(
        `
        UPDATE bank_details_update_requests
        SET
          status = 1,
          reject_reason = NULL,
          updated_at = ?
        WHERE id = ? AND user_id = ? AND type = ?
        `,
        [createdAt, id, user_id, type]
      );
      req.session.success = "Bank details approved successfully!";
    }

    if (Number(status) === 2) {

      await db.query(
        `
        UPDATE bank_details_update_requests
        SET
          status = 2,
          reject_reason = ?,
          updated_at = ?
        WHERE id = ? AND user_id = ? AND type = ?
        `,
        [reason, createdAt, id, user_id, type]
      );

      req.session.success = "Bank request rejected successfully!";
    }

    return res.redirect(`/bank-update-request/${type}`);

  } catch (error) {
    console.error("updateRequestStatus ERROR:", error);
    req.session.error = "Something went wrong!";
    return res.redirect(`/bank-update-request/${req.query.type}`);
  }
};
