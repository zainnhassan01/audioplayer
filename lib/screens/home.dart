import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/const/colors.dart';
import 'package:musicplayer/const/methods.dart';
import 'package:musicplayer/controller/playerController.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    // var controller = Get.put(PlayerController());
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
                decoration: BoxDecoration(gradient: MyColors.gradient2),
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.play_arrow,
                            size: w* 0.1,
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: h * 0.66,
              // child: FutureBuilder(
              //   future: controller.Onaudioquery.querySongs(
              //       orderType: OrderType.ASC_OR_SMALLER,
              //       sortType: null,
              //       ignoreCase: true,
              //       uriType: UriType.EXTERNAL),
              //   builder: (context, snapshot) => 
                // snapshot.data == null
                //     ? CircularProgressIndicator.adaptive()
                //     : snapshot.data!.isEmpty
                //         ? Center(
                //             child: Text("No Songs Found."),
                //           )
                //         : 
                child:        ListView.builder(
                            itemCount: 20,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(2),
                              child: Card(
                                color: MyColors.tileColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: AssetImage(
                                      'assets/images/eminemcover2.jpg',
                                    ),
                                    radius: 28,
                                  ),
                                  title: Text("Song Name $index"),
                                  subtitle: Text("Eminem"),
                                  trailing: Icon(Icons.music_note),
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
