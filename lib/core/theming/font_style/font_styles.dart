import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_weight_helper.dart';

class TextStyles {
  static TextStyle font24BlacksemiBold = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: Colors.black,
  );
  static TextStyle font20BlacksemiBold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: AppColor.primaryColor,
  );
  static TextStyle font16WhiteSemiBold = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: Colors.white,
  );
  static TextStyle font16BlackRegular = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.regular,
    color: Colors.black,
  );
  static TextStyle font16PrimSemiBold = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeightHelper.semiBold,
      color: AppColor.primaryColor);
  static TextStyle font14GreyRegular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColor.thirdColor,
  );
  static TextStyle font12GreyRegular = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColor.thirdColor,
  );

  static TextStyle font13Blackmedium = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeightHelper.medium,
    color: Colors.black,
  );

  static TextStyle font13Whitemedium = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeightHelper.medium,
    color: Colors.white,
  );
  static TextStyle font14Redbold = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.bold,
    color: Colors.red,
  );
  static TextStyle font14Primarybold = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.bold,
    color: AppColor.primaryColor,
  );
    static TextStyle font14WhiteMedium = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.medium,
    color: Colors.white,
  );
  static TextStyle font11WhiteSemiBold = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: Colors.white,
  );
  static TextStyle font11light = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeightHelper.light,
  );
}
