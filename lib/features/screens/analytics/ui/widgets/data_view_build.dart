import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

Widget dataViewBuild() {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
    Expanded(
      child: Container(
        height: 110.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Color(0xFF00a9b5),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(
              "assets/images/lines.png",
              color: Colors.white,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "64",
                    style: TextStyles.font16WhiteSemiBold,
                  ),
                  Text(
                    "employee\nIn\nOrganization ",
                    textAlign: TextAlign.center,
                    style: TextStyles.font13Whitemedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    horizontalSpace(10),
    Expanded(
      child: Container(
        height: 110.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Color(0xFFEAAC7F),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(
              "assets/images/lines2.png",
              color: Colors.white,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "8",
                    style: TextStyles.font16WhiteSemiBold,
                  ),
                  Text(
                    "employee\nIn\nBuilding",
                    textAlign: TextAlign.center,
                    style: TextStyles.font13Whitemedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    horizontalSpace(10),
    Expanded(
      child: Container(
        height: 110.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Color(0xFF00a9b5),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(
              "assets/images/lines.png",
              color: Colors.white,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "8",
                    style: TextStyles.font16WhiteSemiBold,
                  ),
                  Text(
                    "employee\nIn\nFloor",
                    textAlign: TextAlign.center,
                    style: TextStyles.font13Whitemedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ]);
}
