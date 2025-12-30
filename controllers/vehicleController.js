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
        driver_can_discount
      FROM vehicle
      ${where}
      ORDER BY id DESC
      `,
      values
    );

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
      user_increase
    } = req.body;

    const folderName = "cabbooking/vehicle_image";
    let imagePath = null;

    // image handle
    if (req.file) {
      imagePath = `${folderName}/${req.file.filename}`;
    }

    // basic validation
    if (
      !name ||
      !max_passenger ||
      discount === undefined ||
      user_increase === undefined ||
      !imagePath
    ) {
      req.session.error = "All fields are required!";
      return res.redirect("/vehicles");
    }

    // DB insert
    await db.query(
      `
      INSERT INTO vehicle 
      (name, max_passenger, image, discount, user_increase, register_status, visible_status, created_at)
      VALUES (?, ?, ?, ?, ?, 1, 1, NOW())
      `,
      [
        name,
        max_passenger,
        imagePath,
        discount,
        user_increase
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
