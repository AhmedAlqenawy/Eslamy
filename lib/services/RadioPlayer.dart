import 'package:flutter/services.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:get/get.dart';

class RadioPlayerController extends GetxController{
  @override
  void onInit() {
    super.onInit();
    initRadioService();
  }
  var playNow=''.obs;
  var flutterRadioPlayer =  FlutterRadioPlayer().obs;
  var metaData='Radio Channel'.obs;
  Future<void> initRadioService() async {
    try {
     // await flutterRadioPlayer.value.init('Quran Kareem', "Live", "http://live.mp3quran.net:9992/;", "false");
    } on PlatformException {
      print("Exception occurred while trying to register the services.");
    }
  }

  Future<void> changeServer(String server) async {
     flutterRadioPlayer.value.setUrl(server, "true");
      playNow.value=server;
      update();
  }
}