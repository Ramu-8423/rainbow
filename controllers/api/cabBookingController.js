import db from "../../config/database.js";
import { body, validationResult } from "express-validator";
import { nowIST } from "../../utils/dateParser.js";



export const vehicles = async (req, res) => {
  try {
    const BASE_URL = process.env.BASE_URL || "";
    const [rows] = await db.query(
      `SELECT 
         id,
         name,
         image,
         register_status
       FROM vehicle
       WHERE register_status = 1
       ORDER BY id DESC`
    );

    const data = rows.map(item => ({
      id: item.id,
      name: item.name,
      image: item.image ? `${BASE_URL}/${item.image}` : null,
      register_status: item.register_status
    }));

    return res.status(200).json({
      success: true,
      message: "Registered vehicles fetched successfully",
      data: data,
      errors: null
    });

  } catch (error) {
    console.log("getRegisteredVehicles Error:", error);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      data: null,
      errors: error.message
    });
  }
};





export async function getCabCancelReasons(req, res) {
  try {
    const { type } = req.query;

    /* =========================
       BASIC VALIDATION
    ========================= */
    if (!type) {
      return res.status(400).json({
        success: false,
        message: "type is required (1=user, 2=driver)"
      });
    }

    if (![1, 2].includes(Number(type))) {
      return res.status(400).json({
        success: false,
        message: "type must be 1 (user) or 2 (driver)"
      });
    }

    /* =========================
       FETCH DATA
    ========================= */
    const [rows] = await db.query(
      `
      SELECT 
        id,
        reason_title
      FROM cab_cancel_reasons
      WHERE type = ? AND status = 1
      ORDER BY id ASC
      `,
      [Number(type)]
    );

    /* =========================
       SUCCESS RESPONSE
    ========================= */
    return res.status(200).json({
      success: true,
      type: Number(type),
      data: rows
    });

  } catch (error) {
    console.error("Get Cancel Reasons Error:", error);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      error: error.message
    });
  }
}




export const cabHistory = async (req, res) => {
  try {
    /* =========================
       BODY EXISTENCE CHECK
    ========================= */
    if (!req.body || Object.keys(req.body).length === 0) {
      return res.status(400).json({
        success: false,
        message: "Request body is required",
        required_fields: {
          user_type: "1 (user) or 2 (driver)",
          order_type: "1",
          order_status: "[0,5,6,7,8]",
          user_id: "required when user_type = 1",
          driver_id: "required when user_type = 2"
        }
      });
    }

    const {
      user_type,
      user_id,
      driver_id,
      order_status,
      order_type
    } = req.body;

    /* =========================
       BASIC VALIDATION
    ========================= */

    const allowedStatus = [0,1,2,3,4,5,6,7,8];

    const invalidStatus = order_status.find(
      (status) => !allowedStatus.includes(Number(status))
    );

    if (invalidStatus !== undefined) {
      return res.status(400).json({
        success: false,
        message: "Invalid order_status value found. Allowed values are 0 to 8 only.",
        invalid_value: invalidStatus
      });
    }

    if (user_type === undefined || user_type === null) {
      return res.status(400).json({
        success: false,
        message: "user_type is required (1=user, 2=driver)"
      });
    }

    if (![1, 2].includes(Number(user_type))) {
      return res.status(400).json({
        success: false,
        message: "user_type must be 1 (user) or 2 (driver)"
      });
    }

    if (Number(user_type) === 1 && !user_id) {
      return res.status(400).json({
        success: false,
        message: "user_id is required when user_type = 1"
      });
    }

    if (Number(user_type) === 2 && !driver_id) {
      return res.status(400).json({
        success: false,
        message: "driver_id is required when user_type = 2"
      });
    }

    if (order_type === undefined || order_type === null) {
      return res.status(400).json({
        success: false,
        message: "order_type is required"
      });
    }

    /* =========================
       ORDER STATUS VALIDATION
    ========================= */

    if (!Array.isArray(order_status) || order_status.length === 0) {
      return res.status(400).json({
        success: false,
        message: "order_status must be a non-empty array",
        allowed: [0, 6, 5, 7, 8]
      });
    }

    /* =========================
       BUILD WHERE CONDITION
    ========================= */

    let where = "WHERE co.order_status IN (?) AND co.order_type = ? ";
    let values = [order_status, order_type];

    if (Number(user_type) === 1) {
      where += "AND co.user_id = ? ";
      values.push(user_id);
    }

    if (Number(user_type) === 2) {
      where += "AND co.driver_id = ? ";
      values.push(driver_id);
    }

    const BASE_URL = process.env.BASE_URL || "";

    /* =========================
       FETCH DATA
    ========================= */

  const [rows] = await db.query(
  `
  SELECT
    co.id,
    co.wallet_apply,
    co.pay_mode,
    co.amount_after_wallet,
    co.final_amount,
    co.brand_name,
    co.model_name,
    co.distance_km,
    co.estimated_amount,
    co.order_status,
    co.pickup_location,
    co.drop_location,
    co.cancel_reason,
    co.order_type,
    co.schedule_time,
    co.payment_status,
    co.user_comment,
    co.over_limit_passenger,
    co.profile_photo,
    co.vehicle_color,
    co.driver_name,
    co.vehicle_plate_number,
    co.contact_number,
    co.orderOtp,
    co.rating,
    co.user_name,
    co.user_mobile,
    co.vehicle_id,

    v.name AS vehicle_name,
    CONCAT(TRIM(TRAILING '/' FROM ?), '/', v.image) AS vehicle_image

  FROM cab_orders co
  LEFT JOIN vehicle v ON v.id = co.vehicle_id
  ${where}
  ORDER BY co.id DESC
  `,
  [BASE_URL, ...values]
);


    return res.status(200).json({
      success: true,
      count: rows.length,
      data: rows
    });

  } catch (err) {
    console.error("CAB HISTORY ERROR:", err);
    return res.status(500).json({
      success: false,
      message: "Internal server error"
    });
  }
};




export async function cabEarning(req, res) {
  try {
    const { driver_id, type } = req.body;

    if (!driver_id) {
      return res.status(400).json({
        success: false,
        message: "driver_id is required"
      });
    }

    if (![1, 2, 3].includes(Number(type))) {
      return res.status(400).json({
        success: false,
        message: "type must be 1 (all), 2 (today), 3 (weekly)"
      });
    }

    const now = nowIST();

    let dateCondition = "";
    let logDateCondition = "";

    /* =========================
       DATE FILTER
    ========================= */
    if (Number(type) === 2) {
      dateCondition = "AND DATE(created_at) = CURDATE()";
      logDateCondition = "AND DATE(online_time) = CURDATE()";
    }

    if (Number(type) === 3) {
      dateCondition = "AND created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)";
      logDateCondition = "AND online_time >= DATE_SUB(NOW(), INTERVAL 7 DAY)";
    }

    /* =========================
       GET COMPLETED ORDERS
       ✅ ORDER BY id DESC ADDED
    ========================= */
    const [orders] = await db.query(
      `
      SELECT
        id,
        pickup_location,
        drop_location,
        order_status,
        distance_km,
        final_amount,
        pay_mode,
        created_at
      FROM cab_orders
      WHERE driver_id = ?
        AND order_status = 5
        ${dateCondition}
      ORDER BY id DESC
      `,
      [driver_id]
    );

    const completedOrderIds = orders.map(o => o.id);

    /* =========================
       TOTAL DISTANCE
       ✅ FORMAT TO 2 DECIMALS
    ========================= */
    const total_distance = Number(
      orders.reduce(
        (sum, o) => sum + Number(o.distance_km || 0),
        0
      ).toFixed(2)
    );

    const total_completed_ride = orders.length;

    /* =========================
       TOTAL EARNING (FROM PAYING)
    ========================= */
    let total_earning = 0;

    if (completedOrderIds.length) {
      const [earningRows] = await db.query(
        `
        SELECT SUM(final_amount) AS total
        FROM paying
        WHERE module_type = 2
          AND service_order_id IN (?)
        `,
        [completedOrderIds]
      );

      total_earning = Number(earningRows[0]?.total || 0);
    }

    /* =========================
       ONLINE TIME CALCULATION
    ========================= */
    const [onlineLogs] = await db.query(
      `
      SELECT online_time, offline_time
      FROM driver_online_logs
      WHERE driver_id = ?
        ${logDateCondition}
      `,
      [driver_id]
    );

    let totalSeconds = 0;

    for (const row of onlineLogs) {
      const online = new Date(row.online_time);
      const offline = row.offline_time
        ? new Date(row.offline_time)
        : new Date(now);

      totalSeconds += Math.floor((offline - online) / 1000);
    }

    const total_hours = Math.floor(totalSeconds / 3600);
    const total_minutes = Math.floor((totalSeconds % 3600) / 60);

    /* =========================
       RESPONSE (UNCHANGED)
    ========================= */
    return res.status(200).json({
      success: true,
      data: {
        total_earning,
        total_completed_ride,
        total_distance,
        online_time: {
          hours: total_hours,
          minutes: total_minutes
        },
        trip_details: orders
      }
    });

  } catch (err) {
    console.log("Cab Earning API Error:", err);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      error: err.message
    });
  }
}









export const submitDriverRating = async (req, res) => {
  try {

    const { user_id, order_id, driver_id, rating } = req.body;

    /* =========================
       BASIC VALIDATION
       Validate required fields
    ========================= */
    if (!user_id || !order_id || !driver_id || !rating) {
      return res.status(400).json({
        success: false,
        message: "user_id, order_id, driver_id and rating are required"
      });
    }

    /* Validate rating range */
    if (rating < 1 || rating > 5) {
      return res.status(400).json({
        success: false,
        message: "rating must be between 1 to 5"
      });
    }


     await db.query(
         `
         UPDATE cab_orders
         SET rating = ?
         WHERE id = ?
         `,
         [rating, order_id]
       );

    /* =========================
       CHECK IF RATING ALREADY EXISTS
       One user can rate one order only once
    ========================= */
    const [[alreadyRated]] = await db.query(
      `
      SELECT id 
      FROM rating_history 
      WHERE order_id = ? AND user_id = ?
      LIMIT 1
      `,
      [order_id, user_id]
    );

    if (alreadyRated) {
      return res.status(400).json({
        success: false,
        message: "Rating already submitted for this order"
      });
    }

    /* =========================
       FETCH DRIVER CURRENT RATING DATA
    ========================= */
    const [[driver]] = await db.query(
      `
      SELECT 
        rating,
        rating_count,
        rating_sum
      FROM driver_registration
      WHERE id = ?
      LIMIT 1
      `,
      [driver_id]
    );

    if (!driver) {
      return res.status(404).json({
        success: false,
        message: "Driver not found"
      });
    }

    const currentRatingCount = driver.rating_count || 0;
    const currentRatingSum   = driver.rating_sum || 0;

    /* =========================
       RATING CALCULATION (AS PER GIVEN LOGIC)
       rating_count = total rating value
       rating_sum   = total number of users who rated
    ========================= */
    const newRatingCount = currentRatingCount + rating; // rating given by current user
    const newRatingSum   = currentRatingSum + 1;        // total number of users who rated

    const newAverageRating = newRatingCount / newRatingSum;

    /* =========================
       INSERT RATING INTO HISTORY TABLE
    ========================= */
    await db.query(
      `
      INSERT INTO rating_history
      (order_id, user_id, driver_id, rating, created_at)
      VALUES (?, ?, ?, ?, ?)
      `,
      [order_id, user_id, driver_id, rating, nowIST()]
    );

    /* =========================
       UPDATE DRIVER RATING SUMMARY
    ========================= */
    await db.query(
      `
      UPDATE driver_registration
      SET
        rating_count = ?,
        rating_sum   = ?,
        rating       = ?
      WHERE id = ?
      `,
      [
        newRatingCount,
        newRatingSum,
        Math.round(newAverageRating), // store average as INT
        driver_id
      ]
    );

    /* =========================
       SUCCESS RESPONSE
    ========================= */
    return res.status(200).json({
      success: true,
      message: "Rating submitted successfully",
      data: {
        rating_count: newRatingCount,
        rating_sum: newRatingSum,
        rating: Math.round(newAverageRating)
      }
    });

  } catch (error) {
    console.error("SUBMIT DRIVER RATING ERROR:", error);
    return res.status(500).json({
      success: false,
      message: "Internal server error"
    });
  }
};




