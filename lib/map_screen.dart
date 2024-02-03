import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart'; // Import for asset handling

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(-33.870847570782274, 18.505317311333606),
    zoom: 14,
  );

  Set<Marker> markers = {}; // Store all markers (office and taxis)

  @override
  void initState() {
    super.initState();
    _fetchMarkers();
  }

  Future<void> _fetchMarkers() async {
    const officeMarker = Marker(
      markerId: MarkerId("First"),
      position: LatLng(-33.870847570782274, 18.505317311333606),
      infoWindow: InfoWindow(title: "Quickloc8 Office"),
    );
    markers.add(officeMarker); // Add office marker first

    final taxiCoordinates = await _getVehicleCoordinates();
    final taxiMarkers =
        taxiCoordinates.map((vehicle) => _createTaxiMarker(vehicle)).toList();
    markers.addAll(taxiMarkers as Iterable<Marker>); // Add taxi markers

    setState(() {});
  }

  Future<List<Map<String, dynamic>>> _getVehicleCoordinates() async {
    final String jsonString = await rootBundle
        .loadString('assets/coordinates/vehicleCoordinates.json');
    final List<dynamic> coordinates = jsonDecode(jsonString);
    return coordinates.cast<Map<String, dynamic>>();
  }

  Future<Marker> _createTaxiMarker(Map<String, dynamic> vehicle) async {
    final heading = double.parse(vehicle['heading']);
    return Marker(
      markerId: MarkerId(vehicle['latitude'] + vehicle['longitude']),
      position: LatLng(vehicle['latitude'], vehicle['longitude']),
      rotation: heading,
      icon: await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.0),
        "assets/images/white_taxi.png", // Path to taxi image
      ),
      infoWindow: const InfoWindow(title: "Taxi"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _initialPosition,
          mapType: MapType.terrain,
          markers: markers, // Display all markers
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
