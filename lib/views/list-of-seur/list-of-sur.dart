import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:player/components/constrains/constrain.dart';
import 'package:player/components/widgets/commen-widgets.dart';
import 'package:player/components/widgets/list-of-suras-widgets.dart';
import 'package:player/views/list-of-seur/sur-of-list-view-model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:player/views/play-page/playClasses.dart';

import '../../classes.dart';
import '../test.dart';

// ignore: must_be_immutable
class ListOfSurPage extends StatelessWidget {
  ListOfSurPage(this.reciterName,this.server);
  String reciterName;
  String server;
  SurController sur=Get.put(SurController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: primColor,
          appBar: myAppBar(reciterName),
          body: SafeArea(
              child:Obx(()=>sur.isLoading.value?
                  spinKit(context)
                  : ListView.builder(
                   itemCount: sur.surList.length,
                   itemBuilder: (context, index) => GestureDetector(
                    onTap: (){
                      var num='';
                      if(index+1<10)
                        num='00${index+1}.mp3';
                      else if(index+1<100)
                        num='0${index+1}.mp3';
                      else
                        num='${index+1}.mp3';
                      if(MediaLibrary.items.isEmpty==true)
                        MediaLibrary.add(MediaItem(
                          id:  '$server/$num',
                          album: "قرآن",
                          title: sur.surList[index].nameArabic,
                          artist: reciterName,
                          playable: true,
                          duration: Duration(milliseconds: 50739),
                          //artUri: "https://images-na.ssl-images-amazon.com/images/I/71Dpex3OrOL.png",
                        ));
                      else if(MediaLibrary.items[0]!=MediaItem(
                        id:  '$server/$num',
                        album: "قرآن",
                        title: sur.surList[index].nameArabic,
                        artist: reciterName,
                        playable: true,
                        duration: Duration(milliseconds: 50739),
                        //artUri: "https://images-na.ssl-images-amazon.com/images/I/71Dpex3OrOL.png",
                      ))
                        AudioService.stop();
                      Get.to(play2(
                          MediaItem(
                            id:  '$server/$num',
                            album: "قرآن",
                            title: sur.surList[index].nameArabic,
                            artist: reciterName,
                            playable: true,
                            duration: Duration(milliseconds: 50739),
                            //artUri: "https://images-na.ssl-images-amazon.com/images/I/71Dpex3OrOL.png",
                          )
                         /* sur.surList[index].nameArabic,
                          reciterName,
                          '$server/$num'*/
                      ));
                    },
                    child: Container(
                        height: 0.13.sh,
                        margin: EdgeInsets.all(5.sp),
                        padding: EdgeInsets.all(5.sp),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [myBoxShadow]),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 0.12.sh,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(50.r),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://i.pinimg.com/736x/97/ea/81/97ea81d52f91ae1ccff5b2d35ba411de.jpg'),
                                          fit: BoxFit.fill),
                                      boxShadow: [myBoxShadow]
                                  ),
                                ),
                                Container(
                                  width: 100.w,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      autoText(
                                          sur.surList[index].nameSimple,
                                          1,
                                          18.ssp,
                                          FontWeight.w600,
                                          Colors.black),
                                      autoText(
                                          '${sur.surList[index].revelationPlace}',
                                          1,
                                          19.ssp,
                                          FontWeight.w500,
                                          Colors.black54),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            textContainer(sur.surList[index].versesCount.toString(),50.w),
                            textContainer(sur.surList[index].nameArabic,90.w)
                          ],
                        )
                    ),
                  )
              ))
          )
    );
  }
}
