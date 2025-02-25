import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/cache_helper/cache_helper.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/routing/app_router.dart';
import 'package:smart_cleaning_application/src/app_root.dart';
import 'package:smart_cleaning_application/src/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await DioHelper.initDio();
  await ScreenUtil.ensureScreenSize();
  await checkIfLoggedInUser();
  Bloc.observer = const SimpleBlocObserver();
  runApp(AppRoot(
    appRouter: AppRouter(),
  ));
}

checkIfLoggedInUser() async {
  token = await CacheHelper.getSecuredString(SharedPrefKeys.userToken);
  isBoarding = await CacheHelper.getString(SharedPrefKeys.isOnBoarding);
}
