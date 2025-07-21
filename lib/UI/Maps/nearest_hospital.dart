import 'dart:convert';
import 'package:disease_tracker_app/Components/app_colors.dart';
import 'package:disease_tracker_app/Components/text_style.dart';
import 'package:disease_tracker_app/Components/zoomableWidget.dart';
import 'package:disease_tracker_app/Models/custom_marker.dart';
import 'package:flutter/material.dart' hide FutureBuilder;
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:disease_tracker_app/API/apis_Urls.dart';
import 'package:http/http.dart' as http;
import '../../Models/NearestHospital.dart';
import 'hospitalsdetail.dart';

class NearestHospital extends StatefulWidget {
  const NearestHospital({super.key});

  @override
  State<NearestHospital> createState() => _NearestHospitalState();
}

class _NearestHospitalState extends State<NearestHospital>
    with SingleTickerProviderStateMixin {
  MapController _mapController = MapController();
  late LatLng currentScreen;
  late LatLng currentPosition;
  List<CustomMarker> markerPosition = [];
  late AnimationController _animationController;
  late Tween<double> _latTween;
  late Tween<double> _lngTween;
  late Future<List<Hospital>> hospitalsFuture;
  late double lati;
  late double longi;
  List<LatLng> routePoints = [];
  bool isRouteVisible = false;




  void _animateMap(LatLng from, LatLng to) {
    _latTween = Tween<double>(begin: from.latitude, end: to.latitude);
    _lngTween = Tween<double>(begin: from.longitude, end: to.longitude);

    _animationController.reset();
    _animationController.addListener(() {
      var lat = _latTween.evaluate(_animationController);
      var lng = _lngTween.evaluate(_animationController);
      _mapController.move(LatLng(lat, lng), _mapController.camera.zoom);
    });
    _animationController.forward();
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition();
  }

  List<Marker> getMarker() {
    return markerPosition.map((pos) {
      return Marker(
        height: 40,
        width: 40,
        point: pos.position,
        child: Icon(Icons.location_pin, color: pos.color),
      );
    }).toList();
  }


  Future<void> loadUserLocationOnMap() async {
    try {
      Position value = await getUserCurrentLocation();
      currentScreen = _mapController.camera.center;
      currentPosition = LatLng(value.latitude, value.longitude);
      setState(() {
        markerPosition.add(
          CustomMarker(
            position: currentPosition,
            title: 'MY Current Position',
            color: Colors.blue
          ),
        );
        _animateMap(currentScreen, currentPosition);
      });
    } catch (e) {
      print("Error in loading user location: $e");
    }
  }

  Future<List<Hospital>> getNearbyHospitals() async {
    List<Hospital> hospitalList = [];
    Position userLocation = await getUserCurrentLocation();
    double lat = userLocation.latitude;
    double lng = userLocation.longitude;

    final url = ApiConstants.getNearbyHospitals(lat, lng);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      final List elements = data['elements'];
      for (var e in elements) {
        final tags = e['tags'] ?? {};
        lati = e['lat'];
        longi = e['lon'];
        hospitalList.add(
          Hospital(
            name: tags['name'],
            lat: lati,
            lon: longi,
            address: tags['addr:street'] != null || tags['addr:city:en'] != null
                ? "${tags['addr:street'] ?? ''}, ${tags['addr:city'] ?? ''}"
                : "${tags['name'] ?? 'Unknown Hospital'}, Wazirabad",
            rating: '4.3',
            services: [
              'Emergency',
              'Opd',
              "Blood Bank",
              "Pharmacy",
              "Ambulance Service",
              "ICU (Intensive Care Unit)",
            ],
            openingTime: 'N/A',
            phone: 'N/A',
          ),
        );
        markerPosition.add(CustomMarker(position: LatLng(lati, longi)));
      }

    }
    return hospitalList;
  }

  void drawRouteToHospital(Hospital hospital) async {
    try {
      Position userLocation = await getUserCurrentLocation();
      LatLng userLatLng = LatLng(userLocation.latitude, userLocation.longitude);
      LatLng hospitalLatLng = LatLng(hospital.lat, hospital.lon);

      final url =
         'https://router.project-osrm.org/route/v1/driving/${userLatLng.longitude},${userLatLng.latitude};${hospitalLatLng.longitude},${hospitalLatLng.latitude}?overview=full&geometries=geojson';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final coords = data['routes'][0]['geometry']['coordinates'] as List;

        List<LatLng> newRoute = coords
            .map((c) => LatLng(c[1], c[0])) // convert [lon, lat] to LatLng
            .toList();

        setState(() {
          routePoints = newRoute;
          isRouteVisible = true;
        });

        _mapController.move(
          newRoute[(newRoute.length / 2).floor()],
          13.5,
        );
      } else {
        print('Failed to load route');
      }
    } catch (e) {
      print('Error loading route: $e');
    }
  }



  void cancelRoute() {
    setState(() {
      routePoints = [];
      isRouteVisible = false;
    });
  }


  @override
  void initState() {
    super.initState();
    loadUserLocationOnMap();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    hospitalsFuture = getNearbyHospitals();
  }

  Widget sectionTitle(String title, {bool second = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.poppinsBold.copyWith(
            fontSize: 16,
            color: AppColors.secondary1,
          ),
        ),
        ZoomableWidget(
          child: Container(
            height: 29,
            width: 85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: second ? Colors.white : AppColors.primary1,
              border: second ? Border.all(color: AppColors.primary1, width: 2.0) : null,
            ),
            child: Center(
              child: Text(
                'View all',
                style: AppTextStyles.poppinsSemiBold.copyWith(
                  fontSize: 10,
                  color: second ? AppColors.primary1 : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(


    physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
            pinned: true,
            stretch: true,

            onStretchTrigger: () async {
              await loadUserLocationOnMap();
              setState(() {
                print('Load the map');
                hospitalsFuture = getNearbyHospitals();
              });
            },
            expandedHeight: 180,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],

              title: Text(
                'Nearest Hospital',
                style: AppTextStyles.poppinsBold.copyWith(
                  fontSize: 18,
                  color: AppColors.secondary1,
                ),
              ),
              background: Container(
                color: AppColors.primary1,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Select the hospital nearest to you in the case of emergency.',
                      style: AppTextStyles.poppinsMedium.copyWith(
                        fontSize: 10,
                        color: AppColors.secondary2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ZoomableWidget(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.27,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Stack(
                        children: [
                          FlutterMap(
                            mapController: _mapController,
                            options: MapOptions(
                              initialCenter: LatLng(33.6844, 73.0479),
                              initialZoom: 11.0,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate: ApiConstants.tyleUrl ,
                                userAgentPackageName: 'com.example.disease_tracker_app',
                              ),
                              MarkerLayer(markers: getMarker()),
                              PolylineLayer(
                                polylineCulling: false,
                                polylines: isRouteVisible
                                    ? [
                                  Polyline(
                                    points: routePoints,
                                    strokeWidth: 4.0,
                                    color: Colors.blue,
                                  ),
                                ]
                                    : [],
                              ),
                            ],
                          ),

                          if (isRouteVisible)
                            Positioned(
                              top: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: cancelRoute,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Icon(Icons.close, color: Colors.white, size: 20),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: sectionTitle('Nearest Hospitals'),
                  ),
                  HospitalListWidget(
                    fetchHospitals: () => hospitalsFuture,
                    onDrawRoute: drawRouteToHospital,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: sectionTitle('Popular Hospitals', second: true),
                  ),
                  HospitalListWidget(
                    fetchHospitals: () => hospitalsFuture,
                    onDrawRoute: drawRouteToHospital,
                  ),
                  SizedBox(height: 200,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
