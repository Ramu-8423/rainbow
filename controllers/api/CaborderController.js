import db from "../../config/database.js";
import { FCMHelper } from "../../middleware/fcmHelper.js";
import { nowIST } from "../../utils/dateParser.js";
import { getFirestore } from "../../utils/firebaseInit.js";
import { scheduleApiHits } from "../../scheduleHit.js";

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
  if (!body.user_name) return "user_name is required";
  if (!body.user_mobile) return "user_mobile is required";

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
  if (!body.distance_km) return "distance_km is required";
  

  if (!body.estimated_amount) return "estimated_amount is required";

  if (!body.order_type) return "order_type is required";
  if (![1, 2].includes(Number(body.order_type)))
    return "order_type must be 1 or 2";
  
 

  if (!body.pay_mode) return "pay_mode is required";
 
 if (![1, 2].includes(Number(body.pay_mode)))
  return "payment mode must be online or offline";

    
    
 if (![0, 1].includes(Number(body.wallet_apply)))
  return "wallet_apply must be 0 or 1";
    
  if (Number(body.order_type) === 2 && !body.schedule_time)
    return "schedule_time is required for later order";

  return null;
}

/* =========================================================
   CAB ORDER API (FASTEST POSSIBLE)
========================================================= */
/* =========================================================
   CAB ORDER API (FASTEST POSSIBLE)
========================================================= */
async function getMatchedDriversForCabOrder({
  db,
  firestore,
  vehicle_id,
  pickup_latitude,
  pickup_longitude,
  rideRadiusKm
}) {
  /* =========================
     VEHICLE DETAILS (SAME vehicle_id)
  ========================= */
  const [[vehicle]] = await db.query(
    `
    SELECT id, vehicle_category, max_passenger
    FROM vehicle
    WHERE id = ?
    LIMIT 1
    `,
    [vehicle_id]
  );

  if (!vehicle) {
    return [];
  }

  let allowedVehicleIds = [Number(vehicle_id)];

  /* =========================
     VEHICLE CATEGORY = 4
     (CAPACITY BASED FALLBACK)
  ========================= */
  if (Number(vehicle.vehicle_category) === 4) {
    const [vehicles] = await db.query(
      `
      SELECT id
      FROM vehicle
      WHERE vehicle_category = 4
        AND max_passenger >= ?
      `,
      [vehicle.max_passenger]
    );

    allowedVehicleIds = vehicles.map(v => Number(v.id));
  }

console.log("sdfghjk", allowedVehicleIds);
  /* =========================
     FIREBASE : DRIVER MATCH
  ========================= */
  const matched_driver_ids = [];

  for (const vId of allowedVehicleIds) {
    const snapshot = await firestore
      .collection("driver")
      .where("online_status", "==", 1)
      .where("vehicle_type", "==", Number(vId))
      .get();

    for (const doc of snapshot.docs) {
      const d = doc.data();
      const driverId = Number(doc.id);

      if (!d.current_latitude || !d.current_longitude) continue;

      /* 🔥 ACTIVE RIDE CHECK (UNCHANGED) */
      const [[activeRide]] = await db.query(
        `
        SELECT id
        FROM cab_orders
        WHERE driver_id = ?
          AND order_status BETWEEN 0 AND 4
        LIMIT 1
        `,
        [driverId]
      );

      if (activeRide) continue;

      const dist = getDistanceInKm(
        d.current_latitude,
        d.current_longitude,
        pickup_latitude,
        pickup_longitude
      );

      if (dist <= rideRadiusKm) {
        if (!matched_driver_ids.includes(driverId)) {
          matched_driver_ids.push(driverId);
        }
      }
    }
  }

  return matched_driver_ids;
}




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
      user_name,
      user_mobile,

      vehicle_id,
      vehicle_name,

      brand_id,
      brand_name,

      model_id,
      model_name,

      pickup_location,
      pickup_latitude,
      pickup_longitude,

      drop_location,
      drop_latitude,
      drop_longitude,

      order_type,
      schedule_time,
      pay_mode,
      wallet_apply,
      over_limit_passenger,
      user_comment,

      estimated_amount,
      distance_km           
    } = req.body;

    const createdAt = nowIST();

    /* =========================
       ORDER OTP
    ========================= */
    const orderOtp = await generateUniqueOTP(db);

    /* =========================
       MYSQL : INSERT ORDER
    ========================= */
    const [orderResult] = await db.query(
      `
      INSERT INTO cab_orders (
        user_id,
        user_name,
        user_mobile,
        vehicle_id,
        vehicle_name,
        brand_id,
        brand_name,
        model_id,
        model_name,
        pickup_location,
        pickup_latitude,
        pickup_longitude,
        drop_location,
        drop_latitude,
        drop_longitude,
        distance_km,
        estimated_amount,
        order_type,
        schedule_time,
        pay_mode,
        wallet_apply,
        payment_status,
        over_limit_passenger,
        user_comment,
        orderOtp,
        created_at,
        updated_at
      )
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      `,
      [
        user_id,
        user_name,
        user_mobile,
        vehicle_id,
        vehicle_name,
        brand_id,
        brand_name,
        model_id,
        model_name,
        pickup_location,
        pickup_latitude,
        pickup_longitude,
        drop_location,
        drop_latitude,
        drop_longitude,
        distance_km,                       
        estimated_amount,
        order_type,
        Number(order_type) === 2 ? schedule_time : null,
        pay_mode,
        wallet_apply,
        0,
        over_limit_passenger,
        user_comment,
        orderOtp,
        createdAt,
        createdAt
      ]
    );

    const order_id = orderResult.insertId;

    /* =========================
       USER WALLET FETCH
    ========================= */
    const [[user]] = await db.query(
      `SELECT status, wallet FROM users WHERE id = ? LIMIT 1`,
      [user_id]
    );

    if (!user) {
      return res.status(404).json({
        success: false,
        message: "User not found"
      });
    }

    if (Number(wallet_apply) === 1 && Number(user.wallet) <= 0) {
      return res.status(400).json({
        success: false,
        message: "Can't use wallet, first recharge"
      });
    }

    if (Number(pay_mode) === 2 && Number(wallet_apply) === 1) {
      return res.status(400).json({
        success: false,
        message: "Wallet cannot be applied for offline payment"
      });
    }

    /* =========================
       FINAL PAY MODE
    ========================= */
    let finalPayMode = Number(pay_mode);

    if (Number(wallet_apply) === 1) {
      if (finalPayMode === 1 && Number(user.wallet) >= Number(estimated_amount)) {
        finalPayMode = 3;
      }
    }

    await db.query(
      `UPDATE cab_orders SET pay_mode = ? WHERE id = ?`,
      [finalPayMode, order_id]
    );

    /* =========================
       SETTINGS : RIDE RADIUS
    ========================= */
    const [[rideRadiusSetting]] = await db.query(
      `
      SELECT value
      FROM settings
      WHERE id = 7 AND name = 'ride_radius_km'
      LIMIT 1
      `
    );

    const rideRadiusKm = Number(rideRadiusSetting?.value || 5);

    /* =========================
       FIREBASE + MATCHED DRIVERS
    ========================= */
    const firestore = getFirestore();

    const matched_driver_ids = await getMatchedDriversForCabOrder({
      db,
      firestore,
      vehicle_id,
      pickup_latitude,
      pickup_longitude,
      rideRadiusKm
    });

    await db.query(
      `UPDATE cab_orders SET matched_driver_id = ? WHERE id = ?`,
      [JSON.stringify(matched_driver_ids), order_id]
    );

    /* =========================
       FIREBASE : STORE ORDER
    ========================= */
    if (matched_driver_ids.length > 0 && order_type == 1) {
      await firestore
        .collection("cab_orders")
        .doc(String(order_id))
        .set({
          order_id: Number(order_id),
          user_id: Number(user_id),
          user_name,
          user_mobile: Number(user_mobile),
          vehicle_id: Number(vehicle_id),
          vehicle_name,
          brand_id: Number(brand_id),
          brand_name,
          model_id: Number(model_id),
          model_name,
          pickup_location,
          pickup_latitude: Number(pickup_latitude),
          pickup_longitude: Number(pickup_longitude),
          drop_location,
          drop_latitude: Number(drop_latitude),
          drop_longitude: Number(drop_longitude),
          distance_km: Number(distance_km),   // ✅ PAYLOAD VALUE
          estimated_amount: Number(estimated_amount),
          order_type: Number(order_type),
          schedule_time: Number(order_type) === 2 ? schedule_time : null,
          pay_mode: finalPayMode,
          wallet_apply,
          payment_status: 0,
          over_limit_passenger: over_limit_passenger || null,
          user_comment: user_comment || null,
          orderOtp,
          matched_driver_ids,
          order_status: 0,
          created_at: createdAt,
          updated_at: createdAt
        });
    }

    /* =========================
       FCM : BACKGROUND NOTIFICATION
    ========================= */
   if (order_type == 1) {
  setImmediate(async () => {
    try {
      if (!matched_driver_ids.length) return;

      const [drivers] = await db.query(
        `SELECT fcm_token FROM driver_registration WHERE id IN (?)`,
        [matched_driver_ids]
      );

      for (const drv of drivers) {
        if (!drv.fcm_token) continue;

        // ✅ DATA-ONLY FCM PAYLOAD (AS YOU ASKED)
        const dataPayload = {
          type: "NEW_RIDE",
          order_id: String(order_id)
        };

        // 🔥 SEND DATA-ONLY (NO notification)
        await FCMHelper.sendNotification(
          drv.fcm_token,
          null,              // title ❌
          null,              // body ❌
          dataPayload,       // ✅ data only
          "high"             // ✅ priority
        );
      }
    } catch (err) {
      console.error("FCM Background Error:", err);
    }
  });
}




    /* =========================
       SCHEDULE API HIT
    ========================= */
    if (Number(order_type) === 2 && schedule_time) {
      await db.query(
        `
        INSERT INTO scheduled_api_hits
          (order_id, hit_datetime, is_done)
        VALUES
          (?, ?, 0)
        `,
        [order_id, schedule_time]
      );

      scheduleApiHits();
    }

    /* =========================
       FINAL RESPONSE (UNCHANGED)
    ========================= */
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
       UPDATE SQL (UNCHANGED)
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

    /* ==================================================
       ✅ ADDED: ONLINE / OFFLINE LOGIC (NO OLD CODE TOUCHED)
    ================================================== */

    // ✅ When driver goes ONLINE → insert new row
    if (statusChanged && newStatus === 1) {
      await db.query(
        `
        INSERT INTO driver_online_logs
        (driver_id, online_time, created_at, updated_at)
        VALUES (?, ?, ?, ?)
        `,
        [driver_id, createdAt, createdAt, createdAt]
      );
    }

    // ✅ When driver goes OFFLINE → update last open row
    if (statusChanged && newStatus === 0) {
      await db.query(
        `
        UPDATE driver_online_logs
        SET
          offline_time = ?,
          updated_at = ?
        WHERE driver_id = ?
          AND offline_time IS NULL
        ORDER BY id DESC
        LIMIT 1
        `,
        [createdAt, createdAt, driver_id]
      );
    }

    const firestore = getFirestore();

    /* =========================
       FIREBASE PAYLOAD (UNCHANGED)
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




function isPointInPolygon(point, polygon) {
  const x = point.lng;
  const y = point.lat;

  let inside = false;

  for (let i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
    const xi = polygon[i].lng, yi = polygon[i].lat;
    const xj = polygon[j].lng, yj = polygon[j].lat;

    const intersect =
      ((yi > y) !== (yj > y)) &&
      (x < ((xj - xi) * (y - yi)) / (yj - yi) + xi);

    if (intersect) inside = !inside;
  }

  return inside;
}



/* =========================
   NEARBY DRIVER + ETA
========================= */
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
    .get();

  // 🔁 Fallback: only vehicle_type
  if (snapshot.empty) {
    snapshot = await firestore
      .collection("driver")
      .where("online_status", "==", 1)
      .where("vehicle_type", "==", vehicle_type)
      .get();
  }

  // 🔚 FINAL fallback: no driver → random ETA
  if (snapshot.empty) {
    const randomETA = Math.floor(Math.random() * (25 - 15 + 1)) + 15;
    return {
      distance_km: null,
      arrive_time: randomETA
    };
  }

  let nearest = null;

  snapshot.forEach((doc) => {
    const d = doc.data();

    if (d.current_latitude == null || d.current_longitude == null) return;

    const distanceKm = calculateDistanceInKm(
      Number(d.current_latitude),
      Number(d.current_longitude),
      Number(pickup_latitude),
      Number(pickup_longitude)
    );

    if (!nearest || distanceKm < nearest.distance_km) {
      nearest = {
        distance_km: Number(distanceKm.toFixed(2))
      };
    }
  });

  // 🧠 MAIN LOGIC
  if (!nearest || nearest.distance_km > 5) {
    const randomETA = Math.floor(Math.random() * (25 - 15 + 1)) + 15;
    return {
      distance_km: nearest ? nearest.distance_km : null,
      arrive_time: randomETA
    };
  }

  // ✅ REAL ETA (≤ 5 km)
  const arriveMinutes = Math.max(1, Math.round(nearest.distance_km / 0.5));

  return {
    distance_km: nearest.distance_km,
    arrive_time: arriveMinutes
  };
}


/* =========================
   VEHICLE AMOUNT LIST
========================= */
export async function getVehicleAmountList(req, res) {
  try {
    const {
      vehicle_id,
      distance_km,
      pickup_latitude,
      pickup_longitude,
      drop_latitude,
      drop_longitude
    } = req.body;

    if (
      !vehicle_id ||
      !distance_km ||
      !pickup_latitude ||
      !pickup_longitude ||
      !drop_latitude ||
      !drop_longitude
    ) {
      return res.status(400).json({
        success: false,
        message:
          "vehicle_id, distance_km, pickup_latitude, pickup_longitude, drop_latitude, drop_longitude are required",
        errors: null
      });
    }

    /* =========== ZONE CHECK START ============== */

    const pickupLat = Number(pickup_latitude);
    const pickupLng = Number(pickup_longitude);
    const dropLat = Number(drop_latitude);
    const dropLng = Number(drop_longitude);
    const [zones] = await db.query(
   "SELECT id, zone_name, coordinates FROM zones WHERE zone_type = 2"
 );


    let pickupAvailable = false;
    let dropAvailable = false;

    for (const zone of zones) {
      let polygon;
      try {
        polygon = JSON.parse(zone.coordinates);
      } catch (e) {
        continue;
      }

      if (!Array.isArray(polygon) || polygon.length < 3) continue;

      if (!pickupAvailable) {
        pickupAvailable = isPointInPolygon(
          { lat: pickupLat, lng: pickupLng },
          polygon
        );
      }

      if (!dropAvailable) {
        dropAvailable = isPointInPolygon(
          { lat: dropLat, lng: dropLng },
          polygon
        );
      }

      if (pickupAvailable && dropAvailable) break;
    }

    if (!pickupAvailable) {
      return res.status(400).json({
        success: false,
        message: "Cab or Ride service not available for pickup location",
        errors: null
      });
    }

    if (!dropAvailable) {
      return res.status(400).json({
        success: false,
        message: "Cab or Ride service not available for drop location",
        errors: null
      });
    }

    /* =========== ZONE CHECK END ============== */

    /* =========================
       SETTINGS
    ========================= */
    const [[rideRadiusSetting]] = await db.query(
      `
      SELECT value
      FROM settings
      WHERE id = 5 AND name = 'ride_radius_km'
      LIMIT 1
      `
    );

    const rideRadiusKm = Number(rideRadiusSetting?.value || 5);

    const distance = Number(Number(distance_km).toFixed(2));
    const BASE_URL = process.env.BASE_URL || "";

    /* =========================
       FETCH VEHICLE + SLABS
    ========================= */
    const [rows] = await db.query(
      `
      SELECT
        v.id AS vehicle_id,
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

      FROM vehicle v
      INNER JOIN vehicle_charges vc ON vc.vehicle_id = v.id
      LEFT JOIN brand b ON b.vehicle_id = v.id AND b.status = 1
      LEFT JOIN model m ON m.brand_id = b.id AND m.status = 1
      WHERE v.visible_status = 1
      ORDER BY v.id ASC, vc.from_km ASC
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
      const discountPercent = Number(row.discount) || 0;
      const increasePercent = Number(row.user_increase) || 0;

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
          image: `${BASE_URL.replace(/\/$/, "")}/${row.vehicle_image.replace(/^\//, "")}`,
          max_passenger: row.max_passenger,
          selected_status: Number(row.vehicle_id) === Number(vehicle_id) ? 1 : 0,
          rate_per_km: 0,
          amount: 0,
          discount: 0,
          user_increase: 0,
          arrive_time: nearestDriver ? nearestDriver.arrive_time : null,
          slabMatched: false
        };
      }

      if (distance >= row.from_km && distance < row.to_km) {
        const amount = Number((distance * row.rate_per_km).toFixed(2));

        vehicleMap[row.vehicle_id].rate_per_km = Number(row.rate_per_km);
        vehicleMap[row.vehicle_id].amount = amount;
        vehicleMap[row.vehicle_id].discount = Math.floor((amount * discountPercent) / 100);
        vehicleMap[row.vehicle_id].user_increase = Math.floor((amount * increasePercent) / 100);
        vehicleMap[row.vehicle_id].slabMatched = true;
      }
    }

    const finalVehicles = Object.values(vehicleMap).filter(
      v => v.slabMatched === true
    );

    return res.status(200).json({
      success: true,
      distance_km: distance_km,
      data: finalVehicles
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



    const [[orderRow]] = await db.query(
      `
      SELECT order_status
      FROM cab_orders
      WHERE id = ?
      LIMIT 1
      `,
      [order_id]
    );
    
    if (!orderRow) {
      return res.status(404).json({
        success: false,
        message: "Order not found"
      });
    }
    
    if (Number(orderRow.order_status) !== 0) {
      return res.status(400).json({
        success: false,
        message: "Already accepted"
      });
    }

    /* =========================
       ACTIVE RIDE CHECK
       driver cannot bid if already on active ride
       order_status: 0 → 4
    ========================= */
    const [[activeRide]] = await db.query(
      `
      SELECT id
      FROM cab_orders
      WHERE driver_id = ?
        AND order_status >= 0
        AND order_status <= 4
      LIMIT 1
      `,
      [driver_id]
    );
    
    if (activeRide) {
      return res.status(400).json({
        success: false,
        message: "You cannot make an offer while you have an active ride"
      });
    }

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
        model_name,
        fcm_token,
        due_wallet
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

    const [[settingRow]] = await db.query(
      `
      SELECT value
      FROM settings
      WHERE name = 'driver_due_limit'
      LIMIT 1
      `
    );
   
    const driver = driverRows[0];
    
    
   const driver_due_limit = Number(settingRow?.value || 0);
   const driver_due_wallet = Number(driver.due_wallet || 0);



if (driver_due_wallet >= driver_due_limit) {

  if (driver.fcm_token) {
    try {
      await FCMHelper.sendNotification(
        driver.fcm_token,
        "Wallet Due Limit Reached",
        `Your due wallet amount is ₹${driver_due_wallet}. Please clear dues to accept or offer new rides.`,
        {
          type: "DUE_WALLET",
          due_wallet: String(driver_due_wallet),
          limit: String(driver_due_limit)
        }
      );
    } catch (err) {
      console.error("FCM Due Wallet Error:", err);
    }
  }

  return res.status(403).json({
    success: false,
    message: `You cannot accept or offer a ride. Your due wallet is ₹${driver_due_wallet}.`
  });
}

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
      SELECT id, order_status,user_name,user_id,wallet_apply ,pay_mode,final_amount
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


   
    
    // if (Number(orderRows[0].order_status) !== 0) {
    //   return res.status(400).json({
    //     success: false,
    //     message: "Ride already accepted or closed"
    //   });
    // }

    const user_name = orderRows[0].user_name;
 /* =========================
       wallet concept start
       
       
       
       
       
       wallet concept end
    ========================= */
    
    /* =========================
       GET OFFER (MySQL)
    ========================= */
    const [offerRows] = await db.query(
      `
      SELECT id, offer_amount
      FROM driver_offer
      WHERE order_id = ?
        AND driver_id = ?
      LIMIT 1
      `,
      [order_id, driver_id]
    );

    if (!offerRows.length) {
      return res.status(404).json({
        success: false,
        message: "Driver offer not found for this order"
      });
    }

    const accepted_offer_id = offerRows[0].id;
    const final_amount = offerRows[0].offer_amount;


     
// wallet condition
    const user_id = orderRows[0].user_id;
    const wallet_apply = orderRows[0].wallet_apply;
    let pay_mode = orderRows[0].pay_mode;
    let amount_after_wallet = 0;
    const [userRows] = await db.query(`SELECT wallet from users where id =? limit 1`, [user_id]);
    const wallet_amount = Number(userRows[0].wallet) || 0;
  
  
  
   if(pay_mode == 3 && wallet_apply == 1 && wallet_amount < final_amount){
       amount_after_wallet = final_amount - wallet_amount;
       pay_mode = 1;
       console.log("amount kam hai iske wallet ka", amount_after_wallet);
   }
   if(pay_mode == 1 && wallet_apply == 1){
       amount_after_wallet = final_amount - wallet_amount;
   }
   console.log("amount_after_walletXXXXXXX", amount_after_wallet);
// wallet condition end

    /* =========================
       GET DRIVER DETAILS (MySQL)
    ========================= */
    const [driverRows] = await db.query(
      `
      SELECT
        first_name,
        last_name,
        profile_photo,
        vehicle_plate_number,
        mobile,
        rating,
        vehicle_color,
        fcm_token
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
        rating = ?,
        vehicle_color = ?,
        accepted_offer_id = ?,
        final_amount = ?,
        order_status = 1,
        amount_after_wallet = ?,
        pay_mode = ?,
        updated_at = ?
      WHERE id = ?
      `,
      [
        driver_id,
        driver_name,
        profile_photo,
        driver.vehicle_plate_number || null,
        driver.mobile || null,
        driver.rating || null,
        driver.vehicle_color || null,
        accepted_offer_id,
        final_amount,
        amount_after_wallet,
        pay_mode,
        now,
        order_id
      ]
    );

    /* =========================
       UPDATE cab_orders (Firebase)
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
        rating: driver.rating || null,
        vehicle_color: driver.vehicle_color || null,
        accepted_offer_id: Number(accepted_offer_id),
        final_amount: Number(final_amount),
        order_status: 1,
        pay_mode,
        wallet_apply,
        amount_after_wallet,
        order_status: 1,
        updated_at: now
      });

    const offerSnapshot = await firestore
      .collection("driver_offers")
      .where("order_id", "==", Number(order_id))
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
       FCM NOTIFICATION (NEW)
    ========================= */
    if (driver.fcm_token) {
      try {
        await FCMHelper.sendNotification(
          driver.fcm_token,
          "Ride Accepted",
          `${user_name} accepted your ride offer. Proceed to pickup.`,
          {
            order_id: String(order_id),
            driver_id: String(driver_id)
          }
        );
      } catch (fcmErr) {
        console.error("FCM Error:", fcmErr);
      }
    }

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

    /**
     * order_type logic
     * ONLY order_type = 1
     * Expire after 90 seconds
     */

    const [orders] = await db.query(
      `
      SELECT id
      FROM cab_orders
      WHERE order_status = 0
        AND order_type = 1
        AND created_at <= DATE_SUB(?, INTERVAL 90 SECOND)
      `,
      [now]
    );

    if (!orders.length) {
      return res.status(200).json({
        success: true,
        message: "No expired pending order_type 1 orders found",
        deleted_count: 0
      });
    }

    const orderIds = orders.map(o => o.id);

    // 🗑️ Delete from MySQL
    await db.query(
      `DELETE FROM cab_orders WHERE id IN (?)`,
      [orderIds]
    );

    // 🗑️ Delete from Firebase
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
      message: "Expired order_type 1 pending orders deleted successfully",
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





// export async function changeCabOrderStatus(req, res) {
//   try {
//     let {
//       order_id,
//       order_status,
//       type,
//       user_id,
//       driver_id,
//       cancel_reason,
//       orderOtp
//     } = req.body;

//     /* =========================
//       BASIC VALIDATION
//     ========================= */
//     if (!order_id || !order_status || !type) {
//       return res.status(400).json({
//         success: false,
//         message: "order_id, order_status and type are required"
//       });
//     }

//     if (![1, 2].includes(Number(type))) {
//       return res.status(400).json({
//         success: false,
//         message: "type must be 1 (user) or 2 (driver)"
//       });
//     }

//     if (Number(type) === 1 && !user_id) {
//       return res.status(400).json({
//         success: false,
//         message: "user_id is required when type = 1"
//       });
//     }

//     if (Number(type) === 2 && !driver_id) {
//       return res.status(400).json({
//         success: false,
//         message: "driver_id is required when type = 2"
//       });
//     }

//     if (Number(order_status) === 3 && !orderOtp) {
//       return res.status(400).json({
//         success: false,
//         message: "orderOtp is required for ride start"
//       });
//     }



//     if (Number(order_status) === 6 && Number(type) !== 1) {
//       return res.status(400).json({
//         success: false,
//         message: "order_status 6 requires type = 1"
//       });
//     }

//     if (Number(order_status) === 7 && Number(type) !== 2) {
//       return res.status(400).json({
//         success: false,
//         message: "order_status 7 requires type = 2"
//       });
//     }

  

//     const now = nowIST();
//     const firestore = getFirestore();

//     /* =========================
//       FETCH ORDER DETAILS
//     ========================= */
//     const [orderRows] = await db.query(
//       `
//       SELECT
//         id,
//         orderOtp,
//         order_status,
//         pay_mode,
//         user_id,
//         wallet_apply,
//         final_amount
//       FROM cab_orders
//       WHERE id = ?
//       LIMIT 1
//       `,
//       [order_id]
//     );

//     if (!orderRows.length) {
//       return res.status(404).json({
//         success: false,
//         message: "Order not found"
//       });
//     }


//     if (Number(orderRows[0].order_status) === Number(order_status)) {
//       return res.status(400).json({
//         success: false,
//         message: "Order status already updated",
//         order_id,
//         order_status: Number(order_status)
//       });
//     }



//     if (!user_id) {
//       user_id = orderRows[0].user_id;
//     }

//     const {
//       pay_mode,
//       wallet_apply,
//       final_amount
//     } = orderRows[0];

//     /* =========================
//       OTP MATCH CHECK
//     ========================= */
//     if (Number(order_status) === 3) {
//       if (String(orderRows[0].orderOtp) !== String(orderOtp)) {
//         return res.status(400).json({
//           success: false,
//           message: "Invalid order OTP"
//         });
//       }
//     }

//     /* =========================================================
//       🔥 SPECIAL PAYMENT LOGIC
//       This block runs ONLY when order_status = 5 (Ride Completed)
//     ========================================================= */
//     if (Number(order_status) === 5) {

//       /* =========================
//          CASE 1:
//          Online payment (pay_mode = 1)
//          with wallet partially applied (wallet_apply = 1)
//          → No extra operation required
//       ========================= */
//       if (Number(pay_mode) === 1 && Number(wallet_apply) === 1) {
//         // Directly proceed to order completion
//       }

//       /* =========================
//          CASE 2:
//          Wallet payment (pay_mode = 3)
//       ========================= */
//       if (Number(pay_mode) === 3) {

//         // Platform fee calculation
//         const [setting] = await db.query(
//           `SELECT value FROM settings WHERE name = 'platform_fee' LIMIT 1`
//         );

//         const percent = setting.length ? Number(setting[0].value) : 0;
//         const fee = (Number(final_amount) * percent) / 100;

//         const finalAmount_for_driver_wallet =
//           Number(final_amount) - fee;

//         const platformFeeFormatted =
//           `${percent}% - ₹${fee.toFixed(2)}`;

//         // Insert into paying table
//         await db.query(
//           `
//           INSERT INTO paying
//           (
//             service_order_id,
//             user_id,
//             amount,
//             platform_fee,
//             final_amount,
//             payment_type,
//             gateway_type,
//             transaction_id,
//             status,
//             module_type,
//             created_at,
//             updated_at
//           )
//           VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
//           `,
//           [
//             order_id,
//             user_id,
//             final_amount,
//             platformFeeFormatted,
//             finalAmount_for_driver_wallet,
//             3,
//             null,
//             null,
//             1,
//             2,
//             now,
//             now
//           ]
//         );

//         // Deduct full amount from user wallet
//         await db.query(
//           `UPDATE users SET wallet = wallet - ? WHERE id = ?`,
//           [final_amount, user_id]
//         );

//         // Add amount to driver wallet
//         await db.query(
//           `
//           UPDATE driver_registration
//           SET wallet = wallet + ?
//           WHERE id = ?
//           `,
//           [finalAmount_for_driver_wallet, driver_id]
//         );
//       }

//       /* =========================
//          CASE 3:
//          Offline payment (pay_mode = 2)
//       ========================= */
//       if (Number(pay_mode) === 2) {

//         const [setting] = await db.query(
//           `SELECT value FROM settings WHERE name = 'platform_fee' LIMIT 1`
//         );

//         const percent = setting.length ? Number(setting[0].value) : 0;
//         const fee = (Number(final_amount) * percent) / 100;

//         const platformFeeFormatted =
//           `${percent}% - ₹${fee.toFixed(2)}`;

//         // Insert into paying table
//         await db.query(
//           `
//           INSERT INTO paying
//           (
//             service_order_id,
//             user_id,
//             amount,
//             platform_fee,
//             final_amount,
//             payment_type,
//             gateway_type,
//             transaction_id,
//             status,
//             module_type,
//             created_at,
//             updated_at
//           )
//           VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
//           `,
//           [
//             order_id,
//             user_id,
//             final_amount,
//             platformFeeFormatted,
//             final_amount,
//             2,
//             null,
//             null,
//             1,
//             2,
//             now,
//             now
//           ]
//         );


 
//       await db.query(
//           `
//           UPDATE driver_registration
//           SET
//             due_wallet = due_wallet + ?
//           WHERE id = ?
//           `,
//           [fee, driver_id]
//         );
//       }
//     }

//     /* =========================
//       UPDATE ORDER STATUS
//     ========================= */
//     await db.query(
//       `
//       UPDATE cab_orders
//       SET
//         order_status = ?,
//         cancel_reason = ?,
//         updated_at = ?
//       WHERE id = ?
//       `,
//       [
//         Number(order_status),
//         [6, 7].includes(Number(order_status)) ? cancel_reason : null,
//         now,
//         order_id
//       ]
//     );

//     await firestore
//       .collection("cab_orders")
//       .doc(String(order_id))
//       .set(
//         {
//           order_status: Number(order_status),
//           cancel_reason:
//             [6, 7].includes(Number(order_status)) ? cancel_reason : null,
//           updated_at: now
//         },
//         { merge: true }
//       );

//     return res.status(200).json({
//       success: true,
//       message: "Order status updated successfully",
//       order_id,
//       order_status: Number(order_status)
//     });

//   } catch (error) {
//     console.error("Change Order Status Error:", error);
//     return res.status(500).json({
//       success: false,
//       message: "Internal Server Error",
//       error: error.message
//     });
//   }
// }


export async function changeCabOrderStatus(req, res) {
  try {
    let {
      order_id,
      order_status,
      type,
      user_id,
      driver_id,
      cancel_reason,
      orderOtp
    } = req.body;

    /* =========================
       BASIC VALIDATION
    ========================= */
    if (!order_id || !order_status || !type) {
      return res.status(400).json({
        success: false,
        message: "order_id, order_status and type are required"
      });
    }

    // type: 1 = user, 2 = driver
    if (![1, 2].includes(Number(type))) {
      return res.status(400).json({
        success: false,
        message: "type must be 1 (user) or 2 (driver)"
      });
    }

    if (Number(type) === 1 && !user_id) {
      return res.status(400).json({
        success: false,
        message: "user_id is required when type = 1"
      });
    }

    if (Number(type) === 2 && !driver_id) {
      return res.status(400).json({
        success: false,
        message: "driver_id is required when type = 2"
      });
    }

    // Ride start requires OTP
    if (Number(order_status) === 3 && !orderOtp) {
      return res.status(400).json({
        success: false,
        message: "orderOtp is required for ride start"
      });
    }

    // User cancel validation
    if (Number(order_status) === 6 && Number(type) !== 1) {
      return res.status(400).json({
        success: false,
        message: "order_status 6 requires type = 1"
      });
    }

    // Driver cancel validation
    if (Number(order_status) === 7 && Number(type) !== 2) {
      return res.status(400).json({
        success: false,
        message: "order_status 7 requires type = 2"
      });
    }

    const now = nowIST();
    const firestore = getFirestore();

    /* =========================
       FETCH ORDER DETAILS
    ========================= */
    const [orderRows] = await db.query(
      `
      SELECT
        id,
        orderOtp,
        order_status,
        pay_mode,
        user_id,
        driver_id,
        wallet_apply,
        final_amount
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

    const previousStatus = Number(orderRows[0].order_status);

    // Prevent duplicate update
    if (previousStatus === Number(order_status)) {
      return res.status(400).json({
        success: false,
        message: "Order status already updated",
        order_id,
        order_status: Number(order_status)
      });
    }

    // Fallback IDs
    if (!user_id) user_id = orderRows[0].user_id;
    if (!driver_id) driver_id = orderRows[0].driver_id;

    const { pay_mode, wallet_apply, final_amount } = orderRows[0];

    /* =========================
       OTP MATCH CHECK
    ========================= */
    if (Number(order_status) === 3) {
      if (String(orderRows[0].orderOtp) !== String(orderOtp)) {
        return res.status(400).json({
          success: false,
          message: "Invalid order OTP"
        });
      }
    }

    /* =========================================================
       🔥 SPECIAL PAYMENT LOGIC (UNCHANGED)
       This block runs ONLY when order_status = 5 (Ride Completed)
    ========================================================= */
    if (Number(order_status) === 5) {

      /* CASE 1: Online payment + wallet applied */
      if (Number(pay_mode) === 1 && Number(wallet_apply) === 1) {
        // No extra operation required
      }

      /* CASE 2: Wallet payment */
      if (Number(pay_mode) === 3) {

        const [setting] = await db.query(
          `SELECT value FROM settings WHERE name = 'platform_fee' LIMIT 1`
        );

        const percent = setting.length ? Number(setting[0].value) : 0;
        const fee = (Number(final_amount) * percent) / 100;

        const finalAmount_for_driver_wallet =
          Number(final_amount) - fee;

        const platformFeeFormatted =
          `${percent}% - ₹${fee.toFixed(2)}`;

        await db.query(
          `
          INSERT INTO paying
          (
            service_order_id,
            user_id,
            amount,
            platform_fee,
            final_amount,
            payment_type,
            gateway_type,
            transaction_id,
            status,
            module_type,
            created_at,
            updated_at
          )
          VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
          `,
          [
            order_id,
            user_id,
            final_amount,
            platformFeeFormatted,
            finalAmount_for_driver_wallet,
            3,
            null,
            null,
            1,
            2,
            now,
            now
          ]
        );

        await db.query(
          `UPDATE users SET wallet = wallet - ? WHERE id = ?`,
          [final_amount, user_id]
        );

        await db.query(
          `
          UPDATE driver_registration
          SET wallet = wallet + ?
          WHERE id = ?
          `,
          [finalAmount_for_driver_wallet, driver_id]
        );
      }

      /* CASE 3: Offline payment */
      if (Number(pay_mode) === 2) {

        const [setting] = await db.query(
          `SELECT value FROM settings WHERE name = 'platform_fee' LIMIT 1`
        );

        const percent = setting.length ? Number(setting[0].value) : 0;
        const fee = (Number(final_amount) * percent) / 100;

        const platformFeeFormatted =
          `${percent}% - ₹${fee.toFixed(2)}`;

        await db.query(
          `
          INSERT INTO paying
          (
            service_order_id,
            user_id,
            amount,
            platform_fee,
            final_amount,
            payment_type,
            gateway_type,
            transaction_id,
            status,
            module_type,
            created_at,
            updated_at
          )
          VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
          `,
          [
            order_id,
            user_id,
            final_amount,
            platformFeeFormatted,
            final_amount,
            2,
            null,
            null,
            1,
            2,
            now,
            now
          ]
        );

        await db.query(
          `
          UPDATE driver_registration
          SET due_wallet = due_wallet + ?
          WHERE id = ?
          `,
          [fee, driver_id]
        );
      }
    }

    /* =========================
       UPDATE ORDER STATUS
    ========================= */
    await db.query(
      `
      UPDATE cab_orders
      SET
        order_status = ?,
        cancel_reason = ?,
        updated_at = ?
      WHERE id = ?
      `,
      [
        Number(order_status),
        [6, 7].includes(Number(order_status)) ? cancel_reason : null,
        now,
        order_id
      ]
    );

    await firestore
      .collection("cab_orders")
      .doc(String(order_id))
      .set(
        {
          order_status: Number(order_status),
          cancel_reason:
            [6, 7].includes(Number(order_status)) ? cancel_reason : null,
          updated_at: now
        },
        { merge: true }
      );

    /* =====================================================
       🔔 FIREBASE NOTIFICATION LOGIC
       (USING EXISTING FCMHelper STYLE)
    ===================================================== */

    // ❌ If order was never accepted (status = 0), do NOT notify anyone
    /* =====================================================
       🔔 FIREBASE NOTIFICATION LOGIC
       (USING EXISTING FCMHelper STYLE)
    ===================================================== */

    if (previousStatus > 0 && [6, 7].includes(Number(order_status))) {

      // ✅ USER CANCEL → NOTIFY DRIVER
      if (Number(order_status) === 6 && Number(type) === 1) {

        setImmediate(async () => {
          try {
            const [[driver]] = await db.query(
              `SELECT fcm_token FROM driver_registration WHERE id = ?`,
              [driver_id]
            );

            if (!driver || !driver.fcm_token) return;

            await FCMHelper.sendNotification(
              driver.fcm_token,
              "Ride Cancelled",
              "User has cancelled the ride",
              {
                order_id: String(order_id),
                cancelled_by: "user"
              }
            );

          } catch (err) {
            console.error("FCM Driver Cancel Error:", err);
          }
        });
      }

      // ✅ DRIVER CANCEL → NOTIFY USER
      if (Number(order_status) === 7 && Number(type) === 2) {

        setImmediate(async () => {
          try {
            const [[user]] = await db.query(
              `SELECT fcm_token FROM users WHERE id = ?`,
              [user_id]
            );

            if (!user || !user.fcm_token) return;

            await FCMHelper.sendNotification(
              user.fcm_token,
              "Ride Cancelled",
              "Driver has cancelled the ride",
              {
                order_id: String(order_id),
                cancelled_by: "driver"
              }
            );

          } catch (err) {
            console.error("FCM User Cancel Error:", err);
          }
        });
      }
    }

    /* =====================================================
       🚕 DRIVER ACCEPTED NOTIFICATION (Status 0 → 2)
       Aapke screenshot 1 ke according
    ===================================================== */
    if (Number(order_status) === 2 && Number(previousStatus) === 0) {
      setImmediate(async () => {
        try {
          const [[user]] = await db.query(
            `SELECT fcm_token FROM users WHERE id = ?`,
            [user_id]
          );
          
          if (!user || !user.fcm_token) return;
          
          // Aapke screenshot ke hisab se notification message
          await FCMHelper.sendNotification(
            user.fcm_token,
            "Ride Accepted",
            `Use PIN ${orderRows[0].orderOtp}. Give it to your driver at pick-up to start your ride`,
            {
              order_id: String(order_id),
              driver_id: String(driver_id),
              order_status: "2",
              order_otp: String(orderRows[0].orderOtp)
            }
          );
          
          console.log("Driver accepted notification sent to user with OTP:", orderRows[0].orderOtp);
        } catch (err) {
          console.error("FCM Driver Accept Error:", err);
        }
      });
    }

    /* =====================================================
       ✅ TRIP VERIFIED NOTIFICATION (Status → 3)
       Aapke screenshot 2 ke according
    ===================================================== */
    if (Number(order_status) === 3) {
      setImmediate(async () => {
        try {
          const [[user]] = await db.query(
            `SELECT fcm_token FROM users WHERE id = ?`,
            [user_id]
          );
          
          if (!user || !user.fcm_token) return;
          
          // Aapke screenshot 2 ke hisab se notification message
          await FCMHelper.sendNotification(
            user.fcm_token,
            "Trip Verified",
            "Have a great trip!",
            {
              order_id: String(order_id),
              driver_id: String(driver_id),
              order_status: "3",
              verified: "true"
            }
          );
          
          console.log("Trip verified notification sent to user");
        } catch (err) {
          console.error("FCM Trip Verified Error:", err);
        }
      });
    }

    /* =========================
       FINAL RESPONSE
    ========================= */
    return res.status(200).json({
      success: true,
      message: "Order status updated successfully",
      order_id,
      order_status: Number(order_status)
    });

  } catch (error) {
    console.error("Change Order Status Error:", error);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      error: error.message
    });
  }
}


export async function activeRide(req, res) {
  try {
    const {
      type,
      user_id,
      driver_id
    } = req.body;

    /* =========================
       BASIC VALIDATION
    ========================= */
    if (!type) {
      return res.status(400).json({
        success: false,
        message: "type is required"
      });
    }

    if (![1, 2].includes(Number(type))) {
      return res.status(400).json({
        success: false,
        message: "type must be 1 (user) or 2 (driver)"
      });
    }

    if (Number(type) === 1 && !user_id) {
      return res.status(400).json({
        success: false,
        message: "user_id is required when type = 1"
      });
    }

    if (Number(type) === 2 && !driver_id) {
      return res.status(400).json({
        success: false,
        message: "driver_id is required when type = 2"
      });
    }

    /* =========================
       BUILD WHERE CONDITION
    ========================= */
    let where = `
      WHERE order_status BETWEEN 1 AND 4
    `;
    let values = [];

    if (Number(type) === 1) {
      where += " AND user_id = ? ";
      values.push(user_id);
    }

    if (Number(type) === 2) {
      where += " AND driver_id = ? ";
      values.push(driver_id);
    }

    /* =========================
       CHECK ACTIVE RIDE (MySQL)
    ========================= */
    const [rows] = await db.query(
      `
      SELECT id AS order_id, order_status
      FROM cab_orders
      ${where}
      ORDER BY id DESC
      LIMIT 1
      `,
      values
    );

    /* =========================
       ❌ NO ACTIVE RIDE → 400
    ========================= */
    if (!rows.length) {
      return res.status(400).json({
        success: false,
        active_ride_count: 0,
        message: "No active ride found"
      });
    }

    /* =========================
       ✅ ACTIVE RIDE FOUND
    ========================= */
    return res.status(200).json({
      success: true,
      active_ride_count: 1,
      data: rows[0]
    });

  } catch (error) {
    console.error("Active Ride Error:", error);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      error: error.message
    });
  }
}




export async function cabchangePaymentMode(req, res) {
  try {
    const { order_id, user_id, pay_mode } = req.body;

    /* =========================
       BASIC VALIDATION
    ========================= */
    if (!order_id || !user_id || !pay_mode) {
      return res.status(400).json({
        success: false,
        message: "order_id, user_id and pay_mode are required"
      });
    }

    if (![1, 2, 3].includes(Number(pay_mode))) {
      return res.status(400).json({
        success: false,
        message: "pay_mode must be 1 (online), 2 (offline), or 3 (wallet)"
      });
    }

    const now = nowIST();
    const firestore = getFirestore();

    /* =========================
       GET USER WALLET AMOUNT
    ========================= */
    const [userRows] = await db.query(
      `SELECT wallet FROM users WHERE id = ? LIMIT 1`,
      [user_id]
    );

    if (!userRows.length) {
      return res.status(404).json({
        success: false,
        message: "User not found"
      });
    }

    const user_wallet = Number(userRows[0].wallet) || 0;

    /* =========================
       GET ORDER DETAILS
    ========================= */
    const [orderRows] = await db.query(
      `
      SELECT pay_mode, wallet_apply, final_amount, order_status
      FROM cab_orders
      WHERE id = ? AND user_id = ?
      LIMIT 1
      `,
      [order_id, user_id]
    );

    if (!orderRows.length) {
      return res.status(404).json({
        success: false,
        message: "Order not found"
      });
    }

    /* =========================
       SECURITY CHECK
       If ride is already completed (order_status = 5),
       no payment mode change is allowed
    ========================= */
    if (Number(orderRows[0].order_status) === 5) {
      return res.status(400).json({
        success: false,
        message: "Ride already completed. Payment mode cannot be changed."
      });
    }

    const current_pay_mode = Number(orderRows[0].pay_mode);
    const final_amount = Number(orderRows[0].final_amount);

    /* =========================
       SAME PAYMENT MODE CHECK
    ========================= */
    if (current_pay_mode === Number(pay_mode)) {
      return res.status(200).json({
        success: true,
        message: "Payment mode already selected",
        pay_mode: current_pay_mode
      });
    }

    /* =========================
       ONLINE / OFFLINE PAYMENT
       pay_mode = 1 (online)
       pay_mode = 2 (offline)
    ========================= */
    if ([1, 2].includes(Number(pay_mode))) {

      await db.query(
        `
        UPDATE cab_orders
        SET
          pay_mode = ?,
          wallet_apply = 0,
          amount_after_wallet = 0,
          updated_at = ?
        WHERE id = ?
        `,
        [Number(pay_mode), now, order_id]
      );

      await firestore
        .collection("cab_orders")
        .doc(String(order_id))
        .set(
          {
            pay_mode: Number(pay_mode),
            wallet_apply: 0,
            amount_after_wallet: 0,
            updated_at: now
          },
          { merge: true }
        );

      return res.status(200).json({
        success: true,
        message: "Payment mode updated successfully",
        pay_mode: Number(pay_mode)
      });
    }

    /* =========================
       WALLET PAYMENT MODE (3)
    ========================= */
    if (Number(pay_mode) === 3) {

      /* ❌ Case 1: Wallet balance is zero */
      if (user_wallet <= 0) {
        return res.status(400).json({
          success: false,
          message: "Insufficient wallet balance"
        });
      }

      /* ✅ Case 2: Wallet balance is enough to pay full amount */
      if (user_wallet >= final_amount) {

        await db.query(
          `
          UPDATE cab_orders
          SET
            pay_mode = 3,
            wallet_apply = 1,
            amount_after_wallet = 0,
            updated_at = ?
          WHERE id = ?
          `,
          [now, order_id]
        );

        await firestore
          .collection("cab_orders")
          .doc(String(order_id))
          .set(
            {
              pay_mode: 3,
              wallet_apply: 1,
              amount_after_wallet: 0,
              updated_at: now
            },
            { merge: true }
          );

        return res.status(200).json({
          success: true,
          message: "Full payment will be done using wallet",
          pay_mode: 3
        });
      }

      /* =========================
         Case 3:
         Wallet balance is greater than zero
         but less than final_amount
         Partial wallet payment + online payment
      ========================= */

      const amount_after_wallet = final_amount - user_wallet;

      await db.query(
        `
        UPDATE cab_orders
        SET
          pay_mode = 1,
          wallet_apply = 1,
          amount_after_wallet = ?,
          updated_at = ?
        WHERE id = ?
        `,
        [amount_after_wallet, now, order_id]
      );

      await firestore
        .collection("cab_orders")
        .doc(String(order_id))
        .set(
          {
            pay_mode: 1,
            wallet_apply: 1,
            amount_after_wallet,
            updated_at: now
          },
          { merge: true }
        );

      return res.status(200).json({
        success: true,
        message: "Wallet partially used, remaining amount to be paid online",
        pay_mode: 1,
        amount_after_wallet
      });
    }

  } catch (error) {
    console.error("Change Payment Mode Error:", error);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      error: error.message
    });
  }
}




export const letterOrderNotification = async (req, res) => {
  try {
    const { order_id } = req.query;

    /* =========================
       FETCH ACTIVE ORDER
    ========================= */
    const [[order]] = await db.query(
      `
      SELECT user_id, drop_location, schedule_time
      FROM cab_orders
      WHERE id = ?
        AND order_status = 0
      LIMIT 1
      `,
      [order_id]
    );

    if (!order) {
      return res.status(404).json({
        success: false,
        message: "Order not found"
      });
    }

    /* =========================
       FORMAT TIME (AM / PM)
    ========================= */
    let rideTime = "";
    if (order.schedule_time) {
      const dateObj = new Date(order.schedule_time);

      rideTime = dateObj.toLocaleTimeString("en-US", {
        hour: "numeric",
        minute: "2-digit",
        hour12: true
      });
    }

    /* =========================
       FETCH USER FCM TOKEN
    ========================= */
    const [[user]] = await db.query(
      `
      SELECT fcm_token
      FROM users
      WHERE id = ?
      LIMIT 1
      `,
      [order.user_id]
    );

    if (!user || !user.fcm_token) {
      return res.status(404).json({
        success: false,
        message: "FCM token not found for the user"
      });
    }

    /* =========================
       SEND RIDE REMINDER
    ========================= */
    await FCMHelper.sendNotification(
      user.fcm_token,
      "Ride Reminder 🚕",
      `Your ride request is in progress for today at ${rideTime}. Destination: ${order.drop_location}`,
      {
        type: "ride_reminder",
        order_id: String(order_id),
        user_id: String(order.user_id)
      }
    );

    return res.json({
      success: true,
      message: "Ride reminder notification sent successfully"
    });

  } catch (error) {
    console.error("Letter Order Notification Error:", error);

    return res.status(500).json({
      success: false,
      message: "Failed to send ride reminder notification",
      error: error.message
    });
  }
};



function buildFirebaseOrderPayload(order, matched_driver_ids, createdAt) {
  return {
    order_id: Number(order.id),

    user_id: Number(order.user_id),
    user_name: order.user_name,
    user_mobile: Number(order.user_mobile),

    vehicle_id: Number(order.vehicle_id),
    vehicle_name: order.vehicle_name,

    brand_id: Number(order.brand_id),
    brand_name: order.brand_name,

    model_id: Number(order.model_id),
    model_name: order.model_name,

    pickup_location: order.pickup_location,
    pickup_latitude: Number(order.pickup_latitude),
    pickup_longitude: Number(order.pickup_longitude),

    drop_location: order.drop_location,
    drop_latitude: Number(order.drop_latitude),
    drop_longitude: Number(order.drop_longitude),

    distance_km: Number(order.distance_km),
    estimated_amount: Number(order.estimated_amount),

    order_type: Number(order.order_type),
    schedule_time: order.schedule_time,

    pay_mode: order.pay_mode,
    wallet_apply: order.wallet_apply,
    payment_status: 0,

    over_limit_passenger: order.over_limit_passenger || null,
    user_comment: order.user_comment || null,

    orderOtp: order.orderOtp,
    matched_driver_ids,

    order_status: 0,
    created_at: createdAt,
    updated_at: createdAt
  };
}




export const laterAssignOrder = async (req, res) => {
  const { order_id } = req.query;
  try {
    /* =========================
       1. FETCH SCHEDULED ORDER
    ========================= */
   const [[order]] = await db.query(
      `
      SELECT *
      FROM cab_orders
      WHERE id = ?
        AND order_type = 2
        AND order_status = 0
      LIMIT 1
      `,
      [order_id]
    );


    if (!order) {
      return res.json({
        success: false,
        message: "Scheduled order not found"
      });
    }

    /* =========================
       2. REAL-TIME DRIVER MATCH
    ========================= */
    const firestore = getFirestore();

    const snapshot = await firestore
      .collection("driver")
      .where("online_status", "==", 1)
      .where("vehicle_type", "==", Number(order.vehicle_id))
      .get();

    const matched_driver_ids = [];

    snapshot.forEach(doc => {
      const d = doc.data();

      if (!d.current_latitude || !d.current_longitude) return;

      const dist = getDistanceInKm(
        d.current_latitude,
        d.current_longitude,
        order.pickup_latitude,
        order.pickup_longitude
      );

      if (dist <= 5000) {
        matched_driver_ids.push(Number(doc.id));
      }
    });

    /* =========================
       3. UPDATE MYSQL
    ========================= */
    await db.query(
      `UPDATE cab_orders SET matched_driver_id = ? WHERE id = ?`,
      [JSON.stringify(matched_driver_ids), order_id]
    );

    /* =========================
       4. FIREBASE INSERT / UPDATE
       (FORMAT SAME)
    ========================= */
    if (matched_driver_ids.length > 0) {
      const payload = buildFirebaseOrderPayload(
        order,
        matched_driver_ids,
        nowIST()
      );

      await firestore
        .collection("cab_orders")
        .doc(String(order_id))
        .set(payload);
    }

    /* =========================
       5. FCM NOTIFICATION
    ========================= */
    if (matched_driver_ids.length > 0) {
      const [drivers] = await db.query(
        `SELECT fcm_token FROM driver_registration WHERE id IN (?)`,
        [matched_driver_ids]
      );

      for (const drv of drivers) {
        if (!drv.fcm_token) continue;

        await FCMHelper.sendNotification(
          drv.fcm_token,
          "Scheduled Cab Ride",
          order.pickup_location,
          {
            order_id: String(order_id)
          }
        );
      }
    }

    return res.json({
      success: true,
      order_id,
      matched_driver_count: matched_driver_ids.length
    });

  } catch (err) {
    console.error("laterAssignOrder error:", err);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error"
    });
  }
};




export async function acceptLaterRide(req, res) {
  try {
    const { order_id, driver_id, user_id } = req.body;

    /* =========================
       BASIC VALIDATION
    ========================= */
    if (!order_id || !driver_id || !user_id) {
      return res.status(400).json({
        success: false,
        message: "order_id, driver_id and user_id are required"
      });
    }

    const now = nowIST();
    const BASE_URL = process.env.BASE_URL || "";
    const firestore = getFirestore();

    /* =========================
       CHECK ORDER STATUS
    ========================= */
    const [orderRows] = await db.query(
      `
      SELECT 
        id,
        user_id,
        wallet_apply,
        pay_mode,
        estimated_amount,
        order_status
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
        message: "Already accepted by another driver"
      });
    }

    /* =========================
       REQUIRED ORDER DATA
    ========================= */
    const wallet_apply = orderRows[0].wallet_apply;
    let pay_mode = orderRows[0].pay_mode;
    const final_amount = Number(orderRows[0].estimated_amount);
    let amount_after_wallet = 0;

    /* =========================
       WALLET LOGIC
    ========================= */
    const [userRows] = await db.query(
      `SELECT wallet, fcm_token FROM users WHERE id = ? LIMIT 1`,
      [user_id]
    );

    const wallet_amount = Number(userRows[0]?.wallet) || 0;
    const user_fcm_token = userRows[0]?.fcm_token || null;

    if (pay_mode == 3 && wallet_apply == 1 && wallet_amount < final_amount) {
      amount_after_wallet = final_amount - wallet_amount;
      pay_mode = 1;
    }

    if (pay_mode == 1 && wallet_apply == 1) {
      amount_after_wallet = final_amount - wallet_amount;
    }

    /* =========================
       GET DRIVER DETAILS
    ========================= */
    const [driverRows] = await db.query(
      `
      SELECT
        first_name,
        last_name,
        profile_photo,
        vehicle_plate_number,
        mobile,
        rating,
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

    const profile_photo = driver.profile_photo
      ? `${BASE_URL}/${driver.profile_photo.replace(/^\//, "")}`
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
        rating = ?,
        vehicle_color = ?,
        final_amount = ?,
        amount_after_wallet = ?,
        wallet_apply = ?,
        pay_mode = ?,
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
        driver.rating || null,
        driver.vehicle_color || null,
        final_amount,
        amount_after_wallet,
        wallet_apply,
        pay_mode,
        now,
        order_id
      ]
    );

    /* =========================
       UPDATE cab_orders (Firebase)
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
        rating: driver.rating || null,
        vehicle_color: driver.vehicle_color || null,
        final_amount,
        estimated_amount: final_amount,
        amount_after_wallet,
        wallet_apply,
        pay_mode,
        order_status: 1,
        updated_at: now
      });

    /* =========================
       USER FCM NOTIFICATION
    ========================= */
    if (user_fcm_token) {
      try {
        await FCMHelper.sendNotification(
          user_fcm_token,
          "Ride Accepted",
          `Your scheduled ride has been accepted by driver ${driver_name}.`,
          {
            type: "active_ride"
          }
        );
      } catch (fcmErr) {
        // silent fail or existing error handling
  }
}

    return res.status(200).json({
      success: true,
      message: "Ride accepted successfully",
      order_id,
      driver_id
    });

  } catch (error) {
    console.error("Accept Later Ride Error:", error);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      error: error.message
    });
  }
}



/* =========================================================
   DRIVER IGNORE CAB ORDER (FINAL FIXED VERSION)
========================================================= */
export const driverIgnoreCabOrder = async (req, res) => {
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

    const driverIdNum = Number(driver_id);

    /* =========================
       FETCH ORDER
    ========================= */
    const [[order]] = await db.query(
      `
      SELECT
        id,
        order_status,
        matched_driver_id,
        ignored_drivers_id
      FROM cab_orders
      WHERE id = ?
      LIMIT 1
      `,
      [order_id]
    );

    if (!order) {
      return res.status(404).json({
        success: false,
        message: "Order not found"
      });
    }

    /* =========================
       STATUS CHECK
    ========================= */
    if (Number(order.order_status) !== 0) {
      return res.status(400).json({
        success: false,
        message: "Order already accepted"
      });
    }

    /* =========================
       SAFE PARSE DRIVER LISTS
    ========================= */
    let matchedDrivers = [];
    let ignoredDrivers = [];

    // matched drivers
    if (typeof order.matched_driver_id === "string") {
      try {
        matchedDrivers = JSON.parse(order.matched_driver_id);
      } catch {
        matchedDrivers = [];
      }
    }

    // ignored drivers
    if (typeof order.ignored_drivers_id === "string") {
      try {
        ignoredDrivers = JSON.parse(order.ignored_drivers_id);
      } catch {
        ignoredDrivers = [];
      }
    }

    // force arrays
    if (!Array.isArray(matchedDrivers)) matchedDrivers = [];
    if (!Array.isArray(ignoredDrivers)) ignoredDrivers = [];

    /* =========================
       REMOVE DRIVER FROM MATCHED
    ========================= */
    matchedDrivers = matchedDrivers.filter(id => id !== driverIdNum);

    /* =========================
       ADD DRIVER TO IGNORED (NO DUP)
    ========================= */
    if (!ignoredDrivers.includes(driverIdNum)) {
      ignoredDrivers.push(driverIdNum);
    }

    /* =========================
       FINAL ORDER STATUS
    ========================= */
    let finalOrderStatus = 0;

    // 🔥 no driver left
    if (matchedDrivers.length === 0) {
      finalOrderStatus = 8; // ignored by all drivers
    }

    const updatedAt = nowIST();

    /* =========================
       MYSQL UPDATE
    ========================= */
    await db.query(
      `
      UPDATE cab_orders
      SET
        matched_driver_id = ?,
        ignored_drivers_id = ?,
        order_status = ?,
        updated_at = ?
      WHERE id = ?
      `,
      [
        JSON.stringify(matchedDrivers),
        JSON.stringify(ignoredDrivers),
        finalOrderStatus,
        updatedAt,
        order_id
      ]
    );

    /* =========================
       FIREBASE UPDATE
    ========================= */
    const firestore = getFirestore();

    await firestore
      .collection("cab_orders")
      .doc(String(order_id))
      .update({
        matched_driver_ids: matchedDrivers,
        ignored_driver_ids: ignoredDrivers,
        order_status: finalOrderStatus,
        updated_at: updatedAt
      });

    /* =========================
       SUCCESS RESPONSE
    ========================= */
    return res.status(200).json({
      success: true,
      message:
        finalOrderStatus === 8
          ? "Ignored successfully."
          : "Ignored successfully.",
      data: {
        order_id,
        matched_driver_ids: matchedDrivers,
        ignored_driver_ids: ignoredDrivers,
        order_status: finalOrderStatus
      }
    });

  } catch (error) {
    console.error("DRIVER IGNORE ERROR:", error);
    return res.status(500).json({
      success: false,
      message: "Internal server error",
      error: error.message
    });
  }
};





export const updateEstimatedAmount = async (req, res) => {
  try {
    const { order_id, estimated_amount } = req.body;

    /* =========================
       BASIC VALIDATION
    ========================= */
    if (!order_id) {
      return res.status(400).json({
        message: "order_id is required"
      });
    }

    if (!estimated_amount || Number(estimated_amount) <= 0) {
      return res.status(400).json({
        message: "valid estimated_amount is required"
      });
    }

    /* =========================
       CHECK ORDER EXIST
    ========================= */
    const [[order]] = await db.query(
      `
      SELECT id, order_status
      FROM cab_orders
      WHERE id = ?
      LIMIT 1
      `,
      [order_id]
    );

    if (!order) {
      return res.status(404).json({
        message: "Order not found"
      });
    }

    /* =========================
       CHECK ORDER STATUS
    ========================= */
    if (Number(order.order_status) !== 0) {
      return res.status(400).json({
        message: "Only pending orders allowed."
      });
    }

    const updatedAt = nowIST();

    /* =========================
       MYSQL UPDATE
    ========================= */
    await db.query(
      `
      UPDATE cab_orders
      SET estimated_amount = ?, updated_at = ?
      WHERE id = ?
      `,
      [estimated_amount, updatedAt, order_id]
    );

    /* =========================
       FIREBASE UPDATE
    ========================= */
    const firestore = getFirestore();

    await firestore
      .collection("cab_orders")
      .doc(String(order_id))
      .update({
        estimated_amount: Number(estimated_amount),
        updated_at: updatedAt
      });

    /* =========================
       FINAL RESPONSE
    ========================= */
    return res.status(200).json({
      message: "Raise fare updated successfully",
      order_id,
      estimated_amount
    });

  } catch (err) {
    console.error("Raise fare Amount Error:", err);
    return res.status(500).json({
      message: "Internal Server Error",
      error: err.message
    });
  }
};
