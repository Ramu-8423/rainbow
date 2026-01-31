import db from "../../config/database.js";
import { body, validationResult } from "express-validator";

let Current_time; 




export const jobRequestValidationRules = [

  body("user_id")
    .notEmpty().withMessage("user_id is required")
    .isInt().withMessage("user_id must be a number"),

  body("usertype")
    .notEmpty().withMessage("usertype is required")
    .isInt().withMessage("usertype must be a number")
    .custom(value => {
      if (![1, 2].includes(Number(value))) {
        throw new Error("usertype must be either 1 or 2.");
      }
      return true;
    }),

  body("city")
    .notEmpty().withMessage("city is required"),

  body("first_name")
    .notEmpty().withMessage("first_name is required"),

  body("last_name")
    .notEmpty().withMessage("last_name is required"),

  body("email")
    .notEmpty().withMessage("email is required")
    .isEmail().withMessage("Invalid email format"),

  body("mobile")
    .notEmpty().withMessage("mobile is required")
    .matches(/^[0-9]{10,12}$/).withMessage("Invalid mobile number"),

  body("designation")
    .notEmpty().withMessage("designation is required"),

  body("skill_type")
    .notEmpty().withMessage("skill_type is required")
    .isInt().withMessage("skill_type must be a number"),

  // NEW RULE: Profile photo is required
  body("skill_type").custom((value, { req }) => {
    if (!req.files || !req.files["profile_photo"]) {
      throw new Error("Profile photo is required.");
    }
    return true;
  }),

  // Special: multiple file rule
  body("skill_type").custom((value, { req }) => {
    const type = Number(value);

    if (type === 1) return true;

    if (!req.files || !req.files["designation_file"]) {
      throw new Error("Please upload your work proof unless you don’t know any skill.");
    }

    return true;
  })
];

export const JobRequest = [
  ...jobRequestValidationRules,
  
  async (req, res) => {
    const errors = validationResult(req);

    if (!errors.isEmpty()) {
      const msg = errors.array().map(err => err.msg).join(", ");

      return res.status(400).json({
        success: false,
        message: msg,
        errors: errors.array()
      });
    }

    try {
      const {
        user_id,
        usertype,
        city,
        first_name,
        last_name,
        email,
        mobile,
        designation,
        skill_type
      } = req.body;

      const folderName = "JobFiles";

      // Save profile photo path
      let profile_photo = null;
      if (req.files["profile_photo"]) {
        profile_photo =
          `${folderName}/` + req.files["profile_photo"][0].filename;
      }

      let police_certificate = null;
      if (req.files["police_verification_certificate"]) {
        police_certificate =
          `${folderName}/` +
          req.files["police_verification_certificate"][0].filename;
      }

      let designationFiles = [];
      if (req.files["designation_file"]) {
        designationFiles = req.files["designation_file"].map(file => {
          return `${folderName}/` + file.filename;
        });
      }

      const sql = `
        INSERT INTO job_request 
        (user_id, usertype, city, first_name, last_name, email, mobile, designation, profile_photo, police_verification_certificate, skill_type, designation_file, created_at, status)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)
      `;

      const [result] = await db.query(sql, [
        user_id,
        usertype,
        city,
        first_name,
        last_name,
        email,
        mobile,
        designation,
        profile_photo,
        police_certificate,
        skill_type,
        JSON.stringify(designationFiles),
        req.Current_time
      ]);

      return res.status(201).json({
        success: true,
        message:
          "Thanks for submitting your request! We’re reviewing your details and documents. If everything looks good, our team will get in touch with you soon."
      });

    } catch (error) {
      console.log("JobRequest Error:", error);

      return res.status(500).json({
        success: false,
        message: "Internal Server Error",
        error: error.message
      });
    }
  }
];





export async function loginPolicy(req, res) {
  const policyId = req.params.id;
  if (!policyId) {
    return res.status(400).json({
      success: false,
      message: "Policy id is required",
      data: null,
      errors: null
    });
  }

  try {
    const sql = `
      SELECT 
        id,
        title,
        description,
        type,
        created_at
      FROM login_policy
      WHERE id = ?
    `;

    const [rows] = await db.query(sql, [policyId]);

    if (rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: "Policy not found",
        data: null,
        errors: null
      });
    }

    return res.status(200).json({
      success: true,
      message: "Policy fetched successfully",
      data: rows[0],
      errors: null
    });

  } catch (err) {
    console.log("loginPolicy Error:", err);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      data: null,
      errors: err.message
    });
  }
}


export async function loginAdds(req, res) {
  try {
    const BASE_URL = process.env.BASE_URL || "";
    const sql = `
      SELECT 
        id,
        heading,
        sub_heading,
        image,
        created_at
      FROM loginadds
      ORDER BY id ASC
    `;

    const [rows] = await db.query(sql);

    const data = rows.map(item => ({
      ...item,
      image: item.image ? `${BASE_URL}/${item.image}` : null
    }));

    return res.status(200).json({
      success: true,
      message: "Login adds fetched successfully",
      data: data,
      errors: null
    });

  } catch (err) {
    console.log("loginAdds Error:", err);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      data: null,
      errors: err.message
    });
  }
}



export async function userLogin(req, res) {
  const { phone, fcm_token, device_id } = req.body;

  if (!phone) {
    return res.status(400).json({
      success: false,
      message: "Phone number is required",
      data: null,
      errors: null,
    });
  }
   
  Current_time = req.Current_time;

  try {
    const [rows] = await db.query(
      "SELECT * FROM users WHERE phone = ? LIMIT 1",
      [phone]
    );

    if (rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: "User not found",
        data: null,
        errors: null,
      });
    }

    const user = rows[0];

    // ⭐ Block login if status = 0
    if (user.status === 0) {
      return res.status(403).json({
        success: false,
        message: "Your account is deactivated. Please contact support.",
        data: null,
        errors: null,
      });
    }

    // Update device + fcm token
    await db.query(
      `
        UPDATE users 
        SET fcm_token = ?, device_id = ?, updated_at = Current_time
        WHERE id = ?
      `,
      [fcm_token || user.fcm_token, device_id || user.device_id, user.id]
    );

    // ⭐ Return only user_id
    return res.status(200).json({
      success: true,
      message: "Login successful",
      user_id :user.id,
      errors: null,
    });

  } catch (err) {
    console.log("Login Error:", err);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      data: null,
      errors: err.message,
    });
  }
}



export const registerValidation = [
  body("phone")
    .notEmpty().withMessage("phone is required").bail()
    .isLength({ min: 10, max: 10 }).withMessage("phone must be 10 digits").bail()
    .matches(/^[0-9]{10}$/).withMessage("phone must contain only digits"),

  body("name")
    .notEmpty().withMessage("name is required").bail()
    .matches(/^[A-Za-z ]+$/).withMessage("name must contain only alphabets and spaces").bail()
    .isLength({ min: 3 }).withMessage("name must be at least 3 characters"),

  body("fcm_token")
    .notEmpty().withMessage("fcm_token is required").bail(),

  body("device_id")
    .notEmpty().withMessage("device_id is required").bail(),
];



export const userRegister = [
  ...registerValidation,

  async (req, res) => {
    const errors = validationResult(req);

    if (!errors.isEmpty()) {
      const messages = errors.array().map(err => err.msg).join(", ");
      return res.status(400).json({
        success: false,
        message: messages,
        data: null,
        errors: errors.array()
      });
    }

    const { phone, name, fcm_token, device_id } = req.body;

    try {
      const [existing] = await db.query(
        "SELECT id FROM users WHERE phone = ? LIMIT 1",
        [phone]
      );

      if (existing.length > 0) {
        return res.status(409).json({
          success: false,
          message: "User already exists",
          data: null,
          errors: null
        });
      }

      const Current_time = req.Current_time;

      const insertSql = `
        INSERT INTO users (phone, name, fcm_token, device_id, created_at, updated_at)
        VALUES (?, ?, ?, ?, ?, ?)
      `;

      const [result] = await db.query(insertSql, [
        phone,
        name,
        fcm_token,
        device_id,
        Current_time,
        Current_time
      ]);

      return res.status(201).json({
        success: true,
        message: "User registered successfully",
        Register_id: result.insertId,
        errors: null
      });

    } catch (err) {
      return res.status(500).json({
        success: false,
        message: "Internal Server Error",
        data: null,
        errors: err.message
      });
    }
  }
];




export async function userProfile(req, res) {
  const userId = req.params.id;

  if (!userId) {
    return res.status(400).json({
      success: false,
      message: "userid is required",
      data: null,
      errors: null
    });
  }

  try {
    const sql = `
      SELECT 
        id,
        name,
        last_name,
        email,
        phone,
        status,
        wallet,
        city,
        fcm_token,
        created_at,
        updated_at,
        image,
        device_id
      FROM users
      WHERE id = ?
      LIMIT 1
    `;

    const [rows] = await db.query(sql, [userId]);

    if (rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: "User not found",
        data: null,
        errors: null
      });
    }

    const BASE_URL = process.env.BASE_URL || "";
    const user = rows[0];

    // full image URL
    user.image = user.image ? `${BASE_URL}/${user.image}` : null;

    return res.status(200).json({
      success: true,
      message: "Profile fetched successfully",
      data: user,
      errors: null
    });

  } catch (err) {
    console.log("Profile Error:", err);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      data: null,
      errors: err.message
    });
  }
}




export async function profileEdit(req, res) {

  const body = req.body || {};

  const userId = body.user_id;     
  const name = body.name;
  const last_name = body.last_name;
  const city = body.city;
  const email = body.email;

  // ================================
  //   USER_ID REQUIRED
  // ================================
  
  if (!userId) {
    return res.status(400).json({
      success: false,
      message: "user_id is required",
      data: null,
      errors: null
    });
  }

 
  if (email !== undefined) {

    if (email.trim() === "") {
      return res.status(400).json({
        success: false,
        message: "email is required",
        data: null,
        errors: null
      });
    }

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      return res.status(400).json({
        success: false,
        message: "Invalid email format",
        data: null,
        errors: null
      });
    }
  }

  // ================================
  //   NAME VALIDATION
  // ================================
  if (name !== undefined) {

    if (name.trim() === "") {
      return res.status(400).json({
        success: false,
        message: "name is required",
        data: null,
        errors: null
      });
    }

    if (!/^[A-Za-z ]+$/.test(name)) {
      return res.status(400).json({
        success: false,
        message: "name must contain only alphabets and spaces",
        data: null,
        errors: null
      });
    }

    if (name.length < 3) {
      return res.status(400).json({
        success: false,
        message: "name must be at least 3 characters",
        data: null,
        errors: null
      });
    }
  }

  // ================================
  //   LAST_NAME VALIDATION
  // ================================
  if (last_name !== undefined) {

    if (last_name.trim() === "") {
      return res.status(400).json({
        success: false,
        message: "last_name is required",
        data: null,
        errors: null
      });
    }

    if (!/^[A-Za-z ]+$/.test(last_name)) {
      return res.status(400).json({
        success: false,
        message: "last_name must contain only alphabets and spaces",
        data: null,
        errors: null
      });
    }

    if (last_name.length < 3) {
      return res.status(400).json({
        success: false,
        message: "last_name must be at least 3 characters",
        data: null,
        errors: null
      });
    }
  }

  // ================================
  //   CITY VALIDATION
  // ================================
  if (city !== undefined) {

    if (city.trim() === "") {
      return res.status(400).json({
        success: false,
        message: "city is required",
        data: null,
        errors: null
      });
    }

    if (!/^[A-Za-z ]+$/.test(city)) {
      return res.status(400).json({
        success: false,
        message: "city must contain only alphabets",
        data: null,
        errors: null
      });
    }
  }

  try {
    // Check user exists
    const [rows] = await db.query(
      "SELECT id FROM users WHERE id = ? LIMIT 1",
      [userId]
    );

    if (rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: "User not found",
        data: null,
        errors: null
      });
    }

    const folderName = "UserprofileImage";

    let newImage = null;
    if (req.file) {
      newImage = `${folderName}/${req.file.filename}`;
    }

    // Build SQL dynamically
    let sql = `UPDATE users SET `;
    const values = [];

    if (name) {
      sql += `name = ?, `;
      values.push(name);
    }

    if (last_name) {
      sql += `last_name = ?, `;
      values.push(last_name);
    }

    if (city) {
      sql += `city = ?, `;
      values.push(city);
    }

    if (email) {
      sql += `email = ?, `;
      values.push(email);
    }

    if (newImage) {
      sql += `image = ?, `;
      values.push(newImage);
    }

    sql += `updated_at = ? `;
    values.push(req.Current_time);

    sql += `WHERE id = ?`;
    values.push(userId);

    await db.query(sql, values);

    return res.status(200).json({
      success: true,
      message: "Profile updated successfully",
      errors: null
    });

  } catch (err) {
    console.log("Profile Edit Error:", err);

    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      data: null,
      errors: err.message
    });
  }
}


export async function City(req, res) {
  try {
    const sql = "SELECT id, name FROM cities WHERE status = 1 ORDER BY name ASC";

    const [rows] = await db.query(sql);   // IMPORTANT ✔

    return res.status(200).json({
      success: true,
      message: "City list",
      data: rows
    });

  } catch (error) {
    console.log("City API Error:", error);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      error: error.message
    });
  }
}


function timeAgo(dateString) {
  const now = new Date();
  const past = new Date(dateString);
  const diffMs = now - past;

  const seconds = Math.floor(diffMs / 1000);
  const minutes = Math.floor(seconds / 60);
  const hours   = Math.floor(minutes / 60);
  const days    = Math.floor(hours / 24);
  const years   = Math.floor(days / 365);

  // 👉 Year check
  if (years > 0) {
    return `${years} year${years > 1 ? "s" : ""} ago`;
  }

  if (days > 0) {
    return `${days} day${days > 1 ? "s" : ""} ago`;
  }

  if (hours > 0) {
    return `${hours} hour${hours > 1 ? "s" : ""} ago`;
  }

  if (minutes > 0) {
    return `${minutes} minute${minutes > 1 ? "s" : ""} ago`;
  }

  return "just now";
}







export async function getNotificationByType(req, res) {
  try {
    const role_type = Number(req.params.type);      
    const entity_id = Number(req.query.entity_id); 

    // 🔎 validations
    if (![1, 2, 3, 4].includes(role_type)) {
      return res.status(400).json({
        success: false,
        message: "Invalid type. Allowed: 1=User Cab, 2=User Service, 3=Driver, 4=Serviceman"
      });
    }

    if (!entity_id) {
      return res.status(400).json({
        success: false,
        message: "entity_id is required"
      });
    }

    const sql = `
      SELECT 
        id,
        title,
        text,
        created_at
      FROM notifications
      WHERE 
        entity_type = 5
        OR (entity_type = ? AND entity_id = ?)
      ORDER BY id DESC
    `;

    const [rows] = await db.query(sql, [
      role_type,
      entity_id
    ]);

    const data = rows.map(item => ({
      id: item.id,
      title: item.title,
      text: item.text,
      time_ago: timeAgo(item.created_at)
    }));

    return res.status(200).json({
      success: true,
      message: "Notifications fetched successfully",
      data
    });

  } catch (error) {
    console.error("Notification Error:", error);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      error: error.message
    });
  }
}







export async function userBanner(req, res) {
  try {
    const BASE_URL = process.env.BASE_URL || "";
    const sql = `
      SELECT 
        id,
        image,
        created_at
      FROM user_app_banner
      WHERE status = 1
      ORDER BY id ASC
    `;

    const [rows] = await db.query(sql);

    const data = rows.map(item => ({
      id: item.id,
      image: item.image ? `${BASE_URL}/${item.image}` : null
    }));

    return res.status(200).json({
      success: true,
      message: "Login Banner fetched successfully",
      data: data,
      errors: null
    });

  } catch (err) {
    console.log("Banner Error:", err);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      data: null,
      errors: err.message
    });
  }
}

export async function topServices(req, res) {
  try {
    const BASE_URL = process.env.BASE_URL || "";
    const sql = `
      SELECT
        id,
        image,
        price,
        rating,
        service_title,
        service_description,
        included_service
      FROM top_service
      WHERE status = 1
      ORDER BY id ASC
    `;

    const [rows] = await db.query(sql);

    const data = rows.map(item => {
      // parse included_service safely
      let included = [];
      try {
        if (item.included_service) {
          included = typeof item.included_service === "object"
            ? item.included_service
            : JSON.parse(item.included_service);
        }
      } catch (e) {
        console.log("included_service parse error for id", item.id, e);
        included = [];
      }

      return {
        id: item.id,
        image: item.image ? `${BASE_URL}/${item.image}` : null,
        price: item.price,
        rating: item.rating,
        service_title: item.service_title,
        service_description: item.service_description,
        included_service: included
      };
    });

    return res.status(200).json({
      success: true,
      message: "Top services fetched successfully",
      data: data,
      errors: null
    });

  } catch (err) {
    console.log("Top Services Error:", err);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      data: null,
      errors: err.message
    });
  }
}







export async function categories(req, res) {
  try {
    const BASE_URL = process.env.BASE_URL || "";
    const sql = `
      SELECT 
        id,
        name,
        image,
        created_at
      FROM categories
      WHERE status = 1
      ORDER BY id ASC
    `;

    const [rows] = await db.query(sql);
    const data = rows.map(item => ({
      id: item.id,
      name: item.name,
      image: item.image ? `${BASE_URL}/${item.image}` : null
    }));

    return res.status(200).json({
      success: true,
      message: "categories fetched successfully",
      data: data,
      errors: null
    });

  } catch (err) {
    console.log("categories Error:", err);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      data: null,
      errors: err.message
    });
  }
}


export async function subcategories(req, res) {
  try {
    const { category_id } = req.params;
    const BASE_URL = process.env.BASE_URL || "";

    if (!category_id) {
      return res.status(400).json({
        success: false,
        message: "category_id is required",
        data: null,
        errors: null
      });
    }

    const sql = `
      SELECT 
        id,
        category_id,
        name,
        image,
        created_at
      FROM subcategories
      WHERE status = 1 AND category_id = ?
      ORDER BY id ASC
    `;

    const [rows] = await db.query(sql, [category_id]);

    const data = rows.map(item => ({
      id: item.id,
      category_id: item.category_id,
      name: item.name,
      image: item.image ? `${BASE_URL}/${item.image}` : null
    }));

    return res.status(200).json({
      success: true,
      message: "subcategories fetched successfully",
      data: data,
      errors: null
    });

  } catch (err) {
    console.log("subcategories Error:", err);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      data: null,
      errors: err.message
    });
  }
}



export async function getServices(req, res) {
  try {
    const category_id = req.body.category_id || req.query.category_id;
    const subcategory_id = req.body.subcategory_id || req.query.subcategory_id;
    const search_by_text = req.body.search_by_text || req.query.search_by_text; // 🔹 NEW (nullable)

    const BASE_URL = process.env.BASE_URL || "";

    let sql = `
      SELECT 
        id,
        category_id,
        subcategory_id,
        title,
        description,
        image,
        price,
        rating,
        faqs
      FROM services
      WHERE status = 1
    `;

    const params = [];

    // 🔹 CASE 1: category_id + subcategory_id dono nahi diye
    if (!category_id && !subcategory_id) {
      sql += " AND top_servises_status = 1";
    }

    // 🔹 CASE 2: sirf category_id diya
    if (category_id && !subcategory_id) {
      sql += " AND category_id = ?";
      params.push(category_id);
    }

    // 🔹 CASE 3: category_id + subcategory_id dono diye
    if (category_id && subcategory_id) {
      sql += " AND category_id = ? AND subcategory_id = ?";
      params.push(category_id, subcategory_id);
    }

    // 🔹 NEW: search_by_text (title OR description)
    if (search_by_text) {
      sql += " AND (title LIKE ? OR description LIKE ?)";
      params.push(`%${search_by_text}%`, `%${search_by_text}%`);
    }

    sql += " ORDER BY id ASC";

    const [rows] = await db.query(sql, params);

    const data = rows.map(item => ({
      id: item.id,
      category_id: item.category_id,
      subcategory_id: item.subcategory_id,
      title: item.title,
      description: item.description,
      image: item.image ? `${BASE_URL}/${item.image}` : null,
      price: item.price,
      rating: item.rating,
      faqs: item.faqs ? JSON.parse(item.faqs) : []
    }));

    return res.status(200).json({
      success: true,
      message: "services fetched successfully",
      data: data,
      errors: null
    });

  } catch (err) {
    console.log("getServices Error:", err);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      data: null,
      errors: err.message
    });
  }
}


export async function getCoupons(req, res) {
  try {
    const type = Number(req.params.id);
    const user_id = Number(req.query.user_id);  // user_id from query

    if (!type || ![1, 2].includes(type)) {
      return res.status(400).json({
        success: false,
        message: "Invalid type. Allowed: 1 = Services, 2 = Rides",
        data: null,
        errors: null
      });
    }

    const sql = `
      SELECT 
        id,
        code,
        discount_percent,
        type,
        title,
        expires_at
      FROM coupons
      WHERE status = 1 AND type = ?
      ORDER BY id DESC
    `;

    const [rows] = await db.query(sql, [type]);

    let formatted = [];

    for (const item of rows) {
      let formattedDate = null;

      if (item.expires_at) {
        const d = new Date(item.expires_at);

        const day = d.getDate();
        const year = d.getFullYear();

        const months = [
          "January", "February", "March", "April", "May", "June",
          "July", "August", "September", "October", "November", "December"
        ];

        const monthName = months[d.getMonth()];

        formattedDate = `${day} ${monthName} ${year}`;
      }

      // ⭐ CHECK IF USER HAS ALREADY CLAIMED THIS COUPON
      let claimed_status = 0;

      if (user_id) {
        const [used] = await db.query(
          `
          SELECT status 
          FROM coupons_used 
          WHERE user_id = ? AND coupon_id = ? AND type = ?
          LIMIT 1
          `,
          [user_id, item.id, type]
        );

        // status = 1 means used/completed
        if (used.length > 0 && used[0].status === 1) {
          claimed_status = 1;
        }
      }

      formatted.push({
        id: item.id,
        code: item.code,
        discount_percent: item.discount_percent,
        type: item.type,
        title: item.title,
        expires_at: formattedDate,
        claimed_status: claimed_status
      });
    }

    return res.status(200).json({
      success: true,
      message: "Coupons fetched successfully",
      data: formatted,
      errors: null
    });

  } catch (err) {
    console.log("getCoupons Error:", err);

    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      data: null,
      errors: err.message
    });
  }
}





export async function applyCoupon(req, res) {
  try {
    const { user_id, coupon_id, type, amount } = req.body;

    if (!user_id || !coupon_id || !type || !amount) {
      return res.status(400).json({
        success: false,
        message: "user_id, coupon_id, type and amount are required",
        data: null
      });
    }

    // 1) Fetch coupon details
    const [couponRows] = await db.query(
      `SELECT id, discount_percent, type AS coupon_type, status, expires_at
       FROM coupons
       WHERE id = ? LIMIT 1`,
      [coupon_id]
    );

    if (couponRows.length === 0) {
      return res.status(404).json({
        success: false,
        message: "Invalid coupon",
        data: null
      });
    }

    const coupon = couponRows[0];

    // 2) Coupon inactive?
    if (coupon.status !== 1) {
      return res.status(400).json({
        success: false,
        message: "Coupon inactive",
        data: null
      });
    }

    // 3) Check type match
    if (coupon.coupon_type !== Number(type)) {
      return res.status(400).json({
        success: false,
        message: "Coupon type mismatch",
        data: null
      });
    }

    // 4) Expiry check
    if (coupon.expires_at && new Date(coupon.expires_at) < new Date()) {
      return res.status(400).json({
        success: false,
        message: "Coupon expired",
        data: null
      });
    }

    // 5) Check if already used
    const [used] = await db.query(
      `SELECT status 
       FROM coupons_used 
       WHERE user_id = ? AND coupon_id = ? AND type = ?
       LIMIT 1`,
      [user_id, coupon_id, type]
    );

    if (used.length > 0 && used[0].status === 1) {
      return res.status(400).json({
        success: false,
        message: "You have already used this coupon",
        data: null
      });
    }

    // 6) Discount Calculate
    const discount = (amount * coupon.discount_percent) / 100;
    const final_amount = amount - discount;

    // 7) Insert/Update usage as pending (status = 0)
    if (used.length === 0) {
      await db.query(
        `INSERT INTO coupons_used (user_id, coupon_id, type, status)
         VALUES (?, ?, ?, 0)`,
        [user_id, coupon_id, type]
      );
    }

    return res.status(200).json({
      success: true,
      message: "Coupon applied successfully",
      data: {
        coupon_id: coupon_id,
        type: type,
        original_amount: amount,
        discount_percent: coupon.discount_percent,
        discount_amount: discount,
        final_amount: final_amount,
        applied_status: 1
      }
    });

  } catch (error) {
    console.log("applyCoupon Error:", error);

    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      data: null,
      error: error.message
    });
  }
}







export const saveAddress = async (req, res) => {
  try {
    const {
      user_id,
      type,
      address,
      flat_house_building_name,
      floor,
      nearby_landmark,
      service_latitude,
      service_longitude
    } = req.body;

    // 🔹 Field-wise validation (user friendly)
    if (!user_id) {
      return res.status(400).json({
        success: false,
        message: "User is required"
      });
    }

    if (!type) {
      return res.status(400).json({
        success: false,
        message: "Address type is required"
      });
    }

    if (!address) {
      return res.status(400).json({
        success: false,
        message: "Address is required"
      });
    }

    if (!flat_house_building_name) {
      return res.status(400).json({
        success: false,
        message: "Flat / House / Building name is required"
      });
    }

    if (!service_latitude) {
      return res.status(400).json({
        success: false,
        message: "Service latitude is required"
      });
    }

    if (!service_longitude) {
      return res.status(400).json({
        success: false,
        message: "Service longitude is required"
      });
    }

    // 🔹 COUNT existing addresses (user + type)
    const [countRows] = await db.query(
      `SELECT COUNT(*) AS total
       FROM saved_address
       WHERE user_id = ? AND type = ?`,
      [user_id, type]
    );

    if (countRows[0].total >= 6) {
      return res.status(400).json({
        success: false,
        message: "Saved address limit full. Delete one to continue."
      });
    }

    // 🔹 INSERT address (floor & nearby_landmark optional)
    await db.query(
      `INSERT INTO saved_address 
        (
          user_id,
          type,
          address,
          flat_house_building_name,
          floor,
          nearby_landmark,
          service_latitude,
          service_longitude
        )
       VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        user_id,
        type,
        address,
        flat_house_building_name,
        floor || null,
        nearby_landmark || null,
        service_latitude,
        service_longitude
      ]
    );

    return res.status(200).json({
      success: true,
      message: "Address saved successfully"
    });

  } catch (error) {
    console.log("saveAddress Error:", error);
    return res.status(500).json({
      success: false,
      message: "Server error",
      error: error.message
    });
  }
};


export const getSavedAddress = async (req, res) => {
  try {
    const { user_id, type } = req.body;

    if (!user_id) {
      return res.status(400).json({
        success: false,
        message: "user_id is required"
      });
    }

    let sql = `
      SELECT 
        id,
        user_id,
        type,
        address,
        flat_house_building_name,
        floor,
        nearby_landmark,
        service_latitude,
        service_longitude,
        created_at
      FROM saved_address
      WHERE user_id = ?
    `;
    const params = [user_id];

    if (type) {
      sql += " AND type = ?";
      params.push(type);
    }

    sql += " ORDER BY id DESC";

    const [rows] = await db.query(sql, params);

    return res.status(200).json({
      success: true,
      message: "Saved address fetched successfully",
      data: rows
    });

  } catch (error) {
    console.log("getSavedAddress Error:", error);
    return res.status(500).json({
      success: false,
      message: "Server error",
      error: error.message
    });
  }
};



export const deleteSavedAddressByType = async (req, res) => {
  try {
    const { id, user_id, type } = req.body;

    // 🔹 Validation
    if (!id || !user_id || !type) {
      return res.status(400).json({
        success: false,
        message: "id, user_id and type are required"
      });
    }

    // 🔹 DELETE single address only
    const [result] = await db.query(
      `DELETE FROM saved_address
       WHERE id = ? AND user_id = ? AND type = ?
       LIMIT 1`,
      [id, user_id, type]
    );

    if (result.affectedRows === 0) {
      return res.status(404).json({
        success: false,
        message: "Address not found"
      });
    }

    return res.status(200).json({
      success: true,
      message: "Address deleted successfully"
    });

  } catch (error) {
    console.log("deleteSavedAddressById Error:", error);
    return res.status(500).json({
      success: false,
      message: "Server error",
      error: error.message
    });
  }
};





export const getPolicyByType = async (req, res) => {
  try {
    const type = Number(req.params.type);

    // ✅ validation
    if (![1, 2].includes(type)) {
      return res.status(400).json({
        success: false,
        message: "Invalid policy type. Allowed: 1=Privacy Policy, 2=Terms & Conditions"
      });
    }

    const [rows] = await db.query(
      `
      SELECT 
        id,
        name,
        type,
        description,
        created_at,
        updated_at
      FROM policies
      WHERE type = ?
      LIMIT 1
      `,
      [type]
    );

    if (!rows.length) {
      return res.status(404).json({
        success: false,
        message: "Policy not found"
      });
    }

    return res.status(200).json({
      success: true,
      message: "Policy fetched successfully",
      data: rows[0]
    });

  } catch (error) {
    console.error("Get Policy Error:", error);
    return res.status(500).json({
      success: false,
      message: "Internal server error",
      error: error.message
    });
  }
};



export const getHelpSupport = async (req, res) => {
  try {
    const [rows] = await db.query(
      `
      SELECT id, value
      FROM settings
      WHERE id IN (8, 9)
      `
    );

    if (!rows.length) {
      return res.status(404).json({
        success: false,
        message: "Support details not found"
      });
    }

    const data = {
      email: null,
      support_mobile: null
    };

    rows.forEach(row => {
      if (row.id === 8) {
        data.email = row.value;
      }
      if (row.id === 9) {
        data.support_mobile = row.value;
      }
    });

    return res.status(200).json({
      success: true,
      message: "Help & support details fetched successfully",
      data
    });

  } catch (error) {
    console.error("Help Support API Error:", error);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      error: error.message
    });
  }
};
