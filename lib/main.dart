import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:player/components/constrains/constrain.dart';
import 'package:player/components/widgets/commen-widgets.dart';
import 'package:player/views/home/home.dart';
import 'package:player/views/list-of-reciters/list-of-reciters.dart';
import 'package:side_menu_animation/side_menu_animation.dart';

import 'package:player/views/notification/showNotication.dart';

void main() => runApp(AudioServiceWidget(child: MyApp()));

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
        home: SideMenuBuilderScreen(),
      ),
    );
  }
}

class SideMenuBuilderScreen extends StatelessWidget {
  final _index = ValueNotifier<int>(1);

  List<String> titlesList = ['القران الكريم', 'الاشعارات', 'قائمه المقرئيين'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SideMenuAnimation.builder(
        builder: (showMenu) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: showMenu,
              ),
              backgroundColor: primColor,
              elevation: 0,
              brightness: Brightness.light,
              centerTitle: true,
              title: ValueListenableBuilder<int>(
                valueListenable: _index,
                builder: (_, value, __) => autoText(
                  titlesList[_index.value - 1],
                  1,
                  20.ssp,
                  FontWeight.w600,
                  Colors.white,
                ),
              ),
            ),
            body: ValueListenableBuilder<int>(
              valueListenable: _index,
              builder: (_, value, __) => IndexedStack(
                index: value - 1,
                children: [
                  Home(),
                  ShowNotification(),
                  RecitersPage('all'),
                ],
              ),
            ),
          );
        },
        items: [
          customIcon(Icons.exit_to_app_outlined),
          customIcon(Icons.home),
          customIcon(Icons.notifications),
          customIcon(Icons.star_rate_outlined),
          customIcon(Icons.rate_review_outlined),
        ],
        selectedColor: primColor,
        unselectedColor: Color(0xFF1F2041),
        tapOutsideToDismiss: true,
        curveAnimation: Curves.bounceInOut,
        duration: Duration(
          milliseconds: 500,
        ),
        scrimColor: Colors.black45,
        onItemSelected: (value) {
          if (value > 0 && value != _index.value) _index.value = value;
        },
      ),
    );
  }
}
