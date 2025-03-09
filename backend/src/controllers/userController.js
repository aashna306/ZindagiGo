const admin = require("firebase-admin");
const User = require("../models/userModel");

const saveUser = async (req, res) => {
  try {
    const { token, name, dob, gender, phone, email, emergencyContact } = req.body;

    const decodedToken = await admin.auth().verifyIdToken(token);
    const firebaseUID = decodedToken.uid;

    const newUser = new User({
      firebaseUID,
      name,
      dob,
      gender,
      phone,
      email,
      emergencyContact,
    });

    await newUser.save();
    res.status(201).json({ message: "User saved successfully" });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

exports.saveUser = saveUser;