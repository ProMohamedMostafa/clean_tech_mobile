import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

PopupMenuItem<String> buildPopupItem(String value, String text) {
  return PopupMenuItem(
    value: value,
    height: 28.h,
    padding: EdgeInsets.zero,
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 12.w),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyles.font12BlackSemi,
      ),
    ),
  );
}
