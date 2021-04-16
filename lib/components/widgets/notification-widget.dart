import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:flutter/material.dart';
import 'package:player/components/constrains/constrain.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:player/components/widgets/commen-widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;

salahTypeContainer(Audio audio,String label,Color color){
  return GestureDetector(
    onTap:(){
//      audio = Audio.load('assets/salah.mp3');
//      audio.play();
//      salahtype = "salah";
//      prefs.setString("salahtype", "salah");
    },
    child: Container(
      width: 0.25.sw,
      height: 0.05.sh,
      alignment: Alignment.center,
      decoration: notificationBoxShadow.copyWith(
        color: color,
      ),
      child: autoText(label, 1, 17.ssp, FontWeight.w600, Colors.black,),
    ),
  );
}