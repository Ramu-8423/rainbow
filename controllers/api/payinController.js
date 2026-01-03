import db from "../../config/database.js";
import { parseIST, nowIST } from "../../utils/dateParser.js";
import axios from "axios";




export const payment = async (req, res) => { 
  try {
    const { 
      user_id, 
      amount, 
      payment_type,
      service_order_id,
      gateway_type,
      module_type   // nullable
    } = req.body;

    const currentDate = nowIST();

    if (!user_id)
      return res.status(400).json({ status: false, message: "User ID is required" });

    if (!amount)
      return res.status(400).json({ status: false, message: "Amount is required" });

    if (!payment_type)
      return res.status(400).json({ status: false, message: "payment_type is required" });

    if (Number(payment_type) === 1 && !service_order_id) {
      return res.status(400).json({
        status: false,
        message: "service_order_id is required for payment_type 1"
      });
    }

    let payer = null;

    /* =====================================================
       DRIVER DUE WALLET (payment_type = 5, module_type = 2)
    ===================================================== */
    if (Number(payment_type) === 5 && Number(module_type) === 2) {

      const [rows] = await db.query(
        `
        SELECT id, CONCAT(first_name,' ',last_name) AS name, email, mobile
        FROM driver_registration
        WHERE id = ?
        LIMIT 1
        `,
        [user_id]
      );

      if (!rows.length)
        return res.status(404).json({ status: false, message: "Driver not found" });

      payer = rows[0];
    }

    /* =====================================================
       SERVICEMAN DUE WALLET (OLD LOGIC)
    ===================================================== */
    else if (Number(payment_type) === 5) {

      const [rows] = await db.query(
        `
        SELECT id, CONCAT(first_name,' ',last_name) AS name, email, mobile
        FROM serviceman
        WHERE id = ?
        LIMIT 1
        `,
        [user_id]
      );

      if (!rows.length)
        return res.status(404).json({ status: false, message: "Serviceman not found" });

      payer = rows[0];
    }

    /* =====================================================
       USER PAYMENT (SERVICE / CAB)
    ===================================================== */
    else {

      const [rows] = await db.query(
        `
        SELECT id, name, email, phone AS mobile
        FROM users
        WHERE id = ?
        LIMIT 1
        `,
        [user_id]
      );

      if (!rows.length)
        return res.status(404).json({ status: false, message: "User not found" });

      payer = rows[0];
    }

    // service_order_id logic
    const finalServiceOrderId =
      Number(payment_type) === 1 ? service_order_id : null;

    let platformFeeFormatted = "0% - ₹0.00";
    let finalAmount = Number(amount);

    /* =====================================================
       PLATFORM FEE (SERVICE vs CAB)
    ===================================================== */
    if (Number(payment_type) === 1) {

      let feeSettingName = "platform_fee";
      if (Number(module_type) === 2) feeSettingName = "cab_platform_fee";

      const [setting] = await db.query(
        "SELECT value FROM settings WHERE name = ? LIMIT 1",
        [feeSettingName]
      );

      const percent = setting.length ? Number(setting[0].value) : 0;
      const fee = (Number(amount) * percent) / 100;

      finalAmount = Number(amount) - fee;
      platformFeeFormatted = `${percent}% - ₹${fee.toFixed(2)}`;
    }

    const orderId = "ORD" + Date.now();

    const response = await axios.post(
      "https://sandbox.cashfree.com/pg/orders",
      {
        order_id: orderId,
        order_amount: parseFloat(amount),
        order_currency: "INR",
        customer_details: {
          customer_id: `USER${user_id}`,
          customer_email: payer.email || "test@example.com",
          customer_phone: String(payer.mobile || "9999999999"),
          customer_name: payer.name || "User"
        },
        order_meta: {
          notify_url: "https://yoyomiles.codescarts.com/api/callback_service"
        },
        payment_methods: "upi,card,netbanking"
      },
      {
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
          "x-api-version": "2023-08-01",
          "x-client-id": "TEST10256948ec57a943389eb31e588f84965201",
          "x-client-secret": "cfsk_ma_test_4bf75f253a8b0b51dd9252a617bec825_4076da95"
        }
      }
    );

    /* =====================================================
       🔥 FIX IS HERE (module_type INSERTED)
    ===================================================== */
    await db.query(
      `
      INSERT INTO paying 
      (service_order_id, user_id, amount, platform_fee, final_amount,
       payment_type, gateway_type, transaction_id, status, module_type,
       created_at, updated_at)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      `,
      [
        finalServiceOrderId,
        user_id,
        amount,
        platformFeeFormatted,
        finalAmount,
        payment_type,
        gateway_type || 1,
        orderId,
        0,
        Number(module_type) === 2 ? 2 : 1,
        currentDate,
        currentDate
      ]
    );

    return res.status(200).json({
      status: true,
      message: "Payment session created successfully",
      order_id: orderId,
      platform_fee: platformFeeFormatted,
      final_amount: finalAmount,
      data: response.data
    });

  } catch (error) {
    console.error("Payment Error:", error);
    return res.status(500).json({
      status: false,
      message: "Internal server error",
      error: error.message
    });
  }
};












export const callbackService = async (req, res) => {
  try {
    const { order_id, status } = req.body;

    if (!order_id || status === undefined) {
      return res.status(400).json({
        success: false,
        message: "order_id and status are required"
      });
    }

    /* =========================
       NORMALIZE STATUS
    ========================= */
    const paymentStatus =
      String(status).toLowerCase() === "success" || Number(status) === 1
        ? 1
        : 2;

    /* =========================
       FETCH PAYING ROW
    ========================= */
    const [payingRows] = await db.query(
      `SELECT * FROM paying WHERE transaction_id = ? LIMIT 1`,
      [order_id]
    );

    if (!payingRows.length) {
      return res.status(404).json({
        success: false,
        message: "Payment record not found"
      });
    }

    const {
      id,
      payment_type,
      service_order_id,
      user_id,
      final_amount,
      module_type
    } = payingRows[0];

    /* =========================
       UPDATE PAYING STATUS
    ========================= */
    await db.query(
      `UPDATE paying SET status = ?, updated_at = NOW() WHERE id = ?`,
      [paymentStatus, id]
    );

    // ❌ STOP IF FAILED
    if (paymentStatus !== 1) {
      return res.status(200).json({
        success: true,
        message: "Payment failed",
        order_id
      });
    }

    /* =====================================================
       CASE 1: SERVICE → SERVICEMAN WALLET
    ===================================================== */
    if (Number(payment_type) === 1 && Number(module_type) !== 2) {
      const [orderRows] = await db.query(
        `SELECT serviceman_id FROM service_order WHERE id = ? LIMIT 1`,
        [service_order_id]
      );

      if (orderRows.length) {
        await db.query(
          `UPDATE serviceman SET wallet = wallet + ? WHERE id = ?`,
          [Number(final_amount), orderRows[0].serviceman_id]
        );
      }
    }

    /* =====================================================
       CASE 2: CAB → DRIVER WALLET (WITH / WITHOUT WALLET)
    ===================================================== */
   /* =====================================================
   CASE 2: CAB → DRIVER WALLET (WITH / WITHOUT WALLET)
===================================================== */
/* =====================================================
   CASE: CAB → DRIVER WALLET (CORRECT & FINAL)
===================================================== */
if (Number(payment_type) === 1 && Number(module_type) === 2) {

  // 🔥 ALWAYS USE service_order_id (cab_orders)
  const [orderRows] = await db.query(
    `
    SELECT 
      driver_id,
      user_id,
      wallet_apply,
      pay_mode,
      final_amount AS ride_total_amount,
      amount_after_wallet
    FROM cab_orders
    WHERE id = ?
    LIMIT 1
    `,
    [service_order_id]
  );

  if (!orderRows.length) return;

  const {
    driver_id,
    user_id,
    wallet_apply,
    pay_mode,
    ride_total_amount,
    amount_after_wallet
  } = orderRows[0];

  // ✅ Wallet calculation ONLY from cab_orders
  const walletUsed =
    Number(ride_total_amount) - Number(amount_after_wallet); // 500 - 400 = 100

  let creditAmount = Number(ride_total_amount);

  if (Number(wallet_apply) === 1 && Number(pay_mode) === 1) {

    // Platform fee on FULL ride amount
    const [setting] = await db.query(
      `SELECT value FROM settings WHERE name = 'cab_platform_fee' LIMIT 1`
    );

    const percent = setting.length ? Number(setting[0].value) : 0;
    const fee = (Number(ride_total_amount) * percent) / 100;

    creditAmount = Number(ride_total_amount) - fee; // 470

    const platformFeeFormatted =
      `${percent}% - ₹${fee.toFixed(2)}`;

    // ✅ Final paying settlement (auditable)
    await db.query(
      `
      UPDATE paying
      SET 
        amount = ?,
        final_amount = ?,
        platform_fee = ?
      WHERE transaction_id = ?
      `,
      [ride_total_amount, creditAmount, platformFeeFormatted, order_id]
    );

    // ✅ Correct wallet deduction (100)
    await db.query(
      `
      UPDATE users
      SET wallet = wallet - ?
      WHERE id = ?
      `,
      [walletUsed, user_id]
    );
  }

  // ✅ Correct driver credit (470)
  await db.query(
    `
    UPDATE driver_registration
    SET wallet = wallet + ?
    WHERE id = ?
    `,
    [creditAmount, driver_id]
  );
}


    /* =====================================================
       CASE 3: USER WALLET ADD
    ===================================================== */
    if (Number(payment_type) === 4) {
      await db.query(
        `UPDATE users SET wallet = wallet + ? WHERE id = ?`,
        [Number(final_amount), Number(user_id)]
      );
    }

    /* =====================================================
       CASE 4: SERVICEMAN DUE WALLET CLEAR
    ===================================================== */
    if (Number(payment_type) === 5 && Number(module_type) !== 2) {
      await db.query(
        `UPDATE serviceman SET due_wallet = due_wallet - ? WHERE id = ?`,
        [Number(final_amount), Number(user_id)]
      );
    }

    /* =====================================================
       CASE 5: DRIVER DUE WALLET CLEAR
    ===================================================== */
    if (Number(payment_type) === 5 && Number(module_type) === 2) {
      await db.query(
        `UPDATE driver_registration SET due_wallet = due_wallet - ? WHERE id = ?`,
        [Number(final_amount), Number(user_id)]
      );
    }

    /* =========================
       FINAL RESPONSE
    ========================= */
    return res.status(200).json({
      success: true,
      message: "Callback processed successfully",
      service_order_id,
      module_type: module_type,
      order_id
    });

  } catch (error) {
    console.error("Callback Error:", error);
    return res.status(500).json({
      success: false,
      message: "Callback failed",
      error: error.message
    });
  }
};








export const bankDetails = async (req, res) => {
  try {
    const {
      user_id,
      type,               
      account_number,
      re_account_number,
      account_holder_name,
      ifsc_code,
      bank_name,
    } = req.body;

    let errors = [];

    if (!user_id) errors.push("The user_id field is required.");
    if (!type) errors.push("The type field is required (1=serviceman, 2=driver).");

    if (![1, 2, "1", "2"].includes(type)) {
      errors.push("Invalid type. Use 1 for serviceman, 2 for driver.");
    }

    // CHECK EXISTING RECORD
    const [existing] = await db.query(
      "SELECT id FROM bank_details WHERE user_id = ? AND type = ? LIMIT 1",
      [user_id, type]
    );

    // ---------------------------------------------------------
    // ❌ IF RECORD ALREADY EXISTS → RETURN ERROR
    // ---------------------------------------------------------
    if (existing.length > 0) {
      return res.status(200).json({
        success: false,
        message: "Bank details already added. You cannot add again.",
      });
    }

    // ---------------------------------------------------------
    // CASE 1: INSERT NEW RECORD
    // ---------------------------------------------------------
    if (!bank_name) errors.push("The bank name field is required.");
    if (!account_number) errors.push("The account number field is required.");
    if (!re_account_number) errors.push("The re account number field is required.");
    if (!account_holder_name) errors.push("The account holder name field is required.");
    if (!ifsc_code) errors.push("The IFSC code field is required.");

    // IFSC FORMAT VALIDATION
    const ifscRegex = /^[A-Z]{4}0[A-Z0-9]{6}$/;
    if (ifsc_code && !ifscRegex.test(ifsc_code)) {
      errors.push("Invalid IFSC code format. Example: SBIN0123456");
    }

    if (account_number && account_number.length !== 12) {
      errors.push("The account number must be exactly 12 digits.");
    }
    if (re_account_number && re_account_number.length !== 12) {
      errors.push("The re account number must be exactly 12 digits.");
    }
    if (account_number && re_account_number && account_number !== re_account_number) {
      errors.push("Account number and Re-account number must match.");
    }

    if (errors.length > 0) {
      return res.status(400).json({
        success: false,
        message: "Failed: " + errors.join(", "),
      });
    }

    // INSERT QUERY
    await db.query(
      `
      INSERT INTO bank_details 
      (user_id, type, bank_name, account_number, re_account_number, account_holder_name, ifsc_code, datetime)
      VALUES (?, ?, ?, ?, ?, ?, ?, NOW())
      `,
      [
        user_id,
        type,
        bank_name,
        account_number,
        re_account_number,
        account_holder_name,
        ifsc_code
      ]
    );

    return res.status(200).json({
      success: true,
      message: "Bank details submitted successfully.",
    });

  } catch (err) {
    console.log("Bank Details Error:", err);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      error: err.message
    });
  }
};


export const getBankDetails = async (req, res) => {
  try {
    const { user_id, type } = req.body;

    // VALIDATION
    if (!user_id || !type) {
      return res.status(400).json({
        success: false,
        message: "user_id and type are required"
      });
    }

    // FETCH ONLY MAIN BANK DETAILS FROM bank_details TABLE
    const [main] = await db.query(
      `
      SELECT 
          id, 
          user_id, 
          type, 
          bank_name, 
          account_number, 
          re_account_number, 
          account_holder_name, 
          ifsc_code, 
          datetime, 
          updated_at
      FROM bank_details
      WHERE user_id = ? AND type = ?
      LIMIT 1
      `,
      [user_id, type]
    );

    return res.status(200).json({
      success: true,
      message: "Bank details fetched successfully",
      bank_details: main.length ? main[0] : null
    });

  } catch (err) {
    console.log("Get Bank Details Error:", err);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      error: err.message
    });
  }
};


export const bankDetailsUpdateRequest = async (req, res) => {
  try {
    const {
      user_id,
      type,                 
      bank_name,
      account_number,
      re_account_number,
      account_holder_name,
      ifsc_code
    } = req.body;

    let errors = [];

    if (!user_id) errors.push("The user_id field is required.");
    if (!type) errors.push("The type field is required (1=serviceman, 2=driver).");

    if (![1, 2, "1", "2"].includes(type)) {
      errors.push("Invalid type. Use 1 for serviceman, 2 for driver.");
    }

    // IFSC check
    const ifscRegex = /^[A-Z]{4}0[A-Z0-9]{6}$/;
    if (ifsc_code && !ifscRegex.test(ifsc_code)) {
      errors.push("Invalid IFSC code format. Example: SBIN0123456");
    }

    if (account_number && account_number.length !== 12) {
      errors.push("The account number must be exactly 12 digits.");
    }

    if (re_account_number && re_account_number.length !== 12) {
      errors.push("The re account number must be exactly 12 digits.");
    }

    if (account_number && re_account_number && account_number !== re_account_number) {
      errors.push("Account number and Re-account number must match.");
    }

    if (errors.length > 0) {
      return res.status(400).json({
        success: false,
        message: "Failed: " + errors.join(", ")
      });
    }

    // CHECK IF ANY PENDING REQUEST EXISTSA bank update request is
    const [pending] = await db.query(
      `
      SELECT id FROM bank_details_update_requests 
      WHERE user_id = ? AND type = ? AND status = 0
      LIMIT 1
      `,
      [user_id, type]
    );

    if (pending.length > 0) {
      return res.status(400).json({
        success: false,
        message: "A bank update request is already pending. Wait for approval."
      });
    }

    // INSERT REQUEST
    await db.query(
      `
      INSERT INTO bank_details_update_requests
      (user_id, type, bank_name, account_number, re_account_number, account_holder_name, ifsc_code, status, created_at)
      VALUES (?, ?, ?, ?, ?, ?, ?, 0, NOW())
      `,
      [
        user_id,
        type,
        bank_name,
        account_number,
        re_account_number,
        account_holder_name,
        ifsc_code
      ]
    );

    return res.status(200).json({
      success: true,
      message: "Bank update request submitted successfully."
    });

  } catch (err) {
    console.log("Bank Update Request Error:", err);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      error: err.message
    });
  }
};

export const getBankUpdateRequest = async (req, res) => {
  try {
    const { user_id, type } = req.body;

    // VALIDATION
    if (!user_id || !type) {
      return res.status(400).json({
        success: false,
        message: "user_id and type are required"
      });
    }

    // FETCH ONLY UPDATE REQUEST TABLE
    const [request] = await db.query(
      `
      SELECT 
          id,
          user_id,
          type,
          bank_name,
          account_number,
          re_account_number,
          account_holder_name,
          ifsc_code,
          status,
          created_at,
          updated_at
      FROM bank_details_update_requests
      WHERE user_id = ? AND type = ?
      ORDER BY id DESC 
      LIMIT 1
      `,
      [user_id, type]
    );

    return res.status(200).json({
      success: true,
      message: "Bank update request fetched successfully",
      update_request: request.length ? request[0] : null
    });

  } catch (err) {
    console.log("Get Bank Update Request Error:", err);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      error: err.message
    });
  }
};


export async function serviceman_transaction(req, res) {
  try {
    const serviceman_id = req.body.serviceman_id || req.query.serviceman_id;
    const type = req.body.type || req.query.type; 
    if (!serviceman_id) {
      return res.status(400).json({
        success: false,
        message: "serviceman_id is required",
        data: null
      });
    }

    let rows = [];

    const dueWalletSQL = `
      SELECT
        id,
        amount,
        final_amount,
        payment_type,
        status,
        platform_fee,
        created_at AS payment_date
      FROM paying
      WHERE 
        user_id = ?
        AND payment_type = 5
        AND status = 1
      ORDER BY id DESC
    `;

    // 🔹 CASE 2: normal payments
    const normalSQL = `
      SELECT
        p.id,
        p.amount,
        p.final_amount,
        p.payment_type,
        p.platform_fee,
        p.status,
        p.created_at AS payment_date
      FROM paying p
      INNER JOIN service_order so 
        ON so.id = p.service_order_id
      WHERE 
        so.serviceman_id = ?
        AND so.service_status = 4
        AND p.status = 1
      ORDER BY p.id DESC
    `;

    // 🔹 If type is provided
    if (type) {
      if (Number(type) === 5) {
        const [result] = await db.query(dueWalletSQL, [serviceman_id]);
        rows = result;
      } else {
        const [result] = await db.query(
          normalSQL + " AND p.payment_type = ?",
          [serviceman_id, type]
        );
        rows = result;
      }
    } 
    // 🔹 If type NOT provided
    else {
      const [normal] = await db.query(normalSQL, [serviceman_id]);
      const [due] = await db.query(dueWalletSQL, [serviceman_id]);
      rows = [...normal, ...due];
    }

    // 🔹 Mapping (same as before)
    const data = rows.map(item => {
      let section_type = "";
      let section_status = null;

      if (item.payment_type == 1) {
        section_type = "online";
        section_status = 1;
      } else if (item.payment_type == 2) {
        section_type = "offline";
        section_status = 2;
      } else if (item.payment_type == 3) {
        section_type = "wallet";
        section_status = 3;
      } else if (item.payment_type == 5) {
        section_type = "due_wallet";
        section_status = 5;
      }

      return {
        section_type,
        section_status,
        payment: {
          id: item.id,
          amount: item.amount,
          final_amount: item.final_amount,
          status: item.status,
          payment_type: item.payment_type,
          platform_fee: item.platform_fee,
          payment_date: item.payment_date
        }
      };
    });

    return res.status(200).json({
      success: true,
      message: "Serviceman transactions fetched successfully",
      data,
      errors: null
    });

  } catch (err) {
    console.log("serviceman_transaction Error:", err);

    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      data: null,
      errors: err.message
    });
  }
}


export async function user_transaction(req, res) {
  try {
    const user_id = req.body.user_id || req.query.user_id;

    if (!user_id) {
      return res.status(400).json({
        success: false,
        message: "user_id is required",
        data: null
      });
    }

    const userPaymentSQL = `
      SELECT
        id,
        amount,
        final_amount,
        status,
        payment_type,
        platform_fee,
        created_at AS payment_date
      FROM paying
      WHERE
        user_id = ?
        AND payment_type = 4
        AND status = 1
      ORDER BY id DESC
    `;

    const [rows] = await db.query(userPaymentSQL, [user_id]);

    const data = rows.map(item => ({
      id: item.id,
      amount: item.amount,
      final_amount: item.final_amount,
      status: item.status,
      payment_type: item.payment_type,
      platform_fee: item.platform_fee,
      payment_date: item.payment_date
    }));

    return res.status(200).json({
      success: true,
      message: "User payments fetched successfully",
      data,
      errors: null
    });

  } catch (err) {
    console.log("user_transaction Error:", err);

    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      data: null,
      errors: err.message
    });
  }
}


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


export async function servicemanEarnings(req, res) {
  try {
    const { serviceman_id } = req.body || {};

    if (!serviceman_id) {
      return res.status(400).json({
        success: false,
        message: "serviceman_id is required"
      });
    }

    const now = nowIST();

    /* ===============================
       🔹 TOTAL EARNING
    ================================*/
    const [totalRows] = await db.query(
      `
      SELECT IFNULL(SUM(p.final_amount), 0) AS total_earning
      FROM paying p
      INNER JOIN service_order so 
        ON so.id = p.service_order_id
      WHERE
        so.serviceman_id = ?
        AND p.payment_type IN (1,2,3)
        AND p.status = 1
      `,
      [serviceman_id]
    );

    /* ===============================
       🔹 TODAY EARNING
    ================================*/
    const [todayRows] = await db.query(
      `
      SELECT IFNULL(SUM(p.final_amount), 0) AS today_earning
      FROM paying p
      INNER JOIN service_order so 
        ON so.id = p.service_order_id
      WHERE
        so.serviceman_id = ?
        AND DATE(so.service_datetime) = CURDATE()
        AND p.payment_type IN (1,2,3)
        AND p.status = 1
      `,
      [serviceman_id]
    );

    /* ===============================
       🔹 WEEK EARNING (last 7 days)
    ================================*/
    const [weekRows] = await db.query(
      `
      SELECT IFNULL(SUM(p.final_amount), 0) AS week_earning
      FROM paying p
      INNER JOIN service_order so 
        ON so.id = p.service_order_id
      WHERE
        so.serviceman_id = ?
        AND so.service_datetime >= DATE_SUB(NOW(), INTERVAL 7 DAY)
        AND p.payment_type IN (1,2,3)
        AND p.status = 1
      `,
      [serviceman_id]
    );

    /* ===============================
       🔹 MONTHLY EARNING (current month)
    ================================*/
    const [monthRows] = await db.query(
      `
      SELECT IFNULL(SUM(p.final_amount), 0) AS month_earning
      FROM paying p
      INNER JOIN service_order so 
        ON so.id = p.service_order_id
      WHERE
        so.serviceman_id = ?
        AND MONTH(so.service_datetime) = MONTH(CURDATE())
        AND YEAR(so.service_datetime) = YEAR(CURDATE())
        AND p.payment_type IN (1,2,3)
        AND p.status = 1
      `,
      [serviceman_id]
    );

    /* ===============================
       🔹 RECENT EARNINGS LIST
    ================================*/
    const [recentRows] = await db.query(
      `
      SELECT
        so.service_name,
        so.service_datetime,
        p.final_amount
      FROM paying p
      INNER JOIN service_order so 
        ON so.id = p.service_order_id
      WHERE
        so.serviceman_id = ?
        AND p.payment_type IN (1,2,3)
        AND p.status = 1
      ORDER BY p.id DESC
      LIMIT 10
      `,
      [serviceman_id]
    );

    const recent_earnings = recentRows.map(item => ({
      service_name: item.service_name,
      service_datetime: parseIST(item.service_datetime).format("YYYY-MM-DD HH:mm:ss"),
      final_amount: item.final_amount
    }));

    return res.status(200).json({
      success: true,
      message: "Serviceman earnings fetched successfully",
      data: {
        total_earning: totalRows[0].total_earning,
        today_earning: todayRows[0].today_earning,
        week_earning: weekRows[0].week_earning,
        month_earning: monthRows[0].month_earning,
        recent_earnings
      },
      errors: null
    });

  } catch (err) {
    console.log("servicemanEarnings Error:", err);

    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      errors: err.message
    });
  }
}


export async function servicemanServiceInfo(req, res) {
  try {
    const { serviceman_id } = req.body || {};

    if (!serviceman_id) {
      return res.status(400).json({
        success: false,
        message: "serviceman_id is required"
      });
    }

    /* --------------------------------
       1️⃣ Accepted bookings count
       service_status = 1,2,3
    ----------------------------------*/
    const [acceptedRows] = await db.query(
      `
      SELECT COUNT(*) AS total
      FROM service_order
      WHERE serviceman_id = ?
      AND service_status IN (1,2,3)
      `,
      [serviceman_id]
    );

    /* --------------------------------
       2️⃣ Completed bookings count
       service_status = 4
    ----------------------------------*/
   const [completedRows] = await db.query(
      `
      SELECT COUNT(*) AS total
      FROM service_order
      WHERE serviceman_id = ?
      AND service_status IN (4,5,6)
      `,
      [serviceman_id]
    );


    /* --------------------------------
       3️⃣ Total earnings
       paying.status = 1
       payment_type = 1,2,3
       JOIN via service_order_id
    ----------------------------------*/
    const [earningRows] = await db.query(
      `
      SELECT 
        IFNULL(SUM(p.final_amount), 0) AS total_earning
      FROM paying p
      INNER JOIN service_order so
        ON so.id = p.service_order_id
      WHERE
        so.serviceman_id = ?
        AND p.status = 1
        AND p.payment_type IN (1,2,3)
      `,
      [serviceman_id]
    );

    return res.status(200).json({
      success: true,
      message: "Service info fetched successfully",
      data: {
        accepted_booking: acceptedRows[0].total,
        completed_booking: completedRows[0].total,
        total_earning: Number(earningRows[0].total_earning)
      },
      errors: null
    });

  } catch (err) {
    console.log("servicemanServiceInfo Error:", err);

    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      errors: err.message
    });
  }
}



