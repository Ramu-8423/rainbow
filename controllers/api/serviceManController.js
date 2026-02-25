// controllers/api/serviceManController.js

import db from "../../config/database.js";
import { body, validationResult } from "express-validator";
import { parseIST, nowIST } from "../../utils/dateParser.js";


export const servicemanRegisterValidation = [

  body("first_name")
    .notEmpty().withMessage("first_name is required"),

  body("last_name")
    .notEmpty().withMessage("last_name is required"),

     body("city")
     .notEmpty().withMessage("city is required"),


  body("address")
    .notEmpty().withMessage("address is required"),

  body("mobile")
    .notEmpty().withMessage("mobile is required")
    .matches(/^[0-9]{10,12}$/).withMessage("Invalid mobile number"),

  // 🔥 MODIFIED PART (ARRAY ACCEPT करेगा)
  body("service_category")
    .notEmpty().withMessage("service_category is required")
    .custom((value, { req }) => {
      let parsed;

      // agar string me array aaya ho
      if (typeof value === "string") {
        try {
          parsed = JSON.parse(value);
        } catch (e) {
          throw new Error("service_category must be a valid array");
        }
      } else {
        parsed = value;
      }

      // array check
      if (!Array.isArray(parsed) || parsed.length === 0) {
        throw new Error("service_category must be a non-empty array");
      }

      // array ke andar sirf numbers hone chahiye
      const allNumbers = parsed.every(v => Number.isInteger(Number(v)));
      if (!allNumbers) {
        throw new Error("service_category array must contain only numbers");
      }

      // controller ke liye parsed array save kar do
      req.body.service_category = parsed;

      return true;
    }),

  body("device_id")
    .notEmpty().withMessage("device_id is required"),

  body("fcm_token")
    .notEmpty().withMessage("fcm_token is required"),

  body("gender")
    .notEmpty().withMessage("fcm_token is required"),

  body("current_latitude")
    .notEmpty().withMessage("current_latitude is required"),

  body("current_longitude")
    .notEmpty().withMessage("current_longitude is required"),

  body("skill_status")
    .notEmpty().withMessage("skill_status is required")
    .custom(value => {
      if (![0, 1, "0", "1"].includes(value)) {
        throw new Error("skill_status must be 0 or 1");
      }
      return true;
    }),

  body("skill_status").custom((value, { req }) => {
    if (!req.files || !req.files["profile_photo"]) {
      throw new Error("profile_photo is required");
    }
    return true;
  }),

  body("skill_status").custom((value, { req }) => {
    if (!req.files || !req.files["aadhaar_front"]) {
      throw new Error("aadhaar_front is required");
    }
    return true;
  }),

  body("skill_status").custom((value, { req }) => {
    if (!req.files || !req.files["aadhaar_back"]) {
      throw new Error("aadhaar_back is required");
    }
    return true;
  }),

  body("skill_status").custom((value, { req }) => {
    const skill = Number(value);
    if (skill === 0) {
      if (!req.files || !req.files["experience_certificate"]) {
        throw new Error(
          "Experience certificate is required unless you choose 'I don't have any skill"
        );
      }
    }
    return true;
  })
];

export const servicemanRegister = [
  ...servicemanRegisterValidation,

  async (req, res) => {

    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      const msg = errors.array().map(e => e.msg).join(", ");
      return res.status(400).json({
        success: false,
        message: msg,
        errors: errors.array()
      });
    }

    try {
      const {
        first_name,
        last_name,
        email,
        address,
        city,
        mobile,
        service_category,
        skill_status,
        device_id,
        fcm_token,
        gender,                      
        current_latitude,
        current_longitude
      } = req.body;

      const currentDate = nowIST();

    


     const [mobileCheck] = await db.query(
        "SELECT id FROM serviceman WHERE mobile = ? LIMIT 1",
        [mobile]
      );

      if (mobileCheck.length > 0) {
        return res.status(409).json({
          success: false,
          message: "This mobile number is already registered.",
          errors: null
        });
      }
      
      
      const folder = "ServicemanFiles";

      const profile_photo = req.files["profile_photo"]
        ? `${folder}/${req.files["profile_photo"][0].filename}`
        : null;

      const aadhaar_front = req.files["aadhaar_front"]
        ? `${folder}/${req.files["aadhaar_front"][0].filename}`
        : null;

      const aadhaar_back = req.files["aadhaar_back"]
        ? `${folder}/${req.files["aadhaar_back"][0].filename}`
        : null;

      let experience_certificate = null;

      if (Number(skill_status) === 0 && req.files["experience_certificate"]) {
        experience_certificate =
          `${folder}/${req.files["experience_certificate"][0].filename}`;
      }

      const sql = `
        INSERT INTO serviceman 
        (first_name, last_name, email, address, city, mobile, service_category,
         profile_photo, aadhaar_front, aadhaar_back, skill_status, experience_certificate,
         device_id, fcm_token, gender, current_latitude, current_longitude,
         login_status, created_at, updated_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?, 0, ?, ?)
      `;

      const [result] = await db.query(sql, [
        first_name,
        last_name,
        email,
        address,
        city,
        mobile,
        service_category,
        profile_photo,
        aadhaar_front,
        aadhaar_back,
        skill_status,
        experience_certificate,
        device_id,
        fcm_token,
        gender,                        
        current_latitude,
        current_longitude,
        currentDate,
        currentDate
      ]);

      return res.status(201).json({
        success: true,
        message: "Serviceman registered successfully",
        platform_type: 1,
        serviceman_id: result.insertId
      });

    } catch (err) {
      console.log("Serviceman Register Error:", err);
      return res.status(500).json({
        success: false,
        message: "Internal Server Error",
        errors: err.message
      });
    }
  }
];


export async function servicemanLogin(req, res) {
  const { phone, fcm_token, device_id } = req.body;

  if (!phone) {
    return res.status(400).json({
      message: "Phone number is required",
      data: null,
      errors: null
    });
  }

  if (!fcm_token) {
    return res.status(400).json({
      message: "FCM token is required",
      data: null,
      errors: null
    });
  }

  if (!device_id) {
    return res.status(400).json({
      message: "Device ID is required",
      data: null,
      errors: null
    });
  }

  const Current_time = req.Current_time || new Date();

  try {
    /* =====================================================
       STEP 1: CHECK SERVICEMAN TABLE
    ===================================================== */
    const [servicemen] = await db.query(
      "SELECT id, login_status FROM serviceman WHERE mobile = ? LIMIT 1",
      [phone]
    );

    if (servicemen.length > 0) {
      const man = servicemen[0];

      if (man.login_status === 0) {
        return res.status(403).json({
          message: "Your account is deactivated. Please contact support.",
          data: null,
          errors: null
        });
      }

      await db.query(
        `UPDATE serviceman
         SET fcm_token = ?, device_id = ?, updated_at = ?
         WHERE id = ?`,
        [fcm_token, device_id, Current_time, man.id]
      );

      return res.status(200).json({
        message: "Login successful",
        role: "serviceman",
        serviceman_id: man.id,
        platform_type: 1,          
        errors: null
      });
    }

    /* =====================================================
       STEP 2: CHECK DRIVER REGISTRATION TABLE
    ===================================================== */
    const [drivers] = await db.query(
      "SELECT id FROM driver_registration WHERE mobile = ? LIMIT 1",
      [phone]
    );

    if (drivers.length === 0) {
      return res.status(404).json({
        message: "User not found",
        data: null,
        errors: null
      });
    }

    const driver = drivers[0];

    await db.query(
      `UPDATE driver_registration
       SET fcm_token = ?, device_id = ?, updated_at = ?, platform_type = 2
       WHERE id = ?`,
      [fcm_token, device_id, Current_time, driver.id]
    );

    return res.status(200).json({
      message: "Login successful",
      role: "driver",
      driver_id: driver.id,
      platform_type: 2,          
      errors: null
    });

  } catch (err) {
    console.log("Combined Login Error:", err);
    return res.status(500).json({
      message: "Internal Server Error",
      data: null,
      errors: err.message
    });
  }
}



export async function servicemanProfile(req, res) {
    
  if (!req.body || Object.keys(req.body).length === 0) {
    return res.status(400).json({
      success: false,
      message: "Request body is missing",
      data: null,
      errors: null
    });
  }

  // Safe destructure
  const { serviceman_id, current_latitude, current_longitude } = req.body;

  // Required validations
  if (!serviceman_id) {
    return res.status(400).json({
      success: false,
      message: "serviceman_id is required",
      data: null,
      errors: null
    });
  }

  if (!current_latitude || !current_longitude) {
    return res.status(400).json({
      success: false,
      message: "current_latitude & current_longitude are required",
      data: null,
      errors: null
    });
  }

  try {
    const BASE_URL = process.env.BASE_URL || "";

    // STEP 4: Update only location
    await db.query(
      `
      UPDATE serviceman 
      SET 
        current_latitude = ?, 
        current_longitude = ?, 
        updated_at = ?
      WHERE id = ?
      `,
      [
        current_latitude,
        current_longitude,
        req.Current_time,
        serviceman_id
      ]
    );

    // STEP 5: Fetch updated serviceman profile
    const [rows] = await db.query(
      `
      SELECT 
        id,
        wallet,
        due_wallet,
        first_name,
        last_name,
        email,
        address,
        mobile,
        service_category,
        aadhaar_front,
        aadhaar_back,
        skill_status,
        experience_certificate,
        device_id,
        fcm_token,
        form_status,
        reject_reasion,
        login_status,
        online_status,
        created_at,
        updated_at,
        current_latitude,
        current_longitude,
        profile_photo,
        online_status,
        gender
      FROM serviceman
      WHERE id = ?
      LIMIT 1
      `,
      [serviceman_id]
    );

    if (rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: "Serviceman not found",
        data: null,
        errors: null
      });
    }

    const data = rows[0];

    // STEP 6: Fetch service name from subcategories
  let serviceName = null;

    if (Array.isArray(data.service_category) && data.service_category.length > 0) {
      const placeholders = data.service_category.map(() => '?').join(',');
      const [subcat] = await db.query(
        `SELECT name FROM categories WHERE id IN (${placeholders})`,
        data.service_category
      );
      serviceName = subcat.map(row => row.name).join(', ');
    }

    // Add to response
    data.service_name = serviceName;

    // Image URLs
    data.profile_photo = data.profile_photo ? `${BASE_URL}/${data.profile_photo}` : null;
    data.aadhaar_front = data.aadhaar_front ? `${BASE_URL}/${data.aadhaar_front}` : null;
    data.aadhaar_back = data.aadhaar_back ? `${BASE_URL}/${data.aadhaar_back}` : null;
    data.experience_certificate =
      data.experience_certificate ? `${BASE_URL}/${data.experience_certificate}` : null;

    return res.status(200).json({
      success: true,
      message: "Profile updated & fetched successfully",
      data,
      errors: null
    });

  } catch (err) {
    console.log("Serviceman Profile Error:", err);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      data: null,
      errors: err.message
    });
  }
}


export async function servicemanOnlineStatus(req, res) {
  // Check body exists
  if (!req.body || Object.keys(req.body).length === 0) {
    return res.status(400).json({
      success: false,
      message: "Request body is missing",
      errors: null
    });
  }

  const { serviceman_id, online_status, current_latitude, current_longitude } = req.body;

  // Required fields
  if (!serviceman_id) {
    return res.status(400).json({
      success: false,
      message: "serviceman_id is required",
      errors: null
    });
  }

  if (online_status === undefined) {
    return res.status(400).json({
      success: false,
      message: "online_status is required (0 or 1)",
      errors: null
    });
  }

  if (![0, 1, "0", "1"].includes(online_status)) {
    return res.status(400).json({
      success: false,
      message: "online_status must be 0 or 1",
      errors: null
    });
  }

  if (!current_latitude || !current_longitude) {
    return res.status(400).json({
      success: false,
      message: "current_latitude & current_longitude are required",
      errors: null
    });
  }

  try {
    // Fetch serviceman
    const [rows] = await db.query(
      "SELECT id, online_status FROM serviceman WHERE id = ? LIMIT 1",
      [serviceman_id]
    );

    if (rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: "Serviceman not found",
        errors: null
      });
    }

    const man = rows[0];
    const newStatus = Number(online_status);

    // If already same status
    if (man.online_status === newStatus) {
      return res.status(200).json({
        success: true,
        message:
          newStatus === 1
            ? "You are already online"
            : "You are already offline",
        errors: null
      });
    }

    // Update online status + location
    await db.query(
      `
      UPDATE serviceman 
      SET 
        online_status = ?, 
        current_latitude = ?, 
        current_longitude = ?, 
        updated_at = ?
      WHERE id = ?
      `,
      [
        newStatus,
        current_latitude,
        current_longitude,
        req.Current_time,
        serviceman_id
      ]
    );

    return res.status(200).json({
      success: true,
      message:
        newStatus === 1
          ? "You are now online"
          : "You are now offline",
      errors: null
    });

  } catch (err) {
    console.log("Serviceman Online Status Error:", err);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      errors: err.message
    });
  }
}

// export const zoneCities = async (req, res) => {
//   try {
//     const [rows] = await db.query(
//       `
//       SELECT id, zone_name
//       FROM zones
//       ORDER BY id ASC
//       `
//     );

//     if (!rows.length) {
//       return res.status(404).json({
//         message: "Zones not found",
//         cities: []
//       });
//     }

//     // same key & same structure
//     const cities = rows.map(zone => ({
//       id: zone.id,
//       name: zone.zone_name
//     }));

//     return res.status(200).json({
//       message: "Zone cities fetched successfully",
//       cities
//     });

//   } catch (err) {
//     console.log("Zone List Error:", err);
//     return res.status(500).json({
//       message: "Internal Server Error"
//     });
//   }
// };



export const zoneCities = async (req, res) => {
  try {

    const [rows] = await db.query(
      `SELECT * FROM users`
    );

    if (!rows.length) {
      return res.status(400).json({
        message: "users not found",
        users: []
      });
    }

    const users = rows.map(user => ({
      id: user.id,
      name: user.status
    }));

    return res.status(200).json({
      message: "Users fetched successfully",
      users
    });

  } catch (error) {
    console.error("zoneList Error:", error);
    return res.status(500).json({
      message: "Internal server error"
    });
  }
};
