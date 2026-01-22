import axios from "axios";
import db from "../../config/database.js";
import { nowIST } from "../../utils/dateParser.js";

/* ==============================
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

        await axios.get(apiUrl);
      } else {
        otp = BYPASS_OTP; // test mode
      }
    }

    /* ==========================
       SAVE OTP (SAME AS BEFORE)
    ========================== */
    await db.query(
      `INSERT INTO otp_logs (mobile, otp, expires_at, created_at)
       VALUES (?, ?, ?, ?)`,
      [mobile, otp, expiresAt, createdAt]
    );

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
    });
  }
};

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

    const [rows] = await db.query(
      `SELECT id
       FROM otp_logs
       WHERE mobile = ?
         AND otp = ?
         AND is_used = 0
         AND expires_at > ?
       ORDER BY id DESC
       LIMIT 1`,
      [mobile, otp, now]
    );

    if (!rows.length) {
      return res.json({
        msg: "Invalid or expired OTP",
        error: "401"
      });
    }

    await db.query(
      `UPDATE otp_logs SET is_used = 1 WHERE id = ?`,
      [rows[0].id]
    );

    return res.json({
      msg: "Otp Match Successfully",
      error: "200"
    });

  } catch (err) {
    console.error("VERIFY OTP ERROR:", err);
    return res.json({
      msg: "OTP verification failed",
      error: "500"
    });
  }
};
