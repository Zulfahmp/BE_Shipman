const { router, validation, Timestamp } = require("../app/main");
const DBP = require("../app/connection.js").DBP();

router.get("/total-master-port", validation, async (req, res) => {
  try {
    let { rows } = await DBP.query(
      "select count(1) total from production.master_port where deleted_at is NULL limit 1",
    );
    res.status(200).json({ total: rows[0].total });
  } catch (error) {
    res.status(200).json({ message: "Data Not Found" });
  }
});

router.get("/list-master-port", validation, async (req, res) => {
  try {
    if (req.query.search && /^[^=!;]*$/.test(req.query.search)) {
      const columns = ["port_name", "port_code"];
      const search = req.query.search.replace(/[=!;]/g, "").toLowerCase();
      where =
        "AND" +
        ` (${columns.map((col, i) => `LOWER(${col}) LIKE '%${search}%'`).join(" OR ")})`;
    }
    let { rows } = await DBP.query(
      `select port_id,port_name,port_code from production.master_port where deleted_at IS NULL ${where} order by port_name`,
    );
    res.status(200).json(rows);
  } catch (error) {
    res.status(200).json([]);
  }
});

router.post("/add-master-port", validation, async (req, res) => {
  try {
    let { rowCount } = await DBP.query(
      "Insert into production.master_port(port_name,port_code) values($1,$2)",
      [req.body.port_name.toUpperCase(), req.body.port_code],
    );
    res.status(200).json({ affected: rowCount, message: "" });
  } catch (error) {
    res.status(200).json({ affected: -1, message: "Data Not Found" + error });
  }
});

router.post("/edit-master-port", validation, async (req, res) => {
  try {
    let { rowCount } = await DBP.query(
      "UPDATE production.master_port set port_name=$1,port_code=$2 where port_id=$3",
      [req.body.port_name.toUpperCase(), req.body.port_code, req.body.port_id],
    );
    res.status(200).json({ affected: rowCount });
  } catch (error) {
    res.status(200).json({ affected: -1, message: error });
  }
});

router.post("/delete-master-port", validation, async (req, res) => {
  try {
    let timestamp = Timestamp();
    let { rowCount } = await DBP.query(
      "UPDATE production.master_port set deleted_at=$1 where port_id=$2",
      [timestamp, req.body.port_id],
    );
    res
      .status(200)
      .json({ affected: rowCount, timestamp: timestamp, id: req.body.port_id });
  } catch (error) {
    res.status(200).json({ affected: -1, message: error });
  }
});

module.exports = router;
