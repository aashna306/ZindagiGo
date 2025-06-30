const axios = require('axios');
const NodeCache = require('node-cache');

const cache = new NodeCache({ stdTTL: 1800 });

class NominatimService {
  constructor() {
    this.baseURL = 'https://nominatim.openstreetmap.org';
    this.headers = {
      'User-Agent': 'ZindagiGo-ElderlyApp/1.0 (contact@zindagigo.com)'
    };
  }

  async reverseGeocode(lat, lon) {
    const cacheKey = `reverse_${lat}_${lon}`;
    const cached = cache.get(cacheKey);
    
    if (cached) {
      return cached;
    }

    try {
      const response = await axios.get(`${this.baseURL}/reverse`, {
        params: {
          lat: lat,
          lon: lon,
          format: 'json',
          zoom: 18,
          addressdetails: 1
        },
        headers: this.headers
      });

      const result = {
        address: response.data.display_name,
        details: response.data.address || {}
      };

      cache.set(cacheKey, result);
      return result;
    } catch (error) {
      console.error('Reverse geocoding error:', error.message);
      throw new Error('Unable to get address information');
    }
  }

  async geocode(address) {
    const cacheKey = `geocode_${address}`;
    const cached = cache.get(cacheKey);
    
    if (cached) {
      return cached;
    }

    try {
      const response = await axios.get(`${this.baseURL}/search`, {
        params: {
          q: address,
          format: 'json',
          limit: 5,
          addressdetails: 1
        },
        headers: this.headers
      });

      const results = response.data.map(item => ({
        lat: parseFloat(item.lat),
        lon: parseFloat(item.lon),
        display_name: item.display_name,
        address: item.address || {}
      }));

      cache.set(cacheKey, results);
      return results;
    } catch (error) {
      console.error('Geocoding error:', error.message);
      throw new Error('Unable to find location');
    }
  }
}

module.exports = new NominatimService();
