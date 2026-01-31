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

    if (!entity_type || !title || !text) {
      req.session.error = "Invalid notification request.";
      return res.redirect("/send-notification");
    }

    const type = Number(entity_type);

    const chunkArray = (arr, size = 500) => {
      const chunks = [];
      for (let i = 0; i < arr.length; i += size) {
        chunks.push(arr.slice(i, i + size));
      }
      return chunks;
    };

    const sleep = ms => new Promise(r => setTimeout(r, ms));

    /* ==================================================
       CASE 1: ALL USERS
    ================================================== */
    if (type === 4) {
      await db.query(
        `
        INSERT INTO notifications
        (title, text, entity_type, entity_id, created_at)
        VALUES (?, ?, 4, NULL, NOW())
        `,
        [title, text]
      );

      setImmediate(async () => {
        try {
          const [users] = await db.query(
            `SELECT fcm_token FROM users WHERE fcm_token IS NOT NULL`
          );
          const [drivers] = await db.query(
            `SELECT fcm_token FROM driver_registration WHERE fcm_token IS NOT NULL`
          );
          const [servicemen] = await db.query(
            `SELECT fcm_token FROM serviceman WHERE fcm_token IS NOT NULL`
          );

          const allTokens = [
            ...users.map(u => u.fcm_token),
            ...drivers.map(d => d.fcm_token),
            ...servicemen.map(s => s.fcm_token),
          ].filter(Boolean);

          const uniqueTokens = [...new Set(allTokens)];
          if (!uniqueTokens.length) return;

          const chunks = chunkArray(uniqueTokens, 500);

          for (const tokens of chunks) {
            await FCMHelper.send(tokens, title, text, {
              hiddenData: {
                type: push_type || "general",
                entity_type: 4,
              },
            });
            await sleep(200);
          }
        } catch (err) {
          console.error("Public notification error:", err);
        }
      });

      req.session.success = "Public notification sent successfully.";
      return res.redirect("/send-notification");
    }

    /* ==================================================
       CASE 2: SPECIFIC USERS / DRIVERS / SERVICEMEN
    ================================================== */
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
      `
      INSERT INTO notifications
      (title, text, entity_type, entity_id, created_at)
      VALUES ?
      `,
      [values]
    );

    let tokenQuery = "";

    if (type === 1) {
      tokenQuery = `SELECT fcm_token FROM users WHERE id IN (?) AND fcm_token IS NOT NULL`;
    }
    if (type === 2) {
      tokenQuery = `SELECT fcm_token FROM driver_registration WHERE id IN (?) AND fcm_token IS NOT NULL`;
    }
    if (type === 3) {
      tokenQuery = `SELECT fcm_token FROM serviceman WHERE id IN (?) AND fcm_token IS NOT NULL`;
    }

    const [rows] = await db.query(tokenQuery, [entity_id]);
    const tokens = rows.map(r => r.fcm_token).filter(Boolean);

    if (tokens.length) {
      setImmediate(async () => {
        for (const token of tokens) {
          await FCMHelper.send(token, title, text, {
            hiddenData: {
              type: push_type || "general",
              entity_type: type,
            },
          });
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
