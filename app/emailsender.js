import nodemailer from "nodemailer";

// Buat transporter (pakai Gmail misalnya)
let transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "",
    pass: "", // bukan password asli, tapi App Password Gmail
  },
});

// Kirim email
async function sendEmail(to, subject, html) {
  try {
    let info = await transporter.sendMail({
      from: '"RENMAILER',
      to: to,
      subject: subject,
      //   text: "Halo, ini pesan plain text!",
      html: html,
    });
    return true;
    // return info.messageId;
  } catch (err) {
    return false;
  }
}
export { sendEmail };
