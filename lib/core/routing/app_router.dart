import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/logic/bottom_navbar_cubit.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/ui/screen/main_layout.dart';
import 'package:smart_cleaning_application/features/layout/splash/splash_screen.dart';
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
import 'package:smart_cleaning_application/features/screens/home/ui/screen/home_screen.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/ui/screen/login_screen.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/screen/integrations_screen.dart';
import 'package:smart_cleaning_application/features/screens/settings/ui/screen/settings_screen.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/ui/screen/user_managment.dart';

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
          builder: (_) => const UserManagmentScreen(),
        );
      case Routes.settingsScreen:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );
      default:
        return null;
    }
  }
}
