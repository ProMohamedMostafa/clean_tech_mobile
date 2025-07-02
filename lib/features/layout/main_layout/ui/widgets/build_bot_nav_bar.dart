import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/logic/bottom_navbar_cubit.dart';

Widget buildBottomNavigationBar(BuildContext context) {
  final cubit = context.read<BottomNavbarCubit>();
  return SafeArea(
    top: false,
    child: Container(
      height: 65.h,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 2),
        ],
      ),
      child: BottomNavigationBar(
        items: cubit.getBottomNavbarItems(context),
        currentIndex: cubit.currentIndex,
        onTap: (int index) {
          cubit.changeBottomNavbar(index);
        },
      ),
    ),
  );
}
