import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Color primColor = Color(0xFFFF4F7D);

BoxShadow myBoxShadow = BoxShadow(
  color: Colors.black26,
  offset: Offset(1, 1),
  blurRadius: 5,
  spreadRadius: 1,
);

BoxDecoration notificationBoxShadow = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(
      15.r,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        spreadRadius: 1,
        blurRadius: 1,
        offset: Offset(1, 1),
      ),
    ]);
