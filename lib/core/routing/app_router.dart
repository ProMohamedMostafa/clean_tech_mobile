import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/ui/screen/main_layout.dart';
import 'package:smart_cleaning_application/features/layout/splash/splash_screen.dart';
import 'package:smart_cleaning_application/features/screens/activity/logic/activity_cubit.dart';
import 'package:smart_cleaning_application/features/screens/activity/ui/screen/activity_screen.dart';
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
import 'package:smart_cleaning_application/features/screens/edit_profile/logic/edit_profile_cubit.dart';
import 'package:smart_cleaning_application/features/screens/edit_profile/ui/screen/edit_profile_screen.dart';
import 'package:smart_cleaning_application/features/screens/languages/ui/screen/languages_screen.dart';
import 'package:smart_cleaning_application/features/screens/notification/logic/notification_cubit.dart';
import 'package:smart_cleaning_application/features/screens/notification/ui/screen/notification_screen.dart';
import 'package:smart_cleaning_application/features/screens/profile/logic/profile_cubit.dart';
import 'package:smart_cleaning_application/features/screens/profile/ui/screen/profile_screen.dart';
import 'package:smart_cleaning_application/features/screens/provider/provider_management/logic/cubit/provider_cubit.dart';
import 'package:smart_cleaning_application/features/screens/provider/provider_management/ui/screen/provider_screen.dart';
import 'package:smart_cleaning_application/features/screens/sensor/sensor_edit/logic/cubit/assign_sensor_cubit.dart';
import 'package:smart_cleaning_application/features/screens/sensor/sensor_edit/ui/screen/sensor_assign.dart';
import 'package:smart_cleaning_application/features/screens/sensor/sensor_details/logic/cubit/sensor_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/sensor/sensor_details/ui/screen/sensor_details.dart';
import 'package:smart_cleaning_application/features/screens/sensor/sensor_managment/logic/cubit/sensor_cubit.dart';
import 'package:smart_cleaning_application/features/screens/sensor/sensor_managment/ui/screen/sensor_screen.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/logic/cubit/shift_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/add_category/logic/add_category_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/add_category/ui/screen/add_category_screen.dart';
import 'package:smart_cleaning_application/features/screens/stock/add_material/logic/add_material_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/add_material/ui/screen/add_category_screen.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/logic/category_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/ui/screen/material_managment.dart';
import 'package:smart_cleaning_application/features/screens/stock/choose_stock_view/choose_view_stock.dart';
import 'package:smart_cleaning_application/features/screens/stock/edit_category/logic/edit_category_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/edit_category/ui/screen/edit_category_screen.dart';
import 'package:smart_cleaning_application/features/screens/stock/edit_material/logic/edit_material_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/edit_material/ui/screen/edit_material_screen.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/logic/material_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/ui/screen/category_managment.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/logic/transaction_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/ui/screen/transaction_managment.dart';
import 'package:smart_cleaning_application/features/screens/stock/view_material/ui/screen/material_details_screen.dart';
import 'package:smart_cleaning_application/features/screens/stock/view_transaction/ui/screen/transaction_details_screen.dart';
import 'package:smart_cleaning_application/features/screens/task/view_task/logic/cubit/task_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/technical_support/ui/screen/technical_support_screen.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/logic/cubit/user_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/logic/add_work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/ui/screens/add_area_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/ui/screens/add_building_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/ui/screens/add_city_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/ui/screens/add_floor_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/ui/screens/add_organization_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/ui/screens/add_point_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/ui/screens/add_section_screen.dart';
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
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_section/logic/edit_section_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_section/ui/screen/edit_section_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/logic/cubit/work_location_details_cubit.dart';
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
import 'package:smart_cleaning_application/features/screens/change_password/logic/change_password_cubit.dart';
import 'package:smart_cleaning_application/features/screens/change_password/ui/screen/change_password_screen.dart';
import 'package:smart_cleaning_application/features/screens/user/edit_user/logic/edit_user_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/edit_user/ui/screen/edit_user_screen.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/ui/screen/login_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/ui/screen/work_location_screen.dart';
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
        var email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => VerifyAccountCubit(),
            child: VerifyAccountScreen(
              email: email,
            ),
          ),
        );

      case Routes.setPassScreen:
        final args = settings.arguments as Map<String, dynamic>;
        var email = args['email'] as String;
        var code = args['code'] as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SetPasswordCubit(),
            child: SetPasswordScreen(email: email, code: code),
          ),
        );
      case Routes.doneScreen:
        return MaterialPageRoute(
          builder: (_) => const DoneScreen(),
        );
      case Routes.mainLayoutScreen:
        return MaterialPageRoute(
          builder: (_) => const MainLayout(),
        );
      case Routes.languageScreen:
        return MaterialPageRoute(
          builder: (_) => const LanguagesScreen(),
        );
      case Routes.technicalSupportScreen:
        return MaterialPageRoute(
          builder: (_) => const TechnicalSupportScreen(),
        );
      case Routes.profileScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ProfileCubit()
              ..getUserProfileDetails()
              ..getUserWorkLocationDetails()
              ..getUserShiftDetails()
              ..getUserTaskDetails()
              ..getAllHistory()
              ..getAllLeaves(),
            child: const ProfileScreen(),
          ),
        );
      case Routes.editProfileScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditProfileCubit()
              ..getUserProfileDetails()
              ..getNationality(),
            child: EditProfileScreen(),
          ),
        );
      case Routes.userManagmentScreen:
        final roleId = settings.arguments as int?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => UserManagementCubit()..initialize(roleId),
            lazy: false,
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
            create: (context) => WorkLocationCubit()..initialize(selectedIndex),
            child: WorkLocationScreen(
              selectedIndex: selectedIndex,
            ),
          ),
        );
      case Routes.shiftScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ShiftCubit()..initialize(),
            child: const ShiftScreen(),
          ),
        );
      case Routes.providerScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ProviderCubit()..initialize(),
            child: const ProviderScreen(),
          ),
        );
      case Routes.sensorScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SensorCubit()..initialize(),
            child: const SensorScreen(),
          ),
        );
      case Routes.sensorAssignScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AssignSensorCubit()
              ..getSensorDetails(id)
              ..getOrganization(),
            child: SensorAssignScreen(id: id),
          ),
        );
      case Routes.sensorDetailsScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SensorDetailsCubit()..getSensorDetails(id),
            child: SensorDetailsScreen(id: id),
          ),
        );
      case Routes.addUserScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddUserCubit()
              ..getNationality()
              ..getRole()
              ..getProviders(),
            child: const AddUserScreen(),
          ),
        );
      case Routes.userDetailsScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => UserDetailsCubit()
              ..getUserDetails(id)
              ..getUserShiftDetails(id)
              ..getUserTaskDetails(id)
              ..getUserWorkLocationDetails(id)
              ..getAllHistory(id)
              ..getAllLeaves(id)
              ..getUserStatus(id),
            child: UserDetailsScreen(
              id: id,
            ),
          ),
        );
      case Routes.editUserScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditUserCubit()
              ..getUserDetailsInEdit(id)
              ..getAllUsers(id)
              ..getNationality()
              ..getRole()
              ..getProviders(),
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
            create: (context) => AddWorkLocationCubit()
              ..getNationality(userUsedOnly: false, areaUsedOnly: false)
              ..getAllUsers(),
            child: const AddAreaScreen(),
          ),
        );
      case Routes.addCityScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddWorkLocationCubit(),
            child: const AddCityScreen(),
          ),
        );
      case Routes.addOrganizationScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddWorkLocationCubit(),
            child: const AddOrganizationScreen(),
          ),
        );
      case Routes.addBuildingScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddWorkLocationCubit(),
            child: const AddBuildingScreen(),
          ),
        );
      case Routes.addFloorScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddWorkLocationCubit(),
            child: const AddFloorScreen(),
          ),
        );
      case Routes.addSectionScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddWorkLocationCubit(),
            child: AddSectionScreen(),
          ),
        );
      case Routes.addPointScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddWorkLocationCubit(),
            child: const AddPointScreen(),
          ),
        );
      case Routes.workLocationDetailsScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => WorkLocationDetailsCubit(),
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

      case Routes.editSectionScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditSectionCubit(),
            child: EditSectionScreen(
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
            create: (context) => AddShiftCubit()..getOrganization(),
            child: AddShiftScreen(),
          ),
        );
      case Routes.shiftDetailsScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ShiftDetailsCubit()..getShiftDetails(id),
            child: ShiftDetailsScreen(
              id: id,
            ),
          ),
        );
      case Routes.editShiftScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditShiftCubit()
              ..getShiftDetails(id)
              ..getOrganization(),
            child: EditShiftScreen(
              id: id,
            ),
          ),
        );
      case Routes.taskManagementScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TaskManagementCubit()..initialize(),
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
            create: (context) => TaskDetailsCubit()
              ..getTaskDetails(id)
              ..getUsers(),
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
        final status = settings.arguments as int?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AttendanceHistoryCubit()..initialize(status),
            child: AttendanceHistoryScreen(),
          ),
        );

      case Routes.leavesScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AttendanceLeavesCubit()..initialize(),
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

      case Routes.viewStockScreen:
        return MaterialPageRoute(
          builder: (_) => const ChooseViewStock(),
        );
      case Routes.categoryScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CategoryManagementCubit()..initialize(),
            child: const CategoryManagmentScreen(),
          ),
        );
      case Routes.addCategoryScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddCategoryCubit(),
            child: const AddCategoryScreen(),
          ),
        );
      case Routes.editCategoryScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditCategoryCubit(),
            child: EditCategoryScreen(
              id: id,
            ),
          ),
        );

      case Routes.materialScreen:
        final id = settings.arguments is int ? settings.arguments as int : null;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => MaterialManagementCubit()
              ..initialize(id: id)
              ..getProviders(),
            child: MaterialManagmentScreen(id: id),
          ),
        );
      case Routes.addMaterialScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddMaterialCubit(),
            child: const AddMaterialScreen(),
          ),
        );
      case Routes.editMaterialScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditMaterialCubit(),
            child: EditMaterialScreen(
              id: id,
            ),
          ),
        );
      case Routes.materialDetailsScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => MaterialManagementCubit(),
            child: MaterialDetailsScreen(
              id: id,
            ),
          ),
        );

      case Routes.transactionScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TransactionManagementCubit()..initialize(),
            child: const TransactionManagmentScreen(),
          ),
        );

      case Routes.transactionDetailsScreen:
        final args = settings.arguments as Map<String, dynamic>;
        var id = args['id'] as int;
        var type = args['type'] as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TransactionManagementCubit(),
            child: TransactionDetailsScreen(
              id: id,
              type: type,
            ),
          ),
        );

      case Routes.activityScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ActivityCubit()..initialize(),
            child: const ActivityScreen(),
          ),
        );

      case Routes.notificationScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => NotificationCubit()
              ..getNotification()
              ..getUnReadNotification(),
            child: const NotificationScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
