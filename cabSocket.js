import { Server } from "socket.io";
import db from "./config/database.js";

let io;
let isInitialized = false;

// =====================================================
// INIT SOCKET – SHARE ENGINE WITH socket.js
// =====================================================
export const initCabSocket = (httpServer, sharedIO = null) => {

  if (isInitialized) {
    console.log("⚠️ CabSocket already initialized");
    return io;
  }

  isInitialized = true;

  if (sharedIO) {
    io = sharedIO;
  } else {
    io = new Server(httpServer, {
      path: "/socket/live",

      // 🛡️ prevent ws conflict
      wsEngine: false,

      cors: {
        origin: "*",
        methods: ["GET", "POST"],
        credentials: true
      },

      // 🔥 ONLY CONNECTION STABILITY SETTINGS
      pingInterval: 20000,
      pingTimeout: 60000,
      transports: ["websocket", "polling"],

      allowEIO3: true
    });
  }

  io.on("connection", (socket) => {
    console.log("✅ Cab Socket connected:", socket.id);

    // =====================================
    // DRIVER JOIN
    // =====================================
    socket.on("JOIN_DRIVER", async (driverId) => {
      try {
        if (!driverId) return;

        const room = `driver_${driverId}`;
        socket.join(room);

        console.log(`🚖 Driver joined room: ${room}`);

        const [activeRows] = await db.query(
          `
          SELECT id
          FROM cab_orders
          WHERE driver_id = ?
            AND order_status > 0
            AND order_status <= 4
          LIMIT 1
          `,
          [String(driverId)]
        );

        if (activeRows.length > 0) {
          io.to(room).emit("SYNC_RIDES", []);
          console.log(`⛔ Driver ${driverId} busy → EMPTY`);
          return;
        }

        await sendFullRideListToDriver(driverId);

      } catch (err) {
        console.error("❌ JOIN_DRIVER error:", err.message);
      }
    });

    socket.on("disconnect", (reason) => {
      console.log("🔌 Cab Socket disconnected:", socket.id, reason);
    });
  });

  return io;
};

// =====================================================
// SEND FULL RIDE LIST
// =====================================================
async function sendFullRideListToDriver(driverId) {
  if (!io) return;

  const [activeRows] = await db.query(
    `
    SELECT id
    FROM cab_orders
    WHERE driver_id = ?
      AND order_status > 0
      AND order_status <= 4
    LIMIT 1
    `,
    [String(driverId)]
  );

  if (activeRows.length > 0) {
    io.to(`driver_${driverId}`).emit("SYNC_RIDES", []);
    return;
  }

 const [rows] = await db.query(
      `
      SELECT 
        co.id AS order_id,
        co.order_type,
        co.pickup_location AS pickup_address,
        co.drop_location AS drop_address,
        co.distance_km AS distance
    
      FROM cab_orders co
    
      WHERE co.order_status = 0
        AND JSON_CONTAINS(
              co.matched_driver_id,
              JSON_ARRAY(?)
            )
    
        -- 🔥 IMPORTANT: jo already bid kar chuka hai usko hata do
        AND NOT EXISTS (
          SELECT 1 
          FROM driver_offer dof 
          WHERE dof.order_id = co.id 
            AND dof.driver_id = ?
        )
      `,
      [
        Number(driverId), // JSON_CONTAINS
        Number(driverId)  // NOT EXISTS
      ]
    );

  console.log(
    `📦 SYNC_RIDES sent to driver ${driverId}:`,
    rows.length
  );
  
  console.log("all ride", rows);

  io.to(`driver_${driverId}`).emit("SYNC_RIDES", rows);
}

// =====================================================
// EMIT NEW RIDE
// =====================================================
export const emitNewRideToDrivers = async (driverIds) => {
  if (!io || !Array.isArray(driverIds)) return;

  for (const driverId of driverIds) {
    await sendFullRideListToDriver(driverId);
  }
};

// =====================================================
// INSTANT NEW RIDE
// =====================================================
export const emitInstantRide = async (driverIds, payload) => {

  if (!io || !Array.isArray(driverIds)) return;

  for (const id of driverIds) {
    io.to(`driver_${id}`).emit("NEW_RIDE", payload);
  }

  await emitNewRideToDrivers(driverIds);
};

// =====================================================
// REMOVE RIDE
// =====================================================
export const emitRemoveRide = async (rideId) => {
  if (!io || !rideId) return;

  let rideIds = Array.isArray(rideId) ? rideId : [rideId];

  const rooms = io.sockets.adapter.rooms;

  for (const [roomName] of rooms) {
    if (!roomName.startsWith("driver_")) continue;

    const driverId = roomName.replace("driver_", "");

    await sendFullRideListToDriver(driverId);
  }

  console.log(
    `🧹 emitRemoveRide → SYNC updated for rides:`,
    rideIds
  );
};
