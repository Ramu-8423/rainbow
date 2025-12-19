import { Server } from "socket.io";
import db from "./config/database.js";
import { parseIST, nowIST } from "./utils/dateParser.js";

let io = null;

// 🔹 Date formatter
function formatServiceDate(dateString) {
  const date = new Date(dateString);

  const today = new Date();
  const yesterday = new Date();
  yesterday.setDate(today.getDate() - 1);

  const currentYear = today.getFullYear();
  const orderYear = date.getFullYear();

  const isToday =
    date.getDate() === today.getDate() &&
    date.getMonth() === today.getMonth() &&
    orderYear === currentYear;

  const isYesterday =
    date.getDate() === yesterday.getDate() &&
    date.getMonth() === yesterday.getMonth() &&
    orderYear === currentYear;

  let hours = date.getHours();
  let minutes = date.getMinutes();
  const ampm = hours >= 12 ? "PM" : "AM";
  hours = hours % 12 || 12;
  minutes = minutes < 10 ? "0" + minutes : minutes;

  const timeFormatted = `${hours}:${minutes} ${ampm}`;

  if (isToday) return `Today, ${timeFormatted}`;
  if (isYesterday) return `Yesterday, ${timeFormatted}`;

  let dateFormatted = date.toLocaleDateString("en-IN", {
    day: "numeric",
    month: "long"
  });

  if (orderYear !== currentYear) dateFormatted += ` ${orderYear}`;

  return `${dateFormatted}, ${timeFormatted}`;
}

// ✅ INIT SOCKET
export function initSocket(server) {
  io = new Server(server, {
    path: "/socket/live",
    cors: { origin: "*" }
  });

  console.log("🟢 Socket.io Initialized");

  io.on("connection", (socket) => {
    console.log("🔗 Serviceman Connected:", socket.id);

    socket.on("register_serviceman", async (id) => {
      socket.join("serviceman_" + id);
      console.log("📌 Serviceman Joined:", id);

      const [sm] = await db.query(
        "SELECT current_latitude, current_longitude FROM serviceman WHERE id = ?",
        [id]
      );

      if (!sm.length) return;

      const lat = sm[0].current_latitude;
      const lng = sm[0].current_longitude;

      // 🔥 CURRENT IST TIME
      const currentTime = nowIST(); // moment / dayjs object

      console.log("zsdxfcgvhbjnk", currentTime);

      const [orders] = await db.query(
        `
        SELECT 
          id AS order_id,
          service_name,
          user_name AS customer_name,
          user_mobile AS customer_mobile,
          final_amount,
          service_address,
          service_latitude,
          service_longitude,
          quantity,
          service_datetime AS time,
          (
            6371 * ACOS(
              COS(RADIANS(?)) * COS(RADIANS(service_latitude)) *
              COS(RADIANS(service_longitude) - RADIANS(?)) +
              SIN(RADIANS(?)) * SIN(RADIANS(service_latitude))
            )
          ) AS distance
        FROM service_order
        WHERE service_status = 0
          AND service_datetime >= ?
          AND JSON_CONTAINS(available_service_man, JSON_ARRAY(?))
        ORDER BY id DESC
        `,
        [lat, lng, lat, currentTime, id]
      );

      const finalOrders = orders.map(o => ({
        ...o,
        formatted_date: formatServiceDate(o.time)
      }));

      socket.emit("pending_orders", finalOrders);
    });
  });

  return io;
}

// ✅ If needed elsewhere
export function getIO() {
  return io;
}
