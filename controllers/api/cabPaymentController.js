import express from "express";
import { v4 as uuidv4 } from "uuid";
import moment from "moment-timezone";
import axios from "axios";
import db from "../../config/database.js";
import PaytmChecksum from "paytmchecksum";
import { parseIST, nowIST } from "../../utils/dateParser.js";

const istNow = moment().tz("Asia/Kolkata").format("YYYY-MM-DD HH:mm:ss");
const currentDate = nowIST();

/* ================= PAYTM CONFIG (ALWAYS FETCH LATEST FROM DB) ================= */

const getPaytmConfig = async () => {
  try {
    const [rows] = await db.query(
      `SELECT 
          mid, 
          merchant_key, 
          website, 
          txn_url, 
          callback_url,
          status
       FROM payment_gateways
       WHERE gateway_name = 'Paytm_Cab'
       LIMIT 1`
    );

    // ❌ Gateway not found OR disabled
    if (!rows.length || rows[0].status !== 1) {
        console.log("rowsAAAAAAAAAAAAAAAAAAAAAAAA", rows);
      return null;
    }


console.log("rowsAAAAAAAAAAAAAAAAAAAAAAAA", rows);
    return {
      PAYTM_MID: rows[0].mid,
      PAYTM_KEY: rows[0].merchant_key,
      PAYTM_WEBSITE: rows[0].website,
      PAYTM_TXN_URL: rows[0].txn_url,
      PAYTM_CALLBACK_URL: rows[0].callback_url,
    };

  } catch (error) {
    console.error("Paytm Config Fetch Error:", error.message);
    throw error;
  }
};



const paytmConfig = await getPaytmConfig();
const PAYTM_MID = paytmConfig.PAYTM_MID;
const PAYTM_KEY = paytmConfig.PAYTM_KEY;
const PAYTM_WEBSITE = paytmConfig.PAYTM_WEBSITE;
const PAYTM_TXN_URL = paytmConfig.PAYTM_TXN_URL;
const PAYTM_CALLBACK_URL = paytmConfig.PAYTM_CALLBACK_URL;


/* ================= HTML RESPONSES ================= */
const HTML_RESPONSES = {
  success: `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Success</title>
  <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:400,400i,700,900&display=swap" rel="stylesheet">
  <script src="https://unpkg.com/@dotlottie/player-component@2.7.12/dist/dotlottie-player.mjs" type="module"></script>
  <style>
    * { margin:0; padding:0; box-sizing:border-box; }
    body {
      text-align:center;
      padding:20px;
      background: linear-gradient(135deg, #a1c4fd, #c2e9fb);
      font-family: "Nunito Sans","Helvetica Neue",sans-serif;
      height:100vh;
      display:flex;
      justify-content:center;
      align-items:center;
    }
    .card {
      background:#fff;
      padding:40px 30px;
      border-radius:15px;
      box-shadow:0 12px 24px rgba(0,0,0,0.1);
      width:100%;
      max-width:450px;
      text-align:center;
      animation: pop 0.4s ease;
    }
    @keyframes pop {
      from { transform: scale(0.9); opacity:0; }
      to   { transform: scale(1); opacity:1; }
    }
    h1 {
      color:#4CAF50;
      font-weight:900;
      font-size:36px;
      margin-bottom:10px;
    }
    p {
      color:#555;
      font-size:16px;
      line-height:1.6;
    }
    dotlottie-player {
      width:100%;
      max-width:360px;
      margin:0 auto 10px;
    }
    @media (max-width:600px){
      h1{font-size:28px;}
      p{font-size:14px;}
    }
  </style>
</head>
<body>
  <div class="card">
    <dotlottie-player 
      src="https://lottie.host/743650e7-51dc-42cb-8ec0-4d9cdf32542d/qwKFt4V60W.lottie"
      background="transparent"
      speed="1"
      autoplay>
    </dotlottie-player>
    <h1>Success</h1>
    <p>
      Payment completed successfully.<br>
      Thank you for choosing us.
    </p>
  </div>
</body>
</html>`,

  failed: `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Failed</title>
  <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:400,400i,700,900&display=swap" rel="stylesheet">
  <script src="https://unpkg.com/@dotlottie/player-component@2.7.12/dist/dotlottie-player.mjs" type="module"></script>
  <style>
    * { margin:0; padding:0; box-sizing:border-box; }
    body {
      text-align:center;
      padding:20px;
      background: linear-gradient(135deg, #ff9a9e, #fad0c4);
      font-family: "Nunito Sans","Helvetica Neue",sans-serif;
      height:100vh;
      display:flex;
      justify-content:center;
      align-items:center;
    }
    .card {
      background:#fff;
      padding:40px 30px;
      border-radius:15px;
      box-shadow:0 12px 24px rgba(0,0,0,0.1);
      width:100%;
      max-width:450px;
      text-align:center;
      animation: pop 0.4s ease;
    }
    @keyframes pop {
      from { transform: scale(0.9); opacity:0; }
      to   { transform: scale(1); opacity:1; }
    }
    h1 {
      color:#e53935;
      font-weight:900;
      font-size:36px;
      margin-bottom:10px;
    }
    p {
      color:#555;
      font-size:16px;
      line-height:1.6;
    }
    dotlottie-player {
      width:100%;
      max-width:360px;
      margin:0 auto 10px;
    }
    @media (max-width:600px){
      h1{font-size:28px;}
      p{font-size:14px;}
    }
  </style>
</head>
<body>
  <div class="card">
    <dotlottie-player 
      src="https://lottie.host/9d0f60b4-1c5d-4d70-9e57-9f6a7f68c7a2/failed.lottie"
      background="transparent"
      speed="1"
      autoplay>
    </dotlottie-player>
    <h1>Failed</h1>
    <p>
      Payment could not be completed.<br>
      Please try again.
    </p>
  </div>
</body>
</html>`
};




// export const ridePayment = async (req, res) => {
//   try {
      
//     const MODULE_TYPE = 2;
//     const GATEWAY_TYPE = 2;
//     const allowedTypes = [1, 4, 5];

//     const { user_id, amount, payment_type, service_order_id } = req.body;


//     if (!user_id || !amount || !payment_type) {
//       return res.status(400).json({
//         status: false,
//         message: "Missing required fields"
//       });
//     }

//     if (Number(payment_type) === 1 && !service_order_id) {
//       return res.status(400).json({
//         status: false,
//         message: "service_order_id required for ride payment"
//       });
//     }
    

//     if (!allowedTypes.includes(Number(payment_type))) {
//       return res.status(400).json({
//         status: false,
//         message: "Invalid payment_type (allowed: 1, 4, 5)"
//       });
//     }

//     /* ================= USER / DRIVER ================= */

//     let payer;

//     if (Number(payment_type) === 5) {
//       const [rows] = await db.query(
//         `SELECT id FROM driver_registration WHERE id = ?`,
//         [user_id]
//       );

//       if (!rows.length) {
//         return res.status(404).json({
//           status: false,
//           message: "Driver not found"
//         });
//       }

//       payer = rows[0];
//     } else {
//       const [rows] = await db.query(
//         `SELECT id FROM users WHERE id = ?`,
//         [user_id]
//       );

//       if (!rows.length) {
//         return res.status(404).json({
//           status: false,
//           message: "User not found"
//         });
//       }

//       payer = rows[0];
//     }

//     /* ================= PLATFORM FEE ================= */

//     let finalAmount = Number(amount);
//     let platformFeeFormatted = "0% - ₹0.00";

//     if (Number(payment_type) === 1) {
//       const [setting] = await db.query(
//         "SELECT value FROM settings WHERE name = 'cab_platform_fee' LIMIT 1"
//       );

//       const percent = setting.length ? Number(setting[0].value) : 0;
//       const fee = (amount * percent) / 100;

//       finalAmount = amount - fee;
//       platformFeeFormatted = `${percent}% - ₹${fee.toFixed(2)}`;
//     }

//     /* ================= PAYTM SESSION ================= */

//     const orderId = "ORD" + Date.now();

//     const paytmBody = {
//       requestType: "Payment",
//       mid: PAYTM_MID,
//       websiteName: PAYTM_WEBSITE,
//       orderId,
//       callbackUrl: PAYTM_CALLBACK_URL,
//       txnAmount: {
//         value: String(amount),
//         currency: "INR"
//       },
//       userInfo: {
//         custId: String(user_id)
//       }
//     };

//     const checksum = await PaytmChecksum.generateSignature(
//       JSON.stringify(paytmBody),
//       PAYTM_KEY
//     );

//     const response = await axios.post(
//       `${PAYTM_TXN_URL}?mid=${PAYTM_MID}&orderId=${orderId}`,
//       { body: paytmBody, head: { signature: checksum } },
//       { headers: { "Content-Type": "application/json" } }
//     );

//     const txnToken = response?.data?.body?.txnToken;

//     if (!txnToken) {
//       return res.status(400).json({
//         status: false,
//         message: "Paytm session failed"
//       });
//     }

//     /* ================= INSERT ================= */

//     await db.query(
//       `INSERT INTO paying 
//       (service_order_id, user_id, amount, platform_fee, final_amount,
//       payment_type, gateway_type, transaction_id, status, module_type,
//       created_at, updated_at)
//       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
//       [
//         payment_type === 1 ? service_order_id : null,
//         user_id,
//         amount,
//         platformFeeFormatted,
//         finalAmount,
//         payment_type,
//         GATEWAY_TYPE, // ✅ constant
//         orderId,
//         0,
//         MODULE_TYPE,  // ✅ constant
//         currentDate,
//         currentDate
//       ]
//     );

//     return res.json({
//       status: true,
//       message: "Cab payment session created",
//       data: {
//         order_id: orderId,
//         txnToken
//       }
//     });

//   } catch (err) {
//     return res.status(500).json({
//       status: false,
//       message: "Internal error"
//     });
//   }
// };

// export const paytmCallback = async (req, res) => {
//   try {

//     const data = { ...req.body };
//     const checksum = data.CHECKSUMHASH;

//     if (!checksum) {
//       return res.status(400).json({ success: false, message: "Missing checksum" });
//     }

//     delete data.CHECKSUMHASH;

//     const isValid = PaytmChecksum.verifySignature(data, PAYTM_KEY, checksum);
//     if (!isValid) {
//       return res.status(400).json({ success: false, message: "Checksum mismatch" });
//     }

//     const order_id = data.ORDERID;

//     let paymentStatus = 0;
//     if (data.STATUS === "TXN_SUCCESS") paymentStatus = 1;
//     else paymentStatus = 2;

//     /* ================= FETCH PAYMENT ================= */

//     const [rows] = await db.query(
//       `SELECT * FROM paying WHERE transaction_id = ? LIMIT 1`,
//       [order_id]
//     );

//     if (!rows.length) {
//       return res.status(404).json({ success: false });
//     }

//     const pay = rows[0];

//     // ✅ CAB ONLY LOCK
//     if (Number(pay.module_type) !== 2) {
//       return res.status(400).json({ success: false });
//     }

//     /* ================= UPDATE STATUS ================= */

//     await db.query(
//       `UPDATE paying SET status=?, updated_at=NOW() WHERE id=?`,
//       [paymentStatus, pay.id]
//     );

//     if (paymentStatus !== 1) {
//       return res.send(HTML_RESPONSES.failed);
//     }

//     /* ================= CAB WALLET FLOW ================= */

//     // 🚖 RIDE PAYMENT
//     if (Number(pay.payment_type) === 1) {

//       const [orderRows] = await db.query(
//         `
//         SELECT 
//           driver_id,
//           user_id,
//           wallet_apply,
//           pay_mode,
//           final_amount AS ride_total_amount,
//           amount_after_wallet
//         FROM cab_orders
//         WHERE id = ?
//         LIMIT 1
//         `,
//         [pay.service_order_id]
//       );

//       if (orderRows.length) {

//         const {
//           driver_id,
//           user_id,
//           wallet_apply,
//           pay_mode,
//           ride_total_amount,
//           amount_after_wallet
//         } = orderRows[0];

//         const walletUsed =
//           Number(ride_total_amount) - Number(amount_after_wallet);

//         let creditAmount = Number(ride_total_amount);

//         // ✅ WALLET APPLY CONDITION (IMPORTANT)
//         if (Number(wallet_apply) === 1 && Number(pay_mode) === 1) {

//           const [setting] = await db.query(
//             `SELECT value FROM settings WHERE name = 'cab_platform_fee' LIMIT 1`
//           );

//           const percent = setting.length ? Number(setting[0].value) : 0;
//           const fee = (Number(ride_total_amount) * percent) / 100;

//           creditAmount = Number(ride_total_amount) - fee;

//           const platformFeeFormatted =
//             `${percent}% - ₹${fee.toFixed(2)}`;

//           // ✅ UPDATE PAYING TABLE
//           await db.query(
//             `UPDATE paying SET amount=?, final_amount=?, platform_fee=? WHERE transaction_id=?`,
//             [ride_total_amount, creditAmount, platformFeeFormatted, order_id]
//           );

//           // 💰 DEDUCT USER WALLET
//           await db.query(
//             `UPDATE users SET wallet = wallet - ? WHERE id = ?`,
//             [walletUsed, user_id]
//           );
//         }

//         // 💰 CREDIT DRIVER
//         await db.query(
//           `UPDATE driver_registration SET wallet = wallet + ? WHERE id = ?`,
//           [creditAmount, driver_id]
//         );
//       }
//     }

//     // 💰 USER WALLET ADD
//     if (Number(pay.payment_type) === 4) {
//       await db.query(
//         `UPDATE users SET wallet = wallet + ? WHERE id=?`,
//         [pay.final_amount, pay.user_id]
//       );
//     }

//     // 🚗 DRIVER DUE CLEAR
//     if (Number(pay.payment_type) === 5) {
//       await db.query(
//         `UPDATE driver_registration SET due_wallet = due_wallet - ? WHERE id=?`,
//         [pay.final_amount, pay.user_id]
//       );
//     }

//     return res.send(HTML_RESPONSES.success);

//   } catch (err) {
//     console.error("Callback Error:", err);
//     return res.status(500).json({ success: false });
//   }
// };



export const ridePayment = async (req, res) => {
  try {

    const MODULE_TYPE = 2;
    const GATEWAY_TYPE = 2;
    const allowedTypes = [1, 4, 5];

    const { user_id, amount, payment_type, service_order_id } = req.body;

    if (!user_id || !amount || !payment_type) {
      return res.status(400).json({
        status: false,
        message: "Missing required fields"
      });
    }

    if (Number(payment_type) === 1 && !service_order_id) {
      return res.status(400).json({
        status: false,
        message: "service_order_id required for ride payment"
      });
    }

    if (!allowedTypes.includes(Number(payment_type))) {
      return res.status(400).json({
        status: false,
        message: "Invalid payment_type (allowed: 1, 4, 5)"
      });
    }

    /* ================= USER / DRIVER ================= */

    let payer;

    if (Number(payment_type) === 5) {
      const [rows] = await db.query(
        `SELECT id FROM driver_registration WHERE id = ?`,
        [user_id]
      );

      if (!rows.length) {
        return res.status(404).json({
          status: false,
          message: "Driver not found"
        });
      }

      payer = rows[0];
    } else {
      const [rows] = await db.query(
        `SELECT id FROM users WHERE id = ?`,
        [user_id]
      );

      if (!rows.length) {
        return res.status(404).json({
          status: false,
          message: "User not found"
        });
      }

      payer = rows[0];
    }

    /* ================= PLATFORM FEE (ONLY STORE, DO NOT DEDUCT HERE) ================= */

    let finalAmount = Number(amount);
    let platformFeeFormatted = "0% - ₹0.00";

    if (Number(payment_type) === 1) {
      const [setting] = await db.query(
        "SELECT value FROM settings WHERE name = 'cab_platform_fee' LIMIT 1"
      );

      const percent = setting.length ? Number(setting[0].value) : 0;
      const fee = (amount * percent) / 100;

      // ❗ IMPORTANT: yaha deduction nahi karna
      finalAmount = amount; 
      platformFeeFormatted = `${percent}% - ₹${fee.toFixed(2)}`;
    }

    /* ================= PAYTM SESSION ================= */

    const orderId = "ORD" + Date.now();

    const paytmBody = {
      requestType: "Payment",
      mid: PAYTM_MID,
      websiteName: PAYTM_WEBSITE,
      orderId,
      callbackUrl: PAYTM_CALLBACK_URL,
      txnAmount: {
        value: String(amount),
        currency: "INR"
      },
      userInfo: {
        custId: String(user_id)
      }
    };

    const checksum = await PaytmChecksum.generateSignature(
      JSON.stringify(paytmBody),
      PAYTM_KEY
    );

    const response = await axios.post(
      `${PAYTM_TXN_URL}?mid=${PAYTM_MID}&orderId=${orderId}`,
      { body: paytmBody, head: { signature: checksum } },
      { headers: { "Content-Type": "application/json" } }
    );

    const txnToken = response?.data?.body?.txnToken;

    if (!txnToken) {
      return res.status(400).json({
        status: false,
        message: "Paytm session failed"
      });
    }

    /* ================= INSERT ================= */

    await db.query(
      `INSERT INTO paying 
      (service_order_id, user_id, amount, platform_fee, final_amount,
       payment_type, gateway_type, transaction_id, status, module_type,
       created_at, updated_at)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        payment_type === 1 ? service_order_id : null,
        user_id,
        amount,
        platformFeeFormatted,
        finalAmount,
        payment_type,
        GATEWAY_TYPE,
        orderId,
        0,
        MODULE_TYPE,
        currentDate,
        currentDate
      ]
    );

    return res.json({
      status: true,
      message: "Cab payment session created",
      data: {
        order_id: orderId,
        txnToken
      }
    });

  } catch (err) {
    return res.status(500).json({
      status: false,
      message: "Internal error"
    });
  }
};




export const paytmCallback = async (req, res) => {
  try {

    const data = { ...req.body };
    const checksum = data.CHECKSUMHASH;

    if (!checksum) {
      return res.status(400).json({ success: false, message: "Missing checksum" });
    }

    delete data.CHECKSUMHASH;

    const isValid = PaytmChecksum.verifySignature(data, PAYTM_KEY, checksum);
    if (!isValid) {
      return res.status(400).json({ success: false, message: "Checksum mismatch" });
    }

    const order_id = data.ORDERID;

    let paymentStatus = 0;
    if (data.STATUS === "TXN_SUCCESS") paymentStatus = 1;
    else paymentStatus = 2;

    const [rows] = await db.query(
      `SELECT * FROM paying WHERE transaction_id = ? LIMIT 1`,
      [order_id]
    );

    if (!rows.length) {
      return res.status(404).json({ success: false });
    }

    const pay = rows[0];

    if (Number(pay.module_type) !== 2) {
      return res.status(400).json({ success: false });
    }

    await db.query(
      `UPDATE paying SET status=?, updated_at=NOW() WHERE id=?`,
      [paymentStatus, pay.id]
    );

    if (paymentStatus !== 1) {
      return res.send(HTML_RESPONSES.failed);
    }

    /* ================= CAB FLOW ================= */

    if (Number(pay.payment_type) === 1) {

      const [orderRows] = await db.query(
        `SELECT driver_id, user_id, final_amount AS ride_total_amount,
                amount_after_wallet, wallet_apply, pay_mode
         FROM cab_orders WHERE id = ? LIMIT 1`,
        [pay.service_order_id]
      );

      if (orderRows.length) {

        const {
          driver_id,
          user_id,
          ride_total_amount,
          amount_after_wallet
        } = orderRows[0];

        /* ================= PLATFORM FEE ALWAYS ================= */

        const [setting] = await db.query(
          `SELECT value FROM settings WHERE name = 'cab_platform_fee' LIMIT 1`
        );

        const percent = setting.length ? Number(setting[0].value) : 0;
        const fee = (Number(ride_total_amount) * percent) / 100;

        const creditAmount = Number(ride_total_amount) - fee;

        const platformFeeFormatted = `${percent}% - ₹${fee.toFixed(2)}`;

        /* ✅ UPDATE PAYING TABLE FINAL VALUES */
        await db.query(
          `UPDATE paying SET amount=?, final_amount=?, platform_fee=? WHERE transaction_id=?`,
          [ride_total_amount, creditAmount, platformFeeFormatted, order_id]
        );

        /* 💰 WALLET DEDUCT (IF USED) */
        const walletUsed =
          Number(ride_total_amount) - Number(amount_after_wallet);

        if (walletUsed > 0) {
          await db.query(
            `UPDATE users SET wallet = wallet - ? WHERE id = ?`,
            [walletUsed, user_id]
          );
        }

        /* 💰 DRIVER CREDIT (AFTER PLATFORM FEE) */
        await db.query(
          `UPDATE driver_registration SET wallet = wallet + ? WHERE id = ?`,
          [creditAmount, driver_id]
        );
      }
    }

    /* USER WALLET ADD */
    if (Number(pay.payment_type) === 4) {
      await db.query(
        `UPDATE users SET wallet = wallet + ? WHERE id=?`,
        [pay.final_amount, pay.user_id]
      );
    }

    /* DRIVER DUE CLEAR */
    if (Number(pay.payment_type) === 5) {
      await db.query(
        `UPDATE driver_registration SET due_wallet = due_wallet - ? WHERE id=?`,
        [pay.final_amount, pay.user_id]
      );
    }

    return res.send(HTML_RESPONSES.success);

  } catch (err) {
    console.error("Callback Error:", err);
    return res.status(500).json({ success: false });
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
        AND p.module_type = 1
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
        AND p.module_type = 1
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
        AND p.module_type = 1
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
        AND p.module_type = 1
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
        AND p.module_type = 1
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
       service_status = 4,5,6
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
       module_type = 1  ✅
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
        AND p.module_type = 1
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






export const paytmData = async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT 
        gateway_name,
        mid,
        website,
        txn_url,
        callback_url
       FROM payment_gateways
       WHERE status = 1
       LIMIT 1`
    );

    if (!rows.length) {
      return res.status(404).json({
        status: false,
        message: "No active payment gateway found"
      });
    }

    return res.status(200).json({
      status: true,
      message: "Payment gateway fetched successfully",
      data: rows[0]
    });

  } catch (error) {
    console.error("Gateway Fetch Error:", error);
    return res.status(500).json({
      status: false,
      message: "Internal server error"
    });
  }
};