const express = require('express');
const router = express.Router();
const locationController = require('../controllers/locationController');

// GET /api/location/reverse?lat=40.7128&lon=-74.0060
router.get('/reverse', locationController.reverseGeocode);

// GET /api/location/geocode?address=New York City
router.get('/geocode', locationController.geocode);

module.exports = router;
