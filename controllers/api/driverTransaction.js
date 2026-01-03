import db from "../../config/database.js";
import { parseIST, nowIST } from "../../utils/dateParser.js";
import axios from "axios";



export async function driver_transactions(req, res) {
  try {
    const driver_id = req.body.driver_id || req.query.driver_id;
    const type = req.body.type || req.query.type;

    if (!driver_id) {
      return res.status(400).json({
        success: false,
        message: "driver_id is required",
        data: null
      });
    }

    let rows = [];

    /* =====================================================
       🔹 CASE 1: DRIVER DUE WALLET PAYMENTS
       payment_type = 5 AND module_type = 2
    ===================================================== */
    const dueWalletSQL = `
      SELECT
        id,
        amount,
        final_amount,
        payment_type,
        status,
        platform_fee,
        created_at AS payment_date
      FROM paying
      WHERE 
        user_id = ?
        AND payment_type = 5
        AND module_type = 2
        AND status = 1
      ORDER BY id DESC
    `;

    /* =====================================================
       🔹 CASE 2: NORMAL CAB PAYMENTS (USER → DRIVER)
       payment_type = 1/2/3 AND module_type = 2
    ===================================================== */
    const normalSQL = `
      SELECT
        p.id,
        p.amount,
        p.final_amount,
        p.payment_type,
        p.platform_fee,
        p.status,
        p.created_at AS payment_date
      FROM paying p
      INNER JOIN cab_orders co 
        ON co.id = p.service_order_id
      WHERE 
        co.driver_id = ?
        AND p.module_type = 2
        AND p.status = 1
      ORDER BY p.id DESC
    `;

    /* =====================================================
       🔹 TYPE FILTER
    ===================================================== */
    if (type) {
      // 🔹 only due wallet
      if (Number(type) === 5) {
        const [result] = await db.query(dueWalletSQL, [driver_id]);
        rows = result;
      }
      // 🔹 specific payment type (1/2/3)
      else {
        const [result] = await db.query(
          normalSQL + " AND p.payment_type = ?",
          [driver_id, type]
        );
        rows = result;
      }
    }
    /* =====================================================
       🔹 NO TYPE → ALL (normal + due)
    ===================================================== */
    else {
      const [normal] = await db.query(normalSQL, [driver_id]);
      const [due] = await db.query(dueWalletSQL, [driver_id]);
      rows = [...normal, ...due];
    }

    /* =====================================================
       🔹 RESPONSE MAPPING (SAME STYLE AS SERVICEMAN)
    ===================================================== */
    const data = rows.map(item => {
      let section_type = "";
      let section_status = null;

      if (item.payment_type == 1) {
        section_type = "online";
        section_status = 1;
      } else if (item.payment_type == 2) {
        section_type = "offline";
        section_status = 2;
      } else if (item.payment_type == 3) {
        section_type = "wallet";
        section_status = 3;
      } else if (item.payment_type == 5) {
        section_type = "due_wallet";
        section_status = 5;
      }

      return {
        section_type,
        section_status,
        payment: {
          id: item.id,
          amount: item.amount,
          final_amount: item.final_amount,
          status: item.status,
          payment_type: item.payment_type,
          platform_fee: item.platform_fee,
          payment_date: item.payment_date
        }
      };
    });

    return res.status(200).json({
      success: true,
      message: "Driver transactions fetched successfully",
      data,
      errors: null
    });

  } catch (err) {
    console.log("driver_transactions Error:", err);

    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      data: null,
      errors: err.message
    });
  }
}
