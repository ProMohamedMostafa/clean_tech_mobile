import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildBottomNavigationBar(context) => Container(
      height: 60.h,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 200),
        ],
      ),
      child: ClipRRect(
        borderRadius:  BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
        child: BottomNavigationBar(
          items: context.bottomNavbarItems,
          currentIndex: context.currentIndex,
          onTap: (int index) {
            context.changeBottomNavbar(index);
          },
        ),
      ),
    );
