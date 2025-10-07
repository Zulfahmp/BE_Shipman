const { Pool } = require('pg');
require('dotenv').config(); // Loa
module.exports = {
    DBP: () => {
        try{
            return new Pool({
                host: 'pertamina.c1c6cu2im0v3.ap-southeast-2.rds.amazonaws.com',
                user: 'postgres',
                password: 'PPPertamina1',
                database: 'pertamina',
                port: 5432,
                ssl: {
                    rejectUnauthorized: false // Railway butuh SSL
                }
            });
        }catch(err){
            return err
        }
    },
}
