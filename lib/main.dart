import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/cache_helper/cache_helper.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
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
  setupFirebaseMessagingListeners();
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = const SimpleBlocObserver();
  runApp(AppRoot(appRouter: AppRouter()));
}

checkIfLoggedInUser() async {
  ip = await CacheHelper.getString(SharedPrefKeys.ip);
  token = await CacheHelper.getSecuredString(SharedPrefKeys.userToken);
  isBoarding = await CacheHelper.getString(SharedPrefKeys.isOnBoarding);
  role = await CacheHelper.getString(SharedPrefKeys.userRole);

  if (ip != null && ip!.isNotEmpty) {
    ApiConstants.apiBaseUrl = "http://$ip:8080/api/v1/";
  } else {
    await CacheHelper.removeData(SharedPrefKeys.ip);
    ip = null;
  }
  if (token != null && ApiConstants.apiBaseUrl.isNotEmpty) {
    await DioHelper.initDio();
  }
}
