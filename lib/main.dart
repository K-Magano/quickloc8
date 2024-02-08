import 'package:flutter/material.dart';
import 'package:quickloc8/SplashScreen/splash_screen.dart';
import 'package:quickloc8/MapScreen/map_screen.dart';
import 'package:quickloc8/messageScreen/message_screen.dart';
import 'package:quickloc8/theme.dart';

void main() {
  runApp(
    Theme(
      data: lightTheme,
      child: const MyApp(),
    ),
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
      home: SplashScreen(),
    );
  }
}
