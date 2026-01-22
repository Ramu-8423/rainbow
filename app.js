import express from "express";
import session from "express-session";
import dotenv from "dotenv";
import path from "path";
import { fileURLToPath } from "url";
import expressLayouts from "express-ejs-layouts";
import { autoAuth } from "./middleware/auth.js";
import { requestTime } from "./middleware/requestTime.js";

import { scheduleApiHits } from "./scheduleHit.js";


import http from "http";
import { initSocket } from "./socket.js";


dotenv.config();

console.log("Loaded PORT:", process.env.PORT);

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();


const server = http.createServer(app);


initSocket(server);

// ---------------- EXPRESS MIDDLEWARES ----------------

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, "public")));

app.use((req, res, next) => {
  res.locals.activePath = req.path;
  next();
});


app.use(
  session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false
  })
);

app.use((req, res, next) => {
  res.locals.session = req.session || {};
  next();
});

app.use((req, res, next) => {
  res.locals.success = req.session.success || null;
  res.locals.error = req.session.error || null;

  // ✅ turant clear
  req.session.success = null;
  req.session.error = null;

  next();
});



app.use(requestTime);


app.locals.BASE_URL = process.env.BASE_URL;


app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));
app.use(expressLayouts);
app.set("layout", "administrator/main");

// ---------------- ROUTES ----------------
import apiRoutes from "./routes/api.js";
import webRoutes from "./routes/web.js";

app.use("/api", apiRoutes);
app.use("/", autoAuth, webRoutes);

// ---------------- START SERVER ----------------
const PORT = process.env.PORT || 1219;

server.listen(PORT, () => {
  console.log(`🚀 Server + Socket running on port ${PORT}`);
  scheduleApiHits();
});
