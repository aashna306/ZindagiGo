const mongoose = require('mongoose');

const exerciseSchema = new mongoose.Schema({
  name: String,
  duration: Number, // minutes
  purpose: String,
  caution: String,
  video: String,
  completed: { type: Boolean, default: false },
  isCustom: { type: Boolean, default: false }
}, { _id: false });

const fitnessLogSchema = new mongoose.Schema({
  firebaseUID: { type: String, required: true },
  date: { type: String, required: true }, // YYYY-MM-DD
  steps: { type: Number, default: 0 },
  sleepHours: { type: Number, default: 0 },
  distanceKm: { type: Number, default: 0 },
  notes: { type: String, default: '' },
  exercises: [exerciseSchema]
}, { timestamps: true });

fitnessLogSchema.index({ firebaseUID: 1, date: 1 }, { unique: true });

module.exports = mongoose.model('FitnessLog', fitnessLogSchema);
