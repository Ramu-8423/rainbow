import { sendOrderToServicemen } from "./socketSender.js";
import db from "../../config/database.js";
import { body, validationResult } from "express-validator";
import { getIO } from "../../socket.js";
import { FCMHelper } from "../../middleware/fcmHelper.js";
import { parseIST, nowIST } from "../../utils/dateParser.js";



export async function ignoreOrder(req, res) {
  const { order_id, serviceman_id } = req.body;

  if (!order_id || !serviceman_id) {
    return res.status(400).json({
      success: false,
      message: "order_id and serviceman_id are required"
    });
  }

  try {
    const [order] = await db.query(
      `SELECT available_service_man, ignore_service_man 
       FROM service_order WHERE id = ?`,
      [order_id]
    );

    if (!order.length) {
      return res.status(404).json({
        success: false,
        message: "Order not found"
      });
    }

    let available = JSON.parse(order[0].available_service_man || "[]");
    let ignored = JSON.parse(order[0].ignore_service_man || "[]");

    // ➤ Remove serviceman from available list
    available = available.filter(id => id != serviceman_id);

    // ➤ Add into ignore list
    if (!ignored.includes(serviceman_id)) {
      ignored.push(serviceman_id);
    }

    let newStatus = 0;

    // 🔥 Agar available empty ho gaya
    if (available.length === 0) {
      newStatus = 7;
    }

    await db.query(
      `UPDATE service_order SET 
        available_service_man = ?,
        ignore_service_man = ?,
        service_status = CASE WHEN ? = 7 THEN 7 ELSE service_status END
       WHERE id = ?`,
      [
        JSON.stringify(available),
        JSON.stringify(ignored),
        newStatus,
        order_id
      ]
    );

    // ───────── SOCKET EMIT (FIXED LIKE ACCEPT) ─────────

    const io = getIO();

    // ✅ GLOBAL REMOVE – accept jaisa
    io.emit("order_removed", { order_id });

    // Agar sabne ignore kar diya
    if (newStatus === 7) {
      io.emit("order_closed", {
        order_id,
        status: 7
      });
    }

    return res.json({
      success: true,
      message: "Order ignored successfully",
      status: newStatus === 7 ? "closed" : "updated"
    });

  } catch (error) {
    console.log("Ignore Order Error:", error);
    return res.status(500).json({
      success: false,
      message: "Internal server error"
    });
  }
}

export async function acceptOrder(req, res) {
  const { order_id, serviceman_id } = req.body;

  if (!order_id || !serviceman_id) {
    return res.status(400).json({
      success: false,
      message: "order_id and serviceman_id are required"
    });
  }

  try {
    // 🔹 Order fetch (with lat/lng)
    const [orderCheck] = await db.query(
      `
      SELECT 
        service_status,
        serviceman_id,
        user_id,
        service_datetime,
        service_latitude,
        service_longitude
      FROM service_order 
      WHERE id = ?
      LIMIT 1
      `,
      [order_id]
    );

    if (!orderCheck.length) {
      return res.status(404).json({
        success: false,
        message: "Order not found"
      });
    }

    const existing = orderCheck[0];

    if (existing.service_status === 1 || existing.serviceman_id !== null) {
      return res.status(400).json({
        success: false,
        message: "This service is already accepted by another Person"
      });
    }

    const serviceDate = parseIST(existing.service_datetime);
    const currentDate = parseIST(nowIST());

    if (serviceDate < currentDate) {
      return res.status(400).json({
        success: false,
        message: "You can only accept services scheduled for a future time"
      });
    }

    // 🔹 Serviceman fetch (with lat/lng)
    const [sm] = await db.query(
      `
      SELECT 
        first_name,
        last_name,
        mobile,
        current_latitude,
        current_longitude
      FROM serviceman 
      WHERE id = ?
      LIMIT 1
      `,
      [serviceman_id]
    );

    if (!sm.length) {
      return res.status(404).json({
        success: false,
        message: "Serviceman not found"
      });
    }

    const serviceman = sm[0];

    // 🧮 DISTANCE CALCULATION (meters)
    const distanceMeters = calculateDistanceInMeters(
      Number(serviceman.current_latitude),
      Number(serviceman.current_longitude),
      Number(existing.service_latitude),
      Number(existing.service_longitude)
    );

    console.log("📍 Distance (meters):", distanceMeters);

    const fullName =
      (serviceman.first_name || "") +
      (serviceman.last_name ? " " + serviceman.last_name : "");

    // 🔹 UPDATE order (status + serviceman + distance)
    await db.query(
      `
      UPDATE service_order
      SET 
        service_status = 1,
        serviceman_id = ?,
        serviceman_name = ?,
        serviceman_mobile = ?,
        distance = ?
      WHERE id = ?
      `,
      [
        serviceman_id,
        fullName,
        serviceman.mobile,
        distanceMeters,
        order_id
      ]
    );

    // 🔔 User notification
    const [userRow] = await db.query(
      "SELECT fcm_token FROM users WHERE id = ? LIMIT 1",
      [existing.user_id]
    );

    if (userRow.length && userRow[0].fcm_token) {
      await FCMHelper.sendNotification(
        userRow[0].fcm_token,
        "Service Accepted",
        `${fullName} has accepted your service request`,
        {
          order_id: String(order_id),
          serviceman_name: fullName,
          serviceman_mobile: serviceman.mobile,
          distance: distanceMeters.toFixed(2),
          type: "accept_service",
          role: "user"
        }
      );
    }

    // 🔹 SOCKET EVENTS
    const io = getIO();
    io.emit("order_removed", { order_id });

    io.to("serviceman_" + serviceman_id).emit("order_accepted", {
      order_id,
      distance: distanceMeters
    });

    return res.json({
      success: true,
      message: "Order accepted successfully",
      serviceman_name: fullName,
      serviceman_mobile: serviceman.mobile,
      distance: distanceMeters
    });

  } catch (error) {
    console.log("Accept Order Error:", error);
    return res.status(500).json({
      success: false,
      message: "Internal server error"
    });
  }
}



export async function changeOrderStatus(req, res) {
  if (!req.body || Object.keys(req.body).length === 0) {
    return res.status(400).json({ success: false, message: "Request body is missing" });
  }

  const { order_id, status, type, user_id, cancel_reason, otp } = req.body;

  if (!order_id || status === undefined || !type || !user_id) {
    return res.status(400).json({
      success: false,
      message: "order_id, status, type and user_id are required"
    });
  }

  const allowed = [2, 3, 4, 5, 6, 7];
  if (!allowed.includes(status)) {
    return res.status(400).json({ success: false, message: "Invalid status value" });
  }

  try {
    // 🔹 order details (coupon_id bhi add kiya)
    const [orderRows] = await db.query(
      `SELECT 
         service_status, 
         orderOtp, 
         final_amount, 
         pay_mode, 
         serviceman_id,
         user_id,
         coupon_id
       FROM service_order 
       WHERE id = ? 
       LIMIT 1`,
      [order_id]
    );

    if (!orderRows.length) {
      return res.status(404).json({ success: false, message: "Order not found" });
    }

    const order = orderRows[0];
    const current = order.service_status;
    const createdAt = nowIST();
    
    if (current === status) {
      return res.status(400).json({
        success: false,
        message: "Status is already updated"
      });
    }

    // ===================================================
    // STATUS 2 → OTP CHECK
    // ===================================================
    if (status === 2) {
      if (!otp) {
        return res.status(400).json({ success: false, message: "OTP is required" });
      }

      if (String(otp) !== String(order.orderOtp)) {
        return res.status(400).json({ success: false, message: "Invalid OTP" });
      }

      await db.query(
        "UPDATE service_order SET service_status = 2 WHERE id = ?",
        [order_id]
      );

      return res.json({
        success: true,
        message: "OTP verified successfully.",
        status: 2
      });
    }

    // ===================================================
    // STATUS 3 → OFFLINE / WALLET PAYMENT
    // ===================================================
    if (status === 3) {

      // 👉 OFFLINE PAYMENT
      if (Number(order.pay_mode) === 2) {

        const [payingCheck] = await db.query(
          `SELECT id 
           FROM paying 
           WHERE service_order_id = ? AND payment_type = 2 
           LIMIT 1`,
          [order_id]
        );

        if (!payingCheck.length) {

          const [setting] = await db.query(
            `SELECT value FROM settings WHERE name = 'platform_fee' LIMIT 1`
          );

          const percent = setting.length ? Number(setting[0].value) : 0;
          const fee = (Number(order.final_amount) * percent) / 100;
          const final_amount_after_due = Number(order.final_amount) - fee;

          const platformFeeFormatted = `${percent}% - ₹${fee.toFixed(2)}`;

          await db.query(
              `INSERT INTO paying 
               (
                 service_order_id,
                 user_id,
                 amount,
                 final_amount,
                 payment_type,
                 status,
                 platform_fee,
                 created_at,
                 updated_at
               ) 
               VALUES (?, ?, ?, ?, 2, 1, ?, ?, ?)`,
              [
                order_id,
                order.user_id,
                order.final_amount,
                final_amount_after_due,
                platformFeeFormatted,
                createdAt,
                createdAt
              ]
            );

         await db.query(
              `UPDATE serviceman 
               SET due_wallet = due_wallet + ?
               WHERE id = ?`,
              [fee, order.serviceman_id]
            );

        }

        await db.query(
          "UPDATE service_order SET service_status = 4 WHERE id = ?",
          [order_id]
        );

        if (order.coupon_id) {
          await db.query(
            `UPDATE coupons_used 
             SET status = 1 
             WHERE coupon_id = ? AND user_id = ?`,
            [order.coupon_id, order.user_id]
          );
        }

        return res.json({
          success: true,
          message: "Update successfully",
          status: 4
        });
      }

      // 👉 WALLET PAYMENT
      if (Number(order.pay_mode) === 3) {

        const [paying] = await db.query(
          `SELECT id, amount, final_amount 
           FROM paying 
           WHERE service_order_id = ? AND payment_type = 3 
           LIMIT 1`,
          [order_id]
        );

        if (!paying.length) {
          return res.status(400).json({
            success: false,
            message: "Payment record not found"
          });
        }

        const paying_id = paying[0].id;

        await db.query(
          `UPDATE users SET wallet = wallet - ? WHERE id = ?`,
          [paying[0].amount, order.user_id]
        );

        await db.query(
          `UPDATE serviceman SET wallet = wallet + ? WHERE id = ?`,
          [paying[0].final_amount, order.serviceman_id]
        );

       const dateTime = nowIST();
        await db.query(
          `UPDATE paying 
           SET 
             status = 1,
             created_at = ?,
             updated_at = ?
           WHERE id = ?`,
          [createdAt, createdAt, paying_id]
        );

        await db.query(
          "UPDATE service_order SET service_status = 4 WHERE id = ?",
          [order_id]
        );

        if (order.coupon_id) {
          await db.query(
            `UPDATE coupons_used 
             SET status = 1 
             WHERE coupon_id = ? AND user_id = ?`,
            [order.coupon_id, order.user_id]
          );
        }

        return res.json({
          success: true,
          message: "Update successfully",
          status: 4
        });
      }

      await db.query(
        "UPDATE service_order SET service_status = 3 WHERE id = ?",
        [order_id]
      );

      return res.json({
        success: true,
        message: "Update successfully",
        status: 3
      });
    }

    // ===================================================
    // STATUS 4 → DIRECT UPDATE
    // ===================================================
    if (status === 4) {
      await db.query(
        "UPDATE service_order SET service_status = 4 WHERE id = ?",
        [order_id]
      );

      if (order.coupon_id) {
        await db.query(
          `UPDATE coupons_used 
           SET status = 1 
           WHERE coupon_id = ? AND user_id = ?`,
          [order.coupon_id, order.user_id]
        );
      }

      return res.json({
        success: true,
        message: "Update successfully",
        status: 4
      });
    }

    // ===================================================
    // STATUS 5 & 6 → CANCEL
    // ===================================================
    if (status === 5 || status === 6) {
      if (!cancel_reason || cancel_reason.trim() === "") {
        return res.status(400).json({
          success: false,
          message: "cancel_reason is required"
        });
      }

      await db.query(
        "UPDATE service_order SET service_status = ?, cancel_reason = ? WHERE id = ?",
        [status, cancel_reason, order_id]
      );

      // 🌱🌱🌱 ONLY ADDITION START 🌱🌱🌱

      if (status === 5 && order.serviceman_id) {
        const [sm] = await db.query(
          "SELECT fcm_token FROM serviceman WHERE id = ? LIMIT 1",
          [order.serviceman_id]
        );

        if (sm.length && sm[0].fcm_token) {
          await FCMHelper.sendNotification(
            sm[0].fcm_token,
            "Service Cancelled",
            "User has cancelled the service request",
            {
              type: "cancle_service",
              role: "serviceman",
              order_id: String(order_id)
            }
          );
        }
      }

      if (status === 6 && order.user_id) {
        const [us] = await db.query(
          "SELECT fcm_token FROM users WHERE id = ? LIMIT 1",
          [order.user_id]
        );

        if (us.length && us[0].fcm_token) {
          await FCMHelper.sendNotification(
            us[0].fcm_token,
            "Service Cancelled",
            "Serviceman has cancelled your service request",
            {
              type: "cancle_service",
              role: "users",
              order_id: String(order_id)
            }
          );
        }
      }

      // 🌱🌱🌱 ONLY ADDITION END 🌱🌱🌱

      return res.json({
        success: true,
        message: "Order cancelled",
        status
      });
    }

    // ===================================================
    // STATUS 7 → CLOSE
    // ===================================================
    await db.query(
      "UPDATE service_order SET service_status = 7 WHERE id = ?",
      [order_id]
    );

    return res.json({
      success: true,
      message: "Order status updated",
      status: 7
    });

  } catch (err) {
    console.log("changeOrderStatus Error:", err);
    return res.status(500).json({ success: false, message: "Internal server error" });
  }
}



export async function generateUniqueOTP(db) {
  while (true) {
    const otp = Math.floor(1000 + Math.random() * 9000);
    const [rows] = await db.query(
      "SELECT id FROM service_order WHERE orderOtp = ? LIMIT 1",
      [otp]
    );
    if (rows.length === 0) return otp;
  }
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



export const serviceOrder = [
 body().custom((value, { req }) => {
    const { service_address, service_latitude, service_longitude } = req.body;

    if (
      !service_address?.toString().trim() ||
      !service_latitude?.toString().trim() ||
      !service_longitude?.toString().trim()
    ) {
      throw new Error("Service address is required");
    }

    return true;
  }),

  body("service_datetime")
    .notEmpty()
    .withMessage("Service datetime is required"),

  body("user_id")
    .notEmpty()
    .withMessage("User id is required"),

  body("service_id")
    .notEmpty()
    .withMessage("Service id is required"),

  body("quantity")
    .notEmpty()
    .withMessage("Quantity is required"),

  body("amount")
    .notEmpty()
    .withMessage("Amount is required"),

  body("coupon_discount")
    .notEmpty()
    .withMessage("Coupon discount is required"),

  body("gst_charges")
    .notEmpty()
    .withMessage("GST charges is required"),

  body("final_amount")
    .notEmpty()
    .withMessage("Final amount is required"),

  body("pay_mode")
    .notEmpty()
    .withMessage("Pay mode is required")
    .isIn([1, 2, 3])
    .withMessage("Pay mode must be 1 (online), 2 (offline) or 3 (wallet)"),

  async (req, res) => {

    const errors = validationResult(req);

    if (!errors.isEmpty()) {
      return res.status(400).json({
        success: false,
        message: errors.array()[0].msg // only first error
      });
    }

    try {

      const {
        service_address,
        service_latitude,
        service_longitude,
        service_datetime,
        user_id,
        serviceman_id,
        service_id,          
        amount,
        coupon_discount,
        gst_charges,
        final_amount,
        pay_mode,
        quantity,
        coupon_id,
        description
      } = req.body;

      const createdAt = nowIST();
      const otp = await generateUniqueOTP(db);


   // ===========ZONE CONCEPT START ==============
    // 🔹 LOCATION SERVICE CHECK
    const userLat = Number(service_latitude);
    const userLng = Number(service_longitude);
    
    // Fetch all zones
    const [zones] = await db.query(
      "SELECT id, zone_name, coordinates FROM zones WHERE zone_type = 1"
    );
    
    let serviceAvailable = false;
    let matchedZone = null;
    
    for (const zone of zones) {
      let polygon;
    
      try {
        polygon = JSON.parse(zone.coordinates);
      } catch (err) {
        continue; // skip invalid JSON
      }
    
      if (!Array.isArray(polygon) || polygon.length < 3) continue;
    
      const isInside = isPointInPolygon(
        { lat: userLat, lng: userLng },
        polygon
      );
    
      if (isInside) {
        serviceAvailable = true;
        matchedZone = zone.zone_name;
        break;
      }
    }
    
    if (!serviceAvailable) {
      return res.status(400).json({
        success: false,
        message: "Service not available for this location"
      });
    }
    
    
    // =========ZONE CONCEPT END ===============


      // 🔹 USER FETCH
      const [user] = await db.query(
        "SELECT name, last_name, phone, wallet FROM users WHERE id = ? LIMIT 1",
        [user_id]
      );

      if (!user.length) {
        return res.status(404).json({
          success: false,
          message: "User not found"
        });
      }

      // 🔹 WALLET CHECK
      if (Number(pay_mode) === 3) {
        const walletBalance = Number(user[0].wallet || 0);
        if (walletBalance < Number(final_amount)) {
          return res.status(400).json({
            success: false,
            message: "Insufficient balance in your wallet"
          });
        }
      }

      const first = user[0].name || "";
      const last = user[0].last_name || "";
      const user_name = last.trim() ? `${first} ${last}` : first;
      const user_mobile = user[0].phone;

      // 🔹 SERVICE FETCH (SINGLE)
      const [service] = await db.query(
        "SELECT title, category_id, status FROM services WHERE id = ? LIMIT 1",
        [service_id]
      );

      if (!service.length) {
        return res.status(404).json({
          success: false,
          message: "Service not found"
        });
      }

      if (service[0].status === 0) {
        return res.status(400).json({
          success: false,
          message: "This service is not available now"
        });
      }

      const service_name = service[0].title;
      const category_id = service[0].category_id;

      // 🔹 SERVICE RADIUS
      const [setting] = await db.query(
        "SELECT value FROM settings WHERE name = 'service_radius_km' LIMIT 1"
      );

      const radius_km = setting.length ? Number(setting[0].value) : 5;

      // 🔥 MAIN CHANGE: JSON ARRAY MATCH
      const [allServicemenDistance] = await db.query(
        `
        SELECT 
          id,
          current_latitude,
          current_longitude,
          (
            6371 * ACOS(
              COS(RADIANS(?)) * COS(RADIANS(current_latitude)) *
              COS(RADIANS(current_longitude) - RADIANS(?)) +
              SIN(RADIANS(?)) * SIN(RADIANS(current_latitude))
            )
          ) AS distance
        FROM serviceman
        WHERE 
          JSON_CONTAINS(service_category, JSON_ARRAY(?))
          AND login_status = 1
          AND online_status = 1
        ORDER BY distance ASC
        `,
        [
          service_latitude,
          service_longitude,
          service_latitude,
          Number(category_id)
        ]
      );

      const servicemen = allServicemenDistance.filter(
        s => s.distance <= radius_km
      );

      const available_service_man = servicemen.map(s => s.id);

      // 🔹 INSERT ORDER
      const sql = `
        INSERT INTO service_order 
        (
          service_address, service_latitude, service_longitude,
          user_id, user_name, user_mobile,
          serviceman_id,
          amount, coupon_discount, gst_charges, final_amount,
          service_id, service_name,
          pay_mode, coupon_id,
          service_datetime,
          available_service_man,
          service_status,
          quantity,
          created_at, updated_at, orderOtp, description
        )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      `;

      const [result] = await db.query(sql, [
        service_address,
        service_latitude,
        service_longitude,
        user_id,
        user_name,
        user_mobile,
        serviceman_id || null,
        amount,
        coupon_discount,
        gst_charges,
        final_amount,
        service_id,
        service_name,
        pay_mode,
        coupon_id || null,
        service_datetime,
        JSON.stringify(available_service_man),
        0,
        quantity,
        createdAt,
        createdAt,
        otp,
        description
      ]);

      // 🔹 PAYING TABLE
      if (Number(pay_mode) === 3) {
        const [setting] = await db.query(
          "SELECT value FROM settings WHERE name = 'platform_fee' LIMIT 1"
        );

        const percent = setting.length ? Number(setting[0].value) : 0;
        const fee = (Number(final_amount) * percent) / 100;
        const final_amount_after_due = Number(final_amount) - fee;

        await db.query(
          `INSERT INTO paying 
           (service_order_id, user_id, amount, final_amount, payment_type, status, platform_fee) 
           VALUES (?, ?, ?, ?, 3, 0, ?)`,
          [
            result.insertId,
            user_id,
            final_amount,
            final_amount_after_due,
            `${percent}% - ₹${fee.toFixed(2)}`
          ]
        );
      }

      sendOrderToServicemen(servicemen, {
          order_id: result.insertId,
          service_name,
          customer_name: user_name,
          customer_mobile: user_mobile,
          amount,
          final_amount,
          service_address,
          service_latitude,
          service_longitude,
          quantity,
          time: service_datetime
        });


      // 🔹 FCM NOTIFICATION
      
    //   if (available_service_man.length > 0) {
    //     const [tokens] = await db.query(
    //       "SELECT id, fcm_token FROM serviceman WHERE id IN (?)",
    //       [available_service_man]
    //     );

    //     for (const sm of tokens) {
    //       if (!sm.fcm_token) continue;

    //       await FCMHelper.sendNotification(
    //         sm.fcm_token,
    //         "New Service Request",
    //         `${service_name} requested at ${service_address}`,
    //         {
    //           order_id: String(result.insertId),
    //           service_name,
    //           customer_name: user_name,
    //           customer_mobile: user_mobile,
    //           amount: String(amount),
    //           final_amount: String(final_amount),
    //           service_address,
    //           service_latitude: String(service_latitude),
    //           service_longitude: String(service_longitude),
    //           time: service_datetime,
    //           type: "new_service",
    //           role: "serviceman"
    //         }
    //       );
    //     }
    //   }

      return res.status(201).json({
        success: true,
        message: "Service order created successfully",
        order_id: result.insertId,
        available_service_man
      });

    } catch (err) {
      console.log("Service Order Error:", err);
      return res.status(500).json({
        success: false,
        message: "Internal Server Error",
        error: err.message
      });
    }
  }
];


function calculateDistanceInMeters(lat1, lon1, lat2, lon2) {
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




export async function myActiveOrders(req, res) {

  if (!req.body || Object.keys(req.body).length === 0) {
    return res.status(400).json({
      success: false,
      message: "Request body is missing"
    });
  }

  const { type, user_id, serviceman_id, service_status } = req.body;

  // ---------- Validate type ----------
  if (!type) {
    return res.status(400).json({
      success: false,
      message: "type is required (1=user, 2=serviceman)"
    });
  }

  if (![1, 2, "1", "2"].includes(type)) {
    return res.status(400).json({
      success: false,
      message: "Invalid type (must be 1 or 2)"
    });
  }

  // ---------- Validate based on type ----------
  if (Number(type) === 1 && !user_id) {
    return res.status(400).json({
      success: false,
      message: "user_id is required when type = 1"
    });
  }

  if (Number(type) === 2 && !serviceman_id) {
    return res.status(400).json({
      success: false,
      message: "serviceman_id is required when type = 2"
    });
  }

  // ---------- service_status required ----------
  if (!service_status) {
    return res.status(400).json({
      success: false,
      message: "service_status is required"
    });
  }

  try {

    let statuses = Array.isArray(service_status)
      ? service_status
      : [service_status];

    const placeholders = statuses.map(() => "?").join(",");

    // ---------- Dynamic WHERE condition ----------
    let whereCondition = "";
    let whereParams = [];

    if (Number(type) === 1) {
      whereCondition = "so.user_id = ?";
      whereParams.push(user_id);
    } else {
      whereCondition = "so.serviceman_id = ?";
      whereParams.push(serviceman_id);
    }

    const sql = `
      SELECT 
        so.id,
        so.service_address,
        so.service_latitude,
        so.service_longitude,
        so.user_id,
        so.user_name,
        so.user_mobile,
        so.serviceman_id,
        so.serviceman_name,
        so.serviceman_mobile,
        so.amount,
        so.coupon_discount,
        so.gst_charges,
        so.final_amount,
        so.payment_status,
        so.service_status,
        so.service_id,
        so.service_name,
        so.pay_mode,
        so.coupon_id,
        so.available_service_man,
        so.service_datetime,
        so.updated_at,
        so.created_at,
        so.quantity,
        so.cancel_reason,
        so.orderOtp,
        so.description,
        so.rating,
        so.distance,

        s.image AS service_image,
        sm.profile_photo AS serviceman_profile_photo

      FROM service_order AS so
      LEFT JOIN services AS s ON so.service_id = s.id
      LEFT JOIN serviceman AS sm ON so.serviceman_id = sm.id

      WHERE ${whereCondition}
      AND so.service_status IN (${placeholders})
      ORDER BY so.id DESC
    `;

    const [rows] = await db.query(sql, [...whereParams, ...statuses]);

    // ✅ BASE URL ADD (same pattern as userProfile)
    const BASE_URL = process.env.BASE_URL || "";

    const finalRows = rows.map(row => ({
      ...row,
      service_image: row.service_image
        ? `${BASE_URL}/${row.service_image}`
        : null,
      serviceman_profile_photo: row.serviceman_profile_photo
        ? `${BASE_URL}/${row.serviceman_profile_photo}`
        : null
    }));

    return res.json({
      success: true,
      message: "Orders fetched successfully",
      count: finalRows.length,
      data: finalRows
    });

  } catch (err) {
    console.log("myActiveOrders Error:", err);
    return res.status(500).json({
      success: false,
      message: "Internal server error"
    });
  }
}


export async function changePaymentMode(req, res) {
  try {
    const { service_order_id, pay_mode } = req.body || {};

    if (!service_order_id) {
      return res.status(400).json({
        success: false,
        message: "service_order_id is required"
      });
    }

    if (![1, 2, "1", "2"].includes(pay_mode)) {
      return res.status(400).json({
        success: false,
        message: "pay_mode must be 1 (online) or 2 (offline)"
      });
    }

    const [rows] = await db.query(
      "SELECT id, pay_mode FROM service_order WHERE id = ? LIMIT 1",
      [service_order_id]
    );

    if (!rows.length) {
      return res.status(404).json({
        success: false,
        message: "Service order not found"
      });
    }

    const currentPayMode = Number(rows[0].pay_mode);
    const newPayMode = Number(pay_mode);

    // 🔒 Already selected
    if (currentPayMode === newPayMode) {
      const modeText = newPayMode === 1 ? "online" : "offline";
      return res.status(200).json({
        success: false,
        message: `You already chose ${modeText} payment mode`
      });
    }

    // 🔹 Update
    await db.query(
      "UPDATE service_order SET pay_mode = ?, updated_at = NOW() WHERE id = ?",
      [newPayMode, service_order_id]
    );

    const modeText = newPayMode === 1 ? "Online" : "Offline";

    return res.status(200).json({
      success: true,
      message: `${modeText} payment mode updated successfully`,
      pay_mode: newPayMode
    });

  } catch (error) {
    console.error("Change Payment Mode Error:", error);
    return res.status(500).json({
      success: false,
      message: "Internal server error"
    });
  }
}


export async function addServicemanRating(req, res) {
  try {
    const {
      user_id,
      serviceman_id,
      rating,
      order_id,
      service_name
    } = req.body || {};

    if (!user_id || !serviceman_id || !rating || !order_id || !service_name) {
      return res.status(400).json({
        success: false,
        message: "user_id, serviceman_id, rating, order_id and service_name are required"
      });
    }

    const createdAt = nowIST();

    const [existing] = await db.query(
      `SELECT id FROM serviceman_ratings WHERE order_id = ? LIMIT 1`,
      [order_id]
    );

    if (existing.length > 0) {
      return res.status(400).json({
        success: false,
        message: "Rating already given for this order"
      });
    }

    const [userRows] = await db.query(
      `SELECT name, last_name FROM users WHERE id = ? LIMIT 1`,
      [user_id]
    );

    if (!userRows.length) {
      return res.status(404).json({
        success: false,
        message: "User not found"
      });
    }

    const { name, last_name } = userRows[0];

    const user_name = [name, last_name]
      .filter(v => v && v.trim() !== "")
      .join(" ") || "User";

    // 🔹 INSERT rating
    await db.query(
      `
      INSERT INTO serviceman_ratings
      (serviceman_id, user_id, user_name, rating, order_id, service_name, created_at)
      VALUES (?, ?, ?, ?, ?, ?, ?)
      `,
      [
        serviceman_id,
        user_id,
        user_name,
        rating,
        order_id,
        service_name,
        createdAt
      ]
    );

    await db.query(
      `
      UPDATE service_order
      SET rating = ?
      WHERE id = ?
      `,
      [rating, order_id]
    );

    return res.status(200).json({
      success: true,
      message: "Rating submitted successfully",
      data: {
        serviceman_id,
        user_id,
        user_name,
        rating,
        order_id,
        service_name,
        created_at: createdAt
      }
    });

  } catch (err) {
    console.log("addServicemanRating Error:", err);

    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      errors: err.message
    });
  }
}


export async function getServicemanRatings(req, res) {
  try {
    const { serviceman_id } = req.body || {};

    if (!serviceman_id) {
      return res.status(400).json({
        success: false,
        message: "serviceman_id is required"
      });
    }


    const BASE_URL = process.env.BASE_URL || "";

    const [rows] = await db.query(
      `
      SELECT
        sr.id,
        sr.serviceman_id,
        sr.user_id,
        sr.rating,
        sr.order_id,
        sr.service_name,
        sr.user_name,
        sr.created_at,
        u.image
      FROM serviceman_ratings sr
      LEFT JOIN users u 
        ON u.id = sr.user_id
      WHERE sr.serviceman_id = ?
      ORDER BY sr.id DESC
      `,
      [serviceman_id]
    );

    const data = rows.map(item => ({
      id: item.id,
      serviceman_id: item.serviceman_id,
      user_id: item.user_id,
      rating: item.rating,
      order_id: item.order_id,
      service_name: item.service_name,
      user_name: item.user_name,
      created_at: item.created_at,

      // ✅ SAME STYLE AS myActiveOrders
      image: item.image
        ? `${BASE_URL}/${item.image}`
        : null
    }));

    return res.status(200).json({
      success: true,
      message: "Serviceman ratings fetched successfully",
      data,
      errors: null
    });

  } catch (err) {
    console.log("getServicemanRatings Error:", err);

    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      errors: err.message
    });
  }
}



