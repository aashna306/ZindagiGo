const express = require('express');
const router = express.Router();
const fitnessController = require('../controllers/fitnessController');

router.post('/recommend', fitnessController.recommendExercises);
router.post('/log', fitnessController.logFitnessData);
router.patch('/exercise-check', fitnessController.markExerciseDone);
router.get('/logs', fitnessController.getFitnessLogs);
router.get('/summary-text', fitnessController.generateFitnessSummaryText);

module.exports = router;
