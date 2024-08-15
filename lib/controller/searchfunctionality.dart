import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/const/colors.dart';
import 'package:musicplayer/const/methods.dart';
import 'package:musicplayer/controller/playerController.dart';
import 'package:musicplayer/screens/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CustomSearchDelegate extends SearchDelegate {
  void pop(String name) async {}
  final controller = Get.find<PlayerController>();

  // Define your dark theme colors here
  final Color _darkTextColor = Colors.white;
  final Color _darkSubtitleTextColor = Colors.grey[400]!;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.white, // Set color for the clear icon
        ),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  ThemeData appBarTheme(BuildContext context) {
  final ThemeData theme = Theme.of(context);
  return theme.copyWith(
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.black,
      titleTextStyle: GoogleFonts.poppins(color: Colors.white),
      toolbarTextStyle: GoogleFonts.poppins(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
      hintStyle: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
      border: InputBorder.none,
      // Set the text style to white here
      // This is where you define the text color in the TextField
      prefixStyle: GoogleFonts.poppins(color: Colors.white),
      suffixStyle: GoogleFonts.poppins(color: Colors.white),
    ),
    textTheme: theme.textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
  );
}


  @override
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
      icon: Icon(Icons.arrow_back,
          color: Colors.white), // Set color for the back icon
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<SongModel> matchResults = [];
    for (var song in controller.allsongdata) {
      if (song.displayNameWOExt.toLowerCase().contains(query.toLowerCase())) {
        matchResults.add(song);
      }
    }

    return Container(
      decoration: BoxDecoration(gradient: MyColors.background),
      child: ListView.builder(
        itemCount: matchResults.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: QueryArtworkWidget(
              id: matchResults[index].id,
              type: ArtworkType.AUDIO,
              nullArtworkWidget: Icon(Icons.music_note, color: _darkTextColor),
            ),
            title: Text(
              matchResults[index].displayNameWOExt,
              style: TextStyle(
                  fontSize: 16,
                  color: _darkTextColor), // Set dark theme text color
            ),
            subtitle: Text(
              matchResults[index].artist ?? '',
              style: TextStyle(
                  color:
                      _darkSubtitleTextColor), // Set dark theme subtitle color
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<SongModelClass> matchSuggestions = [];
    for (var song in controller.searchIndex) {
      if (song.displayNameWOExt.toLowerCase().contains(query.toLowerCase())) {
        matchSuggestions.add(song);
      }
    }

    return Container(
      decoration: BoxDecoration(gradient: MyColors.background),
      child: ListView.builder(
        itemCount: matchSuggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () async {
              if (MediaQuery.of(context).viewInsets.bottom != 0) {
                SystemChannels.textInput.invokeMethod('TextInput.hide');
              }
              await Future.delayed(Duration(milliseconds: 100));
              playSearchedSong(matchSuggestions, index);
              query = "";
            },
            leading: QueryArtworkWidget(
              id: matchSuggestions[index].id,
              type: ArtworkType.AUDIO,
              nullArtworkWidget: Icon(Icons.music_note, color: _darkTextColor),
            ),
            title: Text(
              matchSuggestions[index].displayNameWOExt,
              style: TextStyle(
                  fontSize: 16,
                  color: _darkTextColor), // Set dark theme text color
            ),
            subtitle: Text(
              matchSuggestions[index].artist ?? '',
              style: TextStyle(
                  color:
                      _darkSubtitleTextColor), // Set dark theme subtitle color
            ),
          );
        },
      ),
    );
  }

  void playSearchedSong(List<SongModelClass> matchSuggestions, int index) {
    for (int i = 0; i < controller.allsongdata.length; i++) {
      if (controller.allsongdata[i].displayNameWOExt ==
          matchSuggestions[index].displayNameWOExt) {
        if (controller.playIndex == i) {
          Get.to(
            () => PlayerScreen(
              data: controller.allsongdata,
            ),
            transition: Transition.downToUp,
          );
        } else {
          Get.to(
            () => PlayerScreen(
              data: controller.allsongdata,
            ),
            transition: Transition.upToDown,
          );
          controller.playSong(controller.allsongdata[i].uri, i);
        }
      }
    }
  }
}
