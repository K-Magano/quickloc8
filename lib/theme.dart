import 'package:flutter/material.dart';
import '../assets/theme/colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    secondary: accentColor,
    error: errorColor,
  ),
);
