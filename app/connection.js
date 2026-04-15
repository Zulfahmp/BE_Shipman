// const { Pool } = require("pg");

// const pool = new Pool({
//   connectionString: process.env.DATABASE_URL,
//   ssl: {
//     rejectUnauthorized: false,
//   },
// });

// module.exports = {
//   DBP: () => pool,
// };

const { Pool } = require("pg");

module.exports = {
  DBP: () => {
    try {
      return new Pool({
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_NAME,
        port: process.env.DB_PORT,
        ssl: {
          rejectUnauthorized: false,
        },
      });
    } catch (err) {
      console.error("DB connection error:", err);

      throw err;
    }
  },
};
