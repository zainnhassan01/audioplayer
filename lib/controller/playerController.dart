import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController{

  final Onaudioquery = OnAudioQuery();

  @override
  void onInit() {
    checkPermissions();
    super.onInit();
  }
  checkPermissions(){
    print("asking permission");
    var permission = Permission.storage.request();
    if(permission.isGranted == true){
    } else {
      checkPermissions();
    }
  }
}