// controllers/driver_controller.js
import db from "../config/database.js";

export const driver_controller = async (req, res) => {
  try {
    const perPage = parseInt(req.query.perPage) || 8;
    const page = parseInt(req.query.page) || 1;
    const offset = (page - 1) * perPage;

    const { from, to, status } = req.query;

    let where = "WHERE 1 ";
    let values = [];

    // DATE FILTER
    if (from && to) {
      where += "AND DATE(created_at) BETWEEN ? AND ? ";
      values.push(from, to);
    }

    // STATUS FILTER
    if (status === "1") {
      where += "AND status = 1 ";
    } else if (status === "0") {
      where += "AND status = 0 ";
    }

    // TOTAL COUNT
    const [[{ total }]] = await db.query(
      `SELECT COUNT(*) AS total FROM driver_registration ${where}`,
      values
    );

    // DATA FETCH
    const [rows] = await db.query(
      `SELECT * FROM driver_registration
       ${where}
       ORDER BY id DESC
       LIMIT ? OFFSET ?`,
      [...values, perPage, offset]
    );

    return res.render("drivers/allDrivers", {
      title: "Drivers List",
      drivers: rows,
      total,
      page,
      perPage,
      totalPages: Math.ceil(total / perPage),
      from,
      to,
      status,
      isFiltered: Boolean(from && to),
    });

  } catch (err) {
    console.log("Driver Fetch Error:", err);

    return res.render("drivers/allDrivers", {
      title: "Drivers List",
      drivers: [],
      total: 0,
      page: 1,
      perPage: 8,
      totalPages: 1,
      error: "Something went wrong!"
    });
  }
};



export const driverView = async (req, res) => {
  try {
    const { id } = req.params;
    if (!id) {
      return res.redirect("/all-drivers");
    }
    const [driverRows] = await db.query(
      "SELECT * FROM driver_registration WHERE id = ? LIMIT 1",
      [id]
    );

    if (!driverRows.length) {
      return res.render("drivers/driverView", {
        title: "Driver Verification",
        driver: null,
        error: "Driver not found"
      });
    }

    const driver = driverRows[0];
    return res.render("drivers/driverView", {
      title: "Driver Verification",
      driver
    });

  } catch (err) {
    console.log("Driver View Error:", err);
    return res.render("drivers/driverView", {
      title: "Driver Verification",
      driver: null,
      error: "Something went wrong!"
    });
  }
};



export const updateDriverStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { section, status, reason } = req.query;

    if (!id || !section || !status) {
      req.session.error = "Invalid request.";
      return res.redirect("/all-drivers");
    }

    /* 🔹 SECTION → COLUMN MAP */
    const sectionMap = {
      personal_information: {
        status: "personal_information_status",
        reason: "personal_information_reject_reason"
      },
      driver_licence: {
        status: "driver_licence_status",
        reason: "driver_licence_reject_reason"
      },
      aadhaar_pan: {
        status: "aadhaar_pan_status",
        reason: "aadhaar_pan_reject_reason"
      },
      required_certificates: {
        status: "required_certificates_status",
        reason: "required_certificates_reject_reason"
      },
      vehicle_info: {
        status: "vehicle_info_status",
        reason: "vehicle_info_reject_reason"
      },
      vehicle_documents: {
        status: "vehicle_documents_status",
        reason: "vehicle_documents_reject_reason"
      }
    };

    if (!sectionMap[section]) {
      req.session.error = "Invalid document section.";
      return res.redirect(`/driver-view/${id}`);
    }

    const statusColumn = sectionMap[section].status;
    const reasonColumn = sectionMap[section].reason;

    /* 🔴 REJECT CASE (3) */
    if (Number(status) === 3) {
      if (!reason) {
        req.session.error = "Reject reason is required.";
        return res.redirect(`/driver-view/${id}`);
      }

      await db.query(
        `
        UPDATE driver_registration
        SET ${statusColumn} = 3,
            ${reasonColumn} = ?
        WHERE id = ?
        `,
        [reason, id]
      );

      req.session.success = "Document rejected successfully.";
    }

    /* 🟢 APPROVE CASE (2) */
    if (Number(status) === 2) {
      await db.query(
        `
        UPDATE driver_registration
        SET ${statusColumn} = 2,
            ${reasonColumn} = NULL
        WHERE id = ?
        `,
        [id]
      );

      req.session.success = "Document approved successfully.";
    }

    return res.redirect(`/driver-view/${id}`);

  } catch (err) {
    console.log("Driver Status Update Error:", err);
    req.session.error = "Something went wrong while updating document status.";
    return res.redirect("/all-drivers");
  }
};


export const approveAllDocuments = async (req, res) => {
  try {
    const { driver_id } = req.body;

    if (!driver_id) {
      req.session.error = "Invalid driver request.";
      return res.redirect("/all-drivers");
    }

    await db.query(
      `
      UPDATE driver_registration
      SET
        personal_information_status = 2,
        personal_information_reject_reason = NULL,

        driver_licence_status = 2,
        driver_licence_reject_reason = NULL,

        aadhaar_pan_status = 2,
        aadhaar_pan_reject_reason = NULL,

        required_certificates_status = 2,
        required_certificates_reject_reason = NULL,

        vehicle_info_status = 2,
        vehicle_info_reject_reason = NULL,

        vehicle_documents_status = 2,
        vehicle_documents_reject_reason = NULL
      WHERE id = ?
      `,
      [driver_id]
    );

    req.session.success = "All driver documents approved successfully.";

    return res.redirect(`/driver-view/${driver_id}`);

  } catch (err) {
    console.log("Approve All Documents Error:", err);
    req.session.error = "Failed to approve all documents.";
    return res.redirect("/all-drivers");
  }
};




export const driverLoginStatus = async (req, res) => {
  try {
    const id = req.params.id;
    const status = parseInt(req.query.status);
    const reason = req.query.reason || null;

    if (!id || isNaN(status)) {
      req.session.error = "Invalid request.";
      return res.redirect("/all-drivers");
    }

    let sql = "";
    let params = [];

    // 🟢 ACTIVE (1)
    if (status === 1) {
      sql = `
        UPDATE driver_registration 
        SET 
          login_status = ?, 
          login_status_inactive_reasion = NULL 
        WHERE id = ?
      `;
      params = [1, id];

      req.session.success = "Driver activated successfully.";
    }

    // 🔴 INACTIVE (0) → reason required + max 25 words
    else if (status === 0) {

      // ❌ reason missing
      if (!reason) {
        req.session.error = "Reject reason is required.";
        return res.redirect("/all-drivers");
      }

      // ❌ word count validation
      const wordCount = reason.trim().split(/\s+/).length;
      if (wordCount > 25) {
        req.session.error = "Reject reason cannot exceed 25 words.";
        return res.redirect("/all-drivers");
      }

      sql = `
        UPDATE driver_registration 
        SET 
          login_status = ?, 
          login_status_inactive_reasion = ? 
        WHERE id = ?
      `;
      params = [0, reason, id];

      req.session.success = "Driver deactivated successfully.";
    }

    await db.query(sql, params);

    return res.redirect("/all-drivers");

  } catch (err) {
    console.log("Status Update Error:", err);
    req.session.error = "Something went wrong while updating status.";
    return res.redirect("/all-drivers");
  }
};


