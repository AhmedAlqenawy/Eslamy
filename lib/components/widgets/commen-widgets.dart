import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:player/components/constrains/constrain.dart';
import 'package:player/services/RadioPlayer.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
  myContainerAppBar(String title){
  return Container(
      height: 0.07.sh,
      color: primColor,
      alignment: Alignment.center,
      child:autoText(title, 1, 17.ssp, FontWeight.w700, Colors.white)
  );
}

//******************************************************
myAppBar(String title){
  return AppBar(
      backgroundColor: primColor,
      elevation: 0,
      centerTitle: true,
      title:autoText(title, 1, 19.ssp, FontWeight.w700, Colors.white)
  );
}

//******************************************************
SpinKitWave spinKit(BuildContext context) {
  return SpinKitWave(
    color: Colors.white,
    size: 50.0,
  );
}

//******************************************************
AutoSizeText autoText(String text, int maxLine, double fontSize,FontWeight fontWeight, Color color ) {
  return AutoSizeText(text,
      maxLines: maxLine,
      overflow: TextOverflow.visible,
      textAlign: TextAlign.center,
      style:GoogleFonts.elMessiri(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      )
  );
}

//******************************************************
myImageContainer(BuildContext context,String image){
  return ClipRRect(
    borderRadius: BorderRadius.circular(47.r),
    child: ProgressiveImage(
      placeholder: AssetImage('assets/images/loading.gif'),
      thumbnail: NetworkImage(
          'https://i1.sndcdn.com/artworks-000558644319-udft7l-t500x500.jpg'),
      image: NetworkImage(
          'https://i1.sndcdn.com/artworks-000558644319-udft7l-t500x500.jpg'),
      fadeDuration: Duration(seconds: 2),
      excludeFromSemantics: true,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width ,
      fit: BoxFit.fill,
    ),
  );
}


//************************************************************

 radioRunContainer(var item,double contHeight2,RadioPlayerController radioController){
  return StreamBuilder(
      stream: radioController.flutterRadioPlayer.value.isPlayingStream,
      initialData:FlutterRadioPlayer.flutter_radio_paused,
      builder: (context, AsyncSnapshot<String> snapshot) {
        String returnData = snapshot.data;
        switch (returnData) {
          case FlutterRadioPlayer.flutter_radio_stopped:
            return GestureDetector(
              onTap: ()async{
                await radioController.initRadioService();
                item.radioUrl==radioController.playNow?
                await radioController.flutterRadioPlayer.value.playOrPause():
                radioController.changeServer(item.radioUrl);
              },
              child: AnimatedContainer(
                duration: Duration(seconds: 3),
                curve: Curves.bounceInOut,
                height: contHeight2,
                width: contHeight2,
                margin: EdgeInsets.all(7.sp),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100.r),
                    border: Border.all(
                        color: primColor, width: 2.sp),
                    image: DecorationImage(
                      image: NetworkImage('https://jekashop.com/media/catalog/product/cache/12ad95d8a2fb3df88ee5f5df1ef6c6e8/d/9/d9pm16520-as200.jpg'),
                      fit: BoxFit.fill,
                      //colorFilter: ColorFilter.mode(Colors.black12, BlendMode.srcOver)
                    ),
                    boxShadow: [myBoxShadow]),
              ),
            );
            break;
          case FlutterRadioPlayer.flutter_radio_loading:
            return  AnimatedContainer(
              duration: Duration(seconds: 3),
              curve: Curves.bounceInOut,
              height: contHeight2,
              width: contHeight2,
              margin: EdgeInsets.all(7.sp),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.r),
                  border: Border.all(color: primColor, width: 2.sp),
                  image: DecorationImage(
                    image: NetworkImage(
                        radioController.playNow==item.radioUrl ?
                        'https://jokercodes.com//assets/imgs/ajax-loader.gif':
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjMML9kORyTVKM5lUsJkg29Sc4H-zmIwwJUA&usqp=CAU'
                    ),
                    fit: BoxFit.fill,
                  ),
                  boxShadow: [myBoxShadow]),
            );
          case FlutterRadioPlayer.flutter_radio_error:
            return RaisedButton(
                child: Text("Retry ?"),
                onPressed: () async {
                  // await initRadioService();
                });
            break;
          default:
            return GestureDetector(
              onTap: ()async{
                item.radioUrl==radioController.playNow.value?
                await radioController.flutterRadioPlayer.value.playOrPause():
                await radioController.changeServer(item.radioUrl);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 2000),
                curve: Curves.bounceInOut,
                height: contHeight2,
                width:  contHeight2,
                margin: EdgeInsets.all(7.sp),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100.r),
                    border: Border.all(color: primColor, width: 2.sp),
                    image: DecorationImage(
                      image: NetworkImage(
                          radioController.playNow==item.radioUrl && snapshot.data == FlutterRadioPlayer.flutter_radio_playing?
                          'https://i.gifer.com/Pf0j.gif':
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjMML9kORyTVKM5lUsJkg29Sc4H-zmIwwJUA&usqp=CAU'
                      ),
                      fit: BoxFit.fill,
                    ),
                    boxShadow: [myBoxShadow]),
              )
            );
            break;
        }
      }
  );
}


////////////
customIcon(IconData icon){
    return Icon(
      icon,
      size: 30.sp,
      color: Colors.white,
    );
}
