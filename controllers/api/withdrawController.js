import db from "../../config/database.js";
import { parseIST, nowIST } from "../../utils/dateParser.js";
import axios from "axios";

async function transactions_generate() {
  const letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  let transaction_id = "";
  let exists = true;

  while (exists) {
    // 2 capital letters
    const firstTwo =
      letters[Math.floor(Math.random() * 26)] +
      letters[Math.floor(Math.random() * 26)];

    // 10 digits → total length = 12
    const digits = Math.floor(
      1000000000 + Math.random() * 9000000000
    ); // 10 digits

    transaction_id = `${firstTwo}${digits}`;

    // unique check
    const [rows] = await db.query(
      `SELECT id FROM withdraw_service WHERE transaction_id = ? LIMIT 1`,
      [transaction_id]
    );

    exists = rows.length > 0;
  }

  return transaction_id;
}

export async function servicemanwithdrawServiceRequest(req, res) {
  try {
    const { serviceman_id, amount } = req.body;

    if (!serviceman_id || !amount) {
      return res.status(400).json({
        success: false,
        message: "serviceman_id and amount are required"
      });
    }

    // 1️⃣ Get due_limit
    const [settingRows] = await db.query(
      "SELECT value FROM settings WHERE name = 'due_limit' LIMIT 1"
    );
    const due_limit = Number(settingRows[0]?.value || 0);

    // 2️⃣ Get serviceman wallet & due_wallet
    const [servicemanRows] = await db.query(
      `
      SELECT wallet, due_wallet
      FROM serviceman
      WHERE id = ?
      LIMIT 1
      `,
      [serviceman_id]
    );

    if (!servicemanRows.length) {
      return res.status(404).json({
        success: false,
        message: "Serviceman not found"
      });
    }

    const { wallet, due_wallet } = servicemanRows[0];

    // 3️⃣ Due wallet check
    if (Number(due_wallet) > due_limit) {
      return res.status(400).json({
        success: false,
        message: `Withdrawal not allowed. Your Current Due wallet ₹${due_wallet} is over ₹${due_limit} limit.`
      });
    }

    // 4️⃣ Wallet balance check
    if (Number(wallet) < Number(amount)) {
      return res.status(400).json({
        success: false,
        message: "Insufficient balance for withdrawal"
      });
    }

    // 5️⃣ Generate transaction_id
    const transaction_id = await transactions_generate();

    // 6️⃣ Deduct amount from wallet
    await db.query(
      `
      UPDATE serviceman
      SET wallet = wallet - ?
      WHERE id = ?
      `,
      [amount, serviceman_id]
    );

    // 7️⃣ Insert withdraw request
    await db.query(
      `
      INSERT INTO withdraw_service
      (user_id, user_type, amount, status, transaction_id)
      VALUES (?, 2, ?, 0, ?)
      `,
      [serviceman_id, amount, transaction_id]
    );

    return res.status(200).json({
      success: true,
      message: "Withdrawal request submitted successfully",
      data: {
        amount,
        transaction_id,
        status: "pending"
      }
    });

  } catch (err) {
    console.log("servicemanwithdrawServiceRequest Error:", err);

    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      errors: err.message
    });
  }
}



export async function servicemanWithdrawHistory(req, res) {
  try {
    const { serviceman_id, status } = req.body;

    if (!serviceman_id) {
      return res.status(400).json({
        success: false,
        message: "serviceman_id is required"
      });
    }

    let sql = `
      SELECT
        id,
        amount,
        status,
        rejected_reason,
        transaction_id,
        created_at
      FROM withdraw_service
      WHERE
        user_id = ?
        AND user_type = 2
    `;

    const params = [serviceman_id];

    // 🔹 status filter (0,1,2)
    if (status !== undefined && status !== null) {
      sql += " AND status = ? ";
      params.push(status);
    }

    sql += " ORDER BY id DESC ";

    const [rows] = await db.query(sql, params);

    // 🔹 Response formatting
    const data = rows.map(item => ({
      id: item.id,
      amount: item.amount,
      status: item.status,
      transaction_id: item.transaction_id,
      rejected_reason: item.status == 2 ? item.rejected_reason : null,
      created_at: item.created_at
    }));

    return res.status(200).json({
      success: true,
      message: "Withdraw history fetched successfully",
      data,
      errors: null
    });

  } catch (err) {
    console.log("servicemanWithdrawHistory Error:", err);

    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      errors: err.message
    });
  }
}




export async function driverWithdrawServiceRequest(req, res) {
  try {
    const { driver_id, amount } = req.body;

    if (!driver_id || !amount) {
      return res.status(400).json({
        success: false,
        message: "driver_id and amount are required"
      });
    }

    /* =========================
       1️⃣ Get driver wallet
    ========================= */
    const [driverRows] = await db.query(
      `
      SELECT wallet
      FROM driver_registration
      WHERE id = ?
      LIMIT 1
      `,
      [driver_id]
    );

    if (!driverRows.length) {
      return res.status(404).json({
        success: false,
        message: "Driver not found"
      });
    }

    const { wallet } = driverRows[0];

    /* =========================
       2️⃣ Wallet balance check
    ========================= */
    if (Number(wallet) < Number(amount)) {
      return res.status(400).json({
        success: false,
        message: "Insufficient balance for withdrawal"
      });
    }

    /* =========================
       3️⃣ Generate transaction_id
    ========================= */
    const transaction_id = await transactions_generate();

    /* =========================
       4️⃣ Deduct wallet amount
    ========================= */
    await db.query(
      `
      UPDATE driver_registration
      SET wallet = wallet - ?
      WHERE id = ?
      `,
      [amount, driver_id]
    );

    /* =========================
       5️⃣ Insert withdraw request
    ========================= */
    await db.query(
      `
      INSERT INTO withdraw_service
      (user_id, user_type, amount, status, transaction_id)
      VALUES (?, 3, ?, 0, ?)
      `,
      [driver_id, amount, transaction_id]
    );

    return res.status(200).json({
      success: true,
      message: "Driver withdrawal request submitted successfully",
      data: {
        amount,
        transaction_id,
        status: "pending"
      }
    });

  } catch (err) {
    console.log("driverWithdrawServiceRequest Error:", err);

    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      errors: err.message
    });
  }
}




export async function driverWithdrawHistory(req, res) {
  try {
    const { driver_id, status } = req.body;

    if (!driver_id) {
      return res.status(400).json({
        success: false,
        message: "driver_id is required"
      });
    }

    let sql = `
      SELECT
        id,
        amount,
        status,
        rejected_reason,
        transaction_id,
        created_at
      FROM withdraw_service
      WHERE
        user_id = ?
        AND user_type = 3
    `;

    const params = [driver_id];

    /* =========================
       Status filter (0,1,2)
    ========================= */
    if (status !== undefined && status !== null) {
      sql += " AND status = ? ";
      params.push(status);
    }

    sql += " ORDER BY id DESC ";

    const [rows] = await db.query(sql, params);

    const data = rows.map(item => ({
      id: item.id,
      amount: item.amount,
      status: item.status,
      transaction_id: item.transaction_id,
      rejected_reason: item.status == 2 ? item.rejected_reason : null,
      created_at: item.created_at
    }));

    return res.status(200).json({
      success: true,
      message: "Driver withdraw history fetched successfully",
      data,
      errors: null
    });

  } catch (err) {
    console.log("driverWithdrawHistory Error:", err);

    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      errors: err.message
    });
  }
}
