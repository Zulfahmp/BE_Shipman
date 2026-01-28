const { router, validation, Timestamp } = require("../app/main");
const DBP = require("../app/connection.js").DBP();
const jwt = require("jsonwebtoken");
require("dotenv").config();
const secretKey = "pertaminamaju";
const formatQ = require("pg-format");

router.post("/add-sscl", validation, async (req, res) => {
  let b = req.body;
  let detail = b.sscl_checklist.map((a) => [
    a.id_sscl,
    a.part_id,
    a.eng,
    a.ind,
    a.checker ? 1 : 0,
    a.nahkoda ? 1 : 0,
    a.remarks,
    a.order,
  ]);
  try {
    let { rowCount } = await DBP.query(
      "Insert into production.sscl_transaction(sscl_id,officer_name,officer_position,officer_contact,ship_id,port_id,berth_id,cargo_id,date_arrival,time_arrival,mt_name,status_sscl,time_8,time_9,interval_8,interval_9,created_by) values($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17)",
      [
        b.sscl_id,
        b.officer_name.toUpperCase(),
        b.officer_position.toUpperCase(),
        b.officer_contact.toUpperCase(),
        b.ship_id,
        b.port_id,
        b.berth_id,
        b.cargo_id,
        b.date_arrival,
        b.time_arrival,
        b.mt_name.toUpperCase(),
        b.status_sscl,
        b.time_8,
        b.time_9,
        b.interval_8,
        b.interval_9,
        b.created_by.toUpperCase(),
      ],
    );
    const query = formatQ(
      "Insert into production.detail_sscl_transaction(id_sscl,part_id,question_eng,question_ind,checker,nahkoda,remarks,order_number) values %L",
      detail,
    );
    let detail_nf = await DBP.query(query);
    res.status(200).json({ affected: rowCount, message: "" });
  } catch (error) {
    res.status(200).json({ affected: -1, message: "Failed " + error });
  }
});

router.post("/sscl-approval", validation, async (req, res) => {
  let b = req.body;
  let token = req.headers["authorization"].split(" ")[1];
  let tokenDecode = jwt.verify(token, secretKey);
  try {
    let { rowCount } = await DBP.query(
      "UPDATE production.sscl_transaction set status_sscl=$1,approver=$2 where sscl_id=$3",
      [b.status_sscl, tokenDecode.full_name, b.sscl_id],
    );
    res.status(200).json({ affected: rowCount, message: "" });
  } catch (error) {
    res.status(200).json({ affected: -1, message: "Failed " + error });
  }
});

router.get("/list-sscl", validation, async (req, res) => {
  try {
    let result = {};
    const search = req.query.search.replace(/[=!;]/g, "");
    let searching = `($1!='' and concat_ws(' ',
        ship_name,
        port_name,
        berth_name,
        cargo_name,
        officer_name,
        officer_position,
        time_arrival,
        TO_CHAR(date_arrival, 'YYYY-MM-DD')
        ) ILIKE $1 )`;
    let join = `
            left join production.master_ship on s.ship_id=production.master_ship.ship_id
            left join production.master_port on s.port_id=production.master_port.port_id
            left join production.master_cargo on s.cargo_id=production.master_cargo.cargo_id
            left join production.master_berth on s.berth_id=production.master_berth.berth_id
        `;
    let restotal = await DBP.query(
      `select count(1) total from production.sscl_transaction s ${join} where ${searching}`,
      [`%${search}%`],
    );

    result = await DBP.query(
      `select sscl_id,status_sscl,officer_name,officer_position,officer_contact,ship_name,port_name,berth_name,cargo_name,time_arrival,to_char(date_arrival,'YYYY-MM-DD') date_arrival from production.sscl_transaction s ${join} where ${searching} order by date_arrival desc limit $2 offset $3`,
      [`%${search}%`, req.query.limit, req.query.current_page],
    );
    res
      .status(200)
      .json({ lists: result.rows, total_rows: restotal.rows[0]["total"] });
  } catch (error) {
    res.status(200).json({ message: "Failed" + error });
  }
});

router.get("/sscl-view/:sscl_id", validation, async (req, res) => {
  try {
    let join = `
            left join production.master_ship on s.ship_id=production.master_ship.ship_id
            left join production.master_port on s.port_id=production.master_port.port_id
            left join production.master_cargo on s.cargo_id=production.master_cargo.cargo_id
            left join production.master_berth on s.berth_id=production.master_berth.berth_id
        `;
    let result = await DBP.query(
      `select *,to_char(date_arrival,'YYYY-MM-DD') date_arrival,status_sscl from production.sscl_transaction s ${join} where sscl_id=$1 limit 1`,
      [req.params.sscl_id],
    );
    let detail = await DBP.query(
      `select * from production.detail_sscl_transaction where id_sscl=$1 order by part_id,order_number`,
      [req.params.sscl_id],
    );

    res.status(200).json({ ...result.rows[0], sscl_checklist: detail.rows });
  } catch (error) {
    res.status(200).json({ message: "Failed" + error });
  }
});

router.get("/list-repetitive-checks/:ship_id", validation, async (req, res) => {
  try {
    let repetitive = [];
    let result = await DBP.query(
      `
            SELECT sscl_id,s.ship_id,ship_name,s.port_id,port_name,time_8,time_9,interval_8,interval_9
            FROM production.sscl_transaction s
            LEFT JOIN production.master_ship ON s.ship_id = production.master_ship.ship_id
            LEFT JOIN production.master_port ON s.port_id = production.master_port.port_id
            LEFT JOIN production.master_cargo ON s.cargo_id = production.master_cargo.cargo_id
            LEFT JOIN production.master_berth ON s.berth_id = production.master_berth.berth_id
            where status_sscl>=0 and s.ship_id=$1 group by sscl_id,ship_name,port_name,date_arrival,time_arrival
            order by s.date_arrival,s.time_arrival desc
            limit 6 `,
      [req.params.ship_id],
    );

    for (const a of result.rows) {
      const { rows } = await DBP.query(
        `select * from production.detail_sscl_transaction
                where id_sscl = $1
                order by part_id, order_number`,
        [a.sscl_id],
      );

      repetitive.push(rows);
    }

    res.status(200).json({ summary: result.rows, detail: repetitive });
  } catch (error) {
    res.status(200).json({ message: "Failed" + error });
  }
});

module.exports = router;
