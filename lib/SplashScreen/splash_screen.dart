import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quickloc8/bottomNavigation/nav_bar.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  // Initialize the animation and set up delayed navigation

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _opacityAnimation = Tween(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat(reverse: true);

    Future.delayed(
      const Duration(milliseconds: 3500),
      () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const NavBar()));
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF55722),
      body: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: const Image(
              height: 130,
              width: 300,
              image: Svg("assets/images/quickloc8.svg")),
        ),
      ),
    );
  }
}
