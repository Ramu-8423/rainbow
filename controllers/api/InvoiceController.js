import puppeteer from "puppeteer";
import path from "path";
import ejs from "ejs";
import axios from "axios";
import db from "../../config/database.js";

// export const generateRideInvoice = async (req, res) => {
//   try {
//     const { ride_id } = req.params;

//     /* =========================
//       FETCH RIDE
//     ========================= */
//     const [[ride]] = await db.query(
//       `
//       SELECT
//         id,
//         final_amount,
//         pay_mode,
//         pickup_latitude,
//         pickup_longitude,
//         pickup_location,
//         drop_location,
//         distance_km,
//         created_at,
//         vehicle_plate_number,
//         driver_name,
//         user_name
//       FROM cab_orders
//       WHERE id = ?
//       LIMIT 1
//       `,
//       [ride_id]
//     );

//     if (!ride) {
//       return res.status(404).send("Invoice not found");
//     }

//     /* =========================
//       FETCH INVOICE SETTINGS
//     ========================= */
//     const [[invoice]] = await db.query(
//       `SELECT * FROM invoice_settings WHERE is_active = 1 LIMIT 1`
//     );

//     /* =========================
//       REVERSE GEO (STATE ONLY)
//     ========================= */
//     let state = "";
//     try {
//       const geoRes = await axios.get(
//         "https://nominatim.openstreetmap.org/reverse",
//         {
//           params: {
//             lat: ride.pickup_latitude,
//             lon: ride.pickup_longitude,
//             format: "json"
//           },
//           headers: { "User-Agent": "RainbowInvoice/1.0" }
//         }
//       );

//       state = geoRes.data?.address?.state || "";
//     } catch (e) {}

//     /* =========================
//       GST CALCULATION
//     ========================= */
//     const gstPercent =
//       invoice.cgst_percentage +
//       invoice.sgst_percentage +
//       invoice.igst_percentage;

//     const baseAmount =
//       ride.final_amount / (1 + gstPercent / 100);

//     const cgst = (baseAmount * invoice.cgst_percentage) / 100;
//     const sgst = (baseAmount * invoice.sgst_percentage) / 100;
//     const igst = (baseAmount * invoice.igst_percentage) / 100;

//     /* =========================
//       LOGO FULL URL
//       DB: /assets/img/invoicelogo.png
//       ENV: BASE_URL
//     ========================= */
//     const companyLogo =
//       invoice.company_logo
//         ? `${process.env.BASE_URL}${invoice.company_logo}`
//         : "";

//     /* =========================
//       EJS DATA
//     ========================= */
//     const data = {
//       ride,
//       invoice,
//       state,
//       companyLogo,
//       baseAmount: baseAmount.toFixed(2),
//       cgst: cgst.toFixed(2),
//       sgst: sgst.toFixed(2),
//       igst: igst.toFixed(2)
//     };

//     /* =========================
//       RENDER HTML
//     ========================= */
//     const templatePath = path.join(
//       process.cwd(),
//       "views/invoice/ride_invoice.ejs"
//     );

//     const html = await ejs.renderFile(templatePath, data);

//     /* =========================
//       HTML → PDF
//     ========================= */
//     const browser = await puppeteer.launch({
//       headless: "new",
//       args: ["--no-sandbox", "--disable-setuid-sandbox"]
//     });

//     const page = await browser.newPage();
//     await page.setContent(html, { waitUntil: "networkidle0" });

//     const pdf = await page.pdf({
//       format: "A4",
//       printBackground: true,
//       margin: {
//         top: "20px",
//         bottom: "20px",
//         left: "20px",
//         right: "20px"
//       }
//     });

//     await browser.close();

//     /* =========================
//       DOWNLOAD
//     ========================= */
//     res.setHeader("Content-Type", "application/pdf");
//     res.setHeader(
//       "Content-Disposition",
//       `attachment; filename=ride_invoice_${ride_id}.pdf`
//     );

//     return res.send(pdf);

//   } catch (err) {
//     console.error("Invoice Error:", err);
//     return res.status(500).send("Invoice generation failed");
//   }
// };


export const generateRideInvoice = async (req, res) => {
  try {
    const { ride_id } = req.params;

    /* =========================
       FETCH RIDE
    ========================= */
    const [[ride]] = await db.query(
      `
      SELECT
        id,
        final_amount,
        pay_mode,
        pickup_latitude,
        pickup_longitude,
        pickup_location,
        drop_location,
        distance_km,
        created_at,
        vehicle_plate_number,
        driver_name,
        user_name
      FROM cab_orders
      WHERE id = ?
      LIMIT 1
      `,
      [ride_id]
    );

    if (!ride) {
      return res.status(404).send("Invoice not found");
    }

    /* =========================
       FETCH INVOICE SETTINGS
    ========================= */
    const [[invoice]] = await db.query(
      `SELECT * FROM invoice_settings WHERE is_active = 1 LIMIT 1`
    );

    /* =========================
       REVERSE GEO
    ========================= */
    let state = "";
    try {
      const geoRes = await axios.get(
        "https://nominatim.openstreetmap.org/reverse",
        {
          params: {
            lat: ride.pickup_latitude,
            lon: ride.pickup_longitude,
            format: "json"
          },
          headers: { "User-Agent": "RainbowInvoice/1.0" }
        }
      );
      state = geoRes.data?.address?.state || "";
    } catch (e) {}

    /* =========================
       GST CALCULATION
    ========================= */
    const gstPercent =
      invoice.cgst_percentage +
      invoice.sgst_percentage +
      invoice.igst_percentage;

    const baseAmount = ride.final_amount / (1 + gstPercent / 100);
    const cgst = (baseAmount * invoice.cgst_percentage) / 100;
    const sgst = (baseAmount * invoice.sgst_percentage) / 100;
    const igst = (baseAmount * invoice.igst_percentage) / 100;

    /* =========================
       LOGO URL
    ========================= */
    const companyLogo = invoice.company_logo
      ? `${process.env.BASE_URL}${invoice.company_logo}`
      : "";

    /* =========================
       RENDER EJS (HTML PREVIEW)
    ========================= */
   return res.render("invoice/ride_invoice", {
  layout: false,   // 🔥 IMPORTANT LINE
  ride,
  invoice,
  state,
  companyLogo,
  baseAmount: baseAmount.toFixed(2),
  cgst: cgst.toFixed(2),
  sgst: sgst.toFixed(2),
  igst: igst.toFixed(2)
});


  } catch (err) {
    console.error("Invoice Error:", err);
    return res.status(500).send("Invoice generation failed");
  }
};
