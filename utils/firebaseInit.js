import admin from "firebase-admin";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const serviceAccountPath = path.join(
  __dirname,
  "..",
  "public",
  "firebase.json"
);

let firebaseApp = null;

export function getFirestore() {
  if (!firebaseApp) {
    const serviceAccount = JSON.parse(
      fs.readFileSync(serviceAccountPath, "utf8")
    );

    firebaseApp = admin.initializeApp({
      credential: admin.credential.cert(serviceAccount)
    });

    console.log("🔥 Firebase (Firestore) connected successfully");
  }

  return admin.firestore();
}

export const serverTimestamp =
  admin.firestore.FieldValue.serverTimestamp;
