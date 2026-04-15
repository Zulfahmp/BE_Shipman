const { router, validation, status_500 } = require("../app/main");
const DBP = require("../app/connection.js").DBP();
const { hashPassword, checkPassword } = require("../app/auth_validation");
const jwt = require("jsonwebtoken");
require("dotenv").config();
const { Pool } = require("pg");
const secretKey = "pertaminamaju"; // Store this in env variables, not in code
const email = require("../app/emailsender.js");
router.get("/test", validation, async (req, res) => {
  res.status(200).json({ password: await hashPassword("#Pertamina321") });
});
router.get("/send_email", validation, async (req, res) => {
  let response = await email.sendEmail();
  res.status(200).json(response);
});

// #-----Kode Baru-----#
router.post("/authorization-checking", async (req, res) => {
  console.log("🚀 HIT AUTHORIZATION CHECKING"); // ⬅️ TAMBAHKAN INI
  try {
    const email = req.body.email?.trim();
    const password = req.body.password?.trim();

    // ✅ validasi basic
    if (!email || !password) {
      return res.status(400).json({
        authenticated: false,
        message: "Email and password required",
      });
    }

    const { rows } = await DBP.query(
      `SELECT full_name, position, email, password, role 
       FROM production.users 
       WHERE email=$1`,
      [email],
    );

    // ✅ user tidak ditemukan
    if (rows.length === 0) {
      return res.status(401).json({
        authenticated: false,
        message: "Email or password incorrect",
      });
    }

    const user = rows[0];

    // ✅ cek password (pakai bcrypt)
    // const is_valid = await checkPassword(password, user.password);
    console.log("USER DARI DB:", user);
    console.log("PASSWORD INPUT:", password);
    console.log("PASSWORD DB:", user.password);

    const is_valid = await checkPassword(password, user.password);

    if (!is_valid) {
      return res.status(401).json({
        authenticated: false,
        message: "Email or password incorrect",
      });
    }

    // ✅ JWT hanya dibuat jika valid
    const userjwt = {
      authenticated: true,
      full_name: user.full_name,
      email: user.email,
      role: user.role,
      position: user.position,
    };

    const token = jwt.sign(userjwt, secretKey, { expiresIn: "6h" });

    // ✅ simpan token (optional)
    try {
      await DBP.query(
        `UPDATE production.users SET token_verifier=$1 WHERE email=$2`,
        [token, user.email],
      );
    } catch (err) {
      console.log("Token save error:", err);
    }

    return res.status(200).json({
      authenticated: true,
      token,
      full_name: user.full_name,
      position: user.position,
      role: user.role,
    });
  } catch (err) {
    console.error("ERROR AUTH:", err);

    return res.status(500).json({
      authenticated: false,
      message: "Internal server error",
    });
  }
});

// #------Kode Lama------#
// router.post("/authorization-checking", async (req, res) => {
//   let response = {};
//   req.body.email = req.body.email.replace(/[=!;]/g, "");
//   req.body.password = req.body.password.replace(/[=!;]/g, "");
//   try {
//     let { rows } = await DBP.query(
//       `select full_name,position,email,password,role from production.users where email=$1`,
//       [req.body.email],
//     );
//     if (rows.length === 0) {
//       return res.json({ authenticated: false });
//     }
//     let is_valid = await checkPassword(req.body.password, rows[0].password);
//     let user = rows[0];
//     let userjwt = {
//       authenticated: true,
//       full_name: user.full_name,
//       email: user.email,
//       role: user.role,
//       position: user.position,
//     };
//     const token = jwt.sign(userjwt, secretKey, { expiresIn: "6h" });
//     if (is_valid) {
//       response.authenticated = true;
//       response.token = token;
//       response.full_name = user.full_name;
//       response.position = user.position;
//       response.role = user.role;
//       try {
//         await DBP.query(
//           `UPDATE production.users set token_verifier=$1 where email=$2`,
//           [token, user.email],
//         );
//       } catch (error) {
//         console.log(error);
//       }
//     } else {
//       response.authenticated = false;
//     }
//     res.json(response);
//   } catch (err) {
//     err ? res.json(status_500) : res.json({ authenticated: false });
//   }
// });

router.get("/check", validation, async (req, res) => {
  let { rows } = await DBP.query("select * from production.users");
  res.status(200).json(rows);
});

router.post("/authorization-validation", validation, async (req, res) => {
  let { rows } = DBP.query(
    "select token_verifier from production.users where token=$1",
    [req.token],
  );
  rows.length
    ? res.json({ authenticated: true })
    : res.json({ authenticated: false });
});

module.exports = router;
