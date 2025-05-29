import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/cache_helper/cache_helper.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/routing/app_router.dart';
import 'package:smart_cleaning_application/core/service/notification/firebase_messaging_helper.dart';
import 'package:smart_cleaning_application/firebase_options.dart';
import 'package:smart_cleaning_application/src/app_root.dart';
import 'package:smart_cleaning_application/src/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await checkIfLoggedInUser();
  await DioHelper.initDio();
  setupFirebaseMessagingListeners();
  await ScreenUtil.ensureScreenSize();
  HttpOverrides.global = MyHttpOverrides();
  Bloc.observer = const SimpleBlocObserver();
  runApp(AppRoot(
    appRouter: AppRouter(),
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

checkIfLoggedInUser() async {
  token = await CacheHelper.getSecuredString(SharedPrefKeys.userToken);
  isBoarding = await CacheHelper.getString(SharedPrefKeys.isOnBoarding);
  role = await CacheHelper.getString(SharedPrefKeys.userRole);
}
