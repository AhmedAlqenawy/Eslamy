import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:player/components/constrains/constrain.dart';
import 'package:player/components/widgets/commen-widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:player/models/famous-radio.dart';
import 'package:player/services/RadioPlayer.dart';
import 'package:player/views/radio-list/radio-list.dart';


headContainer( String title, Widget toPage) {
  return Container(
      height: 40.h,
      margin: EdgeInsets.symmetric(horizontal: 10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
              onTap: (){
                Get.to(toPage);
              },
              child: Icon(
            Icons.more,
            color: primColor,
            size: 35.sp,
          )),
          autoText(title, 1, 20.ssp, FontWeight.w800, Colors.black),
        ],
      ));
}

radioSection(BuildContext context,double contHeight2,RadioPlayerController radioController){
return Container(
  margin: EdgeInsets.symmetric(vertical: 10.h),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
      headContainer('اذاعات الراديو',RadioListPage()),
      Container(
        height: 240.h,
        child: ListView.builder(
            reverse: true,
            itemCount: radioList.length,
            itemExtent: 160.h,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  radioRunContainer(radioList[index],contHeight2,radioController),
                  Container(
                      height: 40.h,
                      child: autoText(radioList[index].name, 2,
                          18.ssp, FontWeight.w700, Colors.black))
                ],
              );
            }),
      )
    ],
  ),
);
}