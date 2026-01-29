import { Server } from "socket.io";
import db from "./config/database.js";
import { parseIST, nowIST } from "./utils/dateParser.js";

const BASE_URL = process.env.BASE_URL;
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


  io.on("connection", (socket) => {
    console.log("🔗 Serviceman Connected:", socket.id);
    

    socket.on("register_serviceman", async (id) => {
      socket.join("serviceman_" + id);
    

      const [sm] = await db.query(
        "SELECT id,current_latitude, current_longitude FROM serviceman WHERE id = ?",
        [id]
      );

      if (!sm.length) return;

      const lat = sm[0].current_latitude;
      const lng = sm[0].current_longitude;
       const servicemanId = sm[0].id;
    //   console.log(lat,'get latitude');
    //   console.log(lng,'get long');
  console.log("🔗 Serviceman_id", servicemanId);
      // 🔥 CURRENT IST TIME
      const currentTime = nowIST();
    //   console.log(currentTime,'get currentTime');// moment / dayjs object
 

      const [orders] = await db.query(
  `
  SELECT 
    so.id AS order_id,
    so.service_id,
    s.title AS service_name,
    CONCAT(?, s.image) AS service_image,
    so.description,
    so.user_name AS customer_name,
    so.user_mobile AS customer_mobile,
    so.final_amount,
    so.service_address,
    so.service_latitude,
    so.service_longitude,
    so.quantity,
    so.service_datetime AS time,
    (
      6371 * ACOS(
        COS(RADIANS(?)) * COS(RADIANS(so.service_latitude)) *
        COS(RADIANS(so.service_longitude) - RADIANS(?)) +
        SIN(RADIANS(?)) * SIN(RADIANS(so.service_latitude))
      )
    ) AS distance
  FROM service_order so
  INNER JOIN services s 
    ON s.id = so.service_id
  WHERE so.service_status = 0
    AND so.service_datetime >= ?
    AND JSON_CONTAINS(so.available_service_man, JSON_ARRAY(?))
  ORDER BY so.id DESC
  `,
  [
    BASE_URL + "/", 
    lat,           
    lng,          
    lat,          
    currentTime,   
    servicemanId   
  ]
);
           console.log(orders,'get final ');
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
