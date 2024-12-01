import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';

IconButton backButton(context) => IconButton(
    onPressed: () {
      Navigator.pop(context);
    },
    icon:  Icon(
      Icons.arrow_back_ios_new_rounded,
      size: 25.sp,
      color: AppColor.darkBlue,
    ));
