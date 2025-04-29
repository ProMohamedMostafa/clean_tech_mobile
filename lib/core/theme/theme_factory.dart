import 'package:smart_cleaning_application/core/theming/theme/components/constant.dart';

import 'components/dark_theme.dart';
import 'components/light_theme.dart';
import 'model/theme_base.dart';

class ThemeFactory {
  static String usedTheme = AppKeys.lightTheme;

  static ThemeBase currentTheme = ThemeFactory.instance(AppKeys.lightTheme);

  static ThemeBase instance(String themeName) {
    usedTheme = themeName;
    if (themeName == AppKeys.darkThem) {
      return DarkTheme();
    } else {
      return LightTheme();
    }
  }
}
