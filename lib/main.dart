import 'package:flutter/material.dart';
import 'package:quickloc8/SplashScreen/splash_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quickloc8 Demo',
      // Set the initial screen of the app to the SplashScreen widget.
      home: SplashScreen(),
    );
  }
}
