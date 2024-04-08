import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController{

  final Onaudioquery = OnAudioQuery();
  final player = AudioPlayer();
  RxInt playIndex = 0.obs;
  RxBool isPlaying = false.obs;
  var duration = ''.obs;
  var position = ''.obs;
  var max = 0.0.obs;
  var current = 0.0.obs;
  @override
  void onInit() {
    checkPermissions();
    super.onInit();
  }
  Future<void> checkPermissions() async{
    var permission = await Permission.storage.request();
    if(permission.isGranted == true){
    } else {
      checkPermissions();
    }
  }
  //to play song
  playSong(String? uri, int index) {
  playIndex.value = index;
  try{
  player.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
  isPlaying.value = true;
  player.play();
  updatePosition();
  
  }
  on Exception catch(e){
    print(e);
  }
  }
  //for time updating on player screen
  updatePosition() {
    player.durationStream.listen((event) {
      duration.value = event.toString().split('.')[0];
      max.value = event!.inSeconds.toDouble();
    });
    player.positionStream.listen((e) {
      position.value = e.toString().split('.')[0];
      current.value = e.inSeconds.toDouble();
    });
  }
  //for slider
  changeDurationToSeconds(seconds){
    var duration = Duration(seconds: seconds); 
    player.seek(duration); 
  }


 
}