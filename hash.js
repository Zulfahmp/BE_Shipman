const bcrypt = require("bcrypt");

const password = "Prams2208+";

bcrypt.hash(password, 10).then((hash) => {
  console.log("HASH:", hash);
});
