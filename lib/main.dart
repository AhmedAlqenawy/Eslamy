import 'package:audio_service/audio_service.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:player/views/home/home.dart';
import 'package:player/views/notification/showNotication.dart';

void main() => runApp(AudioServiceWidget(child: MyApp())
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411, 877),
      allowFontScaling: true,
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quran',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:shownotification(),
      ),
    );
  }
}
