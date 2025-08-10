import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/theming/app_theme.dart';
import 'package:smart_cleaning_application/src/app_cubit/app_cubit.dart';
import 'package:smart_cleaning_application/src/app_cubit/app_states.dart';
import 'package:smart_cleaning_application/core/routing/app_router.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AppRoot extends StatelessWidget {
  final AppRouter appRouter;
  const AppRoot({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return BlocProvider(
          create: (context) => AppCubit()
            ..getSavedLanguage()
            ..initNotifications(context),
          child: BlocBuilder<AppCubit, AppStates>(
            builder: (context, state) {
              final cubit = context.watch<AppCubit>();
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light.copyWith(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.light,
                ),
                child: MaterialApp(
                  navigatorKey: AppNavigator.navigatorKey,
                  debugShowCheckedModeBanner: false,
                  locale: cubit.locale,
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  theme:  AppTheme.lightTheme,
                  initialRoute: Routes.splashScreen,
                  onGenerateRoute: appRouter.generateRoute,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
