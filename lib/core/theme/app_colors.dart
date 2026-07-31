import 'package:flutter/material.dart';

abstract final class AppColors {
  AppColors._();

  // Brand colors
  static const Color navy = Color(0xFF012662);
  static const Color navyDark = Color(0xFF071F5E);
  static const Color navyLight = Color(0xFF024E9B);

  static const Color primary = Color(0xFF024E9B);
  static const Color actionBlue = Color(0xFF0266B4);
  static const Color sky = Color(0xFF02BBE4);
  static const Color lagoon = Color(0xFF75C7D1);
  static const Color gold = Color(0xFFE49E24);

  // Neutral colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF252525);
  static const Color transparent = Colors.transparent;

  // Background and surfaces
  static const Color background = Color(0xFFF7F7F8);
  static const Color sand = Color(0xFFF7F7F8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF071F5E);
  static const Color fieldFill = Color(0xFFFDFDFD);

  // Text colors
  static const Color textPrimary = Color(0xFF252525);
  static const Color mutedText = Color(0xFF8F8F94);
  static const Color placeholder = Color(0xFF8F8F94);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Border and state colors
  static const Color border = Color(0xFFD9DEE5);
  static const Color divider = Color(0xFFE5E7EB);
  static const Color disabled = Color(0xFFB8BBC1);
  static const Color error = Color(0xFFBA1A1A);
  static const Color success = Color(0xFF1A9B69);
  static const Color warning = Color(0xFFE49E24);

  // Social colors
  static const Color facebook = Color(0xFF3578E5);
  static const Color googleRed = Color(0xFFEA4335);
  static const Color apple = Color(0xFF000000);

  // Login button gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF063478),
      Color(0xFF066EB5),
    ],
  );

  // Splash/background gradient
  static const LinearGradient navyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF012662),
      Color(0xFF024E9B),
    ],
  );
}