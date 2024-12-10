import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/logic/bottom_navbar_cubit.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/logic/bottom_navbar_states.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/ui/widgets/build_bot_nav_bar.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavbarCubit, BottomNavbarStates>(
      builder: (context, state) {
        return Scaffold(
            body: context.read<BottomNavbarCubit>().bottomNavbarScreens[
                context.read<BottomNavbarCubit>().currentIndex],
            bottomNavigationBar:
                buildBottomNavigationBar(context.read<BottomNavbarCubit>()));
      },
    );
  }
}
