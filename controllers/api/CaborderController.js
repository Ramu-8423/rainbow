import db from "../../config/database.js";
import { FCMHelper } from "../../middleware/fcmHelper.js";
import { nowIST } from "../../utils/dateParser.js";
import { getFirestore } from "../../utils/firebaseInit.js";

/* =========================================================
   DISTANCE FUNCTION (SAME)
========================================================= */
function getDistanceInKm(lat1, lon1, lat2, lon2) {
  const toRad = (v) => (v * Math.PI) / 180;
  return (
    6371 *
    Math.acos(
      Math.cos(toRad(lat1)) *
        Math.cos(toRad(lat2)) *
        Math.cos(toRad(lon2) - toRad(lon1)) +
        Math.sin(toRad(lat1)) *
          Math.sin(toRad(lat2))
    )
  );
}

/* =========================================================
   🔥 OTP GENERATOR (ADDED – NEW CODE ONLY)
========================================================= */
export async function generateUniqueOTP(db) {
  while (true) {
    const otp = Math.floor(1000 + Math.random() * 9000);
    const [rows] = await db.query(
      "SELECT id FROM cab_orders WHERE orderOtp = ? LIMIT 1",
      [otp]
    );
    if (rows.length === 0) return otp;
  }
}

/* =========================================================
   ULTRA FAST VALIDATION (SAME RULES + MESSAGES)
========================================================= */
function validateCabOrder(body) {
  if (!body.user_id) return "user_id is required";

  if (!body.vehicle_id) return "vehicle_id is required";
  if (!body.vehicle_name) return "vehicle_name is required";

  if (!body.brand_id) return "brand_id is required";
  if (!body.brand_name) return "brand_name is required";

  if (!body.model_id) return "model_id is required";
  if (!body.model_name) return "model_name is required";

  if (!body.pickup_location) return "pickup_location is required";
  if (!body.pickup_latitude) return "pickup_latitude is required";
  if (!body.pickup_longitude) return "pickup_longitude is required";

  if (!body.drop_location) return "drop_location is required";
  if (!body.drop_latitude) return "drop_latitude is required";
  if (!body.drop_longitude) return "drop_longitude is required";

  if (!body.estimated_amount) return "estimated_amount is required";

  if (!body.order_type) return "order_type is required";
  if (![1, 2].includes(Number(body.order_type)))
    return "order_type must be 1 or 2";

  if (!body.pay_mode) return "pay_mode is required";

  if (Number(body.order_type) === 2 && !body.schedule_time)
    return "schedule_time is required for later order";

  return null;
}

/* =========================================================
   CAB ORDER API (FASTEST POSSIBLE)
========================================================= */
export const cabOrder = async (req, res) => {

  const validationError = validateCabOrder(req.body);
  if (validationError) {
    return res.status(400).json({
      success: false,
      message: validationError
    });
  }

  try {
    const {
      user_id,
      vehicle_id, vehicle_name,
      brand_id, brand_name,
      model_id, model_name,
      pickup_location, pickup_latitude, pickup_longitude,
      drop_location, drop_latitude, drop_longitude,
      order_type, schedule_time, pay_mode,
      over_limit_passenger,
      user_comment,
      estimated_amount
    } = req.body;

    const distance_km =
      Math.round(
        getDistanceInKm(
          pickup_latitude,
          pickup_longitude,
          drop_latitude,
          drop_longitude
        ) * 100
      ) / 100;

    const createdAt = nowIST();
    console.log("abhi ka time hai:-", createdAt);

    /* 🔥 ADDED: SERVER SIDE OTP */
    const orderOtp = await generateUniqueOTP(db);

    // MySQL INSERT (hamesha hoga)
    const [orderResult] = await db.query(
      `INSERT INTO cab_orders (
        user_id,
        vehicle_id, vehicle_name,
        brand_id, brand_name,
        model_id, model_name,
        pickup_location, pickup_latitude, pickup_longitude,
        drop_location, drop_latitude, drop_longitude,
        distance_km,
        estimated_amount,
        order_type,
        schedule_time,
        pay_mode,
        payment_status,
        over_limit_passenger,
        user_comment,
        orderOtp,                 -- 🔥 ADDED
        created_at,
        updated_at
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        user_id,
        vehicle_id, vehicle_name,
        brand_id, brand_name,
        model_id, model_name,
        pickup_location, pickup_latitude, pickup_longitude,
        drop_location, drop_latitude, drop_longitude,
        distance_km,
        estimated_amount,
        order_type,
        Number(order_type) === 2 ? schedule_time : null,
        pay_mode,
        0,
        over_limit_passenger,
        user_comment,
        orderOtp,                // 🔥 ADDED
        createdAt,
        createdAt
      ]
    );

    const order_id = orderResult.insertId;

    const firestore = getFirestore();

    // Driver match karna
    const snapshot = await firestore
      .collection("driver")
      .where("online_status", "==", 1)
      .where("vehicle_type", "==", Number(vehicle_id))
      .where("brand_id", "==", Number(brand_id))
      .where("model_id", "==", Number(model_id))
      .get();

    const matched_driver_ids = [];

    snapshot.forEach(doc => {
      const d = doc.data();
      if (!d.current_latitude || !d.current_longitude) return;

      const dist = getDistanceInKm(
        d.current_latitude,
        d.current_longitude,
        pickup_latitude,
        pickup_longitude
      );

      if (dist <= 5000) matched_driver_ids.push(Number(doc.id));
    });

    // MySQL me matched_driver_id update karna
    await db.query(
      `UPDATE cab_orders SET matched_driver_id = ? WHERE id = ?`,
      [JSON.stringify(matched_driver_ids), order_id]
    );

    // 🔥 FIREBASE INSERT
    if (matched_driver_ids.length > 0) {
      try {
        const firestoreData = {
          order_id: String(order_id),
          orderOtp: orderOtp, // 🔥 ADDED
          user_id: String(user_id),
          vehicle_id: String(vehicle_id),
          vehicle_name,
          brand_id: String(brand_id),
          brand_name,
          model_id: String(model_id),
          model_name,
          pickup_location,
          pickup_latitude: Number(pickup_latitude),
          pickup_longitude: Number(pickup_longitude),
          drop_location,
          drop_latitude: Number(drop_latitude),
          drop_longitude: Number(drop_longitude),
          distance_km: Number(distance_km),
          estimated_amount: Number(estimated_amount),
          order_type: Number(order_type),
          schedule_time: Number(order_type) === 2 ? schedule_time : null,
          pay_mode,
          payment_status: 0,
          over_limit_passenger: over_limit_passenger || null,
          user_comment: user_comment || null,
          matched_driver_ids,
          created_at: createdAt,
          updated_at: createdAt,
          order_status: 0
        };

        await firestore
          .collection("cab_orders")
          .doc(String(order_id))
          .set(firestoreData);

      } catch (firebaseErr) {
        console.error("Firebase store error:", firebaseErr);
      }
    }

    // FCM notifications background me bhejna
    setImmediate(async () => {
      try {
        if (!matched_driver_ids.length) return;

        const [drivers] = await db.query(
          "SELECT fcm_token FROM driver_registration WHERE id IN (?)",
          [matched_driver_ids]
        );

        for (const drv of drivers) {
          if (!drv.fcm_token) continue;

          await FCMHelper.sendNotification(
            drv.fcm_token,
            "New Cab Ride Request",
            pickup_location,
            {
              order_id: String(order_id),
              pickup_location
            }
          );
        }

      } catch (err) {
        console.error("FCM Background Error:", err);
      }
    });

    return res.status(201).json({
      success: true,
      message: "Cab order created successfully",
      order_id,
      matched_driver_count: matched_driver_ids.length,
      matched_driver_ids
    });

  } catch (err) {
    console.error("Cab Order Error:", err);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      error: err.message
    });
  }
};


export async function driverOnlineStatus(req, res) {
  if (!req.body || Object.keys(req.body).length === 0) {
    return res.status(400).json({
      success: false,
      message: "Request body is missing",
      errors: null
    });
  }

  const { driver_id, online_status, current_latitude, current_longitude } =
    req.body;

  if (!driver_id) {
    return res.status(400).json({
      success: false,
      message: "driver_id is required",
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

  if (current_latitude === undefined || current_longitude === undefined) {
    return res.status(400).json({
      success: false,
      message: "current_latitude & current_longitude are required",
      errors: null
    });
  }

  try {
    const createdAt = nowIST();

    const [rows] = await db.query(
      `
      SELECT
        id,
        vehicle_type,
        model_id,
        brand_id,
        vehicle_name,
        mobile,
        device_id,
        fcm_token,
        model_name,
        brand_name,
        login_status,
        online_status,
        created_at
      FROM driver_registration
      WHERE id = ?
      LIMIT 1
      `,
      [driver_id]
    );

    if (!rows.length) {
      return res.status(404).json({
        success: false,
        message: "Driver not found",
        errors: null
      });
    }

    const driver = rows[0];
    const newStatus = Number(online_status);
    const statusChanged = Number(driver.online_status) !== newStatus;

    /* =========================
       UPDATE SQL
    ========================= */
    await db.query(
      `
      UPDATE driver_registration
      SET
        online_status = ?,
        current_latitude = ?,
        current_longitude = ?,
        updated_at = ?
      WHERE id = ?
      `,
      [
        newStatus,
        Number(current_latitude),
        Number(current_longitude),
        createdAt,
        driver_id
      ]
    );

    const firestore = getFirestore();

    /* =========================
       FIREBASE PAYLOAD
    ========================= */
    const firebasePayload = {
      id: Number(driver.id),

      vehicle_type: Number(driver.vehicle_type),
      brand_id: Number(driver.brand_id),
      model_id: Number(driver.model_id),

      vehicle_name: driver.vehicle_name,
      brand_name: driver.brand_name,
      model_name: driver.model_name,

      mobile: driver.mobile,
      device_id: driver.device_id,
      fcm_token: driver.fcm_token,

      login_status: Number(driver.login_status),
      online_status: newStatus,

      current_latitude: Number(current_latitude),
      current_longitude: Number(current_longitude),

      created_at: driver.created_at,
      updated_at: createdAt
    };

    await firestore
      .collection("driver")
      .doc(String(driver_id))
      .set(firebasePayload, { merge: true });

    return res.status(200).json({
      success: true,
      message: statusChanged
        ? newStatus === 1
          ? "You are now online"
          : "You are now offline"
        : "Location updated successfully",
      errors: null
    });

  } catch (err) {
    console.log("Driver Online Status Error:", err);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      errors: err.message
    });
  }
}

function calculateDistanceInKm(lat1, lon1, lat2, lon2) {
  const toRad = (v) => (v * Math.PI) / 180;

  const distance =
    6371 * Math.acos(
      Math.cos(toRad(lat1)) *
        Math.cos(toRad(lat2)) *
        Math.cos(toRad(lon2) - toRad(lon1)) +
      Math.sin(toRad(lat1)) *
        Math.sin(toRad(lat2))
    );

  return distance;
}



async function getNearbyOnlineDrivers({
  pickup_latitude,
  pickup_longitude,
  vehicle_type,
  brand_id,
  model_id
}) {

  const firestore = getFirestore();
  let snapshot = await firestore
    .collection("driver")
    .where("online_status", "==", 1)
    .where("vehicle_type", "==", vehicle_type)
    .where("brand_id", "==", brand_id)
    .where("model_id", "==", model_id)
    .get();

  // 🔁 Fallback: only vehicle_type
  if (snapshot.empty) {
    console.log("🔴 Drivers found: 0 → fallback by vehicle_type");

    snapshot = await firestore
      .collection("driver")
      .where("online_status", "==", 1)
      .where("vehicle_type", "==", vehicle_type)
      .get();
  }

  // 🔚 FINAL fallback: random ETA (15–25 min)
  if (snapshot.empty) {
    const randomETA = Math.floor(Math.random() * (25 - 15 + 1)) + 15;
    console.log("🔴 Drivers found: 0 → fallback ETA:", randomETA, "min");

    return {
      distance_km: null,
      arrive_time: randomETA
    };
  }

  let nearest = null;
  const driverIds = [];

  snapshot.forEach((doc) => {
    const d = doc.data();

    if (d.current_latitude == null || d.current_longitude == null) return;

    const distanceKm = calculateDistanceInKm(
      Number(d.current_latitude),
      Number(d.current_longitude),
      Number(pickup_latitude),
      Number(pickup_longitude)
    );

    const arriveMinutes = Math.max(1, Math.round(distanceKm / 0.5));

    driverIds.push(doc.id);

    if (!nearest || distanceKm < nearest.distance_km) {
      nearest = {
        distance_km: Number(distanceKm.toFixed(2)),
        arrive_time: arriveMinutes
      };
    }
  });

  console.log("🚗 Drivers in range (count):", driverIds.length);
  console.log("🆔 Driver IDs:", driverIds);

  return nearest;
}


export async function getVehicleAmountList(req, res) {
  try {
    const {
      vehicle_id,
      pickup_latitude,
      pickup_longitude,
      drop_latitude,
      drop_longitude
    } = req.body;

    if (
      !vehicle_id ||
      !pickup_latitude ||
      !pickup_longitude ||
      !drop_latitude ||
      !drop_longitude
    ) {
      return res.status(400).json({
        success: false,
        message:
          "vehicle_id, pickup_latitude, pickup_longitude, drop_latitude, drop_longitude are required",
        errors: null
      });
    }

    const distanceKm = calculateDistanceInKm(
      Number(pickup_latitude),
      Number(pickup_longitude),
      Number(drop_latitude),
      Number(drop_longitude)
    );

    const distance = Number(distanceKm.toFixed(2));
    const BASE_URL = process.env.BASE_URL || "";

    const [rows] = await db.query(
      `
      SELECT
        vc.vehicle_id,
        v.name AS vehicle_name,
        v.image AS vehicle_image,
        v.max_passenger,
        v.discount,
        v.user_increase,

        b.id AS brand_id,
        b.name AS brand_name,

        m.id AS model_id,
        m.name AS model_name,

        vc.from_km,
        vc.to_km,
        vc.rate_per_km
      FROM vehicle_charges vc
      INNER JOIN vehicle v 
        ON v.id = vc.vehicle_id
        AND v.visible_status = 1
      INNER JOIN brand b
        ON b.vehicle_id = v.id
        AND b.status = 1
      INNER JOIN model m
        ON m.brand_id = b.id
        AND m.status = 1
      ORDER BY vc.vehicle_id ASC, vc.from_km ASC
      `
    );

    if (!rows.length) {
      return res.status(404).json({
        success: false,
        message: "Vehicle charges not found",
        errors: null
      });
    }

    const vehicleMap = {};

    for (const row of rows) {
      if (!vehicleMap[row.vehicle_id]) {

        const nearestDriver = await getNearbyOnlineDrivers({
          pickup_latitude,
          pickup_longitude,
          vehicle_type: row.vehicle_id,
          brand_id: row.brand_id,
          model_id: row.model_id
        });

        vehicleMap[row.vehicle_id] = {
          vehicle_id: row.vehicle_id,
          vehicle_name: row.vehicle_name,
          brand_id: row.brand_id,
          brand_name: row.brand_name,
          model_id: row.model_id,
          model_name: row.model_name,
          image: BASE_URL + row.vehicle_image,

          max_passenger: row.max_passenger,
          discount: row.discount,
          user_increase: row.user_increase,

          selected_status:
            Number(row.vehicle_id) === Number(vehicle_id) ? 1 : 0,

          rate_per_km: 10,
          amount: Number((distance * 10).toFixed(2)),
          arrive_time: nearestDriver ? nearestDriver.arrive_time : null
        };
      }

      if (distance >= row.from_km && distance < row.to_km) {
        vehicleMap[row.vehicle_id].rate_per_km = Number(row.rate_per_km);
        vehicleMap[row.vehicle_id].amount = Number(
          (distance * row.rate_per_km).toFixed(2)
        );
      }
    }

    return res.status(200).json({
      success: true,
      distance_km: distance,
      data: Object.values(vehicleMap)
    });

  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      errors: err.message
    });
  }
}



export async function getDriverCanDiscount(req, res) {
  try {
    const { vehicle_id, amount } = req.body;

    if (!vehicle_id || amount === undefined) {
      return res.status(400).json({
        success: false,
        message: "vehicle_id and amount are required"
      });
    }

    const amt = Number(amount);
    const [matchRows] = await db.query(
      `
      SELECT driver_can_discount
      FROM vehicle_driver_discount_slabs
      WHERE vehicle_id = ?
        AND ? BETWEEN starting_amount AND end_amount
      LIMIT 1
      `,
      [vehicle_id, amt]
    );

    if (matchRows.length) {
      return res.status(200).json({
        success: true,
        driver_can_discount: matchRows[0].driver_can_discount
      });
    }
    
    const [maxRows] = await db.query(
      `
      SELECT driver_can_discount
      FROM vehicle_driver_discount_slabs
      WHERE vehicle_id = ?
      ORDER BY end_amount DESC
      LIMIT 1
      `,
      [vehicle_id]
    );

    if (maxRows.length && amt > maxRows[0].end_amount) {
      return res.status(200).json({
        success: true,
        driver_can_discount: maxRows[0].driver_can_discount
      });
    }
    return res.status(200).json({
      success: true,
      driver_can_discount: 0
    });

  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      error: error.message
    });
  }
}








export async function getDriverProfilePhotos(req, res) {
  try {
    const { driver_ids } = req.body;

    // ❌ invalid type only
    if (!Array.isArray(driver_ids)) {
      return res.status(400).json({
        success: false,
        message: "driver_ids must be an array"
      });
    }

    // ✅ empty array allowed
    if (driver_ids.length === 0) {
      return res.status(200).json({
        success: true,
        data: []
      });
    }

    const BASE_URL = process.env.BASE_URL || "";

    const [rows] = await db.query(
      `
      SELECT 
        id,
        profile_photo
      FROM driver_registration
      WHERE id IN (?)
      `,
      [driver_ids]
    );

    const data = rows.map(row => ({
      id: row.id,
      profile_photo: row.profile_photo
        ? `${BASE_URL}/${row.profile_photo.replace(/^\//, "")}`
        : null
    }));

    return res.status(200).json({
      success: true,
      data
    });

  } catch (error) {
    console.error("Get Driver Profile Photos Error:", error);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      error: error.message
    });
  }
}




export async function addOrUpdateDriverOffer(req, res) {
  try {
    const {
      user_id,
      driver_id,
      order_id,
      offer_amount,
      estimated_amount
    } = req.body;

    /* =========================
       VALIDATION (SAME)
    ========================= */
    if (
      !user_id ||
      !driver_id ||
      !order_id ||
      !offer_amount ||
      !estimated_amount
    ) {
      return res.status(400).json({
        success: false,
        message:
          "user_id, driver_id, order_id, estimated_amount and offer_amount are required"
      });
    }

    const BASE_URL = process.env.BASE_URL || "";
    const now = nowIST();
    const firestore = getFirestore();

    /* =========================
       GET DRIVER DETAILS
       👉 first_name + last_name added
    ========================= */
    const [driverRows] = await db.query(
      `
      SELECT
        first_name,
        last_name,
        profile_photo,
        brand_name,
        model_name
      FROM driver_registration
      WHERE id = ?
      `,
      [driver_id]
    );

    if (driverRows.length === 0) {
      return res.status(404).json({
        success: false,
        message: "Driver not found"
      });
    }

    const driver = driverRows[0];

    const driver_name =
      [driver.first_name, driver.last_name].filter(Boolean).join(" ");

    const rawPhoto = driver.profile_photo || null;
    const profile_photo = rawPhoto
      ? `${BASE_URL}/${rawPhoto.replace(/^\//, "")}`
      : null;

    const brand_name = driver.brand_name || null;
    const model_name = driver.model_name || null;

    /* =========================
       CHECK OFFER EXISTS (SAME)
    ========================= */
    const [offerRows] = await db.query(
      `
      SELECT id
      FROM driver_offer
      WHERE order_id = ? AND driver_id = ?
      `,
      [order_id, driver_id]
    );
    
    /* =========================
       INSERT / UPDATE (MySQL)
        driver_name added ONLY
    ========================= */
    
    if (offerRows.length > 0) {
      await db.query(
        `
        UPDATE driver_offer
        SET
          user_id = ?,
          driver_name = ?,
          brand_name = ?,
          model_name = ?,
          estimated_amount = ?,
          offer_amount = ?,
          profile_photo = ?,
          updated_at = ?
        WHERE order_id = ? AND driver_id = ?
        `,
        [
          user_id,
          driver_name,
          brand_name,
          model_name,
          estimated_amount,
          offer_amount,
          profile_photo,
          now,
          order_id,
          driver_id
        ]
      );
    } else {
      await db.query(
        `
        INSERT INTO driver_offer (
          order_id,
          user_id,
          driver_id,
          driver_name,
          brand_name,
          model_name,
          profile_photo,
          estimated_amount,
          offer_amount,
          offer_status,
          created_at,
          updated_at
        )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        `,
        [
          order_id,
          user_id,
          driver_id,
          driver_name,
          brand_name,
          model_name,
          profile_photo,
          estimated_amount,
          offer_amount,
          0,
          now,
          now
        ]
      );
    }

    /* =========================
       FETCH FINAL ROW (SAME)
    ========================= */
    const [finalRows] = await db.query(
      `
      SELECT
        id,
        order_id,
        profile_photo,
        estimated_amount,
        offer_amount,
        offer_status,
        created_at,
        updated_at,
        user_id,
        driver_id,
        driver_name,
        brand_name,
        total_rides,
        rating,
        model_name
      FROM driver_offer
      WHERE order_id = ? AND driver_id = ?
      `,
      [order_id, driver_id]
    );

    const finalOffer = finalRows[0];

    /* =========================
       FIREBASE SYNC (SAME AS BEFORE)
       👉 matched driver_offer row only
    ========================= */
    setImmediate(async () => {
      try {
        const docId = `${finalOffer.order_id}_${finalOffer.driver_id}`;

        await firestore
          .collection("driver_offers")
          .doc(docId)
          .set(finalOffer, { merge: true });

      } catch (err) {
        console.error("🔥 Firestore Offer Sync Error:", err);
      }
    });

    /* =========================
       RESPONSE (UNCHANGED)
    ========================= */
    return res.status(200).json({
      success: true,
      message: offerRows.length
        ? "Driver offer updated successfully"
        : "Driver offer added successfully"
    });

  } catch (error) {
    console.error("🔥 Driver Offer Error:", error);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      error: error.message
    });
  }
}





export async function acceptCabRide(req, res) {
  try {
    const { order_id, driver_id } = req.body;

    /* =========================
       BASIC VALIDATION
    ========================= */
    if (!order_id || !driver_id) {
      return res.status(400).json({
        success: false,
        message: "order_id and driver_id are required"
      });
    }

    const BASE_URL = process.env.BASE_URL || "";
    const now = nowIST();
    const firestore = getFirestore();

    /* =========================
       CHECK ORDER (MySQL)
    ========================= */
    const [orderRows] = await db.query(
      `
      SELECT id, order_status
      FROM cab_orders
      WHERE id = ?
      LIMIT 1
      `,
      [order_id]
    );

    if (!orderRows.length) {
      return res.status(404).json({
        success: false,
        message: "Order not found"
      });
    }

    if (Number(orderRows[0].order_status) !== 0) {
      return res.status(400).json({
        success: false,
        message: "Ride already accepted or closed"
      });
    }

    /* =========================
       GET DRIVER DETAILS (MySQL)
       👉 profile_photo bhi liya
    ========================= */
    const [driverRows] = await db.query(
      `
      SELECT
        first_name,
        last_name,
        profile_photo,
        vehicle_plate_number,
        mobile,
        vehicle_color
      FROM driver_registration
      WHERE id = ?
      LIMIT 1
      `,
      [driver_id]
    );
    if (!driverRows.length) {
      return res.status(404).json({
        success: false,
        message: "Driver not found"
      });
    }

    const driver = driverRows[0];

    const driver_name = [driver.first_name, driver.last_name]
      .filter(Boolean)
      .join(" ");

    /* =========================
       PROFILE PHOTO (SAME LOGIC)
    ========================= */
    const rawPhoto = driver.profile_photo || null;
    const profile_photo = rawPhoto
      ? `${BASE_URL}/${rawPhoto.replace(/^\//, "")}`
      : null;

    /* =========================
       UPDATE cab_orders (MySQL)
    ========================= */
    await db.query(
      `
      UPDATE cab_orders
      SET
        driver_id = ?,
        driver_name = ?,
        profile_photo = ?,
        vehicle_plate_number = ?,
        contact_number = ?,
        vehicle_color = ?,
        order_status = 1,
        updated_at = ?
      WHERE id = ?
      `,
      [
        driver_id,
        driver_name,
        profile_photo,
        driver.vehicle_plate_number || null,
        driver.mobile || null,
        driver.vehicle_color || null,
        now,
        order_id
      ]
    );

    /* =========================
       UPDATE cab_orders (Firebase)
       👉 update only, no data loss
    ========================= */
    await firestore
      .collection("cab_orders")
      .doc(String(order_id))
      .update({
        driver_id: Number(driver_id),
        driver_name,
        profile_photo,
        vehicle_plate_number: driver.vehicle_plate_number || null,
        contact_number: driver.mobile || null,
        vehicle_color: driver.vehicle_color || null,
        order_status: 1,
        updated_at: now
      });

    /* =========================
       UPDATE driver_offers (Firebase)
       👉 same as before
    ========================= */
    const offerSnapshot = await firestore
      .collection("driver_offers")
      .where("order_id", "==", Number(order_id))
      .where("driver_id", "==", Number(driver_id))
      .get();

    if (!offerSnapshot.empty) {
      const batch = firestore.batch();

      offerSnapshot.forEach(doc => {
        batch.update(doc.ref, {
          offer_status: 1,
          updated_at: now
        });
      });

      await batch.commit();
    }

    /* =========================
       SUCCESS RESPONSE (UNCHANGED)
    ========================= */
    return res.status(200).json({
      success: true,
      message: "Ride accepted successfully",
      order_id,
      driver_id
    });

  } catch (error) {
    console.error("Accept Ride Error:", error);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      error: error.message
    });
  }
}



export const deleteExpiredCabOrders = async (req, res) => {
  try {
    const firestore = getFirestore();
    const now = nowIST();

    // 🔥 1.5 minute (90 sec) earlier time
    const cutoffTime = new Date(
      new Date(now).getTime() - 90 * 1000
    );
    const [orders] = await db.query(
      `
      SELECT id
      FROM cab_orders
      WHERE order_status = 0
        AND created_at <= ?
      `,
      [cutoffTime]
    );

    if (!orders.length) {
      return res.status(200).json({
        success: true,
        message: "No expired pending orders found",
        deleted_count: 0
      });
    }

    const orderIds = orders.map(o => o.id);
    await db.query(
      `
      DELETE FROM cab_orders
      WHERE id IN (?)
      `,
      [orderIds]
    );
    for (const id of orderIds) {
      try {
        await firestore
          .collection("cab_orders")
          .doc(String(id))
          .delete();
      } catch (fbErr) {
        console.error(`Firebase delete failed for order ${id}`, fbErr);
      }
    }

    return res.status(200).json({
      success: true,
      message: "Expired pending orders deleted successfully",
      deleted_count: orderIds.length,
      deleted_order_ids: orderIds
    });

  } catch (err) {
    console.error("Delete Expired Orders Error:", err);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      error: err.message
    });
  }
};
