import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyColors.baseColor,
      body: SafeArea(
        child: Obx(
          () => Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 27,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity! > 0) Get.back();
              },
              child: Container(
                height: h * 0.6,
                width: w * 0.99,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: QueryArtworkWidget(
                  artworkBorder: BorderRadius.circular(500),
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
            ),
            Expanded(
              child: Container(
                height: h * 0.35,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: MyColors.player,
                    shape: BoxShape.rectangle,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(60))),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    children: [
                      Text(
                        data[controller.playIndex.value].title,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize:
                                data[controller.playIndex.value].title.length >
                                        30
                                    ? 20.0
                                    : 25.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        data[controller.playIndex.value].artist!,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Method.textStyle(
                            fontFamily: 'regular',
                            fontSize: 18.0,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: h * 0.05,
                      ),
                      Obx(
                        () => Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(controller.position.value,
                                  style: Method.textStyle(
                                    color: MyColors.backgroundColor,
                                  )),
                              Text(controller.duration.value,
                                  style: Method.textStyle(
                                    color: MyColors.backgroundColor,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Obx(
                        () => Slider(
                            max: controller.max.value,
                            min: Duration(seconds: 0).inSeconds.toDouble(),
                            value: controller.current.value,
                            thumbColor: Colors.white,
                            activeColor: MyColors.accentColor,
                            inactiveColor: Colors.grey[400],
                            onChanged: (item) {
                              controller.changeDurationToSeconds(item.toInt());
                              item = item;
                            }),
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
                              color: MyColors.backgroundColor,
                            ),
                          ),
                          Obx(
                            () => CircleAvatar(
                                backgroundColor: Colors.grey[900],
                                radius: 40,
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
                                              size: 34,
                                              color: Colors.white,
                                            )
                                          : Icon(
                                              Icons.play_arrow_sharp,
                                              size: 34,
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
                              color: MyColors.backgroundColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
