import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:just_audio/just_audio.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final AudioPlayer audioPlayer = AudioPlayer(); // Use just_audio's AudioPlayer

  // late RxInt playIndex;
  var playIndex = 0.obs;
  var isPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }

  Future<void> playSong(String? uri, index) async {
    if (uri == null) {
      print("URI cannot be null.");
      return; // Early return if the URI is null
    }
    playIndex.value = index;
    try {
      await audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(uri),
        ),
      );
      await audioPlayer.play(); // Use await to ensure the method completes
      isPlaying(true);
    } catch (e) {
      print("Error playing song: ${e.toString()}");
    }
  }

  void checkPermission() async {
    var perm = await Permission.storage.request();
    if (perm.isGranted) {
      await audioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: null,
        uriType: UriType.EXTERNAL,
      );
    } else {
      print("Permission denied. Requesting permission again.");
      checkPermission(); // You might want to handle this differently in a real app
    }
  }
}
