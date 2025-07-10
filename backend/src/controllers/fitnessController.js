const { GoogleGenerativeAI } = require('@google/generative-ai');
const admin = require('firebase-admin');
const FitnessLog = require('../models/fitnessLogModel');
const MedicalRecord = require('../models/medicalRecordModel');
const User = require('../models/userModel');
const mongoose = require('mongoose');

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API);
const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });

// test middleware
// // const verifyToken = async (req, res, next) => {
// //   req.user = { uid: 'test-firebase-uid-123' };
// //   next();
// // };

const verifyToken = async (req, res, next) => {
    try {
        const idToken = req.headers.authorization?.split('Bearer ')[1];
        if (!idToken) {
            console.error("No token provided in request headers");
            return res.status(401).json({ error: 'No token provided' });
        }
        const decodedToken = await admin.auth().verifyIdToken(idToken);
        req.user = decodedToken;
        next();
    } catch (error) {
        console.error("Invalid token error:", error);
        res.status(401).json({ error: 'Invalid token' });
    }
};

const getAge = (dobStr) => {
    const dob = new Date(dobStr);
    const ageDifMs = Date.now() - dob.getTime();
    return Math.floor(ageDifMs / (1000 * 60 * 60 * 24 * 365.25));
};


exports.recommendExercises = [
  verifyToken,
  async (req, res) => {
    try {
      const firebaseUID = req.user.uid;

      // Fetch user details
      // const user = await mongoose.connection
      //   .collection("users")
      //   .findOne({ firebaseUID });
      const user = await User.findOne({ firebaseUID });


      if (!user) throw new Error("User not found");
      if (!user.dob || !user.gender)
        throw new Error("Missing user DOB or gender");

      const age = getAge(user.dob);
      const gender = user.gender;

      // Check for medical record
      const latestRecord = await mongoose.connection
        .collection("medicalrecords")
        .findOne(
          {
            firebaseUID,
            category: { $in: ["medical_history", "prescription"] },
          },
          { sort: { createdAt: -1 } }
        );

      // Build prompt
      let prompt = "";
      if (!latestRecord) {
        prompt = `Suggest 3–5 simple and safe daily exercises for a ${age}-year-old ${gender} senior citizen with no known medical conditions. 
Return only a JSON array with the following structure:
[
  {
    "exercise": "",
    "duration": 15,
    "purpose": "",
    "caution": "",
    "video": ""
  }
]`;
      } else {
        prompt = `Suggest 3–5 simple and safe exercises for a ${age}-year-old ${gender} elderly user based on this condition:
${latestRecord.processedText}

Return only a JSON array with the following structure:
[
  {
    "exercise": "",
    "duration": 15,
    "purpose": "",
    "caution": "",
    "video": ""
  }
]`;
      }

      // Call Gemini
      const result = await model.generateContent(prompt);
      const raw = (await result.response).text();
      console.log("Gemini Output:", raw);

      // Extract JSON
      const match = raw.match(/\[\s*\{[\s\S]*?\}\s*\]/);
      if (!match) throw new Error("No JSON array found in Gemini output.");

      const parsed = JSON.parse(match[0]);

      // Validate parsed structure
      if (
        !Array.isArray(parsed) ||
        parsed.some(
          (item) =>
            !item.exercise?.trim() || !item.purpose?.trim()
        )
      ) {
        throw new Error("Incomplete Gemini data");
      }

      // Map cleaned output
      const cleaned = parsed.map((item) => ({
        exercise: item.exercise || "Not specified",
        duration: item.duration || 15,
        purpose: item.purpose || "General well-being",
        caution: item.caution || "None",
        video: item.video || "",
      }));

      return res.status(200).json({ success: true, data: cleaned });

    } catch (error) {
      console.warn("Error in recommendExercises:", error);
      return res.status(500).json({
        success: false,
        message: "Failed to get exercise recommendations",
        error: error.message,
      });
    }
  },
];


exports.recommendYoga = [
  verifyToken,
  async (req, res) => {
    try {
      const firebaseUID = req.user.uid;

      // Fetch user details
      // const user = await mongoose.connection
      //   .collection("users")
      //   .findOne({ firebaseUID });
const user = await User.findOne({ firebaseUID });

      if (!user) throw new Error("User not found");

      if (!user.dob || !user.gender)
        throw new Error("Missing user DOB or gender");

      const age = getAge(user.dob);
      const gender = user.gender;

      // Check for medical record
      const latestRecord = await mongoose.connection
        .collection("medicalrecords")
        .findOne(
          {
            firebaseUID,
            category: { $in: ["medical_history", "prescription"] },
          },
          { sort: { createdAt: -1 } }
        );

      // Build prompt
      let prompt = "";
      if (!latestRecord) {
        prompt = `Suggest 3–5 simple and safe daily yoga exercises for a ${age}-year-old ${gender} senior citizen with no known medical conditions. 
Return only a JSON array with the following structure:
[
  {
    "yoga": "",
    "duration": 15,
    "purpose": "",
    "caution": "",
    "video": ""
  }
]`;
      } else {
        prompt = `Suggest 3–5 simple and safe yoga exercises for a ${age}-year-old ${gender} elderly user based on this condition:
${latestRecord.processedText}

Return only a JSON array with the following structure:
[
  {
    "yoga": "",
    "duration": 15,
    "purpose": "",
    "caution": "",
    "video": ""
  }
]`;
      }

      // Call Gemini
      const result = await model.generateContent(prompt);
      const raw = (await result.response).text();
      console.log("Gemini Output:", raw);

      // Extract JSON
      const match = raw.match(/\[\s*\{[\s\S]*?\}\s*\]/);
      if (!match) throw new Error("No JSON array found in Gemini output.");

      const parsed = JSON.parse(match[0]);

      if (!Array.isArray(parsed) || parsed.some(item => !item.yoga || !item.purpose)) {
        throw new Error("Incomplete Gemini data");
      }

      const cleaned = parsed.map(item => ({
        yoga: item.yoga || "Not specified",
        duration: item.duration || 15,
        purpose: item.purpose || "General well-being",
        caution: item.caution || "None",
        video: item.video || ""
      }));

      return res.status(200).json({ success: true, data: cleaned });

    } catch (error) {
      console.warn("Error in recommendYoga:", error);
      return res
        .status(500)
        .json({ success: false, message: "Failed to get yoga recommendations", error: error.message });
    }
  }
];






exports.recommendDiet = [
    verifyToken,
    async (req, res) => {
        try {
            const firebaseUID = req.user.uid;

      // Fetch user details
      // const user = await mongoose.connection
      //   .collection("users")
      //   .findOne({ firebaseUID });

const user = await User.findOne({ firebaseUID });

      if (!user) throw new Error("User not found");

      if (!user.dob || !user.gender)
        throw new Error("Missing user DOB or gender");

      const age = getAge(user.dob);
      const gender = user.gender;

      // Check for medical record
      const latestRecord = await mongoose.connection
        .collection("medicalrecords")
        .findOne(
          {
            firebaseUID,
            category: { $in: ["medical_history", "prescription"] },
          },
          { sort: { createdAt: -1 } }
        );

      // Build prompt
      let prompt = "";
            if (!latestRecord) {
                prompt = `Suggest 3–5 simple, vegetarian and easy diets that could be made at home easily for a ${age}-year-old ${gender} senior citizen with no known medical conditions. Return a JSON array with:
Return only a JSON array with the following structure. Make sure each field is filled appropriately.
        [
  {
   "mealType": "",
  "timeofMeal": "",
  "items": "",
  "purpose": "",
  "caution": "",
  "note": ""
  }
]`;
            } else {
                prompt = `Suggest 3–5 simple, vegetarian and easy diets that could be made at home easily for an ${age}-year-old ${gender} elderly user based on this condition:
${latestRecord.processedText}

Return only a JSON array with the following structure. Make sure each field is filled appropriately.
[
 {
   "mealType": "",
  "timeofMeal": "",
  "items": "",
  "purpose": "",
  "caution": "",
  "note": ""
  }
]`;
            }

      const result = await model.generateContent(prompt);
      const raw = (await result.response).text();
      console.log("Gemini Output:", raw);

      // Extract JSON
      const match = raw.match(/\[\s*\{[\s\S]*?\}\s*\]/);
      if (!match) throw new Error("No JSON array found in Gemini output.");

      const parsed = JSON.parse(match[0]);

      if (!Array.isArray(parsed) || parsed.some(item =>
  !item.mealType?.trim() || !item.items?.trim() || !item.purpose?.trim()
)) {
  throw new Error("Incomplete Gemini data");
}
             


          

            const cleaned =parsed.map(item => ({
       mealType: item.mealType || "Not specified",
                    timeofMeal: item.timeofMeal || "Anytime",
                    items: item.items || "Milk, fruits,vegetables,nuts",
                    purpose: item.purpose || "General well-being",
                    caution: item.caution || "",
                    note: item.note || "",
      }));
          
      return res.status(200).json({ success: true, data: cleaned });

    } catch (error) {
      console.warn("Error in recommendDiet:", error);
      return res
        .status(500)
        .json({ success: false, message: "Failed to get diet recommendations", error: error.message });
    }
  }
];


exports.logFitnessData = [
    verifyToken,
    async (req, res) => {
        try {
            const firebaseUID = req.user.uid;
            const { date, steps, sleepHours, distanceKm, notes, exercises } = req.body;
            if (!date) return res.status(400).json({ success: false, message: 'Date is required' });
            const update = {};
            if (steps !== undefined) update.steps = steps;
            if (sleepHours !== undefined) update.sleepHours = sleepHours;
            if (distanceKm !== undefined) update.distanceKm = distanceKm;
            if (notes !== undefined) update.notes = notes;
            if (exercises !== undefined) update.exercises = exercises;

            const log = await FitnessLog.findOneAndUpdate(
                { firebaseUID, date },
                { $set: update },
                { upsert: true, new: true }
            );

            res.status(200).json({ success: true, data: log });
        } catch (error) {
            res.status(500).json({ success: false, message: 'Error logging data', error: error.message });
        }
    }
];


exports.markExerciseDone = [
    verifyToken,
    async (req, res) => {
        try {
            const firebaseUID = req.user.uid;
            const { date, exerciseName, completed } = req.body;
            const log = await FitnessLog.findOne({ firebaseUID, date });
            if (!log) return res.status(404).json({ success: false, message: 'Log not found' });

            const index = log.exercises.findIndex(e => e.name === exerciseName);
            if (index >= 0) {
                log.exercises[index].completed = completed;
                await log.save();
                return res.status(200).json({ success: true, data: log });
            } else {
                return res.status(404).json({ success: false, message: 'Exercise not found' });
            }
        } catch (error) {
            res.status(500).json({ success: false, message: 'Update failed', error: error.message });
        }
    }
];

exports.getFitnessLogs = [
    verifyToken,
    async (req, res) => {
        try {
            const firebaseUID = req.user.uid;
            const { start, end } = req.query;
            const query = { firebaseUID };

            if (start || end) query.date = {};
            if (start) query.date.$gte = start;
            if (end) query.date.$lte = end;

            const logs = await FitnessLog.find(query).sort({ date: 1 });
            res.status(200).json({ success: true, data: logs });
        } catch (error) {
            res.status(500).json({ success: false, message: 'Error fetching logs', error: error.message });
        }
    }
];

exports.generateFitnessSummaryText = [
    verifyToken,
    async (req, res) => {
        try {
            const firebaseUID = req.user.uid;
            const { start, end } = req.query;
            const logs = await FitnessLog.find({
                firebaseUID,
                ...(start || end ? { date: { ...(start && { $gte: start }), ...(end && { $lte: end }) } } : {})
            }).sort({ date: 1 });

            const context = logs.map(log => {
                return `Date: ${log.date}\nSteps: ${log.steps}, Sleep: ${log.sleepHours} hrs, Distance: ${log.distanceKm} km`;
            }).join('\n');

            const prompt = `Summarize this elderly person's weekly fitness log in a motivating, kind tone:\n\n${context}`;

            const result = await model.generateContent(prompt);
            const text = (await result.response).text();

            res.status(200).json({ success: true, summaryText: text });
        } catch (error) {
            res.status(500).json({ success: false, message: 'Summary failed', error: error.message });
        }
    }
];
