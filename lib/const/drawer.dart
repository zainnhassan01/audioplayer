import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/const/colors.dart';

CustomDrawer() {
  final w = Get.width;
  final h = Get.height;
  return SizedBox(
    height: h * 0.15,
    child: Drawer(
        shadowColor: MyColors.additionalColor,
        backgroundColor: Colors.grey[800],
        width: w * 0.15,
        shape: StadiumBorder(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ListTile(
                leading: Icon(
              Icons.favorite,
              color: Colors.grey[300],
            )),
            ListTile(
                leading: Icon(
              Icons.settings,
              color: Colors.grey[300],
            )),
          ],
        )),
  );
}
