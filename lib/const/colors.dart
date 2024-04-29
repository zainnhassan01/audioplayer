import 'package:flutter/material.dart';

class MyColors {
  static const Color accentColor = Color.fromARGB(170, 100, 48, 129);
  static const Color secondaryColor = Color.fromARGB(255, 161, 140, 181);
  static const Color whiteColor = Color(0xFFF5F5F5);
  static const Color additionalColor = Color(0xFF9DA8D2);
  static const Color selectedList = Color.fromARGB(255, 210, 209, 209);
  static const Color baseColor = Color.fromARGB(159, 46, 46, 46);
  static Color backgroundColor = Color(0xFF000000).withOpacity(0.5); // Black
  static final gradient = LinearGradient(
      colors: [selectedList, additionalColor],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      );
  static final player = LinearGradient(
      colors: [selectedList, accentColor],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      );
}

  // s