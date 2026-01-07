// scheduleHit.js

import axios from "axios";
import db from "./config/database.js";
import { nowIST } from "./utils/dateParser.js";

/* =======================
   SCHEDULE CONFIG
======================= */

// 🔔 User ko pehle alert (ride reminder)
const alert_schedule_hour = 0;
const alert_schedule_minute = 1;

// 🚕 Driver assign + Firebase store
const assign_schedule_hour = 0;
const assign_schedule_minute = 0.5;

/* =======================
   SCHEDULE JOBS
======================= */

export async function scheduleApiHits() {
  try {
    const createdAtMs = new Date(nowIST()).getTime();

    const [rows] = await db.execute(`
      SELECT id, order_id, hit_datetime
      FROM scheduled_api_hits
      WHERE is_done = 0
        AND first_notification_status = 0
        AND hit_datetime > NOW()
    `);

    if (!rows.length) {
      console.log("ℹ️ No pending scheduled hits");
      return;
    }

    const alertAdvanceMs =
      alert_schedule_hour * 60 * 60 * 1000 +
      alert_schedule_minute * 60 * 1000;

    const assignAdvanceMs =
      assign_schedule_hour * 60 * 60 * 1000 +
      assign_schedule_minute * 60 * 1000;

    for (const row of rows) {
      const hitMs = new Date(row.hit_datetime).getTime();

      /* ========= USER ALERT (FIRST NOTIFICATION) ========= */
      const alertDelay = hitMs - alertAdvanceMs - createdAtMs;

      if (alertDelay > 0) {
        setTimeout(async () => {
          try {
            await axios.get(
              "https://admin.rainbowsenterprises.com/api/letterOrderNotification",
              {
                params: {
                  order_id: row.order_id
                }
              }
            );

            // ✅ mark first notification done
            await db.execute(
              `
              UPDATE scheduled_api_hits
              SET first_notification_status = 1
              WHERE id = ?
              `,
              [row.id]
            );

            console.log("🔔 User alert sent & marked:", row.order_id);

          } catch (err) {
            console.error("❌ User alert error:", err.message);
          }
        }, alertDelay);
      }

      /* ========= DRIVER ASSIGN ========= */
      const assignDelay = hitMs - assignAdvanceMs - createdAtMs;

      if (assignDelay > 0) {
        setTimeout(async () => {
          try {
            await axios.get(
              "https://admin.rainbowsenterprises.com/api/laterAssignOrder",
              {
                params: {
                  order_id: row.order_id
                }
              }
            );

            await db.execute(
              `
              UPDATE scheduled_api_hits
              SET is_done = 1
              WHERE id = ?
              `,
              [row.id]
            );

            console.log("🚕 Driver assigned & marked done:", row.order_id);

          } catch (err) {
            console.error("❌ Assign error:", err.message);
          }
        }, assignDelay);
      }
    }
  } catch (err) {
    console.error("❌ Scheduler error:", err.message);
  }
}
