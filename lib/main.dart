import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/screens/home.dart';
import 'const/methods.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
        appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: true,
            titleSpacing: 35,
            titleTextStyle: Method.textStyle(fontFamily: 'bold', fontSize: 25.0)),
      ),
      home: HomePage(),
    );
  }
}
