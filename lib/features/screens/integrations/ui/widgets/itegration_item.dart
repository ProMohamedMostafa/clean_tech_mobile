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
    child: Card(
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 28.sp, color: AppColor.primaryColor),
            verticalSpace(10),
            Text(
              title,
              style: TextStyles.font13greymedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
