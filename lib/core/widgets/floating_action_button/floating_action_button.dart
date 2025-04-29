import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';

Widget floatingActionButton({
  required IconData icon,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: SizedBox(
      height: 57.h,
      width: 57.w,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: AppColor.primaryColor,
          shape: const CircleBorder(),
          side: BorderSide(
            color: AppColor.secondaryColor,
            width: 1.w,
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 28.sp,
        ),
      ),
    ),
  );
}
