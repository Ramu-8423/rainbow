// controllers/cabOrdersController.js
import db from "../config/database.js";
import { nowIST } from "../utils/dateParser.js";


export const cabOrdersController = async (req, res) => {
  try {
    const perPage = parseInt(req.query.perPage) || 10;
    const page = parseInt(req.query.page) || 1;
    const offset = (page - 1) * perPage;

    const { from, to, type } = req.query;   // 👈 order_type from query
    const statusParam = req.params.status;
    
    const current_date_time = nowIST();
    
    console.log("current_date_time", current_date_time);

    let where = "WHERE 1 ";
    let values = [];

    /* ================= ORDER TYPE FILTER ================= */
    const orderType = Number(type) === 2 ? 2 : 1;  // default NOW
    where += "AND order_type = ? ";
    values.push(orderType);

    /* ================= STATUS FILTER ================= */
    if (statusParam) {
      where += "AND order_status = ? ";
      values.push(Number(statusParam));
    } else {
      if (orderType === 2) {
        // Later Booking
        where += "AND order_status IN (0,5,6,7,8) ";
      } else {
        // Now Booking
        where += "AND order_status IN (5,6,7,8) ";
      }
    }

    /* ================= DATE FILTER ================= */
    if (from && to) {
      where += "AND DATE(created_at) BETWEEN ? AND ? ";
      values.push(from, to);
    }

    /* ================= TOTAL ================= */
    const [[{ total }]] = await db.query(
      `SELECT COUNT(*) AS total FROM cab_orders ${where}`,
      values
    );

    /* ================= DATA ================= */
    const [orders] = await db.query(
      `
      SELECT
        id,
        order_status,
        order_type,
        user_name,
        user_mobile,
        driver_name,
        vehicle_name,
        pickup_location,
        drop_location,
        cancel_reason,
        final_amount,
        schedule_time,
        estimated_amount,
        created_at
      FROM cab_orders
      ${where}
      ORDER BY id DESC
      LIMIT ? OFFSET ?
      `,
      [...values, perPage, offset]
    );

    return res.render("orders/cabOrders", {
      title: "Cab Orders",
      orders,
      total,
      page,
      perPage,
      totalPages: Math.ceil(total / perPage),
      from,
      to,
      statusParam,
      current_date_time,
      orderType
    });

  } catch (err) {
    console.error("Cab Orders Error:", err);
    return res.render("orders/cabOrders", {
      title: "Cab Orders",
      orders: [],
      total: 0,
      page: 1,
      perPage: 10,
      totalPages: 1,
      error: "Something went wrong"
    });
  }
};

