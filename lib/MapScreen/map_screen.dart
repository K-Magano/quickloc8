import "dart:async";
import "dart:convert";
import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:flutter/services.dart" as rootBundle;

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String jsonString = await rootBundle.rootBundle
          .loadString('assets/jsonfile/vehicleCoordinates.json');
      List<dynamic> jsonList = json.decode(jsonString);
      _markers.clear();

      // Load custom marker icon
      BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(20, 20)),
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
            icon: customIcon,
            infoWindow: InfoWindow(title: element['heading']),
          ),
        );
      });

      // Update the state to re-render the map with markers and set loading state to false
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading markers: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quick Loc8",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF55722),
        elevation: 4,
      ),
      body: Stack(
        children: [
          GoogleMap(
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
          if (_isLoading) // Display loading indicator if loading
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Fetching locations',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
