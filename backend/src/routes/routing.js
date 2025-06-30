const express = require('express');
const router = express.Router();
const routingController = require('../controllers/routingController');

// GET /api/routing/route?startLat=40.7128&startLon=-74.0060&endLat=40.7589&endLon=-73.9851
router.get('/route', routingController.getRoute);

// GET /api/routing/walking?startLat=40.7128&startLon=-74.0060&endLat=40.7589&endLon=-73.9851
router.get('/walking',(req, res) => routingController.getWalkingRoute(req, res));

// GET /api/routing/driving?startLat=40.7128&startLon=-74.0060&endLat=40.7589&endLon=-73.9851
router.get('/driving', (req, res) => routingController.getDrivingRoute(req, res));

module.exports = router;
