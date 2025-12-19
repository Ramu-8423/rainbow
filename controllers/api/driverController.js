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

  // 🔹 Required Certificates
  setIfExists("required_certificates_status", data.required_certificates_status);
  setFileIfExists("fitness_certificate");
  setFileIfExists("pollution_certificate");
  setFileIfExists("insurance_certificate");
  setFileIfExists("police_certificate");

  // 🔹 Vehicle Information
  setIfExists("vehicle_info_status", data.vehicle_info_status);
  setIfExists("vehicle_brand", data.vehicle_brand);
  setIfExists("vehicle_model", data.vehicle_model);
  setIfExists("vehicle_color", data.vehicle_color);
  setIfExists("vehicle_plate_number", data.vehicle_plate_number);
  setIfExists("vehicle_production_year", data.vehicle_production_year);
  setFileIfExists("vehicle_photo");

  // 🔹 Vehicle Documents
  setIfExists("vehicle_documents_status", data.vehicle_documents_status);
  setFileIfExists("vehicle_permit_part_a");
  setFileIfExists("vehicle_permit_part_b");
  setFileIfExists("vehicle_registration_front");
  setFileIfExists("vehicle_registration_back"); // OPTIONAL

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

    /* =====================================================
       STEP 1: PERSONAL INFORMATION
    ===================================================== */
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

      // 🔹 UPDATE
      if (id) {
        await db.query(
          "UPDATE driver_registration SET ? WHERE id = ?",
          [buildUpdateObject(data, files, folder), id]
        );

        return res.status(200).json({
          message: "Personal information updated successfully",
          id
        });
      }

      // 🔹 INSERT
      const [result] = await db.query(
        `INSERT INTO driver_registration
         (first_name, last_name, mobile, profile_photo, device_id, fcm_token, personal_information_status, created_at)
         VALUES (?, ?, ?, ?, ?, ?, 1, NOW())`,
        [
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
        id: result.insertId
      });
    }

    /* =====================================================
       STEP 2–6: UPDATE ONLY (ID REQUIRED)
    ===================================================== */
    if (
      driver_licence_status == 1 ||
      aadhaar_pan_status == 1 ||
      required_certificates_status == 1 ||
      vehicle_info_status == 1 ||
      vehicle_documents_status == 1
    ) {
      if (!id) {
        return res.status(400).json({
          message: "id is required for this step"
        });
      }

      await db.query(
        "UPDATE driver_registration SET ? WHERE id = ?",
        [buildUpdateObject(data, files, folder), id]
      );

      return res.status(200).json({
        message: "Step submitted successfully",
        id
      });
    }

    return res.status(400).json({
      message: "Invalid request"
    });

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

    // 🔹 UPDATE CURRENT LOCATION
    await db.query(
      `UPDATE driver_registration
       SET current_latitude = ?, current_longitude = ?, updated_at = NOW()
       WHERE id = ?`,
      [current_latitude, current_longitude, id]
    );

    // 🔹 FETCH FULL PROFILE
    const [rows] = await db.query(
      `SELECT
        id,

        -- Personal Info
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

        personal_information_status,
        personal_information_reject_reason,

        -- Driver Licence
        driver_licence_status,
        driver_licence_reject_reason,
        driver_licence_number,
        licence_validity_date,
        driver_licence_front,
        driver_licence_back,

        -- Aadhaar & PAN
        aadhaar_pan_status,
        aadhaar_pan_reject_reason,
        aadhaar_number,
        pan_card_number,
        aadhaar_front,
        aadhaar_back,
        pan_card_front,
        pan_card_back,

        -- Certificates
        required_certificates_status,
        required_certificates_reject_reason,
        fitness_certificate,
        pollution_certificate,
        insurance_certificate,
        police_certificate,

        -- Vehicle Info
        vehicle_info_status,
        vehicle_info_reject_reason,
        vehicle_brand,
        vehicle_model,
        vehicle_color,
        vehicle_plate_number,
        vehicle_production_year,
        vehicle_photo,

        -- Vehicle Docs
        vehicle_documents_status,
        vehicle_documents_reject_reason,
        vehicle_permit_part_a,
        vehicle_permit_part_b,
        vehicle_registration_front,
        vehicle_registration_back,

        -- Location
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

    return res.status(200).json({
      message: "Profile fetched successfully",
      data: rows[0]
    });

  } catch (error) {
    console.log("getDriverProfile Error:", error);
    return res.status(500).json({
      message: "Internal Server Error",
      error: error.message
    });
  }
};
