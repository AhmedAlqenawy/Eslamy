import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:player/components/constrains/constrain.dart';
import 'package:player/components/widgets/commen-widgets.dart';
import 'package:player/components/widgets/notification-widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowNotification extends StatefulWidget {
  @override
  _ShowNotificationState createState() => _ShowNotificationState();
}

class _ShowNotificationState extends State<ShowNotification> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var a = AudioPlayer();
  SharedPreferences prefs;

  bool salah = false, quam = false, quran = false;
  String salahtype = "";
  Audio audio;

  void shroe() async {
    print(a.getDuration());
  }

  Future<void> _cancelNotificationWithTag(var tag) async {
    await flutterLocalNotificationsPlugin.cancel(0, tag: tag);
  }

  Future<void> _getBool() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("salah") == null) {
      prefs.setBool("salah", false);
      salah = false;
    } else {
      salah = prefs.getBool("salah");
    }

    if (prefs.getBool("quam") == null) {
      prefs.setBool("quam", false);
      quam = false;
    } else {
      quam = prefs.getBool("quam");
    }

    if (prefs.getBool("quran") == null) {
      prefs.setBool("quran", false);
      quran = false;
    } else {
      quran = prefs.getBool("quran");
    }

    if (prefs.getString("salahtype") == null) {
      prefs.setString("salahtype", "salah");
      salahtype = "salah";
    } else {
      salahtype = prefs.getString("salahtype");
    }
  }

  @override
  void initState() {
    _getBool();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings("@mipmap/ic_launcher");
    var ios = new IOSInitializationSettings();
    var setting = new InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(setting);
    super.initState();
  }

  Future<void> _showNotification() async {
    var andriod = AndroidNotificationDetails(
        "channelId", "channelName", "channelDescription",
        playSound: true, priority: Priority.high);
    var ios = IOSNotificationDetails();
    var platform = new NotificationDetails(iOS: ios, android: andriod);
    flutterLocalNotificationsPlugin.show(1, "title", "body", platform,
        payload: "Message");
  }

  Future<void> _repeatNotification(var duration, String notificationSound) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        new AndroidNotificationDetails(
      'repeating channel id',
      'repeating channel name',
      'repeating description',
      tag: "tag1",
      sound: RawResourceAndroidNotificationSound(notificationSound),
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    if (duration == "minute")
      await flutterLocalNotificationsPlugin.periodicallyShow(0, 'اذكار',
          'صلى على محمد', RepeatInterval.everyMinute, platformChannelSpecifics,
          androidAllowWhileIdle: true);
    else if (duration == "houre")
      await flutterLocalNotificationsPlugin.periodicallyShow(0, 'اذكار',
          'صلى على محمد', RepeatInterval.hourly, platformChannelSpecifics,
          androidAllowWhileIdle: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
         child: Container(
          height: 1.sh,
           margin: EdgeInsets.symmetric(
             horizontal: 25.w,
           ),
          child: ListView(
            children: [
              SizedBox(
                height: 15.h,
              ),
              AnimatedContainer(
                  duration: Duration(
                    milliseconds: 700,
                  ),
                  curve: Curves.bounceOut,
                  height: salah?0.32.sh:0.1.sh,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  decoration: notificationBoxShadow,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Switch(
                                value: salah,
                                activeColor: primColor,
                                onChanged: (val) {
                                  setState(() {
                                    salah = val;
                                    prefs.setBool("salah", salah,);
                                    if (salah == true)
                                      _repeatNotification("minute", salahtype,);
                                    else
                                      _cancelNotificationWithTag("tag1",);
                                  },);
                                },),
                            autoText(
                              "الصلاه على النبى",
                              1,
                              18.ssp,
                              FontWeight.w800,
                              Colors.black,
                            ),
                          ],
                        ),
                      ),
                      salah?Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Padding(
                                padding:  EdgeInsets.symmetric(vertical: 5.h,),
                                child: autoText('اختر صيغة الاشعارات', 1, 17.ssp, FontWeight.w600, Colors.black,),
                              ),
                            ),
                            Flexible(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  salahTypeContainer(audio,'نغمه 3',primColor,),
                                  salahTypeContainer(audio,'نغمه 2',Colors.white,),
                                  salahTypeContainer(audio,'نغمه 1',Colors.white,),
                                ],
                              ),
                            ),
                            Flexible(
                                child: Padding(
                                padding:  EdgeInsets.symmetric(vertical: 5.h,),
                                child: autoText('اختر توقيت الاشعارات', 1, 17.ssp, FontWeight.w600, Colors.black,),
                              ),
                            ),
                            Flexible(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  salahTypeContainer(audio,'اسبوع',primColor,),
                                  salahTypeContainer(audio,'يوم',Colors.white,),
                                  salahTypeContainer(audio,'ساعه',Colors.white,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ):SizedBox(),
                    ],
                  ),),
              SizedBox(
                height: 15.h,
              ),
              AnimatedContainer(
                duration: Duration(
                  milliseconds: 700,
                ),
                curve: Curves.bounceOut,
                height: quam?0.26.sh:0.1.sh,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                decoration: notificationBoxShadow,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Switch(
                            value: quam,
                            activeColor: primColor,
                            onChanged: (val) {
                              setState(() {
                                quam = val;
                                prefs.setBool("quam", quam);
                                if (quam == true)
                                  _repeatNotification("minute", salahtype);
                                else
                                  _cancelNotificationWithTag("tag1");
                              });
                            },),
                          autoText(
                            "قيام الليل",
                            1,
                            18.ssp,
                            FontWeight.w800,
                            Colors.black,
                          ),
                        ],
                      ),
                    ),
                    quam ? Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Padding(
                              padding:  EdgeInsets.symmetric(vertical: 5.h,),
                              child: autoText('اختر صيغة الاشعارات', 1, 17.ssp, FontWeight.w600, Colors.black,),
                            ),
                          ),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                salahTypeContainer(audio,'نغمه 2',primColor,),
                                salahTypeContainer(audio,'نغمه 1',Colors.white,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ):SizedBox(),
                  ],
                ),),
              SizedBox(
                height: 15.h,
              ),
              AnimatedContainer(
                duration: Duration(
                  milliseconds: 700,
                ),
                curve: Curves.bounceOut,
                height: quran?0.26.sh:0.1.sh,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                decoration: notificationBoxShadow,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Switch(
                            value: quran,
                            activeColor: primColor,
                            onChanged: (val) {
                              setState(() {
                                quran = val;
                                prefs.setBool("quran", quran);
                                if (quran == true)
                                  _repeatNotification("minute", salahtype);
                                else
                                  _cancelNotificationWithTag("tag1");
                              });
                            },),
                          autoText(
                            'قراءه القران',
                            1,
                            18.ssp,
                            FontWeight.w800,
                            Colors.black,
                          ),
                        ],
                      ),
                    ),
                    quran ? Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Padding(
                              padding:  EdgeInsets.symmetric(vertical: 5.h,),
                              child: autoText('اختر صيغة الاشعارات', 1, 17.ssp, FontWeight.w600, Colors.black,),
                            ),
                          ),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                salahTypeContainer(audio,'نغمه 2',primColor,),
                                salahTypeContainer(audio,'نغمه 1',Colors.white,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ):SizedBox(),
                  ],
                ),),
            ],
          ),),
    ),);
  }
}
