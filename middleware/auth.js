<<<<<<< HEAD
export function autoAuth(req, res, next) {

  if (req.path === "/login" || req.path === "/login/") {
    return next();
  }
  if (req.path.startsWith("/assets/")) {
    return next();
  }

  if (req.session?.admin) {
    return next();
  }

  return res.redirect("/login");
=======
import db from "../config/database.js";

const SESSION_TIMEOUT = 30 * 60 * 1000;

export async function autoAuth(req, res, next) {
  try {

    // ✅ ASSETS ALWAYS ALLOWED
    if (req.path.startsWith("/assets/")) {
      return next();
    }

    // ✅ AJAX LOGIN (POST /login) — MUST PASS
    if (req.method === "POST" && req.path === "/login") {
      return next();
    }

    // 🔐 LOGIN PAGE (GET /)
    if (req.method === "GET" && req.path === "/") {
      if (req.session && req.session.admin) {
        return res.redirect("/dashboard");
      }
      return next();
    }

    // ❌ NOT LOGGED IN → LOGIN PAGE
    if (!req.session || !req.session.admin) {
      return res.redirect("/");
    }

    const now = Date.now();

    // ⏱️ AUTO LOGOUT AFTER INACTIVITY
    if (
      req.session.lastActivity &&
      now - req.session.lastActivity > SESSION_TIMEOUT
    ) {
      return req.session.destroy(() => {
        return res.redirect("/");
      });
    }

    // 🔄 UPDATE ACTIVITY
    req.session.lastActivity = now;

    // 🔐 SESSION VERSION CHECK
    const [rows] = await db.query(
      "SELECT session_version FROM adminuser WHERE id = ? LIMIT 1",
      [req.session.admin.id]
    );

    if (
      !rows.length ||
      rows[0].session_version !== req.session.admin.session_version
    ) {
      return req.session.destroy(() => {
        return res.redirect("/");
      });
    }

    // ✅ ALL GOOD
    return next();

  } catch (err) {
    console.log("AutoAuth Error:", err);
    return res.redirect("/");
  }
>>>>>>> 49d7cd4 (initial push from server)
}
