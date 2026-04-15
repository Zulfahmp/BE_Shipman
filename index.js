require("dotenv").config();

console.log("DB USER:", process.env.PGUSER);

console.log("DB NAME:", process.env.PGDATABASE);

console.log("🚀 STEP 1: index.js loaded");

const { app, startServer } = require("./app/config.js");

console.log("🚀 STEP 2: config loaded");

// routes
// routes
app.use(require("./model/auth.js"));
console.log("✅ auth loaded");

app.use(require("./model/management_user.js"));
console.log("✅ management_user loaded");

app.use(require("./model/master_ship.js"));
console.log("✅ master_ship loaded");

app.use(require("./model/master_port.js"));
console.log("✅ master_port loaded");

app.use(require("./model/master_berth.js"));
console.log("✅ master_berth loaded");

app.use(require("./model/master_cargo.js"));
console.log("✅ master_cargo loaded");

app.use(require("./model/master.js"));
console.log("✅ master loaded");

app.use(require("./model/sscl_transaction.js"));
console.log("✅ sscl_transaction loaded");

app.use(require("./model/negative_feedback.js"));
console.log("✅ negative_feedback loaded");

// root health check
app.get("/", (req, res) => {
  res.status(200).json({
    status: 200,
    message: "API Shipman is running ������",
  });
});

console.log("🚀 STEP 3: routes loaded");

// error handling (optional)
process.on("unhandledRejection", (err) => {
  console.error("Unhandled Rejection:", err);
});

process.on("uncaughtException", (err) => {
  console.error("Uncaught Exception:", err);
});

// START SERVER (SATU KALI SAJA)
startServer();

console.log("🚀 STEP 4: server started");
