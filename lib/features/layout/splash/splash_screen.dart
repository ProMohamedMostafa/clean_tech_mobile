import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/cache_helper/cache_helper.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/screen/home_screen.dart';
import 'package:smart_cleaning_application/features/screens/login/ui/screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Check if token is available from CacheHelper
    checkIfLoggedInUser();
  }

  checkIfLoggedInUser() async {
    token = await CacheHelper.getSecuredString(SharedPrefKeys.userToken);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.white,
      splash: Center(
        child: Image.asset(
          "assets/images/splash.png",
          width: 300.w,
        ),
      ),
      nextScreen: token == null ? const LoginScreen() : const HomeScreen(),
      splashIconSize: 600,
      duration: 2500,
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
