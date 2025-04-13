import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/src/app_cubit/app_cubit.dart';
import 'package:smart_cleaning_application/src/app_cubit/app_states.dart';
import 'package:smart_cleaning_application/core/routing/app_router.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
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
          create: (context) => AppCubit()..getSavedLanguage(),
          child: BlocBuilder<AppCubit, AppStates>(
            builder: (context, state) {
              return MaterialApp(
                navigatorKey: AppNavigator.navigatorKey,
                debugShowCheckedModeBanner: false,
                locale: context.read<AppCubit>().locale,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                theme: ThemeData(
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  appBarTheme: AppBarTheme(
                      titleTextStyle: TextStyles.font16BlackSemiBold,
                      centerTitle: true,
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Colors.white,
                      elevation: 12,
                      selectedItemColor: AppColor.primaryColor,
                      unselectedItemColor: AppColor.thirdColor,
                      selectedLabelStyle: TextStyles.font11lightPrimary),
                  scaffoldBackgroundColor: Colors.white,
                  fontFamily: 'Poppins',
                ),
                initialRoute: Routes.splashScreen,
                onGenerateRoute: appRouter.generateRoute,
              );
            },
          ),
        );
      },
    );
  }
}
