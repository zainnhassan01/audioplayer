import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/const/colors.dart';
import 'package:musicplayer/const/drawer.dart';
import 'package:musicplayer/const/methods.dart';
import 'package:musicplayer/controller/playerController.dart';
import 'package:musicplayer/screens/player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:intl/intl.dart';
import 'package:musicplayer/controller/searchfunctionality.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Container(
      height: h * 1,
      decoration: BoxDecoration(gradient: MyColors.background),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              color: Colors.white,
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              icon: Icon(Icons.search)),
          actions: [
            IconButton(
                color: Colors.white,
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                icon: Icon(Icons.sort_rounded)),
          ],
          title: Text(
            "Home",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
        drawer: CustomDrawer(),
        body: Column(
          children: [
            Obx(
              () => Container(
                  height: h * 0.830,
                  child: controller.songdata.isEmpty
                      ? Center(
                          child: Text(
                            "No Songs Found.",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 10, 3, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // SizedBox(
                                    //   width: w * 0.4,
                                    //   child: ElevatedButton(
                                    //       style: ElevatedButton.styleFrom(
                                    //           backgroundColor:
                                    //               MyColors.elevatedbuttoncolor,
                                    //           shape: StadiumBorder()),
                                    //       onPressed: () {},
                                    //       child: Text("All")),
                                    // ),
                                    SizedBox(
                                      width: w * 0.4,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  MyColors.secondaryColor,
                                              shape: StadiumBorder()),
                                          onPressed: () {},
                                          child: Text(
                                            "Music",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white),
                                          )),
                                    ),
                                    SizedBox(
                                      width: w * 0.4,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  MyColors.secondaryColor,
                                              shape: StadiumBorder()),
                                          onPressed: () {},
                                          child: Text(
                                            "Recordings",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  "Your Music",
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: controller.songdata.length,
                                    itemBuilder: (context, index) {
                                      return Obx(
                                        () =>
                                            //  Card(
                                            //       color: controller.playIndex == index
                                            //           ? MyColors.secondaryColor
                                            //           : Colors.transparent,
                                            //   child:
                                            ListTile(
                                                title: Text(
                                                  controller
                                                      .songdata[index].title,
                                                  maxLines: 1,
                                                  // overflow: TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ),
                                                subtitle: Text(
                                                  controller
                                                      .songdata[index].artist!,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.grey[300],
                                                      fontSize: 12),
                                                ),
                                                leading: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: Colors.grey,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: QueryArtworkWidget(
                                                      artworkFit: BoxFit.cover,
                                                      id: controller
                                                          .songdata[index].id,
                                                      type: ArtworkType.AUDIO,
                                                      nullArtworkWidget: Icon(
                                                          Icons.music_note),
                                                    ),
                                                  ),
                                                ),
                                                trailing: controller
                                                                .playIndex ==
                                                            index &&
                                                        controller.isPlaying
                                                                .value ==
                                                            true
                                                    ? Icon(
                                                        Icons.play_arrow_sharp,
                                                        size: 33,
                                                        color: Colors.white)
                                                    : Text(
                                                        DateFormat('mm:ss')
                                                            .format(DateTime
                                                                .fromMillisecondsSinceEpoch(
                                                                    controller
                                                                        .songdata[
                                                                            index]
                                                                        .duration!,
                                                                    isUtc:
                                                                        false))
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                onTap: () {
                                                  if (controller.playIndex ==
                                                      index) {
                                                    Get.to(
                                                      () => PlayerScreen(
                                                        data:
                                                            controller.songdata,
                                                      ),
                                                      transition:
                                                          Transition.downToUp,
                                                    );
                                                  } else {
                                                    Get.to(
                                                      () => PlayerScreen(
                                                        data:
                                                            controller.songdata,
                                                      ),
                                                      transition:
                                                          Transition.downToUp,
                                                    );
                                                    controller.playSong(
                                                        controller
                                                            .songdata[index]
                                                            .uri,
                                                        index);
                                                  }
                                                }),
                                        // ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        )),
            ),
            //bottombar for player
            Obx(() {
              return controller.songdata.isEmpty
                  ? CircularProgressIndicator()
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Container(
                          height: h * 0.068,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (controller.isPlaying.value == false) {
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
                                        radius: w * 0.05,
                                        child: ClipRRect(
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: QueryArtworkWidget(
                                            id: controller
                                                .songdata[
                                                    controller.playIndex.value]
                                                .id,
                                            type: ArtworkType.AUDIO,
                                            nullArtworkWidget:
                                                Icon(Icons.music_note_sharp),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w * 0.03,
                                      ),
                                      Container(
                                        width: w * 0.64,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                controller
                                                    .songdata[controller
                                                        .playIndex.value]
                                                    .title,
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                softWrap: true,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    color: Colors.white)),
                                            Text(
                                                controller
                                                    .songdata[controller
                                                        .playIndex.value]
                                                    .artist!,
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                softWrap: true,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: w * 0.05,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    onPressed: () {
                                      if (controller.isPlaying.value ==
                                            true) {
                                          controller.isPlaying(false);
                                          controller.player.pause();
                                        } else {
                                          controller.isPlaying(true);
                                          controller.player.play();
                                        }
                                    },
                                    icon: controller.isPlaying.value
                                        ? Icon(
                                            Icons.pause,
                                            size: 28,
                                            color: Colors.white,
                                          )
                                        : Icon(
                                            Icons.play_arrow_sharp,
                                            size: 28,
                                            color: Colors.white,
                                          ),
                                  ),
                                )
                              ])));
            }),
          ],
        ),
      ),
    );
  }
}


//  Center(
//                         child: Container(
//                           height: h * 0.08,
//                           width: double.maxFinite,
                          // clipBehavior: Clip.antiAliasWithSaveLayer,
                          // decoration: BoxDecoration(
                          //     gradient: MyColors.background,
                          //     borderRadius: BorderRadius.circular(20)),
                          // child: InkWell(
//                             onTap: () {
//                               if (controller.isPlaying.value == false) {
//                                 controller.isPlaying(true);
//                                 controller.player.play();
//                               }
//                               Get.to(
//                                 () => PlayerScreen(
//                                   data: controller.songdata,
//                                 ),
//                                 transition: Transition.downToUp,
//                               );
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   width: w * 0.03,
//                                 ),
//                                 CircleAvatar(
//                                   backgroundColor: MyColors.additionalColor,
//                                   radius: w * 0.064,
//                                   child: QueryArtworkWidget(
//                                     id: controller
//                                         .songdata[controller.playIndex.value]
//                                         .id,
//                                     type: ArtworkType.AUDIO,
//                                     nullArtworkWidget:
//                                         Icon(Icons.music_note_sharp),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: w * 0.035,
//                                 ),
//                                 Container(
//                                   width: w * 0.64,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         controller
//                                             .songdata[
//                                                 controller.playIndex.value]
//                                             .title,
//                                         textAlign: TextAlign.center,
//                                         overflow: TextOverflow.ellipsis,
//                                         maxLines: 1,
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: controller
//                                                         .songdata[controller
//                                                             .playIndex.value]
//                                                         .title
//                                                         .length >
//                                                     10
//                                                 ? 20.0
//                                                 : 20.0,
//                                             color: Colors.white),
//                                       ),
//                                       Text(
//                                         controller
//                                             .songdata[
//                                                 controller.playIndex.value]
//                                             .artist!,
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 14.0,
//                                             color: Colors.white),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: w * 0.05,
//                                 ),
//                                 Icon(
//                                   controller.isPlaying == true
//                                       ? Icons.pause
//                                       : Icons.play_arrow,
//                                   size: 30,
//                                   color: Colors.white,
//                                 ),
//                                 SizedBox(
//                                   height: h * 0.02,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),

                                      //   child: Obx(
                                      //     () => Card(
                                      //       color: controller.playIndex == index
                                      //           ? MyColors.additionalColor
                                      //           : MyColors.selectedList,
                                      //       shape: RoundedRectangleBorder(
                                      //           borderRadius:
                                      //               BorderRadius.circular(30)),
                                      //   
                                               
                                      //             }
                                      //           },
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // );
