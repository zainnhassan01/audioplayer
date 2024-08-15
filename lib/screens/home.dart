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
  var bottombarList;
  initializeList() async {
    await controller.initializeList().then((value) => {
          for (int i = 0; i < controller.allsongdata.length; i++)
            {
              controller.searchIndex.add(SongModelClass(
                indexId: i,
                id: controller.allsongdata[i].id,
                artist: controller.allsongdata[i].artist,
                displayNameWOExt: controller.allsongdata[i].displayNameWOExt,
              )),
              controller.recordings.assignAll(controller.allsongdata
                  .where((song) =>
                      (song.fileExtension == ('opus') ||
                          song.fileExtension == ('m4a')) ||
                      ((song.displayName
                                  .toLowerCase()
                                  .contains("AUD".toLowerCase()) &&
                              song.artist == null) ||
                          (song.displayName
                                  .toLowerCase()
                                  .contains("REC".toLowerCase()) &&
                              song.artist == null)))
                  .toList()),
              controller.music.assignAll(controller.allsongdata
                  .where((song) =>
                      !(song.fileExtension == ('opus') ||
                          song.fileExtension == ('m4a')) ||
                      !((song.displayName
                              .toLowerCase()
                              .contains("AUD".toLowerCase()) ||
                          (song.displayName
                              .toLowerCase()
                              .contains("REC".toLowerCase())))))
                  .toList()),
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
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                color: Colors.white,
                onPressed: () {
                  showSearch(
                      context: context, delegate: CustomSearchDelegate());
                },
                icon: Icon(Icons.search)),
            // IconButton(
            //     color: Colors.white,
            //     onPressed: () {
            //       _scaffoldKey.currentState!.openDrawer();
            //     },
            //     icon: Icon(Icons.sort_rounded)),
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
                  child: controller.allsongdata.isEmpty
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
                                scrollDirection: Axis.horizontal,
                                child: Obx(
                                  () => Row(
                                    children: [
                                      SizedBox(
                                        width: w * 0.3,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: controller
                                                            .selectedIndex ==
                                                        0
                                                    ? MyColors
                                                        .pressedbuttoncolor
                                                    : MyColors.secondaryColor,
                                                shape: StadiumBorder()),
                                            onPressed: () {
                                              controller.selectedIndex.value =
                                                  0;
                                            },
                                            child: Text(
                                              "All",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 11.5),
                                            )),
                                      ),
                                      SizedBox(
                                        width: w * 0.02,
                                      ),
                                      SizedBox(
                                        width: w * 0.3,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: controller
                                                            .selectedIndex ==
                                                        1
                                                    ? MyColors
                                                        .pressedbuttoncolor
                                                    : MyColors.secondaryColor,
                                                shape: StadiumBorder()),
                                            onPressed: () {
                                              controller.selectedIndex.value =
                                                  1;
                                            },
                                            child: Text(
                                              "Music",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 11.5),
                                            )),
                                      ),
                                      SizedBox(
                                        width: w * 0.02,
                                      ),
                                      SizedBox(
                                        width: w * 0.3,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: controller
                                                            .selectedIndex ==
                                                        2
                                                    ? MyColors
                                                        .pressedbuttoncolor
                                                    : MyColors.secondaryColor,
                                                shape: StadiumBorder()),
                                            onPressed: () {
                                              controller.selectedIndex.value =
                                                  2;
                                            },
                                            child: Text(
                                              "Recordings",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 11.5),
                                            )),
                                      ),
                                      SizedBox(
                                        width: w * 0.02,
                                      ),
                                      // SizedBox(
                                      //   width: w * 0.3,
                                      //   child: ElevatedButton(
                                      //       style: ElevatedButton.styleFrom(
                                      //           backgroundColor: controller
                                      //                       .selectedIndex ==
                                      //                   3
                                      //               ? MyColors
                                      //                   .pressedbuttoncolor
                                      //               : MyColors.secondaryColor,
                                      //           shape: StadiumBorder()),
                                      //       onPressed: () {
                                      //         controller.selectedIndex.value =
                                      //             3;
                                      //       },
                                      //       child: Text(
                                      //         "Favorites",
                                      //         style: GoogleFonts.poppins(
                                      //             color: Colors.white,
                                      //             fontSize: 11.5),
                                      //       )),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Obx(
                                  () => Text(
                                    controller.selectedIndex.value == 3
                                        ? "Your Favorites"
                                        : controller.selectedIndex.value == 1
                                            ? "Your Music"
                                            : controller.selectedIndex.value ==
                                                    2
                                                ? "Your Recordings"
                                                : "All",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Obx(() {
                                   return controller.selectedIndex.value == 0
                                      ? HomePageListsMain()
                                      : controller.selectedIndex.value == 1
                                          ? HomepageMusic()
                                          : HomepageRecordings();
                                }),
                              ),
                            ],
                          ),
                        )),
            ),
            //bottombar for player
            Expanded(
              child: Obx(() {
                var playedsong = controller.songtitle.value;
                var id = controller.songid.value;
                var artist = controller.songauthor.value;
                print("THE NAME OF THE SONG BEING PLAYED IS" + playedsong);
                return controller.allsongdata.isEmpty
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (controller.isPlaying.value == false) {
                                        controller.isPlaying(true);
                                        controller.player.play();
                                      }
                                      Get.to(
                                        () => PlayerScreen(
                                          data: controller.allsongdata,
                                        ),
                                        transition: Transition.downToUp,
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                              id: id,
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
                                                  playedsong,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  softWrap: true,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      color: Colors.white)),
                                              Text(
                                                  artist,
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
            ),
          ],
        ),
      ),
    );
  }

  ListView HomePageListsMain() {
    return ListView.builder(
                                    itemCount: controller.allsongdata.length,
                                    itemBuilder: (context, index) {
                                      print(controller.allsongdata[index].artist);
                                      return Obx(
                                        () =>
                                            //  Card(
                                            //       color: controller.playIndex == index
                                            //           ? MyColors.secondaryColor
                                            //           : Colors.transparent,
                                            //   child:
                                            ListTile(
                                                title: Text(
                                                  controller.allsongdata[index].title,
                                                  maxLines: 1,
                                                  // overflow: TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ),
                                                subtitle: Text(
                                                  controller.allsongdata[index].artist!,
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
                                                      artworkFit:
                                                          BoxFit.cover,
                                                      id: controller.allsongdata[index].id,
                                                      type: ArtworkType.AUDIO,
                                                      nullArtworkWidget: Icon(
                                                          Icons.music_note),
                                                    ),
                                                  ),
                                                ),
                                                trailing: controller.songtitle.value == controller.allsongdata[index].title &&
                                                        controller.isPlaying
                                                                .value ==
                                                            true
                                                    ? Icon(
                                                        Icons
                                                            .play_arrow_sharp,
                                                        size: 33,
                                                        color: Colors.white)
                                                    : Text(
                                                        DateFormat('mm:ss')
                                                            .format(DateTime
                                                                .fromMillisecondsSinceEpoch(
                                                                    controller.allsongdata[index]
                                                                        .duration!,
                                                                    isUtc:
                                                                        false))
                                                            .toString(),
                                                        style: GoogleFonts
                                                            .poppins(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                onTap: () {
                                                  if (controller.playIndex ==
                                                      index) {
                                                    Get.to(
                                                      () => PlayerScreen(
                                                        data: controller.allsongdata,
                                                      ),
                                                      transition:
                                                          Transition.downToUp,
                                                    );
                                                  } else {
                                                    controller.songtitle.value = controller.allsongdata[index].title;
                                                    controller.songauthor.value = controller.allsongdata[index].artist ?? "Artist" ;
                                                    controller.songid.value = controller.allsongdata[index].id;
                                                    Get.to(
                                                      () => PlayerScreen(
                                                        data: controller.allsongdata,
                                                      ),
                                                      transition:
                                                          Transition.downToUp,
                                                    );
                                                    controller.playSong(
                                                        controller.allsongdata[index].uri,
                                                        index);
                                                  }
                                                }),
                                        // ),
                                      );
                                    });
  }

   ListView HomepageMusic() {
    return ListView.builder(
                                    itemCount: controller.music.length,
                                    itemBuilder: (context, index) {
                                      print(controller.music[index].artist);
                                      return Obx(
                                        () =>
                                            //  Card(
                                            //       color: controller.playIndex == index
                                            //           ? MyColors.secondaryColor
                                            //           : Colors.transparent,
                                            //   child:
                                            ListTile(
                                                title: Text(
                                                  controller.music[index].title,
                                                  maxLines: 1,
                                                  // overflow: TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ),
                                                subtitle: Text(
                                                  controller.music[index].artist!,
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
                                                      artworkFit:
                                                          BoxFit.cover,
                                                      id: controller.music[index].id,
                                                      type: ArtworkType.AUDIO,
                                                      nullArtworkWidget: Icon(
                                                          Icons.music_note),
                                                    ),
                                                  ),
                                                ),
                                                trailing: controller.songtitle.value == controller.music[index].title &&
                                                        controller.isPlaying
                                                                .value ==
                                                            true
                                                    ? Icon(
                                                        Icons
                                                            .play_arrow_sharp,
                                                        size: 33,
                                                        color: Colors.white)
                                                    : Text(
                                                        DateFormat('mm:ss')
                                                            .format(DateTime
                                                                .fromMillisecondsSinceEpoch(
                                                                    controller.music[index]
                                                                        .duration!,
                                                                    isUtc:
                                                                        false))
                                                            .toString(),
                                                        style: GoogleFonts
                                                            .poppins(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                onTap: () {
                                                  if (controller.playIndex ==
                                                      index) {
                                                    Get.to(
                                                      () => PlayerScreen(
                                                        data: controller.music,
                                                      ),
                                                      transition:
                                                          Transition.downToUp,
                                                    );
                                                  } else {
                                                    controller.songtitle.value = controller.music[index].title;
                                                    controller.songauthor.value = controller.music[index].artist ?? "Artist" ;
                                                    controller.songid.value = controller.music[index].id;
                                                    Get.to(
                                                      () => PlayerScreen(
                                                        data: controller.music,
                                                      ),
                                                      transition:
                                                          Transition.downToUp,
                                                    );
                                                    controller.playSong(
                                                        controller.music[index].uri,
                                                        index);
                                                  }
                                                }),
                                        // ),
                                      );
                                    });
  }

   ListView HomepageRecordings() {
    return ListView.builder(
                                    itemCount: controller.recordings.length,
                                    itemBuilder: (context, index) {
                                      print(controller.recordings[index].artist);
                                      return Obx(
                                        () =>
                                            //  Card(
                                            //       color: controller.playIndex == index
                                            //           ? MyColors.secondaryColor
                                            //           : Colors.transparent,
                                            //   child:
                                            ListTile(
                                                title: Text(
                                                  controller.recordings[index].title,
                                                  maxLines: 1,
                                                  // overflow: TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ),
                                                subtitle: Text(
                                                  controller.recordings[index].artist!,
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
                                                      artworkFit:
                                                          BoxFit.cover,
                                                      id: controller.recordings[index].id,
                                                      type: ArtworkType.AUDIO,
                                                      nullArtworkWidget: Icon(
                                                          Icons.music_note),
                                                    ),
                                                  ),
                                                ),
                                                trailing: controller.songtitle.value == controller.recordings[index].title &&
                                                        controller.isPlaying
                                                                .value ==
                                                            true
                                                    ? Icon(
                                                        Icons
                                                            .play_arrow_sharp,
                                                        size: 33,
                                                        color: Colors.white)
                                                    : Text(
                                                        DateFormat('mm:ss')
                                                            .format(DateTime
                                                                .fromMillisecondsSinceEpoch(
                                                                    controller.recordings[index]
                                                                        .duration!,
                                                                    isUtc:
                                                                        false))
                                                            .toString(),
                                                        style: GoogleFonts
                                                            .poppins(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                onTap: () {
                                                  if (controller.playIndex ==
                                                      index) {
                                                    Get.to(
                                                      () => PlayerScreen(
                                                        data: controller.recordings,
                                                      ),
                                                      transition:
                                                          Transition.downToUp,
                                                    );
                                                  } else {
                                                    controller.songtitle.value = controller.recordings[index].title;
                                                    controller.songauthor.value = controller.recordings[index].artist ?? "Artist" ;
                                                    controller.songid.value = controller.recordings[index].id;
                                                    Get.to(
                                                      () => PlayerScreen(
                                                        data: controller.recordings,
                                                      ),
                                                      transition:
                                                          Transition.downToUp,
                                                    );
                                                    controller.playSong(
                                                        controller.recordings[index].uri,
                                                        index);
                                                  }
                                                }),
                                        // ),
                                      );
                                    });
  }

// for favorite
  //  ListView HomePageListsMain() { 
  //   return ListView.builder(
  //                                   itemCount: controller.allsongdata.length,
  //                                   itemBuilder: (context, index) {
  //                                     print(controller.allsongdata[index].artist);
  //                                     return Obx(
  //                                       () =>
  //                                           //  Card(
  //                                           //       color: controller.playIndex == index
  //                                           //           ? MyColors.secondaryColor
  //                                           //           : Colors.transparent,
  //                                           //   child:
  //                                           ListTile(
  //                                               title: Text(
  //                                                 controller.allsongdata[index].title,
  //                                                 maxLines: 1,
  //                                                 // overflow: TextOverflow.ellipsis,
  //                                                 softWrap: false,
  //                                                 style: GoogleFonts.poppins(
  //                                                     color: Colors.white,
  //                                                     fontSize: 14),
  //                                               ),
  //                                               subtitle: Text(
  //                                                 controller.allsongdata[index].artist!,
  //                                                 maxLines: 1,
  //                                                 softWrap: false,
  //                                                 style: GoogleFonts.poppins(
  //                                                     color: Colors.grey[300],
  //                                                     fontSize: 12),
  //                                               ),
  //                                               leading: Container(
  //                                                 width: 50,
  //                                                 height: 50,
  //                                                 decoration: BoxDecoration(
  //                                                   borderRadius:
  //                                                       BorderRadius.circular(
  //                                                           8),
  //                                                   color: Colors.grey,
  //                                                 ),
  //                                                 child: ClipRRect(
  //                                                   borderRadius:
  //                                                       BorderRadius.circular(
  //                                                           8),
  //                                                   child: QueryArtworkWidget(
  //                                                     artworkFit:
  //                                                         BoxFit.cover,
  //                                                     id: controller.allsongdata[index].id,
  //                                                     type: ArtworkType.AUDIO,
  //                                                     nullArtworkWidget: Icon(
  //                                                         Icons.music_note),
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                               trailing: controller.songtitle.value == controller.allsongdata[index].title &&
  //                                                       controller.isPlaying
  //                                                               .value ==
  //                                                           true
  //                                                   ? Icon(
  //                                                       Icons
  //                                                           .play_arrow_sharp,
  //                                                       size: 33,
  //                                                       color: Colors.white)
  //                                                   : Text(
  //                                                       DateFormat('mm:ss')
  //                                                           .format(DateTime
  //                                                               .fromMillisecondsSinceEpoch(
  //                                                                   controller.allsongdata[index]
  //                                                                       .duration!,
  //                                                                   isUtc:
  //                                                                       false))
  //                                                           .toString(),
  //                                                       style: GoogleFonts
  //                                                           .poppins(
  //                                                               color: Colors
  //                                                                   .white),
  //                                                     ),
  //                                               onTap: () {
  //                                                 if (controller.playIndex ==
  //                                                     index) {
  //                                                   Get.to(
  //                                                     () => PlayerScreen(
  //                                                       data: controller.allsongdata,
  //                                                     ),
  //                                                     transition:
  //                                                         Transition.downToUp,
  //                                                   );
  //                                                 } else {
  //                                                   controller.songtitle.value = controller.allsongdata[index].title;
  //                                                   controller.songauthor.value = controller.allsongdata[index].artist ?? "Artist" ;
  //                                                   controller.songid.value = controller.allsongdata[index].id;
  //                                                   Get.to(
  //                                                     () => PlayerScreen(
  //                                                       data: controller.allsongdata,
  //                                                     ),
  //                                                     transition:
  //                                                         Transition.downToUp,
  //                                                   );
  //                                                   controller.playSong(
  //                                                       controller.allsongdata[index].uri,
  //                                                       index);
  //                                                 }
  //                                               }),
  //                                       // ),
  //                                     );
  //                                   });
  // }
}
