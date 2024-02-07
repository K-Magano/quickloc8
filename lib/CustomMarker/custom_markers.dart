import 'dart:async';
//import 'dart:convert';
import 'dart:typed_data';
import "dart:ui" as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TaxiMarker extends StatefulWidget {
  @override
  State<TaxiMarker> createState() => _TaxiMarkerState();
}

class _TaxiMarkerState extends State<TaxiMarker> {
  List<String> images = [
    'images/Quickloc8-logo.png'
        'images/white_taxi.png'
  ];

  final List<LatLng> latlngForImage = <LatLng>[
    const LatLng(-33.870847570782274, 18.505317311333606), //Office
    const LatLng(-33.876115, 18.5008116), //Taxi 1
    const LatLng(-33.9685533, 18.5662383), //Taxi 2
    const LatLng(-34.0461583, 18.7047383), //Taxi 3
    const LatLng(-31.8994016, 26.8671716), //Taxi 4
    const LatLng(-31.8942983, 26.878175), //Taxi 5
    const LatLng(-31.9998233, 27.5801216), //Taxi 6
  ];

  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(-33.870847570782274, 18.505317311333606),
    zoom: 14,
  );

  final List<Marker> myMarker = [];

  Future<Uint8List> getImagesFromMarkers(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec.codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  packData() async {
    for (int a = 0; a < images.length; a++) {
      final Uint8List iconMarker = await getImagesFromMarkers(images[a], 90);
      myMarker.add(Marker(
          markerId: MarkerId(a.toString()),
          position: latlngForImage[a],
          icon: BitmapDescriptor.fromBytes(iconMarker),
          infoWindow: InfoWindow(
            title: "Title Marker: $a",
          )));
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    packData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
