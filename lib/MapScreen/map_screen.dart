import "dart:async";
import "dart:convert";
import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:flutter/services.dart" as rootBundle;
import "package:quickloc8/messageScreen/message_screen.dart";

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    String jsonString = await rootBundle.rootBundle
        .loadString('assets/jsonfile/vehicleCoordinates.json');
    List<dynamic> jsonList = json.decode(jsonString);
    _markers.clear(); // Clear existing markers
    // Load custom marker icon
    BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(20, 20)), // Adjust size as needed
      'assets/images/white_taxi.png',
    );
    // Add markers to the set
    jsonList.forEach((element) {
      final double latitude = double.parse(element['latitude']);
      final double longitude = double.parse(element['longitude']);
      _markers.add(
        Marker(
          markerId: MarkerId(element['heading']),
          position: LatLng(latitude, longitude),
          icon: customIcon, // Set custom marker icon
          infoWindow: InfoWindow(title: element['heading']),
        ),
      );
    });
    // Update the state to re-render the map with markers
    setState(() {});
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
        elevation: 4,
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(-33.870847570782274,
              18.505317311333606), // Initial camera position
          zoom: 12,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers, // Set of markers to display on the map
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MessageScreen()),
          );
        },
        child: const Icon(Icons.message),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
