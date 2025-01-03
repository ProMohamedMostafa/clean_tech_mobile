import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';

Widget addingBuild(BuildContext context) {
  return Align(
    alignment: Alignment.centerRight,
    child: SizedBox(
      height: 45.h,
      width: 110.w,
      child: ElevatedButton(
        onPressed: () {
          context.pushNamed(Routes.addUserScreen);
        },
        style: ElevatedButton.styleFrom(
          padding: REdgeInsets.all(0),
          backgroundColor: AppColor.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          side: BorderSide(
            color: AppColor.secondaryColor,
            width: 1,
          ),
        ),
        child: Icon(
          Icons.person_add,
          color: Colors.white,
          size: 22.sp,
        ),
      ),
    ),
  );
}
