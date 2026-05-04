import { Server } from "socket.io";
import db from "./config/database.js";
import { parseIST, nowIST } from "./utils/dateParser.js";
<<<<<<< HEAD

let io = null;

// 🔹 Date formatter
=======
import axios from "axios"; // ✅ ADD

const BASE_URL = process.env.BASE_URL;
let io = null;

// ✅ GOOGLE DISTANCE FUNCTION (AS PROVIDED)
async function getRoadDistanceKm(pickupLat, pickupLng, dropLat, dropLng) {
  try {
    const apiKey = "AIzaSyB0mG3CGok9-9RZau5J_VThUP4OTbQ_SFM";

    const url = `https://maps.googleapis.com/maps/api/distancematrix/json?origins=${pickupLat},${pickupLng}&destinations=${dropLat},${dropLng}&mode=driving&units=metric&key=${apiKey}`;

    console.log("🌐 URL:", url);

    const response = await axios.get(url);
    const data = response.data;

    if (
      data.rows &&
      data.rows[0].elements &&
      data.rows[0].elements[0].status === "OK"
    ) {
      const km = data.rows[0].elements[0].distance.value / 1000;

      console.log("🛣️ Road Distance KM:", km);

      return km;
    }

    console.log("❌ API Response Error:", data);
    return null;

  } catch (err) {
    console.log("💥 Distance Error:", err.message);
    return null;
  }
}

// 🔹 Date formatter (UNCHANGED)
>>>>>>> 49d7cd4 (initial push from server)
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

<<<<<<< HEAD
  console.log("🟢 Socket.io Initialized");

=======
>>>>>>> 49d7cd4 (initial push from server)
  io.on("connection", (socket) => {
    console.log("🔗 Serviceman Connected:", socket.id);

    socket.on("register_serviceman", async (id) => {
      socket.join("serviceman_" + id);
<<<<<<< HEAD
      console.log("📌 Serviceman Joined:", id);

      const [sm] = await db.query(
        "SELECT current_latitude, current_longitude FROM serviceman WHERE id = ?",
=======

      const [sm] = await db.query(
        "SELECT id,current_latitude, current_longitude FROM serviceman WHERE id = ?",
>>>>>>> 49d7cd4 (initial push from server)
        [id]
      );

      if (!sm.length) return;

      const lat = sm[0].current_latitude;
      const lng = sm[0].current_longitude;
<<<<<<< HEAD

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
=======
      const servicemanId = sm[0].id;

      console.log("🔗 Serviceman_id", servicemanId);

      // 🔥 CURRENT IST TIME
      const currentTime = nowIST();

      // ❌ DISTANCE REMOVED FROM SQL (BAKI SAME)
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
    so.service_datetime AS time
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
          currentTime,
          servicemanId
        ]
      );

      console.log(orders, 'get final ');

      // 🔥 SAME FLOW + DISTANCE ADD
      const finalOrders = await Promise.all(
        orders.map(async (o) => {
          const distance = await getRoadDistanceKm(
            lat,
            lng,
            o.service_latitude,
            o.service_longitude
          );

          return {
            ...o,
            distance: distance,
            formatted_date: formatServiceDate(o.time)
          };
        })
      );
>>>>>>> 49d7cd4 (initial push from server)

      socket.emit("pending_orders", finalOrders);
    });
  });

  return io;
}

// ✅ If needed elsewhere
export function getIO() {
  return io;
<<<<<<< HEAD
}
=======
}
>>>>>>> 49d7cd4 (initial push from server)
