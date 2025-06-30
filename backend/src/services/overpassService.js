const axios = require('axios');
const NodeCache = require('node-cache');

const cache = new NodeCache({ stdTTL: 3600 });

class OverpassService {
  constructor() {
    this.baseURL = 'https://overpass-api.de/api/interpreter';
    this.elderlyRelevantAmenities = {
      hospitals: ['hospital', 'clinic', 'doctors'],
      pharmacies: ['pharmacy'],
      grocery: ['supermarket', 'convenience', 'grocery'],
      emergency: ['police', 'fire_station'],
      transport: ['bus_station', 'taxi'],
      banks: ['bank', 'atm'],
      religious: ['place_of_worship']
    };
  }

  async findNearbyPlaces(lat, lon, category = 'all', radius = 2000) {
    const cacheKey = `places_${lat}_${lon}_${category}_${radius}`;
    const cached = cache.get(cacheKey);
    
    if (cached) {
      return cached;
    }

    try {
      const amenities = category === 'all' 
        ? Object.values(this.elderlyRelevantAmenities).flat()
        : this.elderlyRelevantAmenities[category] || [category];

      const amenityFilter = amenities.map(amenity => `"amenity"="${amenity}"`).join('|');
      
      const overpassQuery = `
        [out:json][timeout:25];
        (
          node["amenity"~"${amenities.join('|')}"](around:${radius},${lat},${lon});
          way["amenity"~"${amenities.join('|')}"](around:${radius},${lat},${lon});
          relation["amenity"~"${amenities.join('|')}"](around:${radius},${lat},${lon});
        );
        out center meta;
      `;

      const response = await axios.post(this.baseURL, overpassQuery, {
        headers: {
          'Content-Type': 'text/plain',
          'User-Agent': 'ZindagiGo-ElderlyApp/1.0'
        },
        timeout: 30000
      });

      const places = this.processOverpassResponse(response.data, lat, lon);
      
      cache.set(cacheKey, places);
      return places;
    } catch (error) {
      console.error('Overpass API error:', error.message);
      throw new Error('Unable to fetch nearby places');
    }
  }

  processOverpassResponse(data, userLat, userLon) {
    if (!data.elements) return [];

    return data.elements
      .filter(element => element.tags && element.tags.name)
      .map(element => {
        const lat = element.lat || (element.center && element.center.lat);
        const lon = element.lon || (element.center && element.center.lon);
        
        if (!lat || !lon) return null;

        const distance = this.calculateDistance(userLat, userLon, lat, lon);
        
        return {
          id: element.id,
          name: element.tags.name,
          amenity: element.tags.amenity,
          category: this.categorizeAmenity(element.tags.amenity),
          lat: lat,
          lon: lon,
          distance: Math.round(distance),
          address: this.formatAddress(element.tags),
          phone: element.tags.phone || null,
          wheelchair: element.tags.wheelchair || 'unknown',
          opening_hours: element.tags.opening_hours || null
        };
      })
      .filter(place => place !== null)
      .sort((a, b) => a.distance - b.distance)
      .slice(0, 20); 
  }

  categorizeAmenity(amenity) {
    for (const [category, amenities] of Object.entries(this.elderlyRelevantAmenities)) {
      if (amenities.includes(amenity)) {
        return category;
      }
    }
    return 'other';
  }

  formatAddress(tags) {
    const parts = [];
    if (tags['addr:housenumber']) parts.push(tags['addr:housenumber']);
    if (tags['addr:street']) parts.push(tags['addr:street']);
    if (tags['addr:city']) parts.push(tags['addr:city']);
    return parts.join(', ') || 'Address not available';
  }

  calculateDistance(lat1, lon1, lat2, lon2) {
    const R = 6371e3; 
    const φ1 = lat1 * Math.PI/180;
    const φ2 = lat2 * Math.PI/180;
    const Δφ = (lat2-lat1) * Math.PI/180;
    const Δλ = (lon2-lon1) * Math.PI/180;

    const a = Math.sin(Δφ/2) * Math.sin(Δφ/2) +
              Math.cos(φ1) * Math.cos(φ2) *
              Math.sin(Δλ/2) * Math.sin(Δλ/2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));

    return R * c;
  }

  async findEmergencyServices(lat, lon) {
    return await this.findNearbyPlaces(lat, lon, 'emergency', 5000);
  }
}

module.exports = new OverpassService();
