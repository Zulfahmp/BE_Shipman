const { router, validation, Timestamp } = require("../app/main");
const DBP = require("../app/connection.js").DBP();

router.get("/sscl-master", validation, async (req, res) => {
  try {
    let master = { ship: [], port: [], berth: [], cargo: [] };
    try {
      let resship = await DBP.query(
        "select * from production.master_ship where deleted_at is NULL",
      );
      master.ship = resship.rows;
    } catch (error) {}
    try {
      let resport = await DBP.query(
        "select * from production.master_port where deleted_at is NULL",
      );
      master.port = resport.rows;
    } catch (error) {}

    try {
      let resberth = await DBP.query(
        "select * from production.master_berth where deleted_at is NULL",
      );
      master.berth = resberth.rows;
    } catch (error) {}

    try {
      let rescargo = await DBP.query(
        "select * from production.master_cargo where deleted_at is NULL",
      );
      master.cargo = rescargo.rows;
    } catch (error) {}
    res.status(200).json(master);
  } catch (error) {
    res.status(200).json({ message: "Data Not Found" });
  }
});

module.exports = router;
