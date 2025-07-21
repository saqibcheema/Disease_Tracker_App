class ApiConstants {
  static const String tyleUrl = 'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=Q4N44CTfsLhxYS43Rirb';
  static const String routingApiUrl = 'https://router.project-osrm.org/route/v1/driving/' ;
  static const String baseUrlCovidApi = 'https://disease.sh/v3/covid-19/';
  static String getNearbyHospitals(double lat, double lon, {int radius = 10000}) {
    return 'https://overpass-api.de/api/interpreter?data='
        '[out:json];node(around:$radius,$lat,$lon)[amenity=hospital];out;';
  }
}
