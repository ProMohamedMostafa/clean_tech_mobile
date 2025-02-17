import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/logic/bottom_navbar_cubit.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/ui/screen/main_layout.dart';
import 'package:smart_cleaning_application/features/layout/splash/splash_screen.dart';
import 'package:smart_cleaning_application/features/screens/assign/logic/assign_cubit.dart';
import 'package:smart_cleaning_application/features/screens/assign/ui/screen/assign_screen.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attedance_leaves_details/ui/screen/leaves_details_screen.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/logic/attendance_history_cubit.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/ui/screen/attendance_history_screen.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/logic/attendance_leaves_cubit.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/ui/screen/attendance_leaves_screen.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_add/logic/leaves_add_cubit.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_add/ui/screen/leaves_add_screen.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_edit/logic/leaves_edit_cubit.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_edit/ui/screen/leaves_edit_screen.dart';
import 'package:smart_cleaning_application/features/screens/attendance/ui/attendance_screen.dart';
import 'package:smart_cleaning_application/features/screens/languages/ui/screen/languages_screen.dart';
import 'package:smart_cleaning_application/features/screens/settings/logic/settings_cubit.dart';
import 'package:smart_cleaning_application/features/screens/technical_support/ui/screen/technical_support_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/logic/add_organization_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/ui/screens/add_area_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/ui/screens/add_building_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/ui/screens/add_city_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/ui/screens/add_floor_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/ui/screens/add_organization_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/ui/screens/add_point_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/choose_view_work_location/choose_view_work_location.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_area/logic/edit_area_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_area/ui/screen/edit_area_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_building/logic/edit_building_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_building/ui/screen/edit_building_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_city/logic/edit_city_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_city/ui/screen/edit_city_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_floor/logic/edit_floor_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_floor/ui/screen/edit_floor_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_organization/logic/edit_organization_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_organization/ui/screen/edit_organization_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_point/logic/edit_point_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_point/ui/screen/edit_point_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/ui/screen/work_location_screen.dart';
import 'package:smart_cleaning_application/features/screens/shift/add_shift/logic/add_shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/shift/add_shift/ui/screen/add_shift_screen.dart';
import 'package:smart_cleaning_application/features/screens/shift/edit_shift/logic/edit_shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/shift/edit_shift/ui/screen/edit_shift_screen.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/ui/screen/shift_details_screen.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/logic/shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/ui/screen/shift_screen.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/logic/add_task_cubit.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/ui/screen/add_task_screen.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/logic/edit_task_cubit.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/ui/screen/edit_task_screen.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/logic/task_management_cubit.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/ui/screen/task_managment_screen.dart';
import 'package:smart_cleaning_application/features/screens/task/view_task/ui/screen/task_details_screen.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/logic/add_user_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/ui/screen/add_user_screen.dart';
import 'package:smart_cleaning_application/features/screens/auth/done_screen/ui/screen/done_screen.dart';
import 'package:smart_cleaning_application/features/screens/auth/forgot_password/logic/forgot_password_cubit.dart';
import 'package:smart_cleaning_application/features/screens/auth/forgot_password/ui/screen/forgot_password.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/logic/login_cubit_cubit.dart';
import 'package:smart_cleaning_application/features/screens/auth/set_password/logic/set_password_cubit.dart';
import 'package:smart_cleaning_application/features/screens/auth/set_password/ui/screen/set_password_screen.dart';
import 'package:smart_cleaning_application/features/screens/auth/verify_account/logic/verify_account_cubit.dart';
import 'package:smart_cleaning_application/features/screens/auth/verify_account/ui/screen/verify_account.dart';
import 'package:smart_cleaning_application/features/screens/calendar/calendar_screen.dart';
import 'package:smart_cleaning_application/features/screens/change_password/logic/change_password_cubit.dart';
import 'package:smart_cleaning_application/features/screens/change_password/ui/screen/change_password_screen.dart';
import 'package:smart_cleaning_application/features/screens/user/edit_user/logic/edit_user_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/edit_user/ui/screen/edit_user_screen.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/screen/home_screen.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/ui/screen/login_screen.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/screen/integrations_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/ui/screen/work_location_screen.dart';
import 'package:smart_cleaning_application/features/screens/settings/ui/screen/settings_screen.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/screen/user_details_screen.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/ui/screen/user_managment.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginScreen(),
          ),
        );

      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ForgotPasswordCubit(),
            child: const ForgotPasswordScreen(),
          ),
        );

      case Routes.verifyScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => VerifyAccountCubit(),
            child: const VerifyAccountScreen(),
          ),
        );

      case Routes.setPassScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SetPasswordCubit(),
            child: const SetPasswordScreen(),
          ),
        );
      case Routes.doneScreen:
        return MaterialPageRoute(
          builder: (_) => const DoneScreen(),
        );
      case Routes.mainLayoutScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => BottomNavbarCubit(),
            child: const MainLayout(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case Routes.settingsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SettingsCubit(),
            child: const SettingsScreen(),
          ),
        );
      case Routes.calendarScreen:
        return MaterialPageRoute(
          builder: (_) => const CalendarScreen(),
        );
      case Routes.integrationsScreen:
        return MaterialPageRoute(
          builder: (_) => const IntegrationsScreen(),
        );
         case Routes.technicalSupportScreen:
        return MaterialPageRoute(
          builder: (_) => const TechnicalSupportScreen(),
        );
          case Routes.languageScreen:
        return MaterialPageRoute(
          builder: (_) => const LanguagesScreen(),
        );
      case Routes.userManagmentScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => UserManagementCubit(),
            child: const UserManagmentScreen(),
          ),
        );

      case Routes.chooseViewWorkLocationScreen:
        return MaterialPageRoute(
          builder: (_) => const ChooseViewWorkLocation(),
        );

      case Routes.workLocationScreen:
        var selectedIndex = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => WorkLocationCubit(),
            child: WorkLocationScreen(
              selectedIndex: selectedIndex,
            ),
          ),
        );
      case Routes.shiftScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ShiftCubit(),
            child: const ShiftScreen(),
          ),
        );
      case Routes.addUserScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddUserCubit(),
            child: const AddUserScreen(),
          ),
        );
      case Routes.userDetailsScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => UserManagementCubit(),
            child: UserDetailsScreen(
              id: id,
            ),
          ),
        );
      case Routes.editUserScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditUserCubit(),
            child: EditUserScreen(
              id: id,
            ),
          ),
        );

      case Routes.changepasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ChangePasswordCubit(),
            child: const ChangePasswordScreen(),
          ),
        );

      case Routes.addAreaScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddOrganizationCubit(),
            child: const AddAreaScreen(),
          ),
        );
      case Routes.addCityScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddOrganizationCubit(),
            child: const AddCityScreen(),
          ),
        );
      case Routes.addOrganizationDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddOrganizationCubit(),
            child: const AddOrganizationDetailsScreen(),
          ),
        );
      case Routes.addBuildingScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddOrganizationCubit(),
            child: const AddBuildingScreen(),
          ),
        );
      case Routes.addFloorScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddOrganizationCubit(),
            child: const AddFloorScreen(),
          ),
        );
      case Routes.addPointScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddOrganizationCubit(),
            child: const AddPointScreen(),
          ),
        );
      case Routes.workLocationDetailsScreen:
        final args = settings.arguments as Map<String, int>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => WorkLocationCubit(),
            child: WorkLocationDetailsScreen(
              id: args['id']!,
              selectedIndex: args['selectedIndex']!,
            ),
          ),
        );

      case Routes.editAreaScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditAreaCubit(),
            child: EditAreaScreen(
              id: id,
            ),
          ),
        );
      case Routes.editCityScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditCityCubit(),
            child: EditCityScreen(
              id: id,
            ),
          ),
        );
      case Routes.editOrganizationScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditOrganizationCubit(),
            child: EditOrganizationScreen(
              id: id,
            ),
          ),
        );
      case Routes.editBuildingScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditBuildingCubit(),
            child: EditBuildingScreen(
              id: id,
            ),
          ),
        );
      case Routes.editFloorScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditFloorCubit(),
            child: EditFloorScreen(
              id: id,
            ),
          ),
        );
      case Routes.editPointScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditPointCubit(),
            child: EditPointScreen(
              id: id,
            ),
          ),
        );

      case Routes.addShiftScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddShiftCubit(),
            child: AddShiftScreen(),
          ),
        );
      case Routes.shiftDetailsScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ShiftCubit(),
            child: ShiftDetailsScreen(
              id: id,
            ),
          ),
        );
      case Routes.editShiftScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditShiftCubit(),
            child: EditShiftScreen(
              id: id,
            ),
          ),
        );
      case Routes.taskManagementScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TaskManagementCubit(),
            child: TaskManagementScreen(),
          ),
        );
      case Routes.addTaskScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddTaskCubit(),
            child: AddTaskScreen(),
          ),
        );
      case Routes.assignScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AssignCubit(),
            child: AssignScreen(),
          ),
        );
      case Routes.taskDetailsScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TaskManagementCubit(),
            child: TaskDetailsScreen(
              id: id,
            ),
          ),
        );

      case Routes.editTaskScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditTaskCubit(),
            child: EditTaskScreen(
              id: id,
            ),
          ),
        );

      case Routes.attendanceScreen:
        return MaterialPageRoute(
          builder: (_) => AttendanceScreen(),
        );

      case Routes.historyScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AttendanceHistoryCubit(),
            child: AttendanceHistoryScreen(),
          ),
        );

      case Routes.leavesScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AttendanceLeavesCubit(),
            child: AttendanceLeavesScreen(),
          ),
        );
      case Routes.createleavesScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LeavesAddCubit(),
            child: LeavesAddScreen(),
          ),
        );
      case Routes.editleavesScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LeavesEditCubit(),
            child: LeavesEditScreen(
              id: id,
            ),
          ),
        );
      case Routes.leavesDetailsScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AttendanceLeavesCubit(),
            child: LeavesDetailsScreen(
              id: id,
            ),
          ),
        );

      default:
        return null;
    }
  }
}
