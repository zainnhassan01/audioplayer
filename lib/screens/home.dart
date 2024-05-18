import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/const/colors.dart';
import 'package:musicplayer/const/drawer.dart';
import 'package:musicplayer/const/methods.dart';
import 'package:musicplayer/controller/playerController.dart';
import 'package:musicplayer/screens/player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:intl/intl.dart';
import 'package:musicplayer/controller/searchfunctionality.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.find<PlayerController>();
  initializeList() async {
    await controller.initializeList().then((value) => {
          for (int i = 0; i < controller.songdata.length; i++)
            {
              controller.searchIndex.add(SongModelClass(
                indexId: i,
                id: controller.songdata[i].id,
                artist: controller.songdata[i].artist,
                displayNameWOExt: controller.songdata[i].displayNameWOExt,
              )),
            }
        });
  }

  @override
  void initState() {
    initializeList();
    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final w = Get.width;
    final h = Get.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MyColors.baseColor,
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        leading: IconButton(onPressed: () {
          _scaffoldKey.currentState!.openDrawer();
        }, icon: Icon(Icons.sort_rounded)),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              icon: Icon(Icons.search))
        ],
        title: Text(
          "AUDIO PLAYER",
        ),
      ),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          Obx(
            () => Container(
              height: h * 0.795,
              child: controller.songdata.isEmpty
                  ? Center(
                      child: Text(
                        "No Songs Found.",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: controller.songdata.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(2),
                          child: Obx(
                            () => Card(
                              color: controller.playIndex == index
                                  ? MyColors.additionalColor
                                  : MyColors.selectedList,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Obx(
                                () => ListTile(
                                  leading: QueryArtworkWidget(
                                    id: controller.songdata[index].id,
                                    type: ArtworkType.AUDIO,
                                    nullArtworkWidget: Icon(Icons.music_note),
                                  ),
                                  title: Text(controller.songdata[index].title),
                                  subtitle:
                                      Text(controller.songdata[index].artist!),
                                  trailing: controller.playIndex == index &&
                                          controller.isPlaying.value == true
                                      ? Icon(Icons.play_arrow_sharp,
                                          size: 30, color: Colors.black)
                                      : Text(DateFormat('mm:ss')
                                          .format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  controller.songdata[index]
                                                      .duration!,
                                                  isUtc: false))
                                          .toString()),
                                  onTap: () {
                                    if (controller.playIndex == index) {
                                      Get.to(
                                        () => PlayerScreen(
                                          data: controller.songdata,
                                        ),
                                        transition: Transition.downToUp,
                                      );
                                    } else {
                                      Get.to(
                                        () => PlayerScreen(
                                          data: controller.songdata,
                                        ),
                                        transition: Transition.downToUp,
                                      );
                                      controller.playSong(
                                          controller.songdata[index].uri,
                                          index);
                                      // controller.sharedPreferencesData(
                                      //   controller.songdata[index].uri,
                                      //   index
                                      // );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
            ),
          ),
          //bottombar for player
          Obx( () => 
             Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Center(
                child: Container(
                  height: h * 0.08,
                  width: double.maxFinite,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      gradient: MyColors.gradient,
                      borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                    onTap: () {
                          if(controller.isPlaying.value == false){
                            controller.isPlaying(true);
                            controller.player.play();
                          }
                      Get.to(
                        () => PlayerScreen(
                          data: controller.songdata,
                        ),
                        transition: Transition.downToUp,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: w * 0.03,
                        ),
                        CircleAvatar(
                          backgroundColor: MyColors.additionalColor,
                          radius: w * 0.064,
                          child: QueryArtworkWidget(
                            id: controller
                                .songdata[controller.playIndex.value].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: Icon(Icons.music_note_sharp),
                          ),
                        ),
                        SizedBox(
                          width: w * 0.035,
                        ),
                        Container(
                            width: w * 0.64,
                             child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller
                                      .songdata[controller.playIndex.value].title,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                      fontSize: controller
                                                  .songdata[
                                                      controller.playIndex.value]
                                                  .title
                                                  .length >
                                              10
                                          ? 20.0
                                          : 20.0,
                                      color: Colors.white),
                                ),
                                Text(
                                  controller
                                      .songdata[controller.playIndex.value].artist!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                      color: Colors.white),
                                ),
                              ],),
                           ),
                        SizedBox(
                          width: w * 0.05,
                        ),
                        Icon(
                            controller.isPlaying == true? Icons.pause :
                            Icons.play_arrow,
                            size: 30,
                            color: Colors.white,
                          ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      
    );
  }
}
