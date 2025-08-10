import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';

Future<bool?> toast({
  required String text,
  required bool isSuccess,
}) {
  // Remove "Exception: " prefix if it exists
  final cleanText = text.replaceFirst('Exception: ', '');

  return Fluttertoast.showToast(
    msg: isSuccess ? '「✔」$cleanText' : '❗ $cleanText',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: isSuccess ? AppColor.fourthColor : Colors.red[50],
    textColor: isSuccess ? AppColor.primaryColor : Colors.red,
    fontSize: 16.sp,
  );
}
