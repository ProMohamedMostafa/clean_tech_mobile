import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/features/layout/ip_screen/logic/cubit/ip_cubit.dart';
import 'package:smart_cleaning_application/features/layout/ip_screen/ui/screen/ip_screen.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/logic/bottom_navbar_cubit.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/ui/screen/main_layout.dart';
import 'package:smart_cleaning_application/features/layout/splash/splash_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/activity/logic/activity_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/activity/ui/screen/activity_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/assign/logic/assign_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/assign/ui/select_assign_view/choose_view_assign.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/assign/ui/screen/assign_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attedance_leaves_details/logic/cubit/leaves_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attedance_leaves_details/ui/screen/leaves_details_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_history_management/logic/attendance_history_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_history_management/ui/screen/attendance_history_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_leaves_management/logic/attendance_leaves_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_leaves_management/ui/screen/attendance_leaves_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_leaves_add/logic/leaves_add_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_leaves_add/ui/screen/leaves_add_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_leaves_edit/logic/leaves_edit_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_leaves_edit/ui/screen/leaves_edit_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/select_view/ui/attendance_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_details/ui/widgets/audit_answers/auditor_answer_details.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/auditor/logic/cubit/auditor_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/auditor/ui/screen/audit_location_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/auditor/ui/widget/audit_location_details.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/auditor/ui/widget/auditor_questions.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/create_devices/logic/cubit/add_device_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/create_devices/ui/screen/create_feedback_audit_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/devices_answers/logic/cubit/device_answers_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/devices_answers/ui/screen/device_answers_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/devices_management/logic/cubit/devices_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/devices_management/ui/screen/devices_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/edit_devices/logic/cubit/edit_devices_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/edit_devices/ui/screen/edit_devices_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/feedback_answer/logic/cubit/feedback_answer_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/feedback_answer/ui/screen/feedback_answer_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/assign_question/logic/cubit/assign_question_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/assign_question/ui/screen/assign_question_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/create_feedback_audit/logic/cubit/add_feedback_audit_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/create_feedback_audit/ui/screen/create_feedback_audit_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/edit_feedback_audit/logic/cubit/edit_feedback_audit_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/edit_feedback_audit/ui/screen/edit_feedback_audit_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/feedback_audit_details/logic/cubit/feedback_audit_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/feedback_audit_details/ui/screen/feedback_audit_details_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/feedback_audit_mangement/logic/feedback_audit_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/feedback_audit_mangement/ui/screen/feedback_audit_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/create_question/logic/cubit/add_question_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/create_question/ui/screen/add_question_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/edit_question/logic/cubit/edit_question_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/edit_question/ui/screen/edit_question_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/question_mangement/logic/question_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/question_mangement/ui/screen/question_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/select_view/ui/feedback_view_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/ui/widgets/work_location_questions/assign_more_question_point/logic/cubit/assign_question_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/ui/widgets/work_location_questions/assign_more_question_point/ui/screen/assign_question_screen.dart';
import 'package:smart_cleaning_application/features/screens/setting/edit_profile/logic/edit_profile_cubit.dart';
import 'package:smart_cleaning_application/features/screens/setting/edit_profile/ui/screen/edit_profile_screen.dart';
import 'package:smart_cleaning_application/features/screens/setting/languages/ui/screen/languages_screen.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/notification/logic/notification_cubit.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/notification/ui/screen/notification_screen.dart';
import 'package:smart_cleaning_application/features/screens/setting/profile/logic/profile_cubit.dart';
import 'package:smart_cleaning_application/features/screens/setting/profile/ui/screen/profile_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/provider/provider_management/logic/cubit/provider_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/provider/provider_management/ui/screen/provider_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/sensor/sensor_edit/logic/cubit/edit_sensor_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/sensor/sensor_edit/ui/screen/sensor_edit_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/sensor/sensor_details/logic/cubit/sensor_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/sensor/sensor_details/ui/screen/sensor_details.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/sensor/sensor_managment/logic/cubit/sensor_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/sensor/sensor_managment/ui/screen/sensor_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/shift_details/logic/cubit/shift_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/add_category/logic/add_category_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/add_category/ui/screen/add_category_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/add_material/logic/add_material_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/add_material/ui/screen/add_material_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/category_management/logic/category_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/category_management/ui/screen/material_managment.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/select_stock_view/choose_view_stock.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/edit_category/logic/edit_category_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/edit_category/ui/screen/edit_category_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/edit_material/logic/edit_material_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/edit_material/ui/screen/edit_material_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/material_management/logic/material_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/material_management/ui/screen/category_managment.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/transaction_management/logic/transaction_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/transaction_management/ui/screen/transaction_managment.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/view_material/logic/cubit/material_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/view_material/ui/screen/material_details_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/view_transaction/logic/cubit/transaction_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/view_transaction/ui/screen/transaction_details_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/select_task_view/select_task_view.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/view_task/logic/task_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/setting/technical_support/ui/screen/technical_support_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_details/logic/cubit/user_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/add_work_location/logic/add_work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/add_work_location/ui/screens/add_area_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/add_work_location/ui/screens/add_building_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/add_work_location/ui/screens/add_city_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/add_work_location/ui/screens/add_floor_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/add_work_location/ui/screens/add_organization_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/add_work_location/ui/screens/add_point_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/add_work_location/ui/screens/add_section_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/select_work_location_view/logic/cubit/choose_view_work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/select_work_location_view/ui/choose_view_work_location.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/logic/cubit/edit_work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/ui/screens/edit_area_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/ui/screens/edit_building_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/ui/screens/edit_city_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/ui/screens/edit_floor_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/ui/screens/edit_organization_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/ui/screens/edit_point_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/ui/screens/edit_section_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/logic/cubit/work_location_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/ui/screen/work_location_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/add_shift/logic/add_shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/add_shift/ui/screen/add_shift_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/edit_shift/logic/edit_shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/edit_shift/ui/screen/edit_shift_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/shift_details/ui/screen/shift_details_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/shifts_management/logic/shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/shifts_management/ui/screen/shift_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/add_task/logic/add_task_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/add_task/ui/screen/add_task_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/edit_task/logic/edit_task_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/edit_task/ui/screen/edit_task_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/task_management/logic/task_management_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/task_management/ui/screen/task_managment_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/view_task/ui/screen/task_details_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/add_user/logic/add_user_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/add_user/ui/screen/add_user_screen.dart';
import 'package:smart_cleaning_application/features/screens/auth/done_screen/ui/screen/done_screen.dart';
import 'package:smart_cleaning_application/features/screens/auth/forgot_password/logic/forgot_password_cubit.dart';
import 'package:smart_cleaning_application/features/screens/auth/forgot_password/ui/screen/forgot_password.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/logic/login_cubit_cubit.dart';
import 'package:smart_cleaning_application/features/screens/auth/set_password/logic/set_password_cubit.dart';
import 'package:smart_cleaning_application/features/screens/auth/set_password/ui/screen/set_password_screen.dart';
import 'package:smart_cleaning_application/features/screens/auth/verify_account/logic/verify_account_cubit.dart';
import 'package:smart_cleaning_application/features/screens/auth/verify_account/ui/screen/verify_account.dart';
import 'package:smart_cleaning_application/features/screens/setting/change_password/logic/change_password_cubit.dart';
import 'package:smart_cleaning_application/features/screens/setting/change_password/ui/screen/change_password_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/edit_user/logic/edit_user_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/edit_user/ui/screen/edit_user_screen.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/ui/screen/login_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_management/logic/work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_management/ui/screen/work_location_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_details/ui/screen/user_details_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_managment/logic/user_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_managment/ui/screen/user_managment.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case Routes.ipScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => IpCubit(),
            child: const IpScreen(),
          ),
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
          builder: (_) => BlocProvider(
            create: (context) => BottomNavbarCubit(),
            child: const MainLayout(),
          ),
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
            create: (context) => ProfileCubit()..getUserProfileDetails(),
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
          builder: (_) => BlocProvider(
            create: (context) =>
                ChooseViewWorkLocationCubit()..getWorkLocations(),
            child: const ChooseViewWorkLocation(),
          ),
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

      case Routes.workLocationAssignQuestionPoint:
        final args = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AssignQuestionPointCubit()
              ..getQuestionsSection(args['sectionId'], args['id']),
            child: AssignQuestionPointScreen(
              id: args['id']!,
              sectionId: args['sectionId']!,
            ),
          ),
        );
      case Routes.shiftScreen:
        final isActive = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ShiftCubit()..initialize(isActive: isActive),
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
      case Routes.feedbackScreen:
        return MaterialPageRoute(
          builder: (_) => FeedbackScreen(),
        );
      case Routes.questionScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => QuestionCubit()..initialize(),
            child: const QuestionScreen(),
          ),
        );
      case Routes.addQuestionScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddQuestionCubit(),
            child: const AddQuestionScreen(),
          ),
        );

      case Routes.editQuestionScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditQuestionCubit()..getQuestionDetails(id),
            child: EditQuestionScreen(id: id),
          ),
        );

      case Routes.feedbackAndAuditViewScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => FeedbackAuditCubit()..initialize(),
            child: const FeedbackAuditScreen(),
          ),
        );

      case Routes.addFeedbackAuditScreen:
        var selectindex = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddFeedbackAuditCubit()
              ..getOrganization()
              ..getDevices(),
            child: AddFeedbackAuditScreen(selectindex: selectindex),
          ),
        );
      case Routes.editFeedbackAuditScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final id = args['id'] as int;
        final selectIndex = args['selectIndex'] as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditFeedbackAuditCubit()
              ..getOrganization()
              ..getFeedbackAuditDetails(selectIndex, id)
              ..getDevices(),
            child: EditFeedbackAuditScreen(id: id, selectIndex: selectIndex),
          ),
        );

      case Routes.feedbackAuditDetailsScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final id = args['id'] as int;
        final selectIndex = args['selectIndex'] as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => FeedbackAuditDetailsCubit()
              ..getFeedbackAuditDetails(selectIndex, id)
              ..getQuestions(id),
            child: FeedbackAuditDetailsScreen(id: id, selectIndex: selectIndex),
          ),
        );

      case Routes.assignQuestionWithFeedbackAuditScreen:
        final args = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AssignQuestionCubit()
              ..getQuestionsWithSection(args['sectionId'], args['id']),
            child: AssignQuestionWithFeedbackAuditScreen(
              id: args['id']!,
              sectionId: args['sectionId']!,
            ),
          ),
        );
      case Routes.devicesScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => DevicesCubit()..initialize(),
            child: const DevicesScreen(),
          ),
        );

      case Routes.addDevicesScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddDeviceCubit()..getBuilding(),
            child: AddDeviceScreen(),
          ),
        );

      case Routes.editDevicesScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditDevicesCubit()
              ..getDeviceDetails(id)
              ..getBuilding(),
            child: EditDevicesScreen(id: id),
          ),
        );

      case Routes.deviceAnswersScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => DeviceAnswersCubit()..getDeviceAnswers(id),
            child: DeviceAnswersScreen(id: id),
          ),
        );

      case Routes.feedbackAnswerScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => FeedbackAnswerCubit()..getAnswerDetails(id),
            child: FeedbackAnswerScreen(),
          ),
        );

      case Routes.auditorScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuditorCubit()..getAuditLocation(),
            child: AuditLocationScreen(),
          ),
        );
      case Routes.auditLocationDetailsScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuditorCubit()
              ..getAuditLocationDetails(id)
              ..getAuditorhistory(id),
            child: AuditLocationDetailsScreen(
              id: id,
            ),
          ),
        );
      case Routes.auditorQuestionsScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuditorCubit()..getAuditorQuestions(id),
            child: AuditorQuestions(
              id: id,
            ),
          ),
        );

      case Routes.auditorAnswerDetailsScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => UserDetailsCubit()..getAnswerDetails(id),
            child: AudiorAnswerDetailsScreen(
              id: id,
            ),
          ),
        );
      case Routes.sensorScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SensorCubit()..initialize(),
            child: const SensorScreen(),
          ),
        );
      case Routes.sensorEditScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditSensorCubit()
              ..getSensorDetails(id)
              ..getOrganization(),
            child: SensorEditScreen(id: id),
          ),
        );
      case Routes.sensorDetailsScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SensorDetailsCubit()
              ..getSensorDetails(id)
              ..getAllTasks(id),
            child: SensorDetailsScreen(id: id),
          ),
        );
      case Routes.addUserScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddUserCubit()
              ..getNationality()
              ..getRole()
              ..getProviders()
              ..getArea(),
            child: const AddUserScreen(),
          ),
        );
      case Routes.userDetailsScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final id = args['id'] as int;
        final roleId = args['roleId'] as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => UserDetailsCubit()..getUserDetails(id),
            child: UserDetailsScreen(
              id: id,
              roleId: roleId,
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
            create: (context) => AddWorkLocationCubit()
              ..getNationality(userUsedOnly: false, areaUsedOnly: true)
              ..getAllUsers(),
            child: const AddCityScreen(),
          ),
        );
      case Routes.addOrganizationScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddWorkLocationCubit()
              ..getNationality(userUsedOnly: false, areaUsedOnly: true)
              ..getAllUsers()
              ..getShifts(),
            child: const AddOrganizationScreen(),
          ),
        );
      case Routes.addBuildingScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddWorkLocationCubit()
              ..getNationality(userUsedOnly: false, areaUsedOnly: true)
              ..getAllUsers()
              ..getShifts(),
            child: const AddBuildingScreen(),
          ),
        );
      case Routes.addFloorScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddWorkLocationCubit()
              ..getNationality(userUsedOnly: false, areaUsedOnly: true)
              ..getAllUsers()
              ..getShifts(),
            child: const AddFloorScreen(),
          ),
        );
      case Routes.addSectionScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddWorkLocationCubit()
              ..getNationality(userUsedOnly: false, areaUsedOnly: true)
              ..getAllUsers()
              ..getShifts(),
            child: AddSectionScreen(),
          ),
        );
      case Routes.addPointScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddWorkLocationCubit()
              ..getNationality(userUsedOnly: false, areaUsedOnly: true)
              ..getAllUsers()
              ..getSensorsData(),
            child: const AddPointScreen(),
          ),
        );
      case Routes.workLocationDetailsScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => WorkLocationDetailsCubit()
              ..initialize(args['id'], args['selectedIndex']),
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
            create: (context) => EditWorkLocationCubit()
              ..getNationality(userUsedOnly: false, areaUsedOnly: false)
              ..getAreaManagersDetails(id)
              ..getAllUsers(),
            child: EditAreaScreen(id: id),
          ),
        );
      case Routes.editCityScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditWorkLocationCubit()
              ..getCityManagersDetails(id)
              ..getNationality(userUsedOnly: false, areaUsedOnly: true)
              ..getAllUsers(),
            child: EditCityScreen(
              id: id,
            ),
          ),
        );
      case Routes.editOrganizationScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditWorkLocationCubit()
              ..getOrganizationManagersDetails(id)
              ..getNationality(userUsedOnly: false, areaUsedOnly: true)
              ..getAllUsers()
              ..getShifts(),
            child: EditOrganizationScreen(
              id: id,
            ),
          ),
        );
      case Routes.editBuildingScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditWorkLocationCubit()
              ..getBuildingManagersDetails(id)
              ..getNationality(userUsedOnly: false, areaUsedOnly: true)
              ..getAllUsers()
              ..getShifts(),
            child: EditBuildingScreen(
              id: id,
            ),
          ),
        );
      case Routes.editFloorScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditWorkLocationCubit()
              ..getFloorManagersDetails(id)
              ..getNationality(userUsedOnly: false, areaUsedOnly: true)
              ..getAllUsers()
              ..getShifts(),
            child: EditFloorScreen(
              id: id,
            ),
          ),
        );

      case Routes.editSectionScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditWorkLocationCubit()
              ..getSectionManagersDetails(id)
              ..getNationality(userUsedOnly: false, areaUsedOnly: true)
              ..getAllUsers()
              ..getShifts(),
            child: EditSectionScreen(
              id: id,
            ),
          ),
        );

      case Routes.editPointScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditWorkLocationCubit()
              ..getPointManagersDetails(id)
              ..getNationality(userUsedOnly: false, areaUsedOnly: true)
              ..getAllUsers()
              ..getSensorsData(),
            child: EditPointScreen(
              id: id,
            ),
          ),
        );

      case Routes.addShiftScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddShiftCubit()
              ..getOrganization()
              ..getBuilding()
              ..getFloor()
              ..getSection(),
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
              ..getOrganization()
              ..getBuilding()
              ..getFloor()
              ..getSection(),
            child: EditShiftScreen(
              id: id,
            ),
          ),
        );
      case Routes.chooseViewTask:
        return MaterialPageRoute(
          builder: (_) => ChooseViewTask(),
        );
      case Routes.taskManagementScreen:
        var index = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TaskManagementCubit()..initialize(index),
            child: TaskManagementScreen(index: index),
          ),
        );
      case Routes.addTaskScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddTaskCubit()
              ..getAllTasks()
              ..getOrganization(),
            child: AddTaskScreen(),
          ),
        );

      case Routes.chooseViewAssignScreen:
        return MaterialPageRoute(
          builder: (_) => ChooseViewAssign(),
        );
      case Routes.assignScreen:
        var index = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                AssignCubit()..fetchAppropriateOrganizations(index),
            child: AssignScreen(index: index),
          ),
        );
      case Routes.taskDetailsScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final id = args['id'] as int;
        final selectedIndex = args['selectedIndex'] as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TaskDetailsCubit()..getTaskDetails(id),
            child: TaskDetailsScreen(id: id, selectedIndex: selectedIndex),
          ),
        );

      case Routes.editTaskScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditTaskCubit()
              ..getTaskDetails(id)
              ..getAllTasks()
              ..getOrganization(),
            child: EditTaskScreen(id: id),
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
            create: (context) => LeavesAddCubit()..initialize(),
            child: LeavesAddScreen(),
          ),
        );
      case Routes.editleavesScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LeavesEditCubit()
              ..getLeavesDetails(id)
              ..getAllUsers(),
            child: LeavesEditScreen(
              id: id,
            ),
          ),
        );

      case Routes.leavesDetailsScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final id = args['id'] as int;
        final isProfile = args['isProfile'] as bool;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LeavesDetailsCubit()..getLeavesDetails(id),
            child: LeavesDetailsScreen(
              id: id,
              isProfile: isProfile,
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
            create: (context) => AddCategoryCubit()..getCategoryList(),
            child: const AddCategoryScreen(),
          ),
        );
      case Routes.editCategoryScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditCategoryCubit()
              ..getCategoryDetails(id)
              ..getCategoryList(),
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
            create: (context) => AddMaterialCubit()..getCategoryList(),
            child: const AddMaterialScreen(),
          ),
        );
      case Routes.editMaterialScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditMaterialCubit()
              ..getMaterialDetails(id)
              ..getCategoryList(),
            child: EditMaterialScreen(
              id: id,
            ),
          ),
        );
      case Routes.materialDetailsScreen:
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => MaterialDetailsCubit()..getMaterialDetails(id),
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
            create: (context) =>
                TransactionDetailsCubit()..getTransactionDetails(id, type),
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
