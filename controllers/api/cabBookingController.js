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
          type: "1 (user) or 2 (driver)",
          order_status: "[6,7,8]",
          user_id: "required when type = 1",
          driver_id: "required when type = 2"
        }
      });
    }

    const {
      type,
      user_id,
      driver_id,
      order_status
    } = req.body;

    /* =========================
       BASIC VALIDATION
    ========================= */

    if (type === undefined || type === null) {
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
       ORDER STATUS VALIDATION
    ========================= */

    if (!Array.isArray(order_status) || order_status.length === 0) {
      return res.status(400).json({
        success: false,
        message: "order_status must be a non-empty array",
        allowed: [6, 7, 8]
      });
    }

    const allowedStatus = [5, 6, 7, 8];

    const invalidStatus = order_status.filter(
      s => !allowedStatus.includes(Number(s))
    );

    if (invalidStatus.length > 0) {
      return res.status(400).json({
        success: false,
        message: "Invalid order_status value(s)",
        allowed: allowedStatus,
        received: order_status
      });
    }

    /* =========================
       BUILD WHERE CONDITION
    ========================= */

    let where = "WHERE order_status IN (?) ";
    let values = [order_status];

    if (Number(type) === 1) {
      where += "AND user_id = ? ";
      values.push(user_id);
    }

    if (Number(type) === 2) {
      where += "AND driver_id = ? ";
      values.push(driver_id);
    }

    /* =========================
       FETCH DATA
    ========================= */

    const [rows] = await db.query(
      `
      SELECT
        id,
        wallet_apply,
        pay_mode,
        amount_after_wallet,
        final_amount,
        vehicle_name,
        brand_name,
        model_name,
        distance_km,
        estimated_amount,
        order_status,
        cancel_reason,
        order_type,
        schedule_time,
        payment_status,
        user_comment,
        over_limit_passenger,
        profile_photo,
        vehicle_color,
        driver_name,
        vehicle_plate_number,
        contact_number,
        orderOtp,
        rating,
        user_name,
        user_mobile
      FROM cab_orders
      ${where}
      ORDER BY id DESC
      `,
      values
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

