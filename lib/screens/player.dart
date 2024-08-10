import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/const/colors.dart';
import 'package:musicplayer/const/methods.dart';
import 'package:musicplayer/controller/playerController.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerScreen extends StatelessWidget {
  PlayerScreen({super.key, required this.data});
  List<SongModel> data;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlayerController>();
    final w = Get.width;
    final h = Get.height;
    return Container(
      height: h * 1,
      decoration: BoxDecoration(gradient: MyColors.background),
      child: GestureDetector(
        onVerticalDragEnd: (details) {
          if(details.primaryVelocity! > 0) Get.back();
        },
        child: Scaffold(
            backgroundColor: MyColors.baseColor,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 27,
                ),
              ),
              backgroundColor: Colors.transparent,
              title: Text(
                "Now Playing",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.favorite,size: 27,color: Colors.white,),),            
              ],
            ),
            body: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Container(
                      height: h * 0.55,
                      width: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                      ),
                      child: Obx(() => QueryArtworkWidget(
                          // artworkBorder: BorderRadius.circular(500),
                          size: 250,
                          quality: 100,
                          artworkQuality: FilterQuality.high,
                          id: data[controller.playIndex.value].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: Icon(
                            Icons.music_note_sharp,
                            size: 80,
                          ),
                        ),
                      ),
                    )),
                     Obx(() => Text(
                            data[controller.playIndex.value].title,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            maxLines: 1,
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: Colors.white,
                            )
                          ),
                     ),
                        Obx(() => Text(
                            data[controller.playIndex.value].artist!,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            maxLines: 1,
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.white,
                            )
                          ),
                        ),
                        Obx(
                          () => Slider(
                              max: controller.max.value,
                              min: Duration(seconds: 0).inSeconds.toDouble(),
                              value: controller.current.value,
                              thumbColor: MyColors.background1,
                              activeColor: MyColors.background1,
                              inactiveColor: Colors.grey[400],
                              onChanged: (item) {
                                controller.changeDurationToSeconds(item.toInt());
                                item = item;
                              }),
                        ),
                         Obx(
                          () => Padding(
                            padding: const EdgeInsets.fromLTRB(20,0,20,0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.position.value,
                                       style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.white,
                            )),
                                  Text(controller.duration.value,
                                       style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.white,
                            )),
                                ],
                              ),
                            ),
                          ),
                        ),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (controller.playIndex.value - 1 < 0) {
                                } else {
                                  controller.playSong(
                                      data[controller.playIndex.value - 1].uri,
                                      controller.playIndex.value - 1);
                                  print(controller.playIndex.value);
                                }
                              },
                              icon: Icon(
                                Icons.skip_previous_sharp,
                                size: 50,
                                color: Colors.black,
                              ),
                            ),
                            Obx(
                              () => CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 35,
                                  child: Transform.scale(
                                      scale: 1.5,
                                      alignment: Alignment.center,
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
                                                size: 25,
                                                color: Colors.white,
                                              )
                                            : Icon(
                                                Icons.play_arrow_sharp,
                                                size: 25,
                                                color: Colors.white,
                                              ),
                                      ))),
                            ),
                            IconButton(
                              onPressed: () {
                                if (controller.playIndex.value + 1 <
                                    data.length) {
                                  controller.playSong(
                                      data[controller.playIndex.value + 1].uri,
                                      controller.playIndex.value + 1);
                                }
                              },
                              icon: Icon(
                                Icons.skip_next_sharp,
                                size: 50,
                                color: Colors.black,
                              ),
                            ),
              ],
            )]),),
      ),
    );
  }
}


  // SafeArea(
      //   child: Obx(
      //     () => Column(children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         children: [
               
      //         ],
      //       ),
      //       GestureDetector(
      //         onVerticalDragEnd: (details) {
      //           if (details.primaryVelocity! > 0) Get.back();
      //         },
      //         child: Container(
      //           height: h * 0.6,
      //           width: w * 0.99,
                // clipBehavior: Clip.antiAliasWithSaveLayer,
                // decoration: BoxDecoration(shape: BoxShape.circle,),
                // child: QueryArtworkWidget(
                //   // artworkBorder: BorderRadius.circular(500),
                //   size: 250,
                //   quality: 100,
                //   artworkQuality: FilterQuality.high,
                //   id: data[controller.playIndex.value].id,
                //   type: ArtworkType.AUDIO,
                //   nullArtworkWidget: Icon(
                //     Icons.music_note_sharp,
                //     size: 80,
                //   ),
      //           ),
      //         ),
      //       ),
      //       Expanded(
      //         child: Container(
      //           height: h * 0.35,
      //           width: double.infinity,
      //           decoration: BoxDecoration(
      //               gradient: MyColors.player,
      //               shape: BoxShape.rectangle,
      //               borderRadius:
      //                   BorderRadius.vertical(top: Radius.circular(60))),
      //           child: Padding(
      //             padding: const EdgeInsets.all(13.0),
      //             child: Column(
      //               children: [
                      // Text(
                      //   data[controller.playIndex.value].title,
                      //   textAlign: TextAlign.center,
                      //   overflow: TextOverflow.ellipsis,
                      //   maxLines: 1,
                      //   style: TextStyle(
                      //       fontSize:
                      //           data[controller.playIndex.value].title.length >
                      //                   30
                      //               ? 20.0
                      //               : 25.0,
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      // Text(
                      //   data[controller.playIndex.value].artist!,
                      //   textAlign: TextAlign.center,
                      //   overflow: TextOverflow.ellipsis,
                      //   maxLines: 1,
                      //   style: Method.textStyle(
                      //       fontFamily: 'regular',
                      //       fontSize: 18.0,
                      //       color: Colors.white),
                      // ),
      //                 SizedBox(
      //                   height: h * 0.05,
      //                 ),
      //                 Obx(
      //                   () => Container(
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: [
      //                         Text(controller.position.value,
      //                             style: Method.textStyle(
      //                               color: MyColors.backgroundColor,
      //                             )),
      //                         Text(controller.duration.value,
      //                             style: Method.textStyle(
      //                               color: MyColors.backgroundColor,
      //                             )),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
                      // Obx(
                      //   () => Slider(
                      //       max: controller.max.value,
                      //       min: Duration(seconds: 0).inSeconds.toDouble(),
                      //       value: controller.current.value,
                      //       thumbColor: Colors.white,
                      //       activeColor: MyColors.accentColor,
                      //       inactiveColor: Colors.grey[400],
                      //       onChanged: (item) {
                      //         controller.changeDurationToSeconds(item.toInt());
                      //         item = item;
                      //       }),
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     IconButton(
                      //       onPressed: () {
                      //         if (controller.playIndex.value - 1 < 0) {
                      //         } else {
                      //           controller.playSong(
                      //               data[controller.playIndex.value - 1].uri,
                      //               controller.playIndex.value - 1);
                      //           print(controller.playIndex.value);
                      //         }
                      //       },
                      //       icon: Icon(
                      //         Icons.skip_previous_sharp,
                      //         size: 50,
                      //         color: MyColors.backgroundColor,
                      //       ),
                      //     ),
                      //     Obx(
                      //       () => CircleAvatar(
                      //           backgroundColor: Colors.grey[900],
                      //           radius: 40,
                      //           child: Transform.scale(
                      //               scale: 1.5,
                      //               alignment: Alignment.center,
                      //               child: IconButton(
                      //                 onPressed: () {
                      //                   if (controller.isPlaying.value ==
                      //                       true) {
                      //                     controller.isPlaying(false);
                      //                     controller.player.pause();
                      //                   } else {
                      //                     controller.isPlaying(true);
                      //                     controller.player.play();
                      //                   }
                      //                 },
                      //                 icon: controller.isPlaying.value
                      //                     ? Icon(
                      //                         Icons.pause,
                      //                         size: 34,
                      //                         color: Colors.white,
                      //                       )
                      //                     : Icon(
                      //                         Icons.play_arrow_sharp,
                      //                         size: 34,
                      //                         color: Colors.white,
                      //                       ),
                      //               ))),
                      //     ),
                      //     IconButton(
                      //       onPressed: () {
                      //         if (controller.playIndex.value + 1 <
                      //             data.length) {
                      //           controller.playSong(
                      //               data[controller.playIndex.value + 1].uri,
                      //               controller.playIndex.value + 1);
                      //         }
                      //       },
                      //       icon: Icon(
                      //         Icons.skip_next_sharp,
                      //         size: 50,
                      //         color: MyColors.backgroundColor,
                      //       ),
                      //     ),
      //                   ],
      //                 )
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     ]),
      //   ),
      // ),
