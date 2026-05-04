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
       WHERE gateway_name = 'Paytm_Service'
       LIMIT 1`
    );

    // ❌ Gateway not found OR disabled
    if (!rows.length || rows[0].status !== 1) {
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


export const servicePayment = async (req, res) => {
  try {
    const MODULE_TYPE = 1; // Service module
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
        message: "service_order_id required for service payment"
      });
    }

    if (!allowedTypes.includes(Number(payment_type))) {
      return res.status(400).json({
        status: false,
        message: "Invalid payment_type (allowed: 1, 4, 5)"
      });
    }

    /* ================= USER / SERVICEMAN ================= */
    let payer;

    if (Number(payment_type) === 5) {
      const [rows] = await db.query(
        `SELECT id FROM serviceman WHERE id = ?`,
        [user_id]
      );

      if (!rows.length) {
        return res.status(404).json({
          status: false,
          message: "Serviceman not found"
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
        "SELECT value FROM settings WHERE name = 'platform_fee' LIMIT 1"
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
      message: "Service payment session created",
      data: {
        order_id: orderId,
        txnToken
      }
    });

  } catch (err) {
    console.error("Service Payment Error:", err);
    return res.status(500).json({
      status: false,
      message: "Internal error"
    });
  }
};

export const servicePaytmCallback = async (req, res) => {
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

    // ✅ SERVICE ONLY LOCK
    if (Number(pay.module_type) !== 1) {
      return res.status(400).json({ success: false });
    }

    await db.query(
      `UPDATE paying SET status=?, updated_at=NOW() WHERE id=?`,
      [paymentStatus, pay.id]
    );

    if (paymentStatus !== 1) {
      return res.send(HTML_RESPONSES.failed);
    }

    /* ================= SERVICE FLOW ================= */

    // 🛠️ SERVICE PAYMENT (payment_type = 1)
    if (Number(pay.payment_type) === 1) {
      const [orderRows] = await db.query(
        `SELECT serviceman_id FROM service_order WHERE id = ? LIMIT 1`,
        [pay.service_order_id]
      );

      if (orderRows.length) {
        const { serviceman_id } = orderRows[0];

        /* ================= PLATFORM FEE CALCULATION ================= */
        const [setting] = await db.query(
          `SELECT value FROM settings WHERE name = 'platform_fee' LIMIT 1`
        );

        const percent = setting.length ? Number(setting[0].value) : 0;
        const fee = (Number(pay.amount) * percent) / 100;
        const creditAmount = Number(pay.amount) - fee;
        const platformFeeFormatted = `${percent}% - ₹${fee.toFixed(2)}`;

        /* ✅ UPDATE PAYING TABLE FINAL VALUES */
        await db.query(
          `UPDATE paying SET amount=?, final_amount=?, platform_fee=? WHERE transaction_id=?`,
          [pay.amount, creditAmount, platformFeeFormatted, order_id]
        );

        /* 💰 SERVICEMAN CREDIT (AFTER PLATFORM FEE) */
        await db.query(
          `UPDATE serviceman SET wallet = wallet + ? WHERE id = ?`,
          [creditAmount, serviceman_id]
        );
      }
    }

    // 💰 USER WALLET ADD (payment_type = 4)
    if (Number(pay.payment_type) === 4) {
      await db.query(
        `UPDATE users SET wallet = wallet + ? WHERE id=?`,
        [pay.final_amount, pay.user_id]
      );
    }

    // 🛠️ SERVICEMAN DUE CLEAR (payment_type = 5)
    if (Number(pay.payment_type) === 5) {
      await db.query(
        `UPDATE serviceman SET due_wallet = due_wallet - ? WHERE id=?`,
        [pay.final_amount, pay.user_id]
      );
    }

    return res.send(HTML_RESPONSES.success);

  } catch (err) {
    console.error("Service Callback Error:", err);
    return res.status(500).json({ success: false });
  }
};