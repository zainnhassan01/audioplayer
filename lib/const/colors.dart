import 'dart:ui';

import 'package:flutter/material.dart';

class MyColors {
  static const Color color1 = Color(0xFFFFFFFF); // White
  static const Color color2 = Color(0xFF6C2716); // Rusty Red
  static const Color backgroundColor = Color(0xFF000000); // Black
  static const Color orange = Color(0xFFB3472E); // Copper Red
  static const Color color5 = Color(0xFF35130C); // Dark Sienna
  static const Color color6 = Color(0xFFD6863C); // Apricot
  static const Color color7 = Color(0xFF7F7B7A); // Gray
  static const Color tileColor = Color.fromRGBO(132, 75, 62, 1);

  static final appbarColor =
      LinearGradient(colors: [color5, orange], begin: Alignment.centerLeft, end: Alignment.centerRight);
  static final gradient2 =
      LinearGradient(colors: [color7, color6], begin: Alignment.centerLeft, end: Alignment.centerRight);
}
