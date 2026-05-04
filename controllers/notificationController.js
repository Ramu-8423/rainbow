import db from "../config/database.js";
import { FCMHelper } from "../middleware/fcmHelper.js";


export const sendNotification = async (req, res) => {
  try {

    const [drivers] = await db.query(`
      SELECT id, first_name, last_name, mobile
      FROM driver_registration
      WHERE login_status = 1
    `);

    const [servicemen] = await db.query(`
      SELECT id, first_name, last_name, mobile
      FROM serviceman
      WHERE login_status = 1
    `);

    const [users] = await db.query(`
      SELECT id, name, last_name, phone as mobile
      FROM users
      WHERE status = 1
    `);

    return res.render("notification/send_notification", {
      drivers,
      servicemen,
      users
    });

  } catch (error) {
    console.error("Notification Target Error:", error);
    return res.status(500).send("Internal Server Error");
  }
};





export const postNotification = async (req, res) => {
  try {
    const { entity_type, entity_id, title, text, push_type } = req.body;

    console.log("===== NOTIFICATION REQUEST =====");
    console.log(req.body);

    if (!entity_type || !title || !text) {
      req.session.error = "Invalid notification request.";
      return res.redirect("/send-notification");
    }

    const type = Number(entity_type);

    if (![1, 2, 3, 4, 5].includes(type)) {
      req.session.error = "Invalid notification type.";
      return res.redirect("/send-notification");
    }

    const chunkArray = (arr, size = 500) => {
      const chunks = [];
      for (let i = 0; i < arr.length; i += size) {
        chunks.push(arr.slice(i, i + size));
      }
      return chunks;
    };

    const sleep = ms => new Promise(r => setTimeout(r, ms));

    const getRole = (type) => {
      if (type === 1 || type === 2) return "user";
      if (type === 3) return "driver";
      if (type === 4) return "serviceman";
      if (type === 5) return "all";
      return "unknown";
    };

    /* ================= ALL / PUBLIC ================= */
    if (type === 5) {
      await db.query(
        `INSERT INTO notifications
        (title, text, entity_type, entity_id, created_at)
        VALUES (?, ?, 5, NULL, NOW())`,
        [title, text]
      );

      setImmediate(async () => {
        try {
          const [users] = await db.query(`SELECT fcm_token FROM users WHERE fcm_token IS NOT NULL`);
          const [drivers] = await db.query(`SELECT fcm_token FROM driver_registration WHERE fcm_token IS NOT NULL`);
          const [servicemen] = await db.query(`SELECT fcm_token FROM serviceman WHERE fcm_token IS NOT NULL`);

          const allTokens = [
            ...users.map(u => u.fcm_token),
            ...drivers.map(d => d.fcm_token),
            ...servicemen.map(s => s.fcm_token),
          ].filter(Boolean);

          const uniqueTokens = [...new Set(allTokens)];
          if (!uniqueTokens.length) return;

          const chunks = chunkArray(uniqueTokens);

          for (const tokens of chunks) {
            for (const token of tokens) {

              const payload = {
                type: push_type || "general",
                role: "all"
              };

              console.log("---- PUBLIC NOTIFICATION PAYLOAD ----");
              console.log({
                token,
                title,
                text,
                data: payload
              });

              await FCMHelper.sendNotification(
                token,
                title,
                text,
                payload
              );
            }
            await sleep(200);
          }

        } catch (err) {
          console.error("Public notification error:", err);
        }
      });

      req.session.success = "Public notification sent successfully.";
      return res.redirect("/send-notification");
    }

    /* ================ SPECIFIC TARGET ================= */
    if (!entity_id || !Array.isArray(entity_id) || !entity_id.length) {
      req.session.error = "Please select at least one receiver.";
      return res.redirect("/send-notification");
    }

    const values = entity_id.map(id => [
      title,
      text,
      type,
      id,
      new Date(),
    ]);

    await db.query(
      `INSERT INTO notifications
      (title, text, entity_type, entity_id, created_at)
      VALUES ?`,
      [values]
    );

    let tokenQuery = "";

    if (type === 1 || type === 2) {
      tokenQuery = `SELECT fcm_token FROM users WHERE id IN (?) AND fcm_token IS NOT NULL`;
    }

    if (type === 3) {
      tokenQuery = `SELECT fcm_token FROM driver_registration WHERE id IN (?) AND fcm_token IS NOT NULL`;
    }

    if (type === 4) {
      tokenQuery = `SELECT fcm_token FROM serviceman WHERE id IN (?) AND fcm_token IS NOT NULL`;
    }

    const [rows] = await db.query(tokenQuery, [entity_id]);
    const tokens = rows.map(r => r.fcm_token).filter(Boolean);

    if (tokens.length) {
      const role = getRole(type);

      setImmediate(async () => {
        for (const token of tokens) {

          const payload = {
            type: push_type || "general",
            role: role
          };

          console.log("---- SINGLE USER NOTIFICATION ----");
          console.log({
            token,
            title,
            text,
            data: payload
          });

          await FCMHelper.sendNotification(
            token,
            title,
            text,
            payload
          );
        }
      });
    }

    req.session.success = "Notification sent successfully.";
    return res.redirect("/send-notification");

  } catch (error) {
    console.error("Send Notification Error:", error);
    req.session.error = "Failed to send notification.";
    return res.redirect("/send-notification");
  }
};

