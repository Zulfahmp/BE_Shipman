const express = require("express");
const validation = require("./token_validation.js");

const DBP = require("./connection.js").DBP();
const router = express.Router();
const status_500 = { status: 500, message: "Something Wrong" };
function Timestamp(date = new Date()) {
  const pad = (n) => n.toString().padStart(2, "0");

  const year = date.getFullYear();
  const month = pad(date.getMonth() + 1); // bulan 0-11
  const day = pad(date.getDate());

  const hours = pad(date.getHours());
  const minutes = pad(date.getMinutes());
  const seconds = pad(date.getSeconds());

  return `${year}-${month}-${day}`;
}
module.exports = {
  express: express,
  validation: validation,
  DBP: DBP,
  router: router,
  status_500,
  Timestamp: Timestamp,
};
