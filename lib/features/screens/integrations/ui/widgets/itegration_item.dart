import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

Widget buildIntegrationItem(Function? onPressed, String title, String image) {
  return InkWell(
    borderRadius: BorderRadius.circular(16.r),
    onTap: () {
      if (onPressed != null) {
        onPressed();
      }
    },
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.black12, width: 1.5.w)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Material(
              elevation: 5,
              shape: CircleBorder(),
              child: Container(
                width: 55.w,
                height: 55.h,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(image,
                      width: 30.w, height: 30.w, fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          verticalSpace(20),
          Text(
            title,
            style: TextStyles.font12BlackSemi,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
