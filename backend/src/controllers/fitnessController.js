const { GoogleGenerativeAI } = require('@google/generative-ai');
const admin = require('firebase-admin');
const FitnessLog = require('../models/fitnessLogModel');
const MedicalRecord = require('../models/medicalRecordModel');
const User = require('../models/userModel'); 

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
    if (!idToken) return res.status(401).json({ error: 'No token provided' });
    const decodedToken = await admin.auth().verifyIdToken(idToken);
    req.user = decodedToken;
    next();
  } catch (error) {
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
      const user = await User.findOne({ firebaseUID });
      const age = getAge(user.dob);
      const gender = user.gender;
      const latestRecord = await MedicalRecord.findOne({
        firebaseUID,
        category: { $in: ['medical_history', 'prescription'] },
      }).sort({ createdAt: -1 });

      let prompt;
      if (!latestRecord) {
        prompt = `Suggest 3–5 simple and safe daily exercises for a ${age}-year-old ${gender} senior citizen with no known medical conditions. Return a JSON array with:
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
        prompt = `Suggest 3–5 simple and safe exercises for an ${age}-year-old ${gender} elderly user based on this condition:
${latestRecord.processedText}

Return a JSON array with:
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

      const result = await model.generateContent(prompt);
      const raw = (await result.response).text();
      let parsed;
      try {
        const match = raw.match(/\[\s*\{[\s\S]*?\}\s*\]/); 
        if (!match) throw new Error("No JSON array found in Gemini output.");
        parsed = JSON.parse(match[0]);
      } catch (err) {
        console.warn("Invalid Gemini output:", raw);
        return res.status(500).json({
          success: false,
          message: 'Invalid Gemini response format',
          error: err.message,
          raw
        });
      }


      res.status(200).json({ success: true, data: parsed });
    } catch (error) {
      res.status(500).json({ success: false, message: 'Failed to get exercise recommendations', error: error.message });
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

      const log = await FitnessLog.findOneAndUpdate(
        { firebaseUID, date },
        {
          $set: {
            steps: steps || 0,
            sleepHours: sleepHours || 0,
            distanceKm: distanceKm || 0,
            notes: notes || '',
            exercises: exercises || []
          }
        },
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
