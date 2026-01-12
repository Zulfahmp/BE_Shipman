const { Pool } = require('pg');
require('dotenv').config(); // Loa
module.exports = {
    DBP: () => {
        try{
            return new Pool({
                // host: 'pertamina-db.c1c6cu2im0v3.ap-southeast-2.rds.amazonaws.com',
                host: 'localhost',
                user: 'postgres',
                password : 'postgres',
                // password: 'PPPertamina1',
                database: 'pertamina',
                port: 5432,
                ssl :false
                // ssl: {
                //     rejectUnauthorized: false // Railway butuh SSL
                // }
            });
        }catch(err){
            return err
        }
    },
}
