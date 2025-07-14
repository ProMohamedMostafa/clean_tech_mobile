import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/logic/bottom_navbar_cubit.dart';

Widget buildBottomNavigationBar(BuildContext context) {
  final cubit = context.read<BottomNavbarCubit>();

  return Container(
    color: Colors.black,
    child: SafeArea(
      top: false,
      child: BottomNavigationBar(
        items: cubit.getBottomNavbarItems(context),
        currentIndex: cubit.currentIndex,
        onTap: cubit.changeBottomNavbar,
      ),
    ),
  );
}
