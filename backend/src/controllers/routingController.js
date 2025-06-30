const routingService = require('../services/routingService');

class RoutingController {
  async getRoute(req, res) {
    try {
      const { startLat, startLon, endLat, endLon, profile = 'foot-walking' } = req.query;
      
      if (!startLat || !startLon || !endLat || !endLon) {
        return res.status(400).json({ 
          error: 'Start and end coordinates are required' 
        });
      }

      const route = await routingService.getRoute(
        parseFloat(startLat),
        parseFloat(startLon),
        parseFloat(endLat),
        parseFloat(endLon),
        profile
      );

      // Generate elderly-friendly instructions
      const elderlyInstructions = routingService.generateElderlyFriendlyInstructions(
        route.instructions
      );

      res.json({
        success: true,
        data: {
          ...route,
          elderlyInstructions: elderlyInstructions
        }
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: error.message
      });
    }
  }

  async getWalkingRoute(req, res) {
    req.query.profile = 'foot-walking';
    return this.getRoute(req, res);
  }

  async getDrivingRoute(req, res) {
    req.query.profile = 'driving-car';
    return this.getRoute(req, res);
  }
}

module.exports = new RoutingController();
