import db from "../../config/database.js";

/* =========================================================
   HELPER: BUILD UPDATE OBJECT (PARTIAL UPDATE SAFE)
========================================================= */
function buildUpdateObject(data, files, folder) {
  const update = {};

  const setIfExists = (key, value) => {
    if (value !== undefined && value !== null && value !== "") {
      update[key] = value;
    }
  };

  const setFileIfExists = (key) => {
    if (files[key]) {
      update[key] = `${folder}/${files[key][0].filename}`;
    }
  };

  // 🔹 Personal Information
  setIfExists("platform_type", data.platform_type);
  setIfExists("vehicle_type", data.vehicle_type);
  setIfExists("vehicle_name", data.vehicle_name);
  setIfExists("first_name", data.first_name);
  setIfExists("last_name", data.last_name);
  setIfExists("mobile", data.mobile);
  setIfExists("date_of_birth", data.date_of_birth);
  setIfExists("device_id", data.device_id);
  setIfExists("fcm_token", data.fcm_token);
  setIfExists("personal_information_status", data.personal_information_status);
  setFileIfExists("profile_photo");

  // 🔹 Driver Licence
  setIfExists("driver_licence_number", data.driver_licence_number);
  setIfExists("licence_validity_date", data.licence_validity_date);
  setIfExists("driver_licence_status", data.driver_licence_status);
  setFileIfExists("driver_licence_front");
  setFileIfExists("driver_licence_back");

  // 🔹 Aadhaar & PAN
  setIfExists("aadhaar_number", data.aadhaar_number);
  setIfExists("pan_card_number", data.pan_card_number);
  setIfExists("aadhaar_pan_status", data.aadhaar_pan_status);
  setFileIfExists("aadhaar_front");
  setFileIfExists("aadhaar_back");
  setFileIfExists("pan_card_front");
  setFileIfExists("pan_card_back");

  // 🔹 Certificates
  setIfExists("required_certificates_status", data.required_certificates_status);
  setFileIfExists("fitness_certificate");
  setFileIfExists("pollution_certificate");
  setFileIfExists("insurance_certificate");
  setFileIfExists("police_certificate");

  // 🔹 Vehicle Info
  setIfExists("vehicle_info_status", data.vehicle_info_status);
  setIfExists("brand_id", data.brand_id);
  setIfExists("brand_name", data.brand_name);
  setIfExists("model_id", data.model_id);
  setIfExists("model_name", data.model_name);
  setIfExists("vehicle_color", data.vehicle_color);
  setIfExists("vehicle_plate_number", data.vehicle_plate_number);
  setIfExists("vehicle_production_year", data.vehicle_production_year);
  setFileIfExists("vehicle_photo");

  // 🔹 Vehicle Documents
  setIfExists("vehicle_documents_status", data.vehicle_documents_status);
  setFileIfExists("vehicle_permit_part_a");
  setFileIfExists("vehicle_permit_part_b");
  setFileIfExists("vehicle_registration_front");
  setFileIfExists("vehicle_registration_back");

  update.updated_at = new Date();
  return update;
}

/* =========================================================
   CONTROLLER
========================================================= */
export const driverRegister = async (req, res) => {
  try {
    const data = req.body;
    const files = req.files || {};
    const folder = "DriverDocuments";

    const {
      id,
      personal_information_status,
      driver_licence_status,
      aadhaar_pan_status,
      required_certificates_status,
      vehicle_info_status,
      vehicle_documents_status
    } = data;

    const getFile = (name) =>
      files[name] ? `${folder}/${files[name][0].filename}` : null;

    /* ================= STEP 1 ================= */
    if (personal_information_status == 1) {
      const missing = [];

      if (!data.platform_type) missing.push("platform_type");
      if (!data.vehicle_type) missing.push("vehicle_type");
      if (!data.vehicle_name) missing.push("vehicle_name");
      if (!data.first_name) missing.push("first_name");
      if (!data.last_name) missing.push("last_name");
      if (!data.mobile) missing.push("mobile");
      if (!data.date_of_birth) missing.push("date_of_birth");
      if (!data.device_id) missing.push("device_id");
      if (!data.fcm_token) missing.push("fcm_token");
      if (!getFile("profile_photo")) missing.push("profile_photo");

      if (missing.length) {
        return res.status(400).json({
          message: "Personal information fields are required",
          missing_fields: missing
        });
      }

      /* 🔥 DUPLICATE MOBILE FIX (LOGIC SAME) */
      if (!id) {
        const [[existing]] = await db.query(
          "SELECT id FROM driver_registration WHERE mobile = ? LIMIT 1",
          [data.mobile]
        );

        if (existing) {
          await db.query(
            "UPDATE driver_registration SET ? WHERE id = ?",
            [buildUpdateObject(data, files, folder), existing.id]
          );

          return res.status(200).json({
            message: "Personal information saved successfully",
            platform_type: 2,
            id: existing.id
          });
        }

        const [result] = await db.query(
          `INSERT INTO driver_registration
           (
             platform_type,
             vehicle_type,
             vehicle_name,
             date_of_birth,
             first_name,
             last_name,
             mobile,
             profile_photo,
             device_id,
             fcm_token,
             personal_information_status,
             created_at
           )
           VALUES (?,?,?,?,?,?,?,?,?,?,1,NOW())`,
          [
            data.platform_type,
            data.vehicle_type,
            data.vehicle_name,
            data.date_of_birth,
            data.first_name,
            data.last_name,
            data.mobile,
            getFile("profile_photo"),
            data.device_id,
            data.fcm_token
          ]
        );

        return res.status(200).json({
          message: "Personal information saved successfully",
          platform_type: 2,
          id: result.insertId
        });
      }
    }

    /* ================= DRIVER LICENCE ================= */
    if (driver_licence_status == 1) {
      const missing = [];
      if (!data.driver_licence_number) missing.push("driver_licence_number");
      if (!data.licence_validity_date) missing.push("licence_validity_date");
      if (!getFile("driver_licence_front")) missing.push("driver_licence_front");
      if (!getFile("driver_licence_back")) missing.push("driver_licence_back");

      if (missing.length) {
        return res.status(400).json({
          message: "Driver licence fields are required",
          missing_fields: missing
        });
      }
    }

    /* ================= AADHAAR + PAN ================= */
    if (aadhaar_pan_status == 1) {
      const missing = [];
      if (!data.aadhaar_number) missing.push("aadhaar_number");
      if (!data.pan_card_number) missing.push("pan_card_number");
      if (!getFile("aadhaar_front")) missing.push("aadhaar_front");
      if (!getFile("aadhaar_back")) missing.push("aadhaar_back");
      if (!getFile("pan_card_front")) missing.push("pan_card_front");
      if (!getFile("pan_card_back")) missing.push("pan_card_back");

      if (missing.length) {
        return res.status(400).json({
          message: "Aadhaar & PAN fields are required",
          missing_fields: missing
        });
      }
    }

    /* ================= CERTIFICATES ================= */
    if (required_certificates_status == 1) {
      const missing = [];
      if (!getFile("fitness_certificate")) missing.push("fitness_certificate");
      if (!getFile("pollution_certificate")) missing.push("pollution_certificate");
      if (!getFile("insurance_certificate")) missing.push("insurance_certificate");
      if (!getFile("police_certificate")) missing.push("police_certificate");

      if (missing.length) {
        return res.status(400).json({
          message: "Certificate fields are required",
          missing_fields: missing
        });
      }
    }

    /* ================= VEHICLE INFO ================= */
    if (vehicle_info_status == 1) {
      const missing = [];
      if (!data.brand_id) missing.push("brand_id");
      if (!data.brand_name) missing.push("brand_name");
      if (!data.model_id) missing.push("model_id");
      if (!data.model_name) missing.push("model_name");
      if (!data.vehicle_plate_number) missing.push("vehicle_plate_number");
      if (!data.vehicle_production_year) missing.push("vehicle_production_year");
      if (!getFile("vehicle_photo")) missing.push("vehicle_photo");

      if (missing.length) {
        return res.status(400).json({
          message: "Vehicle information fields are required",
          missing_fields: missing
        });
      }
    }

    /* ================= VEHICLE DOCUMENTS ================= */
    if (vehicle_documents_status == 1) {
      const missing = [];
      if (!getFile("vehicle_permit_part_a")) missing.push("vehicle_permit_part_a");
      if (!getFile("vehicle_permit_part_b")) missing.push("vehicle_permit_part_b");
      if (!getFile("vehicle_registration_front"))
        missing.push("vehicle_registration_front");

      if (missing.length) {
        return res.status(400).json({
          message: "Vehicle documents fields are required",
          missing_fields: missing
        });
      }
    }

    /* ================= UPDATE (STEP 2–6) ================= */
    if (!id) {
      return res.status(400).json({ message: "id is required for this step" });
    }

    await db.query(
      "UPDATE driver_registration SET ? WHERE id = ?",
      [buildUpdateObject(data, files, folder), id]
    );

    let message = "Step submitted successfully";
    if (driver_licence_status == 1)
      message = "Driver licence details submitted successfully";
    else if (aadhaar_pan_status == 1)
      message = "Aadhaar & PAN details submitted successfully";
    else if (required_certificates_status == 1)
      message = "Certificates submitted successfully";
    else if (vehicle_info_status == 1)
      message = "Vehicle information submitted successfully";
    else if (vehicle_documents_status == 1)
      message = "Vehicle documents submitted successfully";

    return res.status(200).json({ message, id });

  } catch (error) {
    console.log("driverRegister Error:", error);
    return res.status(500).json({
      message: "Internal Server Error",
      error: error.message
    });
  }
};






export const getDriverProfile = async (req, res) => {
  try {
    const { id, current_latitude, current_longitude } = req.body;

    // 🔹 BASIC VALIDATION
    const missing = [];
    if (!id) missing.push("id");
    if (!current_latitude) missing.push("current_latitude");
    if (!current_longitude) missing.push("current_longitude");

    if (missing.length) {
      return res.status(400).json({
        message: "Required fields are missing",
        missing_fields: missing
      });
    }

    // ✅ SAME BASE_URL PATTERN
    const BASE_URL = process.env.BASE_URL || "";

    // 🔹 UPDATE CURRENT LOCATION
    await db.query(
      `UPDATE driver_registration
       SET current_latitude = ?, current_longitude = ?, updated_at = NOW()
       WHERE id = ?`,
      [current_latitude, current_longitude, id]
    );

    // 🔹 FETCH PROFILE
    const [rows] = await db.query(
      `SELECT
        id,
        wallet,
        due_wallet,
        platform_type,
        vehicle_type,
        vehicle_name,
        first_name,
        last_name,
        mobile,
        date_of_birth,
        profile_photo,
        device_id,
        fcm_token,
        online_status,

        personal_information_status,
        personal_information_reject_reason,

        driver_licence_status,
        driver_licence_reject_reason,
        driver_licence_number,
        licence_validity_date,
        driver_licence_front,
        driver_licence_back,

        aadhaar_pan_status,
        aadhaar_pan_reject_reason,
        aadhaar_number,
        pan_card_number,
        aadhaar_front,
        aadhaar_back,
        pan_card_front,
        pan_card_back,

        required_certificates_status,
        required_certificates_reject_reason,
        fitness_certificate,
        pollution_certificate,
        insurance_certificate,
        police_certificate,

        vehicle_info_status,
        vehicle_info_reject_reason,
        brand_id,
        brand_name,
        model_id,
        model_name,
        vehicle_color,
        vehicle_plate_number,
        vehicle_production_year,
        vehicle_photo,

        vehicle_documents_status,
        vehicle_documents_reject_reason,
        vehicle_permit_part_a,
        vehicle_permit_part_b,
        vehicle_registration_front,
        vehicle_registration_back,

        current_latitude,
        current_longitude,
        created_at,
        updated_at
      FROM driver_registration
      WHERE id = ?
      LIMIT 1`,
      [id]
    );

    if (!rows.length) {
      return res.status(404).json({
        message: "Driver profile not found"
      });
    }

    // ✅ EXACT SAME STYLE AS YOUR EXAMPLE
    const data = {
      ...rows[0],

      profile_photo: rows[0].profile_photo
        ? `${BASE_URL}/${rows[0].profile_photo}`
        : null,

      driver_licence_front: rows[0].driver_licence_front
        ? `${BASE_URL}/${rows[0].driver_licence_front}`
        : null,

      driver_licence_back: rows[0].driver_licence_back
        ? `${BASE_URL}/${rows[0].driver_licence_back}`
        : null,

      aadhaar_front: rows[0].aadhaar_front
        ? `${BASE_URL}/${rows[0].aadhaar_front}`
        : null,

      aadhaar_back: rows[0].aadhaar_back
        ? `${BASE_URL}/${rows[0].aadhaar_back}`
        : null,

      pan_card_front: rows[0].pan_card_front
        ? `${BASE_URL}/${rows[0].pan_card_front}`
        : null,

      pan_card_back: rows[0].pan_card_back
        ? `${BASE_URL}/${rows[0].pan_card_back}`
        : null,

      fitness_certificate: rows[0].fitness_certificate
        ? `${BASE_URL}/${rows[0].fitness_certificate}`
        : null,

      pollution_certificate: rows[0].pollution_certificate
        ? `${BASE_URL}/${rows[0].pollution_certificate}`
        : null,

      insurance_certificate: rows[0].insurance_certificate
        ? `${BASE_URL}/${rows[0].insurance_certificate}`
        : null,

      police_certificate: rows[0].police_certificate
        ? `${BASE_URL}/${rows[0].police_certificate}`
        : null,

      vehicle_photo: rows[0].vehicle_photo
        ? `${BASE_URL}/${rows[0].vehicle_photo}`
        : null,

      vehicle_permit_part_a: rows[0].vehicle_permit_part_a
        ? `${BASE_URL}/${rows[0].vehicle_permit_part_a}`
        : null,

      vehicle_permit_part_b: rows[0].vehicle_permit_part_b
        ? `${BASE_URL}/${rows[0].vehicle_permit_part_b}`
        : null,

      vehicle_registration_front: rows[0].vehicle_registration_front
        ? `${BASE_URL}/${rows[0].vehicle_registration_front}`
        : null,

      vehicle_registration_back: rows[0].vehicle_registration_back
        ? `${BASE_URL}/${rows[0].vehicle_registration_back}`
        : null
    };

    return res.status(200).json({
      message: "Profile fetched successfully",
      data
    });

  } catch (error) {
    console.log("getDriverProfile Error:", error);
    return res.status(500).json({
      message: "Internal Server Error",
      error: error.message
    });
  }
};

















export const getBrandByVehicle = async (req, res) => {
  try {
    const { vehicle_id } = req.body;

    if (!vehicle_id) {
      return res.status(400).json({
        message: "vehicle_id is required",
        data: null
      });
    }

    const [rows] = await db.query(
      `SELECT id, name
       FROM brand
       WHERE vehicle_id = ? AND status = 1
       ORDER BY name`,
      [vehicle_id]
    );

    return res.status(200).json({
      message: "Brand list fetched successfully",
      data: rows
    });

  } catch (error) {
    return res.status(500).json({
      message: "Something went wrong",
      error: error.message
    });
  }
};




export const getModelByBrand = async (req, res) => {
  try {
    const { brand_id } = req.body;

    if (!brand_id) {
      return res.status(400).json({
        message: "brand_id is required",
        data: null
      });
    }

    const [rows] = await db.query(
      `SELECT id, name
       FROM model
       WHERE brand_id = ? AND status = 1
       ORDER BY name`,
      [brand_id]
    );

    return res.status(200).json({
      message: "Model list fetched successfully",
      data: rows
    });

  } catch (error) {
    return res.status(500).json({
      message: "Something went wrong",
      error: error.message
    });
  }
};




export const getColors = async (req, res) => {
  try {

    const [rows] = await db.query(
      `SELECT name
       FROM colors
       ORDER BY name`
    );

    return res.status(200).json({
      message: "Color list fetched successfully",
      data: rows
    });

  } catch (error) {
    return res.status(500).json({
      message: "Something went wrong",
      error: error.message
    });
  }
};



