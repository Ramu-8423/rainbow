import { JWT } from "google-auth-library";
import axios from "axios";
import path from "path";
import { fileURLToPath } from "url";
import fs from "fs";

<<<<<<< HEAD
// __dirname fix for ES modules
=======
>>>>>>> 49d7cd4 (initial push from server)
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const serviceAccountPath = path.join(__dirname, "..", "public", "firebase.json");
const serviceAccount = JSON.parse(fs.readFileSync(serviceAccountPath, "utf8"));

export const FCMHelper = {
<<<<<<< HEAD
=======
  /* =====================================
     SINGLE TOKEN (AS IT IS)
  ===================================== */
>>>>>>> 49d7cd4 (initial push from server)
  sendNotification: async (fcmToken, title, body, data = {}) => {
    try {
      const client = new JWT({
        email: serviceAccount.client_email,
        key: serviceAccount.private_key,
        scopes: ["https://www.googleapis.com/auth/firebase.messaging"],
      });
<<<<<<< HEAD
      
    
=======
>>>>>>> 49d7cd4 (initial push from server)

      const accessTokenResponse = await client.authorize();
      const accessToken = accessTokenResponse.access_token;

<<<<<<< HEAD
      if (!accessToken) {
        return { success: false, error: "Unable to generate access token" };
      }

      const projectId = serviceAccount.project_id || "porter-98613";
=======
      const projectId = serviceAccount.project_id;
>>>>>>> 49d7cd4 (initial push from server)
      const url = `https://fcm.googleapis.com/v1/projects/${projectId}/messages:send`;

      const formattedData = Object.fromEntries(
        Object.entries(data).map(([k, v]) => [k, String(v)])
      );

      const payload = {
        message: {
          token: fcmToken,
          notification: { title, body },
          data: formattedData,
        },
      };

<<<<<<< HEAD
      const response = await axios.post(url, payload, {
=======
      await axios.post(url, payload, {
>>>>>>> 49d7cd4 (initial push from server)
        headers: {
          Authorization: `Bearer ${accessToken}`,
          "Content-Type": "application/json",
        },
      });
<<<<<<< HEAD
       console.log('Firebase SendNotification Success')
    } catch (error) {
      return {
        success: false,
        error: error.response?.data || error.message,
      };
=======

      console.log("Firebase SendNotification Success");
    } catch (error) {
      const err = error.response?.data?.error;

      // 🔴 ADD-ON ERROR UNDERSTANDING
      if (err?.code === 404) {
        console.warn("⚠️ FCM 404: Token exist nahi karta (uninstall / expired)");
      } else if (err?.code === 400) {
        console.warn("⚠️ FCM 400: Invalid / galat token format");
      } else {
        console.error("Firebase Error:", err || error.message);
      }

      // ❗ Logic intentionally same rakha hai
      // ❗ Yahan se future me DB cleanup hook laga sakte ho
    }
  },

  /* =====================================
     UNIVERSAL SEND (ADD-ON, SAFE)
  ===================================== */
  send: async (tokens, title, body, data = {}) => {
    // SINGLE
    if (typeof tokens === "string") {
      return FCMHelper.sendNotification(tokens, title, body, data);
    }

    // MULTIPLE (ARRAY)
    if (Array.isArray(tokens) && tokens.length) {
      for (const token of tokens) {
        await FCMHelper.sendNotification(token, title, body, data);
      }
>>>>>>> 49d7cd4 (initial push from server)
    }
  },
};
