import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/routing/app_router.dart';
import 'package:smart_cleaning_application/src/app_root.dart';
import 'package:smart_cleaning_application/src/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = const SimpleBlocObserver();
  runApp(AppRoot(
    appRouter: AppRouter(),
  ));
}
// checkIfLoggedInUser() async {
//   String? userToken =
//       await CacheHelper.getSecuredString(SharedPrefKeys.userToken);
//   if (!userToken.isEmpty) {
//     isLoggedInUser = true;
//   } else {
//     isLoggedInUser = false;
//   }
// }