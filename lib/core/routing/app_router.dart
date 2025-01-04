import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/logic/bottom_navbar_cubit.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/ui/screen/main_layout.dart';
import 'package:smart_cleaning_application/features/layout/splash/splash_screen.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/logic/add_organization_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/ui/screen/add_organization_screen.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/ui/widgets/add_area_screen.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/ui/widgets/add_building_screen.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/ui/widgets/add_city_screen.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/ui/widgets/add_floor_screen.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/ui/widgets/add_organization_screen.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/ui/widgets/add_point_screen.dart';
import 'package:smart_cleaning_application/features/screens/organization/delete_organizations/logic/delete_organization_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organization/delete_organizations/ui/screen/delete_organization_screen.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_area/logic/edit_area_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_area/ui/screen/edit_area_screen.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_building/logic/edit_building_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_building/ui/screen/edit_building_screen.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_city/logic/edit_city_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_city/ui/screen/edit_city_screen.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_floor/logic/edit_floor_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_floor/ui/screen/edit_floor_screen.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_organization/logic/edit_organization_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_organization/ui/screen/edit_organization_screen.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_point/logic/edit_point_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_point/ui/screen/edit_point_screen.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_area_details/ui/Screen/view_organization_screen.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_building_details/ui/Screen/view_organization_screen.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_city_details/ui/Screen/view_organization_screen.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_floor_details/ui/Screen/view_organization_screen.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_organization_details/ui/Screen/view_organization_screen.dart';
import 'package:smart_cleaning_application/features/screens/shift/add_shift/logic/add_shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/shift/add_shift/ui/screen/add_shift_screen.dart';
import 'package:smart_cleaning_application/features/screens/shift/edit_shift/logic/edit_shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/shift/edit_shift/ui/screen/edit_shift_screen.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/ui/screen/shift_details_screen.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/logic/shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/ui/screen/shift_screen.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/logic/add_user_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/ui/screen/add_user_screen.dart';
import 'package:smart_cleaning_application/features/screens/analytics/ui/screen/analytics_screen.dart';
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
import 'package:smart_cleaning_application/features/screens/organization/organizations/logic/organizations_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/ui/screen/organizations_screen.dart';
import 'package:smart_cleaning_application/features/screens/settings/ui/screen/settings_screen.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/screen/user_details_screen.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/ui/screen/user_managment.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_point_details/ui/Screen/view_organization_screen.dart';

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
      case Routes.analyticasScreen:
        return MaterialPageRoute(
          builder: (_) => const AnalyticsScreen(),
        );
      case Routes.calendarScreen:
        return MaterialPageRoute(
          builder: (_) => const CalendarScreen(),
        );
      case Routes.integrationsScreen:
        return MaterialPageRoute(
          builder: (_) => const IntegrationsScreen(),
        );
      case Routes.userManagmentScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => UserManagementCubit(),
            child: const UserManagmentScreen(),
          ),
        );
      case Routes.organizationsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => OrganizationsCubit(),
            child: const OrganizationsScreen(),
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
      case Routes.settingsScreen:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );
      case Routes.changepasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ChangePasswordCubit(),
            child: const ChangePasswordScreen(),
          ),
        );
      case Routes.addOrganizationScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddOrganizationCubit(),
            child: const AddOrganizationScreen(),
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

      case Routes.areaDetailsScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => OrganizationsCubit(),
            child: AreaDetailsScreen(
              id: id,
            ),
          ),
        );
      case Routes.cityDetailsScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => OrganizationsCubit(),
            child: CityDetailsScreen(
              id: id,
            ),
          ),
        );
      case Routes.organizationDetailsScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => OrganizationsCubit(),
            child: OrganizationDetailsScreen(
              id: id,
            ),
          ),
        );
      case Routes.buildingDetailsScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => OrganizationsCubit(),
            child: BuildingDetailsScreen(
              id: id,
            ),
          ),
        );
      case Routes.floorDetailsScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => OrganizationsCubit(),
            child: FloorDetailsScreen(
              id: id,
            ),
          ),
        );
      case Routes.pointDetailsScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => OrganizationsCubit(),
            child: PointDetailsScreen(
              id: id,
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

      case Routes.deleteOrganizationScreen:
        var selectedIndex = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => DeleteOrganizationsCubit(),
            child: DeleteOrganizationScreen(
              selectedIndex: selectedIndex,
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

      default:
        return null;
    }
  }
}
