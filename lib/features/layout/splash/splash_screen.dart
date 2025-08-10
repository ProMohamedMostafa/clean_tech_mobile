import 'package:flutter/material.dart';
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
      duration: const Duration(seconds: 2),
    );

    // Only move logo left (not up)
    _iconPosition = Tween<double>(begin: 0, end: -70).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _cleanPosition = Tween<double>(begin: 70, end: 50).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start animation after 1 second delay
    Future.delayed(const Duration(seconds: 2), () {
      _controller.forward();
    });

    // Navigate to next screen after animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => getStartWidget()),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // LOGO moving left only
                Positioned(
                  left: (MediaQuery.of(context).size.width - 80) / 2 +
                      _iconPosition.value,
                  child: Image.asset(
                    "assets/images/logo_launcher.png",
                    width: 90.r,
                    height: 90.r,
                  ),
                ),

                // CLEAN text fades in and moves left slightly
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 -
                      _cleanPosition.value,
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Image.asset(
                      "assets/images/clean.png",
                      width: 200.w,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
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
