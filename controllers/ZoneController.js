import db from "../config/database.js";

/* =====================================
   ZONE LIST + CREATE PAGE
===================================== */
export const createZone = async (req, res) => {
  try {
    const [zones] = await db.query(
      "SELECT * FROM zones ORDER BY id DESC"
    );

    return res.render("ride_order/createZone", {
      pageTitle: "Zone Management",
      zones,
      activeTab: req.query.tab || "list"
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
      INSERT INTO zones (zone_name, coordinates, created_at)
      VALUES (?, ?, NOW())
      `,
      [zone_name, zone_coordinates]
    );

    req.session.success = "Zone created successfully!";
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
