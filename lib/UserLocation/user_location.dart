import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserLocation extends StatefulWidget {
  const UserLocation({super.key});

  @override
  State<UserLocation> createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(-33.870847570782274, 18.505317311333606),
    zoom: 14,
  );

  final List<Marker> myMarker = [];
  final List<Marker> markerList = const [
    Marker(
      markerId: MarkerId("Home"),
      position: LatLng(-33.870847570782274, 18.505317311333606),
      infoWindow: InfoWindow(title: "Quickloc8 Office"),
    )
  ];

  @override
  void initState() {
    super.initState();
    myMarker.addAll(markerList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: _initialPosition,
              mapType: MapType.terrain,
              markers: Set<Marker>.of(myMarker),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton(
                  onPressed: _goToUserLocation,
                  backgroundColor: const Color(0xFFFFCCBC),
                  child: const Icon(Icons.my_location),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _goToUserLocation() async {
    // Request location permission if needed
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.getCurrentPosition();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition();
      final userLocation = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 17,
      );
      _controller.future.then((controller) => controller
          .animateCamera(CameraUpdate.newCameraPosition(userLocation)));
    }
  }
}

class Trilateration {
  static Map<String, double> calculatePosition(
    List<Map<String, dynamic>> towers,
  ) {
    const double R = 6371e3; // Earth radius in meters

    // Convert ranges to distances
    List<double> distances = [];
    towers.forEach((tower) {
      double range = tower['range'] as double;
      distances.add(range);
    });

    // Convert latitude and longitude to radians
    List<double> latitudes = [];
    List<double> longitudes = [];
    towers.forEach((tower) {
      double latitude = tower['latitude'] as double;
      double longitude = tower['longitude'] as double;
      latitudes.add(_toRadians(latitude));
      longitudes.add(_toRadians(longitude));
    });

    // Trilateration calculation
    double A = cos(latitudes[0]) * cos(latitudes[1]) * cos(latitudes[2]);
    double B = cos(latitudes[0]) * sin(latitudes[1]) * cos(latitudes[2]);
    double C = sin(latitudes[0]) * sin(latitudes[2]);
    double D = sin(latitudes[0]) * cos(latitudes[1]) * sin(latitudes[2]);
    double E = sin(latitudes[0]) * cos(latitudes[2]);
    double F = cos(latitudes[0]) * sin(latitudes[2]);

    double x = (distances[0] * cos(longitudes[0]) -
                distances[1] * cos(longitudes[1])) /
            cos(latitudes[1]) +
        (distances[1] * cos(longitudes[1]) -
                distances[2] * cos(longitudes[2])) /
            cos(latitudes[2]);
    x /= (A - B);
    double y = (distances[0] * sin(longitudes[0]) -
                distances[1] * sin(longitudes[1])) /
            cos(latitudes[1]) +
        (distances[1] * sin(longitudes[1]) -
                distances[2] * sin(longitudes[2])) /
            cos(latitudes[2]);
    y /= (C - D);

    // Convert back to degrees
    double latitude = _toDegrees(atan((E * x + F * y) / (A - B)));
    double longitude = _toDegrees(
        (distances[0] - x * cos(latitudes[0])) / (cos(longitudes[0])));

    return {'latitude': latitude, 'longitude': longitude};
  }

  static double _toRadians(double degrees) {
    return degrees * pi / 180;
  }

  static double _toDegrees(double radians) {
    return radians * 180 / pi;
  }
}
