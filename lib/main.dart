import 'package:flutter/material.dart';
import 'package:quickloc8/map_screen.dart';

import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//import "package:flutter_config/flutter_config.dart";

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Quickloc8 Splash Screen',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
//time
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 3500),
      () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MapScreen()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF55722),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/Quickloc8-logo.png",
                height: 130,
                width: 300,
              ),
            ],
          ),
        ));
  }
}

// class MapScreen extends StatelessWidget {
//   const MapScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF55722),
//         title: const Text('Map page'),
//       ),
//     );
//   }
// }
