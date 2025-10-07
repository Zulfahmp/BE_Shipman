const {router,validation, Timestamp} = require('../app/main')
const DBP = require('../app/connection.js').DBP()

router.post('/add-sscl',validation,async(req,res)=>{
    try {
        let b = req.body
        let {rowCount} = await DBP.query('Insert into production.sscl_transaction(sscl_id,officer_name,officer_position,officer_contact,ship_name,port_name,berth_name,cargo_name,date_arrival,time_arrival) values($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)',[b.sscl_id,b.officer_name,b.officer_position,b.officer_contact,b.ship_name,b.port_name,b.berth_name,b.cargo_name,b.date_arrival,b.time_arrival])
        res.status(200).json({affected:rowCount,message:''})
    } catch (error) {
        res.status(200).json({affected:-1,message:'Data Not Found'+error})
    }
})

router.get('/list-sscl',validation,async(req,res)=>{
    try {
        let {rows} = await DBP.query(`select sscl_id,officer_name,officer_position,officer_contact,ship_name,port_name,berth_name,cargo_name,time_arrival,to_char(date_arrival,'YYYY-MM-DD') date_arrival from production.sscl_transaction`)
        res.status(200).json(rows)
    } catch (error) {
        res.status(200).json({message:'Data Not Found'})
    }
})

module.exports = router