import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/playerController.dart';
import 'screens/home.dart';
import 'const/methods.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final controller = Get.put(PlayerController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player',
      theme: ThemeData(
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
