class Hospital {
  final String name;
  final double lat;
  final double lon;
  final String address;
  final String rating;
  final List<String> services;
  final String openingTime;
  final String phone;

  Hospital({
    required this.name,
    required this.lat,
    required this.lon,
    required this.address,
    required this.rating,
    required this.services,
    required this.openingTime,
    required this.phone,
  });
}