import express from "express";
import session from "express-session";
import dotenv from "dotenv";
import path from "path";
<<<<<<< HEAD
=======
import cors from "cors";

>>>>>>> 49d7cd4 (initial push from server)
import { fileURLToPath } from "url";
import expressLayouts from "express-ejs-layouts";
import { autoAuth } from "./middleware/auth.js";
import { requestTime } from "./middleware/requestTime.js";

<<<<<<< HEAD
// ⭐ Socket Dependencies
import http from "http";
import { initSocket } from "./socket.js";

// Load ENV
=======
import { scheduleApiHits } from "./scheduleHit.js";

import http from "http";

// SOCKET MODULES
import { initSocket } from "./socket.js";
import { initCabSocket } from "./cabSocket.js";

>>>>>>> 49d7cd4 (initial push from server)
dotenv.config();

console.log("Loaded PORT:", process.env.PORT);

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();

<<<<<<< HEAD
// ✅ IMPORTANT: create HTTP server
const server = http.createServer(app);

// ✅ IMPORTANT: init socket ONLY ONCE
initSocket(server);
=======
// ===============================================
// SINGLE HTTP SERVER – ONLY ONE ENGINE
// ===============================================
const server = http.createServer(app);


app.use(cors());

// ===============================================
// 🚀 SOCKET INIT – SHARE SAME INSTANCE
// ===============================================
const mainIO = initSocket(server);      // existing socket system
initCabSocket(server, mainIO);          // cab system reuse
>>>>>>> 49d7cd4 (initial push from server)

// ---------------- EXPRESS MIDDLEWARES ----------------

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, "public")));

<<<<<<< HEAD
=======
app.use((req, res, next) => {
  res.locals.activePath = req.path;
  next();
});

>>>>>>> 49d7cd4 (initial push from server)
app.use(
  session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false
  })
);

<<<<<<< HEAD
=======

>>>>>>> 49d7cd4 (initial push from server)
app.use((req, res, next) => {
  res.locals.session = req.session || {};
  next();
});

<<<<<<< HEAD
=======

>>>>>>> 49d7cd4 (initial push from server)
app.use((req, res, next) => {
  res.locals.success = req.session.success || null;
  res.locals.error = req.session.error || null;

<<<<<<< HEAD
  delete req.session.success;
  delete req.session.error;
  next();
});

// time middleware
app.use(requestTime);

// base url
app.locals.BASE_URL = process.env.BASE_URL;

// ---------------- EJS ----------------
=======
  req.session.success = null;
  req.session.error = null;

  next();
});

app.use(requestTime);

app.locals.BASE_URL = process.env.BASE_URL;

>>>>>>> 49d7cd4 (initial push from server)
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
<<<<<<< HEAD
const PORT = process.env.PORT || 1218;

server.listen(PORT, () => {
  console.log(`🚀 Server + Socket running on port ${PORT}`);
=======
const PORT = process.env.PORT || 1214;

server.listen(PORT, () => {
  console.log(`🚀 Server + Socket running on port ${PORT}`);
  scheduleApiHits();
>>>>>>> 49d7cd4 (initial push from server)
});
