import 'package:smart_cleaning_application/core/theming/theme/components/constant.dart';
import 'package:smart_cleaning_application/core/theming/theme/components/dark_theme.dart';
import 'package:smart_cleaning_application/core/theming/theme/components/light_theme.dart';
import 'package:smart_cleaning_application/core/theming/theme/data/model/theme_base.dart';

class ThemeFactory {
  static String usedTheme = AppKeys.lightTheme;

  static ThemeBase currentTheme = ThemeFactory.instance(AppKeys.lightTheme);

  static ThemeBase instance(String themeName) {
    usedTheme = themeName;
    if (themeName == AppKeys.darkThem) {
      return DarkTheme();
    }
    return LightTheme();
  }
}
