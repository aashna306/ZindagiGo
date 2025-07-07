const nodemailer = require("nodemailer");

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.APP_EMAIL,
    pass: process.env.APP_PASSWORD
  }
});

const sendCaretakerEmail = async (to, email, password) => {
  await transporter.sendMail({
    from: process.env.APP_EMAIL,
    to,
    subject: "ZindagiGo Caretaker Account Credentials",
    html: `<p>You have been registered as a caretaker on ZindagiGo.</p>
           <p><strong>Email:</strong> ${email}</p>
           <p><strong>Temporary Password:</strong> ${password}</p>
           <p>Please login and change your password after first login.</p>`
  });
};

module.exports = sendCaretakerEmail;
