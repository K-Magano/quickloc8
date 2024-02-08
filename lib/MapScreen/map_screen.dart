import "dart:async";
import "package:flutter/material.dart";
//import 'package:flutter/services.dart';
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:quickloc8/messageScreen/message_screen.dart";

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

  final List<Marker> myMarker = [];
  final List<Marker> markerList = const [
    Marker(
      markerId: MarkerId("Home"),
      position: LatLng(-33.870847570782274, 18.505317311333606),
      infoWindow: InfoWindow(title: "Quickloc Office"),
    ),
    Marker(
      markerId: MarkerId("TaxiOne"),
      position: LatLng(-33.876115, 18.5008116),
      infoWindow: InfoWindow(title: "TaxiOne!"),
    ),
    Marker(
      markerId: MarkerId("TaxiTwo"),
      position: LatLng(-33.9685533, 18.5662383),
      infoWindow: InfoWindow(title: "TaxiTwo"),
    ),
    Marker(
      markerId: MarkerId("TaxiThree"),
      position: LatLng(-34.0461583, 18.7047383),
      infoWindow: InfoWindow(title: "TaxiThree"),
    ),
    Marker(
      markerId: MarkerId("TaxiFour"),
      position: LatLng(-31.8994016, 26.8671716),
      infoWindow: InfoWindow(title: "TaxiFour"),
    ),
    Marker(
      markerId: MarkerId("TaxiFive"),
      position: LatLng(-31.8942983, 26.878175),
      infoWindow: InfoWindow(title: "TaxiFive"),
    ),
    Marker(
      markerId: MarkerId("TaxiSix"),
      position: LatLng(-31.9998233, 27.5801216),
      infoWindow: InfoWindow(title: "TaxiSix"),
    ),
  ];

  @override
  void initState() {
    super.initState();
    myMarker.addAll(markerList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quick Loc8",
          style: TextStyle(
            color: Colors.white, // Change color as desired
            fontSize: 25, // Adjust font size
            fontFamily: 'Roboto', // Set desired font family
            fontWeight: FontWeight.bold, // Adjust font weight
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF55722),
        elevation: 4, // Set border elevation
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _initialPosition,
          mapType: MapType.terrain,
          markers: Set<Marker>.of(myMarker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MessageScreen()),
        ),
        child: const Icon(Icons.message),
      ),
    );
  }
}
