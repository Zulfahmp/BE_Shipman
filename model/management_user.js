const {router,validation, Timestamp} = require('../app/main')
const DBP = require('../app/connection.js').DBP()
const {hashPassword} = require('../app/auth_validation.js')
const {sendEmail} = require('../app/emailsender')
const crypto = require("crypto");

async function random8Char() {
  const alphabet = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789";
  // (tanpa 0, O, l, I biar tidak membingungkan)
  const bytes = crypto.randomBytes(8);
  let out = "";
  for (let i = 0; i < 8; i++) {
    out += alphabet[bytes[i] % alphabet.length];
  }
  return {password:out,hash:await hashPassword(out)};
}


router.get('/list-users',validation,async(req,res)=>{
    try {
        let where = ''
        if(req.query.search){
            const columns = ['full_name', 'email'];
            const search = req.query.search.replace(/[=!;]/g, "")
            where = 'AND'+` (${columns.map((col,i) => `${col} LIKE '%${search}%'`).join(' OR ')})`;
        }

        let {rows} = await DBP.query(`select user_id,full_name,email,role from production.users where deleted_at IS NULL AND (token_verifier IS NULL OR token_verifier!=$1) ${where}`,[req.headers.authorization.split(' ')[1]])
        res.status(200).json(rows)
    } catch (error) {
        res.status(400).json(error)
    }
})

router.post('/add-user',validation,async(req,res)=>{
    try {
        let pass = await random8Char()
        req.body.email = req.body.email.replace(/[=!;]/g, "")
        let {rowCount} = await DBP.query('INSERT into production.users(full_name,email,password,role,position) values($1,$2,$3,$4,$5)',[req.body.full_name,req.body.email.toLowerCase(),pass.hash,req.body.role,{1:'Admin',2:'Verifier',3:'Checker'}[req.body.role]])
        if(rowCount){
            let html=`
            <div style="text-align:center">Halo ${req.body.full_name.split(' ')[0]}, Password Anda sebagai berikut</div>
            <div style="background:white;border-radius:4px;border:1px solid gray;padding:5px;font-size:14pt;margin:0 auto;text-align:center">${pass.password}</div>
            `
            sendEmail(req.body.email,'Password Akun Shipman',html)
            res.status(200).json({affected:rowCount})
        }else{
            res.status(200).json({affected:0})
        }
    } catch (error) {
        if(error.detail.includes('already exists')){
            res.status(200).json({affected:-1,message:'Duplicate Entry!'})
        }else{
            res.status(200).json({affected:0})
        }
    }
})

router.post('/edit-user',validation,async(req,res)=>{
    try {
        let {rowCount} = await DBP.query('UPDATE production.users set full_name=$1,email=$2,role=$3 where user_id=$4',[req.body.full_name,req.body.email,req.body.role,req.body.user_id])
        res.status(200).json({affected:rowCount,message:'Update Successful!'})
    } catch (error) {
        res.status(200).json({affected:-1,message:'Update Failed!',error:error})
    }
})

router.post('/delete-user',validation,async(req,res)=>{
    try {
        let timestamp = Timestamp()
        let {rowCount} = await DBP.query('UPDATE production.users set deleted_at=$1 where user_id=$2',[timestamp,req.body.user_id])
        res.status(200).json({affected:rowCount})
    } catch (error) {
        res.status(404).json({message:'Data Not Found'})
    }
})

module.exports = router
