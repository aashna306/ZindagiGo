const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  firebaseUID: String,
  name: String,
  dob: String,
  gender: String,
  phone: String,
  email: String,
  emergencyContact: String,
});
const User = mongoose.model("User", userSchema, "users");
module.exports = User;