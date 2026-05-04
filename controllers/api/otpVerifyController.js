<<<<<<< HEAD
// controllers/verifyController.js
=======
>>>>>>> 49d7cd4 (initial push from server)
import axios from "axios";
import db from "../../config/database.js";
import { nowIST } from "../../utils/dateParser.js";

/* ==============================
<<<<<<< HEAD
   CONFIG (DLT APPROVED – LEGACY)
================================ */
const DIGIDONAR_CONFIG = {
  URL: "https://sms.digidonar.com/app/smsapi/index.php",
  API_KEY: "4694B639226E59",      
  SENDER: "DGDONR",              
  TEMPLATE_ID: "YOUR_TEMPLATE_ID",
  PE_ID: "YOUR_PE_ID",            
  ROUTE: "101494"                 
};

/* ==============================
   OTP GENERATOR
================================ */
function generateOTP() {
  return Math.floor(1000 + Math.random() * 9000).toString();
}

/* ==============================
   ADD MINUTES (IST SAFE)
================================ */
function addMinutes(dateTime, minutes) {
  const date = new Date(dateTime.replace(" ", "T"));
  date.setMinutes(date.getMinutes() + minutes);

  return date
    .toISOString()
    .slice(0, 19)
    .replace("T", " ");
}


export const sendOtp = async (req, res) => {
  try {
    const { mobile } = req.body;

    if (!mobile) {
      return res.status(400).json({
        success: false,
        message: "mobile is required"
      });
    }

    const otp = generateOTP();
    const createdAt = nowIST(); 
    const expiresAt = addMinutes(createdAt, 5); 

    // 🔹 Save OTP
=======
   DIGIDONAR CONFIG
================================ */
const DIGIDONAR_CONFIG = {
  URL: "https://sms.digidonar.com/app/smsapi/index.php",
  API_KEY: "4694B639226E59",
  SENDER: "RENBWD",
  TEMPLATE_ID: "1107176649406310277",
  PE_ID: "1101488150000091120",
  ROUTE: "101753",
  CAMPAIGN: "OTP_LOGIN"
};

/* ==============================
   BYPASS NUMBERS
================================ */
const BYPASS_NUMBERS = ["9876543210", "9876543211"];
const BYPASS_OTP = "1111";

/* ==============================
   HELPERS
================================ */
function generateOTP(digit = 4) {
  const min = Math.pow(10, digit - 1);
  const max = Math.pow(10, digit) - 1;
  return Math.floor(min + Math.random() * (max - min)).toString();
}

function addMinutes(dateTime, minutes) {
  const date = new Date(dateTime.replace(" ", "T"));
  date.setMinutes(date.getMinutes() + minutes);
  return date.toISOString().slice(0, 19).replace("T", " ");
}

/* ==============================
   SEND OTP
================================ */
export const sendOtp = async (req, res) => {
  try {
    const { mobile, mode = "live", digit = 4 } = req.query;

    if (!mobile) {
      return res.json({ msg: "mobile required", error: "400" });
    }

    const createdAt = nowIST();
    const expiresAt = addMinutes(createdAt, 2);

    let otp = BYPASS_OTP;
    const isBypass = BYPASS_NUMBERS.includes(mobile);

    /* ==========================
       NORMAL FLOW
    ========================== */
    if (!isBypass) {
      if (mode === "live") {
        otp = generateOTP(Number(digit));

        const smsText =
          `OTP for login your account ${otp} and valid till 2 minutes. ` +
          `Do not share this OTP to anyone for security reasons. Via Rainbow Enterprises`;

        const apiUrl =
          `${DIGIDONAR_CONFIG.URL}` +
          `?key=${DIGIDONAR_CONFIG.API_KEY}` +
          `&campaign=${DIGIDONAR_CONFIG.CAMPAIGN}` +
          `&routeid=${DIGIDONAR_CONFIG.ROUTE}` +
          `&type=text` +
          `&contacts=91${mobile}` +
          `&senderid=${DIGIDONAR_CONFIG.SENDER}` +
          `&msg=${encodeURIComponent(smsText)}` +
          `&template_id=${DIGIDONAR_CONFIG.TEMPLATE_ID}` +
          `&pe_id=${DIGIDONAR_CONFIG.PE_ID}`;


        const response = await axios.get(apiUrl);
        if (!response.data || response.data.includes("error")) {
          return res.json({
            msg: "SMS sending failed",
            error: "500"
          });
        }


        
        
      } else {
        otp = BYPASS_OTP; // test mode
      }
    }

    /* ==========================
       SAVE OTP (SAME AS BEFORE)
    ========================== */
>>>>>>> 49d7cd4 (initial push from server)
    await db.query(
      `INSERT INTO otp_logs (mobile, otp, expires_at, created_at)
       VALUES (?, ?, ?, ?)`,
      [mobile, otp, expiresAt, createdAt]
    );

<<<<<<< HEAD
    // 🔹 Message
    const message = `Your OTP is ${otp}. Do not share it.`;

    const payload = {
      key: DIGIDONAR_CONFIG.API_KEY,        
      campaign: "OTP_LOGIN",                
      routeid: DIGIDONAR_CONFIG.ROUTE,      
      type: "text",                        
      contacts: mobile,                     
      senderid: DIGIDONAR_CONFIG.SENDER,    
      msg: message,                        
      template_id: DIGIDONAR_CONFIG.TEMPLATE_ID,
      pe_id: DIGIDONAR_CONFIG.PE_ID
    };

    await axios.post(DIGIDONAR_CONFIG.URL, payload);
    return res.status(200).json({
      success: true,
      message: "OTP sent successfully"
    });

  } catch (error) {
    console.error("Send OTP Error:", error.response?.data || error);
    return res.status(500).json({
      success: false,
      message: "OTP send failed"
=======
    return res.json({
      otp: otp,
      msg: "OTP sent successfully",
      error: "200"
    });

  } catch (err) {
    console.error("SEND OTP ERROR:", err);
    return res.json({
      msg: "OTP send failed",
      error: "500"
>>>>>>> 49d7cd4 (initial push from server)
    });
  }
};

<<<<<<< HEAD


export const verifyOtp = async (req, res) => {
  try {
    const { mobile, otp } = req.body;

    if (!mobile || !otp) {
      return res.status(400).json({
        success: false,
        message: "mobile and otp required"
      });
    }

    const currentTime = nowIST();
=======
/* ==============================
   VERIFY OTP
================================ */
export const verifyOtp = async (req, res) => {
  try {
    const { mobile, otp } = req.query;

    if (!mobile || !otp) {
      return res.json({ msg: "mobile and otp required", error: "400" });
    }

    /* ==========================
       BYPASS VERIFY
    ========================== */
    if (BYPASS_NUMBERS.includes(mobile) && otp === BYPASS_OTP) {
      return res.json({
        msg: "Otp Match Successfully",
        error: "200"
      });
    }

    const now = nowIST();

>>>>>>> 49d7cd4 (initial push from server)
    const [rows] = await db.query(
      `SELECT id
       FROM otp_logs
       WHERE mobile = ?
         AND otp = ?
         AND is_used = 0
         AND expires_at > ?
       ORDER BY id DESC
       LIMIT 1`,
<<<<<<< HEAD
      [mobile, otp, currentTime]
    );

    if (!rows.length) {
      return res.status(401).json({
        success: false,
        message: "Invalid or expired OTP"
      });
    }

    // 🔹 Mark OTP as used
=======
      [mobile, otp, now]
    );

    if (!rows.length) {
      return res.json({
        msg: "Invalid or expired OTP",
        error: "401"
      });
    }

>>>>>>> 49d7cd4 (initial push from server)
    await db.query(
      `UPDATE otp_logs SET is_used = 1 WHERE id = ?`,
      [rows[0].id]
    );

<<<<<<< HEAD
    return res.status(200).json({
      success: true,
      message: "OTP verified successfully"
    });

  } catch (error) {
    console.error("Verify OTP Error:", error);
    return res.status(500).json({
      success: false,
      message: "OTP verification failed"
    });
  }
};





export const getOTPCount = async (req, res) => {
  try {
    const [updateResult] = await db.query(
      `
      UPDATE otp_counter
      SET remaining_otp = remaining_otp - 1
      WHERE counter_name = 'default'
        AND remaining_otp > 0
      `
    );

    // ❌ OTP already finished
    if (updateResult.affectedRows === 0) {
      const [rows] = await db.query(
        `SELECT total_otp FROM otp_counter WHERE counter_name = 'default' LIMIT 1`
      );

      return res.status(400).json({
        success: false,
        message: "OTP limit finished",
        remaining_otp: 0,
        total_otp: rows[0]?.total_otp || 0
      });
    }

    // ✅ Fetch updated value
    const [rows] = await db.query(
      `SELECT remaining_otp, total_otp
       FROM otp_counter
       WHERE counter_name = 'default'
       LIMIT 1`
    );

    return res.status(200).json({
      success: true,
      remaining_otp: rows[0].remaining_otp,
      total_otp: rows[0].total_otp
    });

  } catch (error) {
    console.error("OTP Count API Error:", error);
    return res.status(500).json({
      success: false,
      message: "Failed to fetch OTP count"
=======
    return res.json({
      msg: "Otp Match Successfully",
      error: "200"
    });

  } catch (err) {
    console.error("VERIFY OTP ERROR:", err);
    return res.json({
      msg: "OTP verification failed",
      error: "500"
>>>>>>> 49d7cd4 (initial push from server)
    });
  }
};
