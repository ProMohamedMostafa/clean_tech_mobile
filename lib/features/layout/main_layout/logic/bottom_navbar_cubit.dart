import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/logic/bottom_navbar_states.dart';
import 'package:smart_cleaning_application/features/screens/calendar/logic/calendar_cubit.dart';
import 'package:smart_cleaning_application/features/screens/calendar/ui/calendar_screen.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_cubit.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/screen/home_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/ui/screen/integrations_screen.dart';
import 'package:smart_cleaning_application/features/screens/setting/settings/logic/settings_cubit.dart';
import 'package:smart_cleaning_application/features/screens/setting/settings/ui/screen/settings_screen.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class BottomNavbarCubit extends Cubit<BottomNavbarStates> {
  BottomNavbarCubit() : super(InitialBottomNavbarState());

  static BottomNavbarCubit get(context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();

  int currentIndex = 0;

  List<Widget> bottomNavbarScreens = [
    BlocProvider(
      create: (context) => HomeCubit()..initializeHome(),
      child: const HomeScreen(),
    ),
    const IntegrationsScreen(),
    BlocProvider(
      create: (context) => CalendarCubit()..getAllTasks(),
      child: const CalendarScreen(),
    ),
    BlocProvider(
      create: (context) => SettingsCubit()
        ..getUserDetails()
        ..initializeNotificationStatus(),
      child: const SettingsScreen(),
    )
  ];

  List<BottomNavigationBarItem> getBottomNavbarItems(BuildContext context) {
    return [
      BottomNavigationBarItem(
          icon: Icon(
            IconBroken.home,
          ),
          label: S.of(context).botNavTitle1),
      BottomNavigationBarItem(
          icon: Icon(IconBroken.category), label: S.of(context).botNavTitle2),
      BottomNavigationBarItem(
          icon: Icon(IconBroken.calendar), label: S.of(context).botNavTitle3),
      BottomNavigationBarItem(
          icon: Icon(Icons.menu), label: S.of(context).botNavTitle4),
    ];
  }

  void changeBottomNavbar(int index) {
    currentIndex = index;
    emit(ChangeBottomNavbarState());
  }

  void changeBottomNavbarWithRoute(BuildContext context, int index) {
    context.popUntilFirst();
    currentIndex = index;
    emit(ChangeBottomNavbarState());
  }
}
