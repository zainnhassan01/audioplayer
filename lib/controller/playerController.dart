import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/const/methods.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerController extends GetxController {
  final Onaudioquery = OnAudioQuery();
  final player = AudioPlayer();
  RxString songtitle = "".obs; //for play button in lists
  RxString songauthor = "".obs;
  RxInt songid = 0.obs;
  // final _preferences = SharedPreferences.getInstance();
  RxInt playIndex = 0.obs;
  RxBool isPlaying = false.obs;
  RxInt selectedIndex = 0.obs;
  var duration = ''.obs;
  var position = ''.obs;
  var max = 0.0.obs;
  var current = 0.0.obs;
  RxMap<String,dynamic> toJSON = <String,dynamic>{}.obs; 
  RxList<SongModelClass> searchIndex = <SongModelClass>[].obs;
  RxList<SongModel> allsongdata = <SongModel>[].obs;
  RxList<SongModel> recordings = <SongModel>[].obs;
  RxList<SongModel> music = <SongModel>[].obs;
  PlayerController() {
    playIndex.value = 0; // Initialize playIndex to 0
  }
  @override
  void onInit() {
    checkPermissions();
    super.onInit();
  }

  Future<void> checkPermissions() async {
    var permission = await Permission.storage.request();
    if (permission.isGranted == true) {
    } else {
      checkPermissions();
    }
  }

  Future initializeList() async {
    allsongdata.value = await Onaudioquery.querySongs(
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: null,
        ignoreCase: true,
        uriType: UriType.EXTERNAL);
  }
  // sharedPreferencesData(String? uri, int index) {
  //   String? songUri = uri;
  //   int songIndex = index;
  //   player.durationStream.listen((event) {
  //     duration.value = event.toString().split('.')[0];});
  //   toJSON.value = {
  //       'songUri' : songUri,
  //       'songIndex': songIndex,
  //       'duration': duration.value
  //     };
  //   }
  //to play song
  playSong(String? uri, int index) {
    playIndex.value = index;
    try {
      player.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      isPlaying.value = true;
      player.play();
      updatePosition();
    } on Exception catch (e) {
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
  changeDurationToSeconds(seconds) {
    var duration = Duration(seconds: seconds);
    player.seek(duration);
  }
}
