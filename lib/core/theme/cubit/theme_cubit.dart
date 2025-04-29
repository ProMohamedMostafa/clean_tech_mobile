import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/cache_helper/cache_helper.dart';
import 'package:smart_cleaning_application/core/theming/theme/components/constant.dart';


import '../theme_factory.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitialState());

  static ThemeCubit get(context) => BlocProvider.of(context);

  ThemeData applicationTheme = ThemeData.light();
  ThemeMode applicationThemeMode = ThemeMode.light;
  bool isDark = false;

  ThemeData applicationLightThemeData = ThemeData(
      appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark, // For iOS: (dark icons)
              systemNavigationBarColor: Colors.transparent,
              systemNavigationBarDividerColor: Colors.transparent,
              statusBarIconBrightness:
                  Brightness.dark // For Android(M and greater): (dark icons)
              )),
      // brightness: Brightness.dark,
      primarySwatch: Colors.green,
      switchTheme: SwitchThemeData(
          thumbColor: MaterialStatePropertyAll<Color>(
              ThemeFactory.currentTheme.primary)),
      radioTheme: RadioThemeData(
          fillColor: MaterialStatePropertyAll<Color>(
              ThemeFactory.currentTheme.primary)),
      datePickerTheme: DatePickerThemeData(
          backgroundColor: ThemeFactory.currentTheme.background,
          headerBackgroundColor: ThemeFactory.currentTheme.primary,
          rangePickerHeaderBackgroundColor: ThemeFactory.currentTheme.primary
          // rangeSelectionOverlayColor:
          //     MaterialStatePropertyAll<Color>(ThemeFactory.currentTheme.primary),
          // rangeSelectionBackgroundColor: ThemeFactory.currentTheme.primary
          // MaterialStatePropertyAll<Color>(ThemeFactory.currentTheme.primary),
          ),
      expansionTileTheme: ExpansionTileThemeData(
        iconColor: ThemeFactory.currentTheme.primary,
      ),
      fontFamily:  'Poppins',
      useMaterial3: false);

  ThemeData applicationDarkThemeData = ThemeData(
      appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light, // For iOS: (dark icons)
        statusBarIconBrightness:
            Brightness.light, // For Android(M and greater): (dark icons)
      )),
      brightness: Brightness.dark,
      primarySwatch: Colors.green,
      fontFamily:  'Poppins',
      useMaterial3: false);

  setApplicationTheme() {
    if (ThemeFactory.usedTheme == AppKeys.darkThem) {
      applicationThemeMode = ThemeMode.dark;
      applicationTheme = ThemeData.dark();
      isDark = true;
    } else {
      applicationThemeMode = ThemeMode.light;
      applicationTheme = ThemeData.light();
      isDark = false;
    }
  }

  changeApplicationTheme(BuildContext context) async {
    isDark = !isDark;
    ThemeFactory.usedTheme = isDark ? AppKeys.darkThem : AppKeys.lightTheme;
    applicationThemeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    await CacheHelper.setData(
        key: AppKeys.currentTheme, value: ThemeFactory.usedTheme);
    ThemeFactory.currentTheme = ThemeFactory.instance(ThemeFactory.usedTheme);
    emit(ThemeChangeState());
  }
}
