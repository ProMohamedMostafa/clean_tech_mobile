import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors/color.dart';
import 'font_style/font_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColor.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyles.font16BlackSemiBold,
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 12,
        selectedItemColor: AppColor.primaryColor,
        unselectedItemColor: AppColor.thirdColor,
        selectedLabelStyle: TextStyles.font12PrimSemi,
        unselectedLabelStyle: TextStyles.font11lightPrimary,
        selectedIconTheme: IconThemeData(size: 21.sp),
        unselectedIconTheme: IconThemeData(size: 20.sp),
      ),
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Poppins',
    );
  }
}
