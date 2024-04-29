import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/const/colors.dart';
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
  var controller = Get.find<PlayerController>();

  initializeList() async {
    await controller.initializeList().then((value) => {
    for (int i=0;i<controller.songdata.length;i++) {
      controller.searchIndex.add(SongModelClass(indexId: i,id:controller.songdata[i].id, artist: controller.songdata[i].artist, displayNameWOExt: controller.songdata[i].displayNameWOExt,)),
    }
    })  ;
  }

  @override
  void initState() {
    initializeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final w = Get.width;
    final h = Get.height;
    return Scaffold(
      backgroundColor: MyColors.baseColor,
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.sort_rounded)),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              icon: Icon(Icons.search))
        ],
        title: Text(
          "MUSIC PLAYER",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.accentColor,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Container(
                height: h * 0.12,
                width: double.maxFinite,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    gradient: MyColors.gradient,
                    borderRadius: BorderRadius.circular(70)),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: w * 0.05,
                      ),
                      CircleAvatar(
                        radius: w * 0.095,
                        // child: QueryArtworkWidget(id: controller.data![controller.playIndex.value].id, type: ArtworkType.AUDIO,nullArtworkWidget: Icon(Icons.music_note_sharp),),
                      ),
                      SizedBox(
                        width: w * 0.05,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Beautiful".toUpperCase(),
                            style: Method.textStyle(
                                fontFamily: 'bold',
                                fontSize: 25.0,
                                color: Colors.white),
                          ),
                          Text(
                            "Eminem",
                            style: Method.textStyle(
                                fontFamily: 'bold',
                                fontSize: 20.0,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: w * 0.1,
                      ),
                      Icon(
                        Icons.play_circle_fill_sharp,
                        color: MyColors.whiteColor,
                        size: w * 0.1,
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
          Obx(() => Container(
            height: h * 0.73,
            child: 
                 controller.songdata.isEmpty
                    ? Center(
                        child: Text("No Songs Found.",style: TextStyle(color: Colors.white,fontSize: 16),),
                      )
                    :  ListView.builder(
                      itemCount: controller.songdata.length,
                      itemBuilder: (context, index) {
                          return  Padding(
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
                                    title:
                                        Text(controller.songdata[index].title),
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
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    ),),
        ],
      ),
    );
  }
}


// old list view for other projects
// ListView(
//       children: List.generate(matchSuggestions.length, (index) {
//         return Card(
//             child: ListTile(
//                 onTap: () async {
//                   query = matchSuggestions[index];
//                 },
//                 title: Text(matchSuggestions[index],
//                     style: TextStyle(fontSize: 20))));
//       }),
//     );