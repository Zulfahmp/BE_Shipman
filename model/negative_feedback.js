const {router,validation, Timestamp} = require('../app/main')
const DBP = require('../app/connection.js').DBP()
const formatQ = require('pg-format')
const multer = require('multer');
const path = require('path');
// Konfigurasi multer untuk simpan file ke folder public/uploads
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, '/var/www/html/public/nf'); // folder tujuan
  },
  filename: (req, file, cb) => {
    // nama unik
    // const ext = path.extname(file.originalname);
    // const filename = Date.now() + '-' + Math.round(Math.random() * 1E9) + ext;
    cb(null, file.originalname);
  }
});
const upload = multer({ storage });

router.post('/add-negative-feedback',validation,async(req,res)=>{
    try {
        let b = req.body
        let nf = await DBP.query('Insert into production.negative_feedback(nf_id,ship_name,port_name,created_by) values($1,$2,$3,$4)',[b.nf_id,b.ship_name,b.port,b.created_by])
        let detail = b.detail.map(a => [a.id_nf, a.ref_number, a.remarks, a.evidence_name]);
        const query = formatQ(
        'INSERT INTO production.detail_negative_feedback(id_nf, ref_number, remarks, evidence) VALUES %L',detail);
        let detail_nf = await DBP.query(query)
        res.status(200).json({affected:nf.rowCount,message:''})
    } catch (error) {
        res.status(200).json({affected:-1,message:'Data Not Found'+error})
    }
})
router.post('/upload-evidences',upload.array('evidences',20),validation,async(req,res)=>{
    try {
        res.status(200).json({cek:'oke'})
        
    } catch (error) {
        
        res.status(200).json({error:error})
    }
})

router.get('/list-negative-feedback',validation,async(req,res)=>{
    try {
        let {rows} = await DBP.query(`select nf_id,ship_name,port_name,to_char(created_at,'YYYY-MM-DD') date_of_report from production.negative_feedback`)
        res.status(200).json(rows)
    } catch (error) {
        res.status(200).json({message:'Data Not Found'})
    }
})

router.post('/negative-feedback-detail',validation,async(req,res)=>{
    try {
        let {rows} = await DBP.query(`select ship_name,port_name,created_by,approver,created_at from production.negative_feedback where nf_id='$1'`,[req.body.nf_id])
        // let nfdetail = await DBP.query(`select * from production.detail_negative_feedback where id_nf='$1'`,[req.body.nf_id])
        res.status(200).json(rows)
    } catch (error) {
        res.status(200).json({message:'Data Not Found',error:error,nf:req.body.nf_id})
    }
})

router.get('/negative-feedback-ref',validation,async(req,res)=>{
    try {
        let {rows} = await DBP.query(`select ref_number from production.negative_feedback_ref`)
        res.status(200).json(rows)
    } catch (error) {
        res.status(200).json({message:'Data Not Found'})
    }
})

module.exports = router