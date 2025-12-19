import db from "../../config/database.js";
import { body, validationResult } from "express-validator";




export const vehicles = async (req, res) => {
  try {
    const BASE_URL = process.env.BASE_URL || "";
    const [rows] = await db.query(
      `SELECT 
         id,
         name,
         image,
         register_status
       FROM vehicle
       WHERE register_status = 1
       ORDER BY id DESC`
    );

    const data = rows.map(item => ({
      id: item.id,
      name: item.name,
      image: item.image ? `${BASE_URL}/${item.image}` : null,
      register_status: item.register_status
    }));

    return res.status(200).json({
      success: true,
      message: "Registered vehicles fetched successfully",
      data: data,
      errors: null
    });

  } catch (error) {
    console.log("getRegisteredVehicles Error:", error);
    return res.status(500).json({
      success: false,
      message: "Internal Server Error",
      data: null,
      errors: error.message
    });
  }
};
