import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

Widget buildIntegrationItem(Function? onPressed, String title, IconData icon) {
  return InkWell(
    borderRadius: BorderRadius.circular(16.r),
    onTap: () {
      if (onPressed != null) {
        onPressed();
      }
    },
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColor.primaryColor)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30.sp, color: AppColor.primaryColor),
          verticalSpace(10),
          Text(title, style: TextStyles.font14GreyRegular),
        ],
      ),
    ),
  );
}
