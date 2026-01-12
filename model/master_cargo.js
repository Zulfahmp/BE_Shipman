
const {router,validation, Timestamp} = require('../app/main')
const DBP = require('../app/connection.js').DBP()

router.get('/total-master-cargo',validation,async(req,res)=>{
    try {
        let {rows} = await DBP.query('select count(1) total from production.master_cargo where deleted_at is NULL limit 1')
        res.status(200).json({total:rows[0].total})
    } catch (error) {
        res.status(200).json({message:'Data Not Found'})
    }
})

router.get('/list-master-cargo',validation,async(req,res)=>{
    try {
        let {rows} = await DBP.query('select cargo_id,cargo_name,cargo_code from production.master_cargo where deleted_at IS NULL order by cargo_name')
        res.status(200).json(rows)
    } catch (error) {
        res.status(200).json([])
    }
})

router.post('/add-master-cargo',validation,async(req,res)=>{
    try {
        let {rowCount} = await DBP.query('Insert into production.master_cargo(cargo_name,cargo_code) values($1,$2)',[req.body.cargo_name.toUpperCase(),req.body.cargo_code])
        res.status(200).json({affected:rowCount,message:''})
    } catch (error) {
        res.status(200).json({affected:-1,message:'Data Not Found'+error})
    }
})

router.post('/edit-master-cargo',validation,async(req,res)=>{
    try {
        let {rowCount} = await DBP.query('UPDATE production.master_cargo set cargo_name=$1,cargo_code=$2 where cargo_id=$3',[req.body.cargo_name.toUpperCase(),req.body.cargo_code,req.body.cargo_id])
        res.status(200).json({affected:rowCount})
    } catch (error) {
        res.status(200).json({affected:-1,message:error})
    }
})

router.post('/delete-master-cargo',validation,async(req,res)=>{
    try {
        let timestamp = Timestamp()
        let {rowCount} = await DBP.query('UPDATE production.master_cargo set deleted_at=$1 where cargo_id=$2',[timestamp,req.body.cargo_id])
        res.status(200).json({affected:rowCount})
    } catch (error) {
        res.status(200).json({affected:-1,message:error})
    }
})

module.exports = router