const { router, validation, Timestamp } = require("../app/main");
const DBP = require("../app/connection.js").DBP();

router.get("/total-master-ship", validation, async (req, res) => {
  try {
    let { rows } = await DBP.query(
      "select count(1) total from production.master_ship where deleted_at is NULL limit 1",
    );
    res.status(200).json({ total: rows[0].total });
  } catch (error) {
    res.status(200).json({ message: "Data Not Found" });
  }
});

router.get("/list-master-ship", validation, async (req, res) => {
  try {
    let where = "";

    if (req.query.search && /^[^=!;]*$/.test(req.query.search)) {
      const columns = ["ship_name", "ship_code"];
      const search = req.query.search.replace(/[=!;]/g, "").toLowerCase();
      where =
        "AND" +
        ` (${columns.map((col, i) => `LOWER(${col}) LIKE '%${search}%'`).join(" OR ")})`;
    }
    let { rows } = await DBP.query(
      `select ship_id,ship_name,ship_code from production.master_ship where deleted_at IS NULL ${where} order by ship_name`,
    );
    res.status(200).json(rows);
  } catch (error) {
    res.status(200).json([]);
  }
});

router.post("/add-master-ship", validation, async (req, res) => {
  try {
    let { rowCount } = await DBP.query(
      "Insert into production.master_ship(ship_name,ship_code) values($1,$2)",
      [req.body.ship_name.toUpperCase(), req.body.ship_code],
    );
    res.status(200).json({ affected: rowCount, message: "" });
  } catch (error) {
    res.status(200).json({ affected: -1, message: "Data Not Found" + error });
  }
});

router.post("/edit-master-ship", validation, async (req, res) => {
  try {
    let { rowCount } = await DBP.query(
      "UPDATE production.master_ship set ship_name=$1,ship_code=$2 where ship_id=$3",
      [req.body.ship_name.toUpperCase(), req.body.ship_code, req.body.ship_id],
    );
    res.status(200).json({ affected: rowCount });
  } catch (error) {
    res.status(200).json({ affected: -1, message: error });
  }
});

router.post("/delete-master-ship", validation, async (req, res) => {
  try {
    let timestamp = Timestamp();
    let { rowCount } = await DBP.query(
      "UPDATE production.master_ship set deleted_at=$1 where ship_id=$2",
      [timestamp, req.body.ship_id],
    );
    res.status(200).json({ affected: rowCount });
  } catch (error) {
    res.status(200).json({ affected: -1, message: error });
  }
});

module.exports = router;
