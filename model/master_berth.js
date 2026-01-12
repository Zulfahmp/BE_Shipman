const {router,validation, Timestamp} = require('../app/main')
const DBP = require('../app/connection.js').DBP()

router.get('/total-master-berth',validation,async(req,res)=>{
    try {
        let {rows} = await DBP.query('select count(1) total from production.master_berth where deleted_at is NULL limit 1')
        res.status(200).json({total:rows[0].total})
    } catch (error) {
        res.status(200).json({message:'Data Not Found'})
    }
})

router.get('/list-master-berth',validation,async(req,res)=>{
    try {
        let {rows} = await DBP.query('select berth_id,berth_name,berth_code from production.master_berth where deleted_at IS NULL order by berth_name')
        res.status(200).json(rows)
    } catch (error) {
        res.status(200).json([])
    }
})

router.post('/add-master-berth',validation,async(req,res)=>{
    try {
        let {rowCount} = await DBP.query('Insert into production.master_berth(berth_name,berth_code) values($1,$2)',[req.body.berth_name.toUpperCase(),req.body.berth_code])
        res.status(200).json({affected:rowCount,message:''})
    } catch (error) {
        res.status(200).json({affected:-1,message:'Data Not Found'+error})
    }
})


router.post('/edit-master-berth',validation,async(req,res)=>{
    try {
        let {rowCount} = await DBP.query('UPDATE production.master_berth set berth_name=$1,berth_code=$2 where berth_id=$3',[req.body.berth_name.toUpperCase(),req.body.berth_code,req.body.berth_id])
        res.status(200).json({affected:rowCount})
    } catch (error) {
        res.status(200).json({affected:-1,message:error})
    }
})

router.post('/delete-master-berth',validation,async(req,res)=>{
    try {
        let timestamp = Timestamp()
        let {rowCount} = await DBP.query('UPDATE production.master_berth set deleted_at=$1 where berth_id=$2',[timestamp,req.body.berth_id])
        res.status(200).json({affected:rowCount,timestamp:timestamp,id:req.body.berth_id})
    } catch (error) {
        res.status(200).json({affected:-1,message:error})
    }
})

module.exports = router