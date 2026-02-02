import db from "../config/database.js";

export const vehicleList = async (req, res) => {
  try {
    const { register_status } = req.query;

    let where = "WHERE 1 ";
    let values = [];

    /* =========================
       REGISTER STATUS FILTER
    ========================= */
    if (register_status === "1") {
      where += "AND register_status = ? ";
      values.push(1);
    }

    if (register_status === "0") {
      where += "AND register_status = ? ";
      values.push(0);
    }

    /* =========================
       DATA QUERY (NO LIMIT / OFFSET)
    ========================= */
    const [rows] = await db.query(
      `
      SELECT 
        id,
        name,
        max_passenger,
        image,
        register_status,
        visible_status,
        created_at,
        discount,
        vehicle_category,
        user_increase
      FROM vehicle
      ${where}
      ORDER BY id DESC
      `,
      values
    );
 // console.log("all vehicle data", rows);
    return res.render("vehicle/allvehicle", {
      title: "All Vehicles",
      vehicles: rows,
      register_status
    });

  } catch (err) {
    console.log("vehicleList Error:", err);

    return res.render("vehicle/allvehicle", {
      title: "All Vehicles",
      vehicles: [],
      register_status: ""
    });
  }
};




export const addVehicle = async (req, res) => {
  try {
    const {
      name,
      max_passenger,
      discount,
      user_increase,
      vehicle_type   // 👈 NEW (from form)
    } = req.body;

    // map vehicle_type → vehicle_category
    const vehicle_category = vehicle_type;

    const folderName = "cabbooking/vehicle_image";
    let imagePath = null;

    // image handle
    if (req.file) {
      imagePath = `${folderName}/${req.file.filename}`;
    }

    // basic validation (ONLY vehicle_category added)
    if (
      !name ||
      !max_passenger ||
      discount === undefined ||
      user_increase === undefined ||
      !imagePath ||
      !vehicle_category
    ) {
      req.session.error = "All fields are required!";
      return res.redirect("/vehicles");
    }

    // DB insert (ONLY vehicle_category added)
    await db.query(
      `
      INSERT INTO vehicle 
      (
        name,
        max_passenger,
        image,
        discount,
        user_increase,
        vehicle_category,
        register_status,
        visible_status,
        created_at
      )
      VALUES (?, ?, ?, ?, ?, ?, 1, 1, NOW())
      `,
      [
        name,
        max_passenger,
        imagePath,
        discount,
        user_increase,
        vehicle_category
      ]
    );

    req.session.success = "Vehicle added successfully!";
    return res.redirect("/vehicle-list");

  } catch (err) {
    console.log("ADD VEHICLE ERROR:", err);
    req.session.error = "Something went wrong!";
    return res.redirect("/vehicle-list");
  }
};

export const updateVehicle = async (req, res) => {
  console.log("all data :", req.body);

  try {
    const {
      id,
      name,
      max_passenger,
      discount,
      user_increase,
      vehicle_type,   // 👈 NEW
      old_image
    } = req.body;

    const vehicle_category = vehicle_type;

    if (!id || !name || !max_passenger || !vehicle_category) {
      req.session.error = "Invalid request!";
      return res.redirect("/vehicle-list");
    }

    let imagePath = old_image;

    // image update (same as add)
    if (req.file) {
      imagePath = "cabbooking/vehicle_image/" + req.file.filename;
    }

    await db.query(
      `
      UPDATE vehicle
      SET
        name = ?,
        max_passenger = ?,
        discount = ?,
        user_increase = ?,
        vehicle_category = ?,   -- ✅ ONLY THIS ADDED
        image = ?
      WHERE id = ?
      `,
      [
        name.trim(),
        max_passenger,
        discount,
        user_increase,
        vehicle_category,
        imagePath,
        id
      ]
    );

    req.session.success = "Vehicle updated successfully!";
    return res.redirect("/vehicle-list");

  } catch (err) {
    console.log("UPDATE VEHICLE ERROR:", err);
    req.session.error = "Something went wrong!";
    return res.redirect("/vehicle-list");
  }
};


export const updateVehicleStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { type, status } = req.query;

    if (!id || !type || status === undefined) {
      req.session.error = "Invalid request!";
      return res.redirect("/vehicle-list");
    }

    let sql = "";
    let value = parseInt(status);

    if (type === "register") {
      // register_status: 0 = can register, 1 = cannot register
      sql = "UPDATE vehicle SET register_status = ? WHERE id = ?";
    }
    else if (type === "visible") {
      // visible_status: 0 = hidden, 1 = visible
      sql = "UPDATE vehicle SET visible_status = ? WHERE id = ?";
    }
    else {
      req.session.error = "Invalid status type!";
      return res.redirect("/vehicle-list");
    }

    await db.query(sql, [value, id]);

    req.session.success = "Vehicle status updated successfully!";
    return res.redirect("/vehicle-list");

  } catch (err) {
    console.log("VEHICLE STATUS ERROR:", err);
    req.session.error = "Something went wrong!";
    return res.redirect("/vehicle-list");
  }
};







export const brandList = async (req, res) => {
  try {
    const { register_status } = req.query;

    let where = "WHERE 1 ";
    let values = [];

    /* =========================
       REGISTER STATUS FILTER
    ========================= */
    if (register_status === "1") {
      where += "AND v.register_status = ? ";
      values.push(1);
    }

    if (register_status === "0") {
      where += "AND v.register_status = ? ";
      values.push(0);
    }

    /* =========================
       TABLE DATA
       (1 ROW = 1 BRAND)
    ========================= */
    const [rows] = await db.query(
      `
      SELECT
        v.id            AS id,
        v.name          AS name,
        v.max_passenger,
        v.image,
        v.created_at,

        b.id            AS brand_id,
        b.name          AS brand_name,
        b.status        AS brand_status
      FROM vehicle v
      LEFT JOIN brand b
        ON b.vehicle_id = v.id
      ${where}
      ORDER BY v.id DESC, b.id DESC
      `,
      values
    );

    /* =========================
       VEHICLE LIST (FOR DROPDOWN)
    ========================= */
    const [vehicleRows] = await db.query(
      `
      SELECT
        id,
        name
      FROM vehicle
      ORDER BY name ASC
      `
    );

    return res.render("vehicle/allbrand", {
      title: "Vehicle Brand List",
      vehicles: rows,          // table ke liye
      vehicleList: vehicleRows, // dropdown ke liye
      register_status
    });

  } catch (err) {
    console.log("brandList Error:", err);

    return res.render("vehicle/allbrand", {
      title: "Vehicle Brand List",
      vehicles: [],
      vehicleList: [],
      register_status: ""
    });
  }
};




export const updateBrandStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.query;

    // basic validation
    if (!id || (status !== "0" && status !== "1")) {
      req.session.error = "Invalid request!";
      return res.redirect("/brand-list");
    }

    await db.query(
      `
      UPDATE brand
      SET status = ?
      WHERE id = ?
      `,
      [status, id]
    );

    req.session.success =
      status == 1
        ? "Brand activated successfully!"
        : "Brand deactivated successfully!";

    return res.redirect("/brand-list");

  } catch (err) {
    console.log("updateBrandStatus Error:", err);

    req.session.error = "Something went wrong!";
    return res.redirect("/brand-list");
  }
};


export const addBrand = async (req, res) => {
  try {
    const { vehicle_id, name } = req.body;

    /* =========================
       BASIC VALIDATION
    ========================= */
    if (!vehicle_id || !name || !name.trim()) {
      req.session.error = "Vehicle and Brand name are required!";
      return res.redirect("/brand-list");
    }

    /* =========================
       DUPLICATE CHECK
    ========================= */
    const [exists] = await db.query(
      `
      SELECT id
      FROM brand
      WHERE vehicle_id = ?
        AND name = ?
      LIMIT 1
      `,
      [vehicle_id, name.trim()]
    );

    if (exists.length) {
      req.session.error = "Brand already exists for this vehicle!";
      return res.redirect("/brand-list");
    }

    /* =========================
       INSERT BRAND
    ========================= */
    await db.query(
      `
      INSERT INTO brand (vehicle_id, name, status)
      VALUES (?, ?, 1)
      `,
      [vehicle_id, name.trim()]
    );

    req.session.success = "Brand added successfully!";
    return res.redirect("/brand-list");

  } catch (err) {
    console.log("ADD BRAND ERROR:", err);
    req.session.error = "Something went wrong!";
    return res.redirect("/brand-list");
  }
};





export const updateBrand = async (req, res) => {
  try {
    const { brand_id, vehicle_id, name } = req.body;

    if (!brand_id || !vehicle_id || !name.trim()) {
      req.session.error = "Invalid request!";
      return res.redirect("/brand-list");
    }

    await db.query(
      `
      UPDATE brand
      SET vehicle_id = ?, name = ?
      WHERE id = ?
      `,
      [vehicle_id, name.trim(), brand_id]
    );

    req.session.success = "Brand updated successfully!";
    return res.redirect("/brand-list");

  } catch (err) {
    console.log("UPDATE BRAND ERROR:", err);
    req.session.error = "Something went wrong!";
    return res.redirect("/brand-list");
  }
};







export const modelList = async (req, res) => {
  try {
    /* =========================
       TABLE DATA (Vehicle + Brand + Model)
    ========================= */
    const [rows] = await db.query(`
      SELECT
        v.id   AS vehicle_id,
        v.name AS vehicle_name,
        v.image AS vehicle_image,

        b.id   AS brand_id,
        b.name AS brand_name,

        m.id   AS model_id,
        m.name AS model_name,
        m.status AS model_status,
        m.created_at AS model_created_at

      FROM vehicle v
      LEFT JOIN brand b ON b.vehicle_id = v.id
      LEFT JOIN model m ON m.brand_id = b.id
      ORDER BY v.id DESC, b.id DESC, m.id DESC
    `);

    /* =========================
       VEHICLE LIST (TOP FILTER)
    ========================= */
    const [vehicles] = await db.query(`
      SELECT id, name
      FROM vehicle
      ORDER BY name ASC
    `);

    /* =========================
       BRAND LIST (ADD MODEL DROPDOWN)
       👉 ONLY BRAND, NO VEHICLE
    ========================= */
    const [brands] = await db.query(`
      SELECT
        id,
        name
      FROM brand
      ORDER BY name ASC
    `);

    return res.render("vehicle/model-list", {
      title: "Model List",
      rows,
      vehicles,
      brands
    });

  } catch (err) {
    console.log("MODEL LIST ERROR:", err);

    return res.render("vehicle/model-list", {
      title: "Model List",
      rows: [],
      vehicles: [],
      brands: []
    });
  }
};


export const getBrandsByVehicle = async (req, res) => {
  const { vehicle_id } = req.params;

  const [rows] = await db.query(
    `SELECT id, name FROM brand WHERE vehicle_id = ? ORDER BY name ASC`,
    [vehicle_id]
  );

  res.json(rows);
};



export const getModelsByFilter = async (req, res) => {
  const { vehicle_id, brand_id } = req.query;

  let where = "WHERE 1 ";
  let values = [];

  if (vehicle_id) {
    where += "AND v.id = ? ";
    values.push(vehicle_id);
  }

  if (brand_id) {
    where += "AND b.id = ? ";
    values.push(brand_id);
  }

  const [rows] = await db.query(
    `
    SELECT
      v.name AS vehicle_name,
      v.image AS vehicle_image,
      b.name AS brand_name,
      m.id AS model_id,
      m.name AS model_name,
      m.status AS model_status,
      m.created_at AS model_created_at
    FROM vehicle v
    LEFT JOIN brand b ON b.vehicle_id = v.id
    LEFT JOIN model m ON m.brand_id = b.id
    ${where}
    ORDER BY m.id DESC
    `,
    values
  );

  res.json(rows);
};





export const addModel = async (req, res) => {
  try {
    const { brand_id, name } = req.body;

    if (!brand_id || !name.trim()) {
      req.session.error = "Brand and model name required!";
      return res.redirect("/model-list");
    }

    // duplicate check
    const [exists] = await db.query(
      `
      SELECT id
      FROM model
      WHERE brand_id = ?
        AND name = ?
      LIMIT 1
      `,
      [brand_id, name.trim()]
    );

    if (exists.length) {
      req.session.error = "Model already exists!";
      return res.redirect("/model-list");
    }

    await db.query(
      `
      INSERT INTO model (brand_id, name, status)
      VALUES (?, ?, 1)
      `,
      [brand_id, name.trim()]
    );

    req.session.success = "Model added successfully!";
    return res.redirect("/model-list");

  } catch (err) {
    console.log("ADD MODEL ERROR:", err);
    req.session.error = "Something went wrong!";
    return res.redirect("/model-list");
  }
};




export const updateModel = async (req, res) => {
  try {
    const {
      model_id,   // 👈 modal se aa raha hai
      brand_id,
      name
    } = req.body;

    /* =========================
       BASIC VALIDATION
    ========================= */
    if (!model_id || !brand_id || !name || !name.trim()) {
      req.session.error = "Brand and model name required!";
      return res.redirect("/model-list");
    }

    /* =========================
       DUPLICATE CHECK
    ========================= */
    const [exists] = await db.query(
      `
      SELECT id
      FROM model
      WHERE brand_id = ?
        AND name = ?
        AND id != ?
      LIMIT 1
      `,
      [brand_id, name.trim(), model_id]
    );

    if (exists.length) {
      req.session.error = "Model already exists!";
      return res.redirect("/model-list");
    }

    /* =========================
       UPDATE MODEL
    ========================= */
    await db.query(
      `
      UPDATE model
      SET
        brand_id = ?,
        name = ?
      WHERE id = ?
      `,
      [brand_id, name.trim(), model_id]
    );

    req.session.success = "Model updated successfully!";
    return res.redirect("/model-list");

  } catch (err) {
    console.log("UPDATE MODEL ERROR:", err);
    req.session.error = "Something went wrong!";
    return res.redirect("/model-list");
  }
};



export const updateModelStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.query;

    /* =========================
       BASIC VALIDATION
    ========================= */
    if (!id || (status !== "0" && status !== "1")) {
      req.session.error = "Invalid request!";
      return res.redirect("/model-list");
    }

    /* =========================
       UPDATE STATUS
    ========================= */
    await db.query(
      `
      UPDATE model
      SET status = ?
      WHERE id = ?
      `,
      [status, id]
    );

    req.session.success =
      status === "1"
        ? "Model activated successfully!"
        : "Model deactivated successfully!";

    return res.redirect("/model-list");

  } catch (err) {
    console.log("MODEL STATUS UPDATE ERROR:", err);
    req.session.error = "Something went wrong!";
    return res.redirect("/model-list");
  }
};


export const vehicleAmountList = async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT
        vc.id AS charge_id,
        v.id  AS vehicle_id,
        v.name AS vehicle_name,

        IF(vc.id IS NULL, 'NOT SET', vc.from_km)     AS from_km,
        IF(vc.id IS NULL, 'NOT SET', vc.to_km)       AS to_km,
        IF(vc.id IS NULL, 'NOT SET', vc.rate_per_km) AS rate_per_km

      FROM vehicle v
      LEFT JOIN vehicle_charges vc
        ON vc.vehicle_id = v.id

      ORDER BY v.id DESC, vc.from_km ASC
    `);

    res.render("vehicle/vehicleAmountList", {
      title: "Vehicle Amount List",
      rows
    });

  } catch (err) {
    console.log("vehicleAmountList Error:", err);
    res.render("vehicle/vehicleAmountList", {
      title: "Vehicle Amount List",
      rows: []
    });
  }
};


export const vehicleAmountAdd = async (req, res) => {
  try {
    const { vehicle_id, from_km, to_km, rate_per_km } = req.body;

    if (!vehicle_id || !from_km || !to_km || !rate_per_km) {
      req.session.error = "All fields are required";
      return res.redirect("/vehicle-amount-list");
    }

    if (Number(from_km) >= Number(to_km)) {
      req.session.error = "From KM must be less than To KM";
      return res.redirect("/vehicle-amount-list");
    }

    /* ===== OVERLAP CHECK ===== */
    const [exists] = await db.query(
      `
      SELECT id
      FROM vehicle_charges
      WHERE vehicle_id = ?
        AND (
          (from_km < ? AND to_km > ?)
          OR
          (from_km >= ? AND from_km < ?)
        )
      LIMIT 1
      `,
      [vehicle_id, from_km, from_km, from_km, to_km]
    );

    if (exists.length) {
      req.session.error = "KM slab already exists or overlaps";
      return res.redirect("/vehicle-amount-list");
    }

    /* ===== INSERT ===== */
    await db.query(
      `
      INSERT INTO vehicle_charges
        (vehicle_id, from_km, to_km, rate_per_km, created_at)
      VALUES
        (?, ?, ?, ?, NOW())
      `,
      [vehicle_id, from_km, to_km, rate_per_km]
    );

    req.session.success = "Vehicle amount slab added successfully";
    res.redirect("/vehicle-amount-list");

  } catch (err) {
    console.log("vehicleAmountAdd Error:", err);
    req.session.error = "Something went wrong";
    res.redirect("/vehicle-amount-list");
  }
};


export const vehicleAmountUpdate = async (req, res) => {
  try {
    const { id, from_km, to_km, rate_per_km } = req.body;

    if (!id || !from_km || !to_km || !rate_per_km) {
      req.session.error = "All fields are required";
      return res.redirect("/vehicle-amount-list");
    }

    if (Number(from_km) >= Number(to_km)) {
      req.session.error = "From KM must be less than To KM";
      return res.redirect("/vehicle-amount-list");
    }

    /* ===== GET VEHICLE ID ===== */
    const [[row]] = await db.query(
      `SELECT vehicle_id FROM vehicle_charges WHERE id = ?`,
      [id]
    );

    if (!row) {
      req.session.error = "Invalid slab";
      return res.redirect("/vehicle-amount-list");
    }

    /* ===== OVERLAP CHECK (EXCEPT SELF) ===== */
    const [exists] = await db.query(
      `
      SELECT id
      FROM vehicle_charges
      WHERE vehicle_id = ?
        AND id != ?
        AND (
          (from_km < ? AND to_km > ?)
          OR
          (from_km >= ? AND from_km < ?)
        )
      LIMIT 1
      `,
      [row.vehicle_id, id, from_km, from_km, from_km, to_km]
    );

    if (exists.length) {
      req.session.error = "Overlapping KM slab exists";
      return res.redirect("/vehicle-amount-list");
    }

    /* ===== UPDATE ===== */
    await db.query(
      `
      UPDATE vehicle_charges
      SET from_km = ?, to_km = ?, rate_per_km = ?, updated_at = NOW()
      WHERE id = ?
      `,
      [from_km, to_km, rate_per_km, id]
    );

    req.session.success = "Vehicle amount updated successfully";
    res.redirect("/vehicle-amount-list");

  } catch (err) {
    console.log("vehicleAmountUpdate Error:", err);
    req.session.error = "Something went wrong";
    res.redirect("/vehicle-amount-list");
  }
};


export const vehicleAmountDelete = async (req, res) => {
  try {
    const { id } = req.params;

    if (!id) {
      req.session.error = "Invalid slab id";
      return res.redirect("/vehicle-amount-list");
    }

    await db.query(
      `DELETE FROM vehicle_charges WHERE id = ?`,
      [id]
    );

    req.session.success = "Vehicle amount slab deleted successfully";
    res.redirect("/vehicle-amount-list");

  } catch (err) {
    console.log("vehicleAmountDelete Error:", err);
    req.session.error = "Something went wrong";
    res.redirect("/vehicle-amount-list");
  }
};



