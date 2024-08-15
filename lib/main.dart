import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/playerController.dart';
import 'screens/home.dart';
import 'const/methods.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

// errors
// fix the bottombar by passing only the list that is currently being passed and also change the condition of the playbutton in home screen
class MyApp extends StatelessWidget {
  MyApp({super.key});
  final controller = Get.put(PlayerController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Audio Player',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: true,
            titleSpacing: 35,
            titleTextStyle:
                Method.textStyle(fontFamily: 'bold', fontSize: 25.0)),
      ),
      home: HomePage(),
    );
  }
}
