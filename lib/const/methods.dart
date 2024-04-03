import 'package:flutter/material.dart';

class Method {
String? fontFamily = 'regular';
double? fontSize = 20.0;
Color? color = Colors.white;
static textStyle({fontFamily,  fontSize, color}) {
  
  return TextStyle(fontFamily: fontFamily, fontSize: fontSize, color: color);
}
}

