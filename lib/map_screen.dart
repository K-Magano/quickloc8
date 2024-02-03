import "dart:async";
import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(-33.870847570782274, 18.505317311333606),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: GoogleMap(
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    ));
  }
}
