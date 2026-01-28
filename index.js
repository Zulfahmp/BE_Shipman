require('dotenv').config();

console.log('DB USER:', process.env.DB_USER);

console.log('DB NAME:', process.env.DB_NAME);

const { app, startServer } = require('./app/config.js');

// routes
app.use(require('./model/auth.js'));
app.use(require('./model/management_user.js'));
app.use(require('./model/master_ship.js'));
app.use(require('./model/master_port.js'));
app.use(require('./model/master_berth.js'));
app.use(require('./model/master_cargo.js'));
app.use(require('./model/master.js'));
app.use(require('./model/sscl_transaction.js'));
app.use(require('./model/negative_feedback.js'));

// root health check
app.get('/', (req, res) => {
  res.status(200).json({
    status: 200,
    message: 'API Shipman is running í ½íº€'
  });
});

// error handling (optional)
process.on('unhandledRejection', (err) => {
  console.error('Unhandled Rejection:', err);
});

process.on('uncaughtException', (err) => {
  console.error('Uncaught Exception:', err);
});

// START SERVER (SATU KALI SAJA)
startServer();
