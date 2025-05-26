import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

Widget buildLegend(String text, Color color) {
  return Row(
    children: [
      Container(width: 8.w, height: 3.h, color: color),
      Container(
        width: 12.w,
        height: 12.h,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.white, width: 2.w),
          shape: BoxShape.circle,
        ),
      ),
      Container(width: 8.w, height: 3.h, color: color),
      horizontalSpace(8),
      Text(
        text,
        style: TextStyles.font11BlackMedium,
      ),
    ],
  );
}