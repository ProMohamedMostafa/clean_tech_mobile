import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
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

    _iconPosition = Tween<double>(begin: 0, end: -70).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _cleanPosition = Tween<double>(begin: 70, end: 50).animate(
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
        statusBarIconBrightness: Brightness.dark,
      ),
      child: AnimatedSplashScreen(
        splash: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: (MediaQuery.of(context).size.width - 250) / 2 +
                      _iconPosition.value,
                  child: Image.asset(
                    "assets/images/icon.png",
                    width: 250.w,
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
            );
          },
        ),
        nextScreen: isBoarding!.isNotEmpty
            ? BlocProvider(
                create: (context) => LoginCubit(),
                child: LoginScreen(),
              )
            : OnBoardingScreen(),
        splashIconSize: 600,
        duration: 3000,
        splashTransition: SplashTransition.sizeTransition,
      ),
    );
  }
}
