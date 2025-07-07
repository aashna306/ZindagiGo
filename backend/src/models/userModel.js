const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  firebaseUID: String,
  name: String,
  dob: String,
  gender: String,
  phone: String,
  email: String,
  emergencyContact: String,
  fcmToken: String,
   role: { type: String, enum: ['elderly', 'caretaker'], default: 'elderly' },
  hasCaretaker: { type: Boolean, default: false },
  caretakerEmail: String,
  caretakerId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' }
});
const User = mongoose.model("User", userSchema, "users");
module.exports = User;
