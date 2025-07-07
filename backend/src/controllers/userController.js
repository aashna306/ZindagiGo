const admin = require("firebase-admin");
const User = require("../models/userModel");
const generatePassword = require("../utils/generatePassword");
const sendCaretakerEmail = require("../utils/sendCaretakerEmail");

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
    // const firebaseUID = 'test-elderly-uid-123';


    let user = await User.findOne({ firebaseUID });

    if (user) {
      user.fcmToken = fcmToken;

      if (!user.hasCaretaker && caretakerEmail) {
        const tempPassword = generatePassword();

        try {
          const caretakerUserRecord = await admin.auth().createUser({
            email: caretakerEmail,
            password: tempPassword
          });

          const caretakerRecord = new User({
            firebaseUID: caretakerUserRecord.uid,
            email: caretakerEmail,
            role: 'caretaker'
          });

          await caretakerRecord.save();

          user.caretakerId = caretakerRecord._id;
          user.hasCaretaker = true;
          user.caretakerEmail = caretakerEmail;
          await user.save();

          await sendCaretakerEmail(caretakerEmail, caretakerEmail, tempPassword);
        } catch (err) {
          console.warn("Caretaker account creation error (update case):", err);
        }
      } else {
        await user.save(); // just update fcmToken
      }

      return res.status(200).json({ message: "User updated successfully" });
    }


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
      let caretakerRecord;

      try {
        const caretakerUserRecord = await admin.auth().createUser({
          email: caretakerEmail,
          password: tempPassword
        });

        caretakerRecord = new User({
          firebaseUID: caretakerUserRecord.uid,
          email: caretakerEmail,
          role: 'caretaker'
        });

        await caretakerRecord.save();

        elderlyUser.caretakerId = caretakerRecord._id;
        await elderlyUser.save();

        await sendCaretakerEmail(caretakerEmail, caretakerEmail, tempPassword);
      } catch (err) {
        console.warn("Caretaker account creation error:", err);
      }
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

module.exports = { saveUser, changeCaretaker};
