import { JWT } from "google-auth-library";
import axios from "axios";
import path from "path";
import { fileURLToPath } from "url";
import fs from "fs";

// __dirname fix for ES modules
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const serviceAccountPath = path.join(__dirname, "..", "public", "firebase.json");
const serviceAccount = JSON.parse(fs.readFileSync(serviceAccountPath, "utf8"));

export const FCMHelper = {
  sendNotification: async (fcmToken, title, body, data = {}) => {
    try {
      const client = new JWT({
        email: serviceAccount.client_email,
        key: serviceAccount.private_key,
        scopes: ["https://www.googleapis.com/auth/firebase.messaging"],
      });

      const accessTokenResponse = await client.authorize();
      const accessToken = accessTokenResponse.access_token;

      if (!accessToken) {
        return { success: false, error: "Unable to generate access token" };
      }

      const projectId = serviceAccount.project_id || "porter-98613";
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

      const response = await axios.post(url, payload, {
        headers: {
          Authorization: `Bearer ${accessToken}`,
          "Content-Type": "application/json",
        },
      });
       console.log('Firebase SendNotification Success')
    } catch (error) {
      return {
        success: false,
        error: error.response?.data || error.message,
      };
    }
  },
};
