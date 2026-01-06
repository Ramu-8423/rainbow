import axios from "axios";
import db from "./config/database.js";
import { nowIST } from "./utils/dateParser.js";

/* =======================
   STEP 1: SCHEDULE JOBS
======================= */

async function scheduleApiHits() {
  try {
    // 🔍 JS raw time (sirf reference ke liye)
    const jsNow = new Date();
    console.log("🕒 JS NOW (UTC) :", jsNow.toISOString(), jsNow.getTime());

    // ✅ Tumhara trusted business time (IST)
    const createdAt = nowIST(); 
    const createdAtMs = new Date(createdAt).getTime();

    console.log("🕒 SYSTEM IST NOW :", createdAt, createdAtMs);

    // 🔍 DB side ka time
    const [nowRow] = await db.execute(`SELECT NOW() AS db_now`);
    const dbNow = nowRow[0].db_now;
    console.log("🕒 DB NOW (UTC)  :", dbNow);

    const [rows] = await db.execute(`
      SELECT id, hit_datetime
      FROM scheduled_api_hits
      WHERE is_done = 0
        AND hit_datetime > NOW()
    `);

    if (!rows.length) {
      console.log("ℹ️ No pending scheduled hits");
      return;
    }

    for (const row of rows) {
      const hitDateTime = new Date(row.hit_datetime);

      // ⏰ trigger = hit_datetime - 30 sec
      const triggerTimeMs = hitDateTime.getTime() - 30 * 1000;

      // ✅ delay IST based
      const delay = triggerTimeMs - createdAtMs;

      if (delay <= 0) {
        console.log("⚠️ Skip past time:", row.hit_datetime);
        continue;
      }

      console.log(
        "⏰ API scheduled:",
        row.hit_datetime,
        "(30 sec before, IST based)"
      );

      setTimeout(async () => {
        try {
          const fireTime = nowIST();
          console.log(
            "🚀 API HIT TIME (IST):",
            fireTime,
            "ID:",
            row.id
          );

          // 👉 real API
          await axios.get("https://admin.rainbowsenterprises.com/api/test-notification");

          await db.execute(
            "UPDATE scheduled_api_hits SET is_done = 1 WHERE id = ?",
            [row.id]
          );

          console.log("✅ Done once:", row.id);
        } catch (err) {
          console.error("❌ API hit error:", err.message);
        }
      }, delay);
    }
  } catch (err) {
    console.error("❌ Scheduler error:", err.message);
  }
}

/* =======================
   AUTO START
======================= */

scheduleApiHits();
