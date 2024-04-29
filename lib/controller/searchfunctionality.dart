import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musicplayer/const/methods.dart';
import 'package:musicplayer/controller/playerController.dart';
import 'package:musicplayer/screens/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CustomSearchDelegate extends SearchDelegate {
  void pop(String name) async {}
  final controller = Get.find<PlayerController>();
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
        ),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (MediaQuery.of(context).viewInsets.bottom != 0) {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          query = "";
        } else {
          print("Keyboard hidden");
          Get.back();
        }
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  Widget buildResults(BuildContext context) {
    List<SongModel> matchresults =
        []; // here can be just a string for names only
    for (var song in controller.songdata) {
      if (song.displayNameWOExt.toLowerCase().contains(query.toLowerCase())) {
        matchresults.add(song);
      }
    }
    return ListView.builder(
        itemCount: matchresults.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: QueryArtworkWidget(
                id: matchresults[index].id,
                type: ArtworkType.AUDIO,
                nullArtworkWidget: Icon(Icons.music_note),
              ),
              title: Text(
                matchresults[index].displayNameWOExt,
                style: TextStyle(fontSize: 16),
              ),
              subtitle: matchresults[index].artist!.isEmpty
                  ? Text(matchresults[index].artist!)
                  : Text(""),
            ),
          );
        });
  }

  Widget buildSuggestions(BuildContext context) {
    List<SongModelClass> matchSuggestions = [];
    for (var song in controller.searchIndex) {
      if (song.displayNameWOExt.toLowerCase().contains(query.toLowerCase())) {
        matchSuggestions.add(song);
      }
    }
    print("length ${matchSuggestions.length}");
    return ListView(
      children: List.generate(matchSuggestions.length, (index) {
        return Card(
          child: ListTile(
            onTap: () {
              query = matchSuggestions[index].displayNameWOExt;
              if (MediaQuery.of(context).viewInsets.bottom != 0) {
                SystemChannels.textInput.invokeMethod('TextInput.hide');
                Future.delayed(Duration(milliseconds: 500));
                playSearchedSong(matchSuggestions, index);
                query = "";
              } else {
                playSearchedSong(matchSuggestions, index);
                query = "";
              }
            },
            leading: QueryArtworkWidget(
              id: matchSuggestions[index].id,
              type: ArtworkType.AUDIO,
              nullArtworkWidget: Icon(Icons.music_note),
            ),
            title: Text(
              matchSuggestions[index].displayNameWOExt,
              style: TextStyle(fontSize: 16),
            ),
            subtitle: matchSuggestions[index].artist == null
                ? Text("")
                : Text(matchSuggestions[index].artist!),
          ),
        );
      }),
    );
  }

  playSearchedSong(List<SongModelClass> matchSuggestions, int index) {
    for (int i = 0; i < controller.songdata.length; i++) {
      if (controller.songdata[i].displayNameWOExt ==
          matchSuggestions[index].displayNameWOExt) {
        if (controller.playIndex == i) {
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
            transition: Transition.upToDown,
          );
          controller.playSong(controller.songdata[i].uri, i);
        }
      }
    }
  }
}
