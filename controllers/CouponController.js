import db from "../config/database.js";

export const couponList = async (req, res) => {
  try {
    // TABLE 1: ALL COUPONS
    const [coupons] = await db.query(`
      SELECT *
      FROM coupons
      ORDER BY id DESC
    `);

    // TABLE 2: USED COUPONS
    const [usedCoupons] = await db.query(`
      SELECT
        cu.id,
        cu.user_id,
        cu.status,
        cu.applied_at,

        c.code,
        c.title,
        c.discount_percent,
        c.type
      FROM coupons_used cu
      INNER JOIN coupons c ON c.id = cu.coupon_id
      ORDER BY cu.id DESC
    `);

    return res.render("coupons/index", {
      title: "Coupons",
      coupons,
      usedCoupons
    });

  } catch (err) {
    console.error(err);
    req.session.error = "Something went wrong!";
    return res.redirect("/");
  }
};



export const addCoupon = async (req, res) => {
  try {
    const { code, title, discount_percent, expires_at } = req.body;

    // 🔒 static type
    const type = 1;

    // validation
    if (!code || !title || !discount_percent || !expires_at) {
      req.session.error = "All fields are required!";
      return res.redirect("/coupons");
    }

    // duplicate check
    const [exist] = await db.query(
      "SELECT id FROM coupons WHERE code = ?",
      [code]
    );

    if (exist.length) {
      req.session.error = "Coupon code already exists!";
      return res.redirect("/coupons");
    }

    await db.query(
      `
      INSERT INTO coupons
      (code, title, discount_percent, type, expires_at, status, created_at)
      VALUES (?, ?, ?, ?, ?, 1, NOW())
      `,
      [code, title, discount_percent, type, expires_at]
    );

    req.session.success = "Coupon added successfully!";
    return res.redirect("/coupons");

  } catch (err) {
    console.error("Add Coupon Error:", err);
    req.session.error = "Something went wrong!";
    return res.redirect("/coupons");
  }
};



export const deleteCoupon = async (req, res) => {
  try {
    const { id } = req.params;

    // 🔒 check coupon exists
    const [coupon] = await db.query(
      "SELECT id FROM coupons WHERE id = ?",
      [id]
    );

    if (!coupon.length) {
      req.session.error = "Coupon not found!";
      return res.redirect("/coupons");
    }

    // 🔒 check if coupon already used
    const [used] = await db.query(
      "SELECT id FROM coupons_used WHERE coupon_id = ? LIMIT 1",
      [id]
    );

    if (used.length) {
      req.session.error = "Used coupon cannot be deleted!";
      return res.redirect("/coupons");
    }

    // ✅ delete coupon
    await db.query(
      "DELETE FROM coupons WHERE id = ?",
      [id]
    );

    req.session.success = "Coupon deleted successfully!";
    return res.redirect("/coupons");

  } catch (err) {
    console.error("Delete Coupon Error:", err);
    req.session.error = "Something went wrong!";
    return res.redirect("/coupons");
  }
};


export const updateCouponStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.query;

    if (status !== "0" && status !== "1") {
      req.session.error = "Invalid status!";
      return res.redirect("/coupons");
    }

    const [exist] = await db.query(
      "SELECT id FROM coupons WHERE id = ?",
      [id]
    );

    if (!exist.length) {
      req.session.error = "Coupon not found!";
      return res.redirect("/coupons");
    }

    await db.query(
      "UPDATE coupons SET status = ? WHERE id = ?",
      [status, id]
    );

    req.session.success =
      status == 1
        ? "Coupon activated successfully!"
        : "Coupon deactivated successfully!";

    return res.redirect("/coupons");

  } catch (err) {
    console.error("Coupon Status Update Error:", err);
    req.session.error = "Something went wrong!";
    return res.redirect("/coupons");
  }
};
