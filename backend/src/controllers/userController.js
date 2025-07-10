const admin = require("firebase-admin");
const User = require("../models/userModel");
const generatePassword = require("../utils/generatePassword");
const sendCaretakerEmail = require("../utils/sendCaretakerEmail");

// 
const saveUser = async (req, res) => {
  try {
    const {
      token,
      name,
      dob,
      gender,
      phone,
      email,
      emergencyContact,
      caretakerEmail,
      fcmToken
    } = req.body;

    const decodedToken = await admin.auth().verifyIdToken(token);
    const firebaseUID = decodedToken.uid;

    let user = await User.findOne({ firebaseUID });

    if (user) {
      user.fcmToken = fcmToken;

      if (!user.hasCaretaker && caretakerEmail) {
        const tempPassword = generatePassword();
        let caretakerUserRecord;

        try {
          caretakerUserRecord = await admin.auth().createUser({
            email: caretakerEmail,
            password: tempPassword
          });
          console.log("✅ Created new Firebase caretaker:", caretakerUserRecord.uid);
        } catch (err) {
          if (err.code === 'auth/email-already-exists') {
            console.warn("⚠️ Caretaker email already exists, reusing it");
            caretakerUserRecord = await admin.auth().getUserByEmail(caretakerEmail);
          } else {
            console.error("❌ Unhandled caretaker create error:", err);
            throw err; // stop if unexpected error
          }
        }

        let caretakerRecord = await User.findOne({ firebaseUID: caretakerUserRecord.uid });
        if (!caretakerRecord) {
          caretakerRecord = new User({
            firebaseUID: caretakerUserRecord.uid,
            email: caretakerEmail,
            role: 'caretaker'
          });
          await caretakerRecord.save();
        }

        user.caretakerId = caretakerRecord._id;
        user.hasCaretaker = true;
        user.caretakerEmail = caretakerEmail;
        await user.save();

        await sendCaretakerEmail(caretakerEmail, caretakerEmail, tempPassword);
      } else {
        await user.save(); // just update fcmToken
      }

      return res.status(200).json({ message: "User updated successfully" });
    }

    // If user does not exist — create elderly
    const elderlyUser = new User({
      firebaseUID,
      name,
      dob,
      gender,
      phone,
      email,
      emergencyContact,
      fcmToken,
      role: 'elderly',
      hasCaretaker: !!caretakerEmail,
      caretakerEmail
    });

    await elderlyUser.save();

    if (caretakerEmail) {
      const tempPassword = generatePassword();
      let caretakerUserRecord;

      try {
        caretakerUserRecord = await admin.auth().createUser({
          email: caretakerEmail,
          password: tempPassword
        });
      } catch (err) {
        if (err.code === 'auth/email-already-exists') {
          caretakerUserRecord = await admin.auth().getUserByEmail(caretakerEmail);
        } else {
          console.error("❌ Caretaker create error:", err);
          throw err;
        }
      }

      let caretakerRecord = await User.findOne({ firebaseUID: caretakerUserRecord.uid });
      if (!caretakerRecord) {
        caretakerRecord = new User({
          firebaseUID: caretakerUserRecord.uid,
          email: caretakerEmail,
          role: 'caretaker'
        });
        await caretakerRecord.save();
      }

      elderlyUser.caretakerId = caretakerRecord._id;
      await elderlyUser.save();

      await sendCaretakerEmail(caretakerEmail, caretakerEmail, tempPassword);
    }

    res.status(201).json({ message: "User saved successfully" });

  } catch (error) {
    console.error(error);
    res.status(400).json({ error: error.message });
  }
};

const changeCaretaker = async (req, res) => {
  const { caretakerEmail } = req.body;

  if (!caretakerEmail) return res.status(400).json({ error: "Email required" });

  try {
    const tempPassword = generatePassword();

    const userRecord = await admin.auth().getUserByEmail(caretakerEmail);
    await admin.auth().updateUser(userRecord.uid, { password: tempPassword });

    await sendCaretakerEmail(caretakerEmail, caretakerEmail, tempPassword);

    res.json({ message: "Caretaker credentials reset and resent successfully" });
  } catch (error) {
    console.error("Error resetting caretaker credentials:", error);
    res.status(500).json({ error: "Failed to resend credentials" });
  }
};


const login = async (req, res) => {
  try {
    const { token } = req.body;
    const decodedToken = await admin.auth().verifyIdToken(token);
    const firebaseUID = decodedToken.uid;

    const user = await User.findOne({ firebaseUID });

    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    // If user is caretaker, get linked elderly's UID
    if (user.role === 'caretaker') {
      const elderly = await User.findOne({ caretakerId: user._id });
      // print(elderly);
      if (!elderly) {
        return res.status(404).json({ error: "Elderly user not linked to caretaker" });
      }

      return res.status(200).json({
        role: "caretaker",
        elderlyUID: elderly.firebaseUID,
        name: user.name || '', // optional
      });
    }

    // If user is elderly
    // return res.status(200).json({
    //   role: "elderly",
    //   firebaseUID,
    //   name: user.name || '', // optional
    // });

  } catch (error) {
    console.error("Login error:", error);
    return res.status(500).json({ error: "Internal Server Error" });
  }
};

module.exports = { saveUser, changeCaretaker,login};
