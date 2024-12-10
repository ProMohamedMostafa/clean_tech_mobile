import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';

Widget profileWidget() {
  return Center(
    child: Container(
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColor.primaryColor,
          width: 2.w,
        ),
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/profile.png',
          width: 90.w,
          height: 90.h,
        ),
      ),
    ),
  );
}
