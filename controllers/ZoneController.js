import db from "../config/database.js";

/* =====================================
   ZONE LIST + CREATE PAGE
===================================== */
export const createZone = async (req, res) => {
  try {
    const [zones] = await db.query(
      "SELECT * FROM zones  WHERE zone_type = 2 ORDER BY id DESC"
    );

return res.render("ride_order/createZone", {
  pageTitle: "Zone Management",
  zones,
  activeTab: req.query.tab || "list",
  editZone: null   // ✅ FIX
});


  } catch (error) {
    console.error("Create Zone Page Error:", error);
    req.session.error = "Something went wrong!";
    return res.redirect("/");
  }
};


/* =====================================
   INSERT ZONE
===================================== */
export const insertZone = async (req, res) => {
  try {
    const { zone_name, zone_coordinates } = req.body;

    if (!zone_coordinates || zone_coordinates.trim() === "") {
      req.session.error = "Please draw a zone on the map.";
      return res.redirect("/create_zone");
    }

    await db.query(
      `
      INSERT INTO zones (zone_name, coordinates, zone_type, created_at)
      VALUES (?, ?, 2, NOW())
      `,
      [zone_name, zone_coordinates]
    );

    req.session.success = "Ride zone created successfully!";
    return res.redirect("/create_zone");

  } catch (error) {
    console.error("Insert Zone Error:", error);
    req.session.error = "Something went wrong!";
    return res.redirect("/create_zone");
  }
};


/* =====================================
   DELETE ZONE
===================================== */
export const deleteZone = async (req, res) => {
  try {
    const { id } = req.params;

    // optional safety: check zone exists
    const [exist] = await db.query(
      "SELECT id FROM zones WHERE id = ?",
      [id]
    );

    if (!exist.length) {
      req.session.error = "Zone not found!";
      return res.redirect("/create_zone?tab=list");
    }

    await db.query(
      "DELETE FROM zones WHERE id = ?",
      [id]
    );

    req.session.success = "Zone deleted successfully!";
    return res.redirect("/create_zone?tab=list");

  } catch (error) {
    console.error("Delete Zone Error:", error);
    req.session.error = "Something went wrong!";
    return res.redirect("/create_zone?tab=list");
  }
};



    export const editZonePage = async (req, res) => {
      try {
        const { id } = req.params;
    
        const [[zone]] = await db.query(
          "SELECT * FROM zones WHERE id = ?",
          [id]
        );
    
        if (!zone) {
          req.session.error = "Zone not found!";
          return res.redirect("/create_zone?tab=list");
        }
    
        const [zones] = await db.query(
          "SELECT * FROM zones ORDER BY id DESC"
        );
    
        return res.render("ride_order/editZone", {
          pageTitle: "Edit Zone",
          zones,
          activeTab: "create",
          editZone: zone   // 👈 important
        });
    
      } catch (error) {
        console.error("Edit Zone Page Error:", error);
        req.session.error = "Something went wrong!";
        return res.redirect("/create_zone?tab=list");
      }
    };


    export const updateZone = async (req, res) => {
      try {
        const { id } = req.params;
        const { zone_name, zone_coordinates } = req.body;
    
        if (!zone_coordinates || zone_coordinates.trim() === "") {
          req.session.error = "Please draw a zone on the map.";
          return res.redirect(`/zones/edit/${id}`);
        }
    
        await db.query(
          `
          UPDATE zones
          SET zone_name = ?, coordinates = ?
          WHERE id = ?
          `,
          [zone_name, zone_coordinates, id]
        );
    
        req.session.success = "Zone updated successfully!";
        return res.redirect("/create_zone?tab=list");
    
      } catch (error) {
        console.error("Update Zone Error:", error);
        req.session.error = "Something went wrong!";
        return res.redirect(`/zones/edit/${id}`);
      }
    };






















///==============



export const createServiceZone = async (req, res) => {
  try {
    const [zones] = await db.query(
      "SELECT * FROM zones WHERE zone_type= 1 ORDER BY id DESC"
    );

return res.render("service_order/createserviceZone", {
  pageTitle: "Zone Management",
  zones,
  activeTab: req.query.tab || "list",
  editZone: null   // ✅ FIX
});


  } catch (error) {
    console.error("Create Zone Page Error:", error);
    req.session.error = "Something went wrong!";
    return res.redirect("/");
  }
};


/* =====================================
   INSERT ZONE
===================================== */
export const insertServiceZone = async (req, res) => {
  try {
    const { zone_name, zone_coordinates } = req.body;

    if (!zone_coordinates || zone_coordinates.trim() === "") {
      req.session.error = "Please draw a zone on the map.";
      return res.redirect("/create_service_zone");
    }

    await db.query(
      `
      INSERT INTO zones (zone_name, coordinates, zone_type, created_at)
      VALUES (?, ?, 1, NOW())
      `,
      [zone_name, zone_coordinates]
    );

    req.session.success = "Service zone created successfully!";
    return res.redirect("/create_service_zone");

  } catch (error) {
    console.error("Insert Service Zone Error:", error);
    req.session.error = "Something went wrong!";
    return res.redirect("/create_service_zone");
  }
};

/* =====================================
   DELETE ZONE
===================================== */
export const deleteServiceZone = async (req, res) => {
  try {
    const { id } = req.params;

    // optional safety: check zone exists
    const [exist] = await db.query(
      "SELECT id FROM zones WHERE id = ?",
      [id]
    );

    if (!exist.length) {
      req.session.error = "Zone not found!";
      return res.redirect("/create_service_zone?tab=list");
    }

    await db.query(
      "DELETE FROM zones WHERE id = ?",
      [id]
    );

    req.session.success = "Zone deleted successfully!";
    return res.redirect("/create_service_zone?tab=list");

  } catch (error) {
    console.error("Delete Zone Error:", error);
    req.session.error = "Something went wrong!";
    return res.redirect("/create_service_zone?tab=list");
  }
};



    export const editServiceZonePage = async (req, res) => {
      try {
        const { id } = req.params;
    
        const [[zone]] = await db.query(
          "SELECT * FROM zones WHERE id = ?",
          [id]
        );
    
        if (!zone) {
          req.session.error = "Zone not found!";
          return res.redirect("/create_service_zone?tab=list");
        }
    
        const [zones] = await db.query(
          "SELECT * FROM zones ORDER BY id DESC"
        );
    
        return res.render("service_order/editServiceZone", {
          pageTitle: "Edit Zone",
          zones,
          activeTab: "create",
          editZone: zone   // 👈 important
        });
    
      } catch (error) {
        console.error("Edit Zone Page Error:", error);
        req.session.error = "Something went wrong!";
        return res.redirect("/create_service_zone?tab=list");
      }
    };


    export const updateServiceZone = async (req, res) => {
      try {
        const { id } = req.params;
        const { zone_name, zone_coordinates } = req.body;
    
        if (!zone_coordinates || zone_coordinates.trim() === "") {
          req.session.error = "Please draw a zone on the map.";
          return res.redirect(`/service_zones/edit/${id}`);
        }
    
        await db.query(
          `
          UPDATE zones
          SET zone_name = ?, coordinates = ?
          WHERE id = ?
          `,
          [zone_name, zone_coordinates, id]
        );
    
        req.session.success = "Zone updated successfully!";
        return res.redirect("/create_service_zone?tab=list");
    
      } catch (error) {
        console.error("Update Zone Error:", error);
        req.session.error = "Something went wrong!";
        return res.redirect(`/service_zones/edit/${id}`);
      }
    };


