function validation(req, res, next) {
  authorization = req.headers["vrapi_token"];
  // if(!req.headers['authorization']){
  //     res.status(403).send({message:'Forbidden Here!'})
  //     return
  // }
  if (
    authorization != process.env.VRAPI_TOKEN &&
    process.env.TOKEN_ACTIVE == "true"
  ) {
    res.status(401).send({ status: 401, message: "Token Invalid!" });
  } else {
    next();
  }
}

module.exports = validation;
