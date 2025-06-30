const overpassService = require('../services/overpassService');

class PlacesController {
  async getNearbyPlaces(req, res) {
    try {
      const { lat, lon, category = 'all', radius = 2000 } = req.query;
      
      if (!lat || !lon) {
        return res.status(400).json({ 
          error: 'Latitude and longitude are required' 
        });
      }

      const places = await overpassService.findNearbyPlaces(
        parseFloat(lat), 
        parseFloat(lon), 
        category, 
        parseInt(radius)
      );

      res.json({
        success: true,
        data: places,
        count: places.length
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: error.message
      });
    }
  }

  async getEmergencyServices(req, res) {
    try {
      const { lat, lon } = req.query;
      
      if (!lat || !lon) {
        return res.status(400).json({ 
          error: 'Latitude and longitude are required' 
        });
      }

      const emergencyServices = await overpassService.findEmergencyServices(
        parseFloat(lat), 
        parseFloat(lon)
      );

      res.json({
        success: true,
        data: emergencyServices,
        count: emergencyServices.length
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: error.message
      });
    }
  }

  async getPlacesByCategory(req, res) {
    try {
      const { category } = req.params;
      const { lat, lon, radius = 2000 } = req.query;
      
      if (!lat || !lon) {
        return res.status(400).json({ 
          error: 'Latitude and longitude are required' 
        });
      }

      const places = await overpassService.findNearbyPlaces(
        parseFloat(lat), 
        parseFloat(lon), 
        category, 
        parseInt(radius)
      );

      res.json({
        success: true,
        data: places,
        category: category,
        count: places.length
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: error.message
      });
    }
  }
}

module.exports = new PlacesController();
