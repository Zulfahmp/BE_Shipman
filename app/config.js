require('dotenv').config()
var express = require('express');
var app = express();
const cors = require('cors');
var path = require('path');

const allowedOrigins = [
  'http://localhost:5173',
];

const corsOptions = {
  origin: function (origin, callback) {
      if (!origin || allowedOrigins.indexOf(origin) !== -1) {
          callback(null, true);
      } else {
          callback(new Error(403), false);
      }
  },
  methods: ['GET', 'POST', 'PUT', 'DELETE','OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization','vrapi_token'],
};

app.use(cors(corsOptions));
app.use(express.static(path.join(__dirname, 'public')));
app.use('/nf', express.static(path.join(__dirname, '../public/nf')));
app.use(express.json({ limit: '1mb' }));
app.use(express.urlencoded({ extended: true, limit: '200mb' }));
app.use('/error', require('../errors.js'))

app.use((err, req, res, next) => {
  if(err.message==403){
    res.status(403).send({status:403, message: 'Forbidden Here!'})
  }else{
    next()
  }
})

function startServer(){
  app.use((req, res, next) => {
    res.status(404).json({status:404,message: 'Not Found!'});
  });
  app.listen(process.env.PORT || 3000,'0.0.0.0', async() => {
    console.log('Server is running',process.env.PORT);
  });
}

module.exports={
    app:app,
    path:path,
    express : express,
    startServer : startServer
}
