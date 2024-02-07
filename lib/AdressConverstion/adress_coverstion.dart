import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class AddressConversion extends StatefulWidget {
  @override
  State<AddressConversion> createState() => _AddressConversionState();
}

class _AddressConversionState extends State<AddressConversion> {
  String placeM = " ";
  String addressOnScreen = " ";

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 244, 204, 188),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(placeM),
              Text(addressOnScreen),
              GestureDetector(
                  onTap: () async {
                    List<Location> location =
                        await locationFromAddress("Office, Cape Town");
                    List<Placemark> placemark =
                        await placemarkFromCoordinates(-34.0461583, 18.7047383);
                    setState(() {
                      placeM =
                          '${placemark.reversed.last.country}, ${placemark.reversed.last.locality}';
                      addressOnScreen =
                          "${location.last.longitude}, ${location.last.latitude}";
                    });
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.blueAccent,
                          ),
                          child: const Center(
                            child: Text("Convert Location"),
                          )))),
            ],
          ),
        ));
  }
}
