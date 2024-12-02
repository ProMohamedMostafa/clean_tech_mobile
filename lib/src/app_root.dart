import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/routing/app_router.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/features/screens/login/logic/login_cubit_cubit.dart';
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
        return MultiBlocProvider(
          providers: [BlocProvider(create: (context) => LoginCubit())],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: const Locale('ar'),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              fontFamily: 'Poppins',
            ),
            initialRoute: Routes.splashScreen,
            onGenerateRoute: appRouter.generateRoute,
          ),
        );
      },
    );
  }
}
