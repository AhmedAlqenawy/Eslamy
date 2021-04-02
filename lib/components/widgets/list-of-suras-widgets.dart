import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:player/components/widgets/commen-widgets.dart';

textContainer(String text,double width){
  return Container(
    width: width,
    alignment: Alignment.center,
    child: autoText(
        text,
        2,
        19.ssp,
        FontWeight.w600,
        Colors.black),
  );
}