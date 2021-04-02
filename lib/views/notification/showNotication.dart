import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:player/components/constrains/constrain.dart';
import 'package:player/components/widgets/commen-widgets.dart';
import 'package:player/components/widgets/home-widget.dart';
import 'package:player/views/list-of-reciters/list-of-reciters.dart';
import 'package:shared_preferences/shared_preferences.dart';

class shownotification extends StatefulWidget {
  @override
  _shownotificationState createState() => _shownotificationState();
}

class _shownotificationState extends State<shownotification> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var a = AudioPlayer();
  SharedPreferences prefs ;
  bool salah=false,quam=false,quran=false; String salahtype="";
  Audio audio;
  void shroe() async {
    print(a.getDuration());
  }
  Future<void> _cancelNotificationWithTag(var Tag) async {
    await flutterLocalNotificationsPlugin.cancel(0, tag: Tag);
  }

  Future<void> _getbool()async {
    prefs =await  SharedPreferences.getInstance();
    if(prefs.getBool("salah")==null)
      {prefs.setBool("salah", false);salah=false;}
    else
      {salah=prefs.getBool("salah");}

    if(prefs.getBool("quam")==null)
    {prefs.setBool("quam", false);quam=false;}
    else
    {quam=prefs.getBool("quam");}


    if(prefs.getBool("quran")==null)
    {prefs.setBool("quran", false);quran=false;}
    else
    {quran=prefs.getBool("quran");}

    if(prefs.getString("salahtype")==null)
    {prefs.setString("salahtype", "salah");salahtype="salah";}
    else
    {salahtype=prefs.getString("salahtype");}
  }
  @override
  void initState() {
    _getbool();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var andriod = new AndroidInitializationSettings("@mipmap/ic_launcher");
    var ios = new IOSInitializationSettings();
    var seting = new InitializationSettings(android: andriod, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(seting);

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

  Future<void> _showNotificationCustomSound() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your other channel id',
      'your other channel name',
      'your other channel description',
      sound: RawResourceAndroidNotificationSound('slow_spring_board'),
      playSound: true,
      // sound: ,
    );
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: 'slow_spring_board.aiff');
    const MacOSNotificationDetails macOSPlatformChannelSpecifics =
        MacOSNotificationDetails(sound: 'slow_spring_board.aiff');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
        macOS: macOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        'custom sound notification title',
        'custom sound notification body',
        platformChannelSpecifics);
  }

  Future<void> _repeatNotification(var duration,String notificationsound) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        new AndroidNotificationDetails(
      'repeating channel id',
      'repeating channel name',
      'repeating description',tag: "tag1",
      sound: RawResourceAndroidNotificationSound(notificationsound),
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


  Future<void> _cancelNotification(){

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
            height: 0.99.sh,
        child:Column(
          textDirection: TextDirection.ltr,
          children: [
            myAppBar('الاعدادات'),
            SizedBox(
              height: 15.h,
            ),
           /* ExpandablePanel(
              theme: ExpandableThemeData(

              ),
              header:   autoText("الصلاه على النبى", 1, 20.ssp, FontWeight.w800, Colors.black),

              collapsed: Text("article", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
              expanded: Text("articlebody", softWrap: true, ),
              controller:ExpandableController(
                initialExpanded: true,
              ) ,
              ),
*/
            Container(
                height: 40.h,
                margin: EdgeInsets.symmetric(horizontal: 15.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Switch(
                      value: salah,
                      activeColor: primColor,
                      onChanged: (val){
                        setState(() {
                          salah=val;
                          prefs.setBool("salah", salah);
                          if(salah==true)
                            _repeatNotification("minute",salahtype);
                          else
                            _cancelNotificationWithTag("tag1");
                        });
                  }),
                    autoText("الصلاه على النبى", 1, 20.ssp, FontWeight.w800, Colors.black),
                  ],
                )),
            SizedBox(
              height: 15.h,
            ),
            Center(
              child:  autoText("صيغه الذكر", 1, 17.ssp, FontWeight.w800, Colors.black),
            ),
            Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  child: Text("صيغه 1"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: (){
                   audio = Audio.load('assets/salah.mp3');
                  audio.play();
                   salahtype="salah";
                   prefs.setString("salahtype", "salah");
                },

                ),
                ElevatedButton(child: Text("صيغه 2"),onPressed: (){
                  audio = Audio.load('assets/salahh.mp3');
                  audio.play();
                  prefs.setString("salahtype", "salahh");

                  salahtype="salahh";
                },),
                ElevatedButton(child: Text("صيغه 3"),onPressed: (){
                  audio = Audio.load('assets/salahhh.mp3');
                  audio.play();
                  prefs.setString("salahtype", "salahhh");
                  salahtype="salahhh";
                },),
            ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
                height: 40.h,
                margin: EdgeInsets.symmetric(horizontal: 15.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Switch(
                      value: quam,
                      activeColor: primColor,
                      onChanged: (val){
                        setState(() {
                          quam=val;
                          prefs.setBool("quam", quam);
                        });

                  }),
                    autoText("قيام الليل", 1, 20.ssp, FontWeight.w800, Colors.black),
                  ],
                )),
            Center(
              child:  autoText("صيغه الذكر", 1, 17.ssp, FontWeight.w800, Colors.black),
            ),
            Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(child: Text("صيغه 1"),onPressed: (){
                  audio = Audio.load('assets/salah.mp3');
                  audio.play();
                },),
                ElevatedButton(child: Text("صيغه 2"),onPressed: (){
                  audio = Audio.load('assets/salah.mp3');
                  audio.play();
                },),
               ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
                height: 40.h,
                margin: EdgeInsets.symmetric(horizontal: 15.sp),
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Switch(
                      value: quran,
                      activeColor: primColor,
                      onChanged: (val){

                        setState(() {
                          quran=val;
                          prefs.setBool("quran", quran);

                        });
                  }),
                    autoText("قراءه القران ", 1, 20.ssp, FontWeight.w800, Colors.black),
                  ],
                )),


          ],
        )
        ));
  }
}
