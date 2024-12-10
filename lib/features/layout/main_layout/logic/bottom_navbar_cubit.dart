import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/logic/bottom_navbar_states.dart';
import 'package:smart_cleaning_application/features/screens/analytics/ui/screen/analytics_screen.dart';
import 'package:smart_cleaning_application/features/screens/calendar/calendar_screen.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/screen/home_screen.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/screen/integrations_screen.dart';

class BottomNavbarCubit extends Cubit<BottomNavbarStates> {
  BottomNavbarCubit() : super(InitialBottomNavbarState());

  static BottomNavbarCubit get(context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();

  int currentIndex = 0;

  List<Widget> bottomNavbarScreens = [
    const HomeScreen(),
    const AnalyticsScreen(),
    const CalendarScreen(),
    const IntegrationsScreen()
  ];

  List<BottomNavigationBarItem> bottomNavbarItems = const [
    BottomNavigationBarItem(
        icon: Icon(
          IconBroken.Home,
        ),
        label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.bar_chart_rounded), label: 'Analytics'),
    BottomNavigationBarItem(icon: Icon(IconBroken.Calendar), label: 'Calendar'),
    BottomNavigationBarItem(
        icon: Icon(Icons.more_horiz_outlined), label: 'Integrations'),
  ];

  void changeBottomNavbar(int index) {
    currentIndex = index;
    emit(ChangeBottomNavbarState());
  }
}
