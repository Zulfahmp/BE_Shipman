const { router, validation, Timestamp } = require("../app/main");
const DBP = require("../app/connection.js").DBP();
const formatQ = require("pg-format");
const multer = require("multer");
const path = require("path");
const jwt = require("jsonwebtoken");
require("dotenv").config();
const secretKey = "pertaminamaju";
// Konfigurasi multer untuk simpan file ke folder public/uploads
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "D:/REN/Project/shipman/public/nf"); // folder tujuan
    // cb(null, '/var/www/html/public/nf'); // folder tujuan
  },
  filename: (req, file, cb) => {
    // nama unik
    // const ext = path.extname(file.originalname);
    // const filename = Date.now() + '-' + Math.round(Math.random() * 1E9) + ext;
    cb(null, file.originalname);
  },
});
const upload = multer({ storage });

router.post("/add-negative-feedback", validation, async (req, res) => {
  let b = req.body;
  if (b.nf_id == "") {
    res.status(200).json({ affected: -1, message: "Bad Request!" });
    return;
  }
  try {
    let nf = await DBP.query(
      "Insert into production.negative_feedback(nf_id,ship_id,port_id,port_next_id,created_by,status_nf) values($1,$2,$3,$4,$5,$6)",
      [
        b.nf_id,
        b.ship_id,
        b.port_id,
        b.port_next_id,
        b.created_by.toUpperCase(),
        -1,
      ],
    );
    let detail = b.detail.map((a) => [
      a.id_nf,
      a.ref_number,
      a.remarks,
      a.evidence_name,
      -1,
    ]);
    const query = formatQ(
      "INSERT INTO production.detail_negative_feedback(id_nf, ref_number, remarks, evidence,status_feedback) VALUES %L",
      detail,
    );
    let detail_nf = await DBP.query(query);
    res.status(200).json({ affected: nf.rowCount, message: "" });
  } catch (error) {
    res.status(200).json({ affected: -1, message: "Bad Request!" + error });
  }
});
router.post(
  "/upload-evidences",
  upload.array("evidences", 20),
  validation,
  async (req, res) => {
    try {
      res.status(200).json({ cek: "oke" });
    } catch (error) {
      res.status(200).json({ error: error });
    }
  },
);

router.get("/list-negative-feedback", validation, async (req, res) => {
  try {
    const search = req.query.search.replace(/[=!;]/g, "");
    let searching = `($1!='' and concat_ws(' ',
        mship.ship_name,
        mport.port_name,
        port_next.port_name,
        TO_CHAR(n.created_at, 'YYYY-MM-DD')
        ) ILIKE $1 )`;

    let join = `
            left join production.master_ship mship on n.ship_id=mship.ship_id
            left join production.master_port mport on n.port_id=mport.port_id
            left join production.master_port port_next on n.port_next_id=port_next.port_id
        `;

    let restotal = await DBP.query(
      `select count(1) total from production.negative_feedback n ${join} where ${searching}`,
      [`%${search}%`],
    );

    let result = await DBP.query(
      `select nf_id,mship.ship_name,mport.port_name,port_next.port_name port_next_name,approver,to_char(n.created_at,'YYYY-MM-DD') date_of_report,status_nf from production.negative_feedback n ${join} where ${searching} order by n.created_at desc limit $2 offset $3`,
      [`%${search}%`, req.query.limit, req.query.current_page],
    );
    res
      .status(200)
      .json({ lists: result.rows, total_rows: restotal.rows[0]["total"] });
  } catch (error) {
    res.status(200).json({ message: "Data Not Found" });
  }
});

router.post("/nf-approval", validation, async (req, res) => {
  let b = req.body;
  let token = req.headers["authorization"].split(" ")[1];
  let tokenDecode = jwt.verify(token, secretKey);
  try {
    let { rowCount } = await DBP.query(
      "UPDATE production.negative_feedback set status_nf=$1,approver=$2 where nf_id=$3",
      [b.status_nf, tokenDecode.full_name, b.nf_id],
    );
    b.detail.forEach(async (a) => {
      await DBP.query(
        "UPDATE production.detail_negative_feedback set status_feedback=$1 where id=$2",
        [a.status_feedback, a.id],
      );
    });
    res.status(200).json({ affected: rowCount, message: "" });
  } catch (error) {
    res.status(200).json({ affected: -1, message: "Failed " + error });
  }
});

router.post("/negative-feedback-detail", validation, async (req, res) => {
  try {
    let join = `
            left join production.master_ship mship on n.ship_id=mship.ship_id
            left join production.master_port mport on n.port_id=mport.port_id
            left join production.master_port port_next on n.port_next_id=port_next.port_id
        `;
    let nfmaster = await DBP.query(
      `select mship.ship_name,mport.port_name,port_next.port_name port_next_name,created_by,approver,n.created_at,status_nf from production.negative_feedback n ${join} where nf_id=$1`,
      [req.body.nf_id],
    );
    let nfdetail = await DBP.query(
      `select * from production.detail_negative_feedback where id_nf=$1`,
      [req.body.nf_id],
    );
    res.status(200).json({ master: nfmaster.rows[0], detail: nfdetail.rows });
  } catch (error) {
    res
      .status(200)
      .json({ message: "Data Not Found", error: error, nf: req.body.nf_id });
  }
});

router.get("/nf-view/:nf_id", validation, async (req, res) => {
  try {
    let join = `
            left join production.master_ship mship on n.ship_id=mship.ship_id
            left join production.master_port mport on n.port_id=mport.port_id
            left join production.master_port port_next on n.port_next_id=port_next.port_id
        `;
    let result = await DBP.query(
      `select *,mship.ship_name,mport.port_name,port_next.port_name port_next_name,to_char(n.created_at,'YYYY-MM-DD') n.created_at,status_nf from production.negative_feedback where nf_id=$1 limit 1`,
      [req.params.nf_id],
    );
    let detail = await DBP.query(
      `select * from production.detail_negative_feedback where id_nf=$1 order by ref_number`,
      [req.params.nf_id],
    );

    res.status(200).json({ ...result.rows[0], detail: detail.rows });
  } catch (error) {
    res.status(200).json({ message: "Failed" + error });
  }
});

router.get("/negative-feedback-ref", validation, async (req, res) => {
  try {
    let { rows } = await DBP.query(
      `select ref_number from production.negative_feedback_ref`,
    );
    res.status(200).json(rows);
  } catch (error) {
    res.status(200).json({ message: "Data Not Found" });
  }
});

module.exports = router;
