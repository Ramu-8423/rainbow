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
}
