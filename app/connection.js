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
// cel aja
const { Pool } = require("pg");

module.exports = {
  DBP: () => {
    try {
      return new Pool({
        host: process.env.PGHOST,
        user: process.env.PGUSER,
        password: process.env.PGPASSWORD,
        database: process.env.PGDATABASE,
        port: process.env.PGPORT,
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
