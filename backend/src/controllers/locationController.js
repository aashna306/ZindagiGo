const nominatimService = require('../services/nominationService');

class LocationController {
  async reverseGeocode(req, res) {
    try {
      const { lat, lon } = req.query;
      
      if (!lat || !lon) {
        return res.status(400).json({ 
          error: 'Latitude and longitude are required' 
        });
      }

      const result = await nominatimService.reverseGeocode(
        parseFloat(lat), 
        parseFloat(lon)
      );

      res.json({
        success: true,
        data: result
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: error.message
      });
    }
  }

  async geocode(req, res) {
    try {
      const { address } = req.query;
      
      if (!address) {
        return res.status(400).json({ 
          error: 'Address is required' 
        });
      }

      const results = await nominatimService.geocode(address);

      res.json({
        success: true,
        data: results
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: error.message
      });
    }
  }
}

module.exports = new LocationController();
