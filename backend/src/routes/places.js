const express = require('express');
const router = express.Router();
const placesController = require('../controllers/placesController');

// GET /api/places/nearby?lat=40.7128&lon=-74.0060&category=hospitals&radius=2000
router.get('/nearby', placesController.getNearbyPlaces);

// GET /api/places/emergency?lat=40.7128&lon=-74.0060
router.get('/emergency', placesController.getEmergencyServices);

// GET /api/places/category/hospitals?lat=40.7128&lon=-74.0060
router.get('/category/:category', placesController.getPlacesByCategory);

module.exports = router;
