import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/const/colors.dart';
import 'package:musicplayer/const/methods.dart';
import 'package:musicplayer/controller/playerController.dart';
import 'package:musicplayer/screens/player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.sort_rounded)),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: MyColors.appbarColor),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        title: Text(
          "MUSIC PLAYER",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.orange,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Container(
                height: h * 0.17,
                width: w * 0.95,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(gradient: MyColors.gradient2,borderRadius: BorderRadius.circular(70)),
                child: InkWell(
                  child: Row(
                    children: [
                      SizedBox(
                        width: w * 0.05,
                      ),
                      CircleAvatar(
                        radius: w * 0.15,
                        backgroundImage:
                            AssetImage('assets/images/eminemcover1.jpg'),
                      ),
                      SizedBox(
                        width: w * 0.05,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: h * 0.04,
                          ),
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
                        width: w * 0.04,
                      ),
                          Icon(
                            Icons.play_circle_fill_sharp,
                            color: MyColors.backgroundColor,
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
          Container(
            height: h * 0.66,
            child: FutureBuilder<List<SongModel>>(
                future: controller.Onaudioquery.querySongs(
                    orderType: OrderType.ASC_OR_SMALLER,
                    sortType: null,
                    ignoreCase: true,
                    uriType: UriType.EXTERNAL),
                builder: (context, snapshot) {
                  return snapshot.data == null
                      ? CircularProgressIndicator.adaptive()
                      : snapshot.data!.isEmpty
                          ? Center(
                              child: Text("No Songs Found."),
                            )
                          : ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(2),
                                child: Obx(
                                  () => Card(
                                    color: controller.playIndex == index
                                        ? MyColors.selectedList
                                        : MyColors.titleColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Obx(
                                      () => ListTile(
                                        leading: QueryArtworkWidget(
                                          id: snapshot.data![index].id,
                                          type: ArtworkType.AUDIO,
                                          nullArtworkWidget:
                                              Icon(Icons.music_note),
                                        ),
                                        title:
                                            Text(snapshot.data![index].title),
                                        subtitle:
                                            Text(snapshot.data![index].artist!),
                                        trailing: controller.playIndex ==
                                                    index &&
                                                controller.isPlaying.value ==
                                                    true
                                            ? Icon(Icons.play_arrow_sharp,
                                                size: 30,
                                                color: MyColors.color1)
                                            : Text(DateFormat('mm:ss')
                                                .format(DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        snapshot.data![index]
                                                            .duration!,
                                                        isUtc: false))
                                                .toString()),
                                        onTap: () {
                                          if (controller.playIndex == index) {
                                            Get.to(
                                              () => PlayerScreen(
                                                data: snapshot.data!,
                                              ),
                                              transition: Transition.downToUp,
                                            );
                                          } else {
                                            Get.to(
                                              () => PlayerScreen(
                                                data: snapshot.data!,
                                              ),
                                              transition: Transition.downToUp,
                                            );
                                            controller.playSong(
                                                snapshot.data![index].uri,
                                                index);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                }),
          ),
        ],
      ),
    );
  }
}
