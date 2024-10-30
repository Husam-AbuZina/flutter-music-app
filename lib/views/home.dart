import 'package:beats/controllers/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart'; // Ensure this is imported
import '../consts/text_style.dart';
import '../consts/colors.dart';
import './player.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());

    return Scaffold(
      backgroundColor: bgDarkColor,
      appBar: AppBar(
        backgroundColor: bgDarkColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: whiteColor),
          )
        ],
        leading: Icon(
          Icons.sort_rounded,
          color: whiteColor,
        ),
        title: Text(
          "Beats",
          style: ourStyle(
            family: bold,
            size: 18,
          ),
        ),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType: UriType.EXTERNAL,
        ),
        initialData: const [], // Use an empty list as the initial data
        builder:
            (BuildContext context, AsyncSnapshot<List<SongModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print(snapshot.data);
            return const Center(
              child: Text(
                "No song found",
                style: TextStyle(color: whiteColor),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: snapshot.data!.length, // Get actual data length
              itemBuilder: (BuildContext context, int index) {
                final song = snapshot.data![index]; // Access song data
                return Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Obx(
                    () => ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: Text(
                        song.title, // Use song title
                        style: ourStyle(
                          family: bold,
                          size: 15,
                        ),
                      ),
                      subtitle: Text(
                        "$snapshot.data![index].artist" ??
                            "Unknown Artist", // Handle null artist
                        style: ourStyle(
                          family: regular,
                          size: 12,
                        ),
                      ),
                      leading: QueryArtworkWidget(
                        id: snapshot.data![index].id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: const Icon(Icons.music_note,
                            color: whiteColor, size: 32),
                      ),
                      trailing: controller.playIndex == index &&
                              controller.isPlaying.value
                          ? const Icon(Icons.play_arrow,
                              color: whiteColor, size: 26)
                          : null,
                      onTap: () {
                        //controller.playSong(snapshot.data![index].uri, index);
                        Get.to(() => const Player());
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
