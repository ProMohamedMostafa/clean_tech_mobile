import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/logic/bottom_navbar_cubit.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/ui/screen/main_layout.dart';
import 'package:smart_cleaning_application/features/layout/on_boarding/ui/screen/on_boarding_screen.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/logic/login_cubit_cubit.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/ui/screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconPosition;
  late Animation<double> _cleanPosition;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _iconPosition = Tween<double>(begin: 0, end: -80).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _cleanPosition = Tween<double>(begin: 80, end: 50).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    Future.delayed(Duration(seconds: 2), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      child: AnimatedSplashScreen(
        splash: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: const Offset(0, 12),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: (MediaQuery.of(context).size.width - 102) / 2 +
                          _iconPosition.value,
                      child: Image.asset(
                        "assets/images/logo_launcher.png",
                        width: 102.w,
                        height: 102.h,
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width / 2 -
                          _cleanPosition.value,
                      child: Opacity(
                        opacity: _fadeAnimation.value,
                        child: Image.asset(
                          "assets/images/clean.png",
                          width: 150.w,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
        nextScreen: getStartWidget(),
        splashIconSize: 600,
        duration: 3000,
      ),
    );
  }

  Widget getStartWidget() {
    if (isBoarding != null && isBoarding!.isNotEmpty) {
      if (token != null && token!.isNotEmpty) {
        return BlocProvider(
          create: (context) => BottomNavbarCubit(),
          child: const MainLayout(),
        );
      } else {
        return BlocProvider(
          create: (context) => LoginCubit(),
          child: const LoginScreen(),
        );
      }
    } else {
      return const OnBoardingScreen();
    }
  }
}
