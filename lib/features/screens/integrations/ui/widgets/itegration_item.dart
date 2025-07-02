import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

Widget buildIntegrationItem(
    Function? onPressed, String title, String image, double? padding) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      InkWell(
          borderRadius: BorderRadius.circular(8.r),
          onTap: () {
            if (onPressed != null) {
              onPressed();
            }
          },
          child: Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.black12, width: 1.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Center(
              child: Material(
                elevation: 1,
                shape: const CircleBorder(),
                child: Container(
                  width: 57.r,
                  height: 57.r,
                  padding: EdgeInsets.all(padding ?? 13),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    image,
                    width: 40.r,
                    height: 40.r,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          )),
      verticalSpace(10),
      Flexible(
        child: Text(
          title,
          style: TextStyles.font14BlackRegular,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      verticalSpace(10),
    ],
  );
}
