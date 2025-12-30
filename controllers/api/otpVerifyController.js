// controllers/verifyController.js
import axios from "axios";
import db from "../../config/database.js";
import { nowIST } from "../../utils/dateParser.js";

/* ==============================
   CONFIG (DLT APPROVED – LEGACY)
================================ */
const DIGIDONAR_CONFIG = {
  URL: "https://sms.digidonar.com/app/smsapi/index.php",
  API_KEY: "4694B639226E59",      
  SENDER: "",              
  TEMPLATE_ID: "YOUR_TEMPLATE_ID",
  PE_ID: "YOUR_PE_ID",            
  ROUTE: ""                 
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
    await db.query(
      `INSERT INTO otp_logs (mobile, otp, expires_at, created_at)
       VALUES (?, ?, ?, ?)`,
      [mobile, otp, expiresAt, createdAt]
    );

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
    });
  }
};



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
    const [rows] = await db.query(
      `SELECT id
       FROM otp_logs
       WHERE mobile = ?
         AND otp = ?
         AND is_used = 0
         AND expires_at > ?
       ORDER BY id DESC
       LIMIT 1`,
      [mobile, otp, currentTime]
    );

    if (!rows.length) {
      return res.status(401).json({
        success: false,
        message: "Invalid or expired OTP"
      });
    }

    // 🔹 Mark OTP as used
    await db.query(
      `UPDATE otp_logs SET is_used = 1 WHERE id = ?`,
      [rows[0].id]
    );

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
    });
  }
};
