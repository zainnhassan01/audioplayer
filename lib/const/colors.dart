import 'package:flutter/material.dart';

class MyColors {
  static const Color background1 = Color.fromARGB(255, 93, 20, 20);
  static const Color background2 = Colors.black;
  static const Color pressedbuttoncolor = Color.fromARGB(107, 106, 37, 37);
  static const Color secondaryColor = Color.fromARGB(255, 121, 99, 99);

  static const Color accentColor = Color.fromARGB(170, 100, 48, 129);
  static const Color whiteColor = Color(0xFFF5F5F5);
  static const Color additionalColor = Color(0xFF9DA8D2);
  static const Color selectedList = Color.fromARGB(255, 210, 209, 209);
  static Color backgroundColor = Color(0xFF000000).withOpacity(0.5); // Black
  static final background = LinearGradient(
      colors: [background2, background1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      );
  static final player = LinearGradient(
      colors: [selectedList, accentColor],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      );
}

  // s