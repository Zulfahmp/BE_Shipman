require("dotenv").config();

const express = require("express");
const cors = require("cors");
const path = require("path");

const app = express();

/* =====================
   CORS CONFIG
===================== */
const allowedOrigins = [
  "http://localhost:5173",
  "https://shipman.my.id", // FE production
  "https://www.shipman.my.id", // FE www (penting)
];

const corsOptions = {
  origin: (origin, callback) => {
    if (!origin || allowedOrigins.includes(origin)) {
      callback(null, true);
    } else {
      callback(new Error("403"));
    }
  },
  methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
  allowedHeaders: ["Content-Type", "Authorization", "vrapi_token"],
};
app.use(cors(corsOptions));
app.options("*", cors(corsOptions));

/* =====================
   BODY PARSER
===================== */
app.use(express.json({ limit: "1mb" }));
app.use(express.urlencoded({ extended: true, limit: "200mb" }));

/* =====================
   STATIC FILES
===================== */
app.use(express.static(path.join(__dirname, "../public")));
app.use("/nf", express.static(path.join(__dirname, "../public/nf")));

/* =====================
   CUSTOM ERROR ROUTE
===================== */
app.use("/error", require("../errors.js"));

/* =====================
   GLOBAL ERROR HANDLER
===================== */
app.use((err, req, res, next) => {
  if (err.message === "403") {
    return res.status(403).json({
      status: 403,
      message: "Forbidden Here!",
    });
  }

  console.error(err);
  res.status(500).json({
    status: 500,
    message: err.message || "Internal Server Error",
  });
});

/* =====================
   START SERVER
===================== */
const startServer = () => {
  const PORT = process.env.PORT || 3000;

  console.log("PORT:", PORT);

  app.listen(PORT, () => {
    console.log(`🚀 Server running on port ${PORT}`);
  });
};

module.exports = {
  app,
  startServer,
};
