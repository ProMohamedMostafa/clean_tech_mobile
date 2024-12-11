import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/logic/bottom_navbar_states.dart';
import 'package:smart_cleaning_application/features/screens/analytics/ui/screen/analytics_screen.dart';
import 'package:smart_cleaning_application/features/screens/calendar/calendar_screen.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/screen/home_screen.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/screen/integrations_screen.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

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

  List<BottomNavigationBarItem> getBottomNavbarItems(BuildContext context) {
    return [
      BottomNavigationBarItem(
          icon: Icon(
            IconBroken.home,
          ),
          label: S.of(context).botNavTitle1),
      BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_rounded),
          label: S.of(context).botNavTitle2),
      BottomNavigationBarItem(
          icon: Icon(IconBroken.calendar), label: S.of(context).botNavTitle3),
      BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz_outlined),
          label: S.of(context).botNavTitle4),
    ];
  }

  void changeBottomNavbar(int index) {
    currentIndex = index;
    emit(ChangeBottomNavbarState());
  }
}
