import bcrypt from "bcrypt";
// hash password
async function hashPassword(password) {
  const saltRounds = 10; // semakin besar, semakin aman tapi lebih lambat
  const hashed = await bcrypt.hash(password, saltRounds);
  return hashed;
}

// cek password saat login
async function checkPassword(password, hashedPassword) {
  const match = await bcrypt.compare(password, hashedPassword);
  return match; // true kalau cocok
}

export { hashPassword, checkPassword };
