import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final OnAudioQuery audioQuery = OnAudioQuery();

  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }

  void checkPermission() async {
    var perm = await Permission.storage.request();
    if (perm.isGranted) {
      audioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: null,
        uriType: UriType.EXTERNAL,
      );
    } else {
      checkPermission();
    }
  }
}
