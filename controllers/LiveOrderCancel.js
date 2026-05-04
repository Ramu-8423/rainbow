import db from "../config/database.js";
import { getFirestore } from "../utils/firebaseInit.js";
import { nowIST } from "../utils/dateParser.js";

export const updateRideStatusFromPage = async (req, res) => {
  try {

    console.log("========== ADMIN CANCEL START ==========");

    const { id, ride_status } = req.body;

    if (!id || !ride_status) {
      req.session.error = "Invalid request.";
      return res.redirect("/cabLiveOrdersRoutes");
    }

    

    const firestore = getFirestore();

    const docRef = firestore
      .collection("cab_orders")
      .doc(String(id));

    const doc = await docRef.get();

    if (!doc.exists) {
      req.session.error = "Ride not found in Firebase.";
      return res.redirect("/cabLiveOrdersRoutes");
    }

    const firestoreStatus =
      Number(doc.data().order_status);

    const allowedStatuses = [1, 2, 3, 4, 5];

    if (!allowedStatuses.includes(firestoreStatus)) {
      req.session.error =
        "Only active rides can be cancelled.";
      return res.redirect("/cabLiveOrdersRoutes");
    }

    const now = nowIST();

    /* MYSQL UPDATE */
    const [updateResult] = await db.query(
      `UPDATE cab_orders
       SET order_status = 5,
           cancel_by_admin = 1,
           updated_at = ?
       WHERE id = ?`,
      [now, id]
    );

    if (updateResult.affectedRows === 0) {
      req.session.error = "Database update failed.";
      return res.redirect("/cabLiveOrdersRoutes");
    }

    /* FIRESTORE UPDATE */
    await docRef.update({
      order_status: 9,
      cancel_by_admin: 1,
      updated_at: now
    });

    req.session.success =
      "Ride cancelled by Admin successfully.";

    return res.redirect("/cabLiveOrdersRoutes");

  } catch (err) {
    console.error("Admin Cancel Error:", err);
    req.session.error = "Something went wrong.";
    return res.redirect("/cabLiveOrdersRoutes");
  }
};