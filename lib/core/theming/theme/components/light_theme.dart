import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/theming/theme/components/constant.dart';
import '../data/model/theme_base.dart';

class LightTheme extends ThemeBase {
  @override
  String get name => AppKeys.lightTheme;

  @override
  Color get primary => const Color(0xFF238668);

  @override
  Color get primaryHeader => const Color(0xFF056FDD);

  @override
  Color get primaryHeaderIcon => const Color(0xFF056FDD);

  @override
  Color get secondary => const Color(0xFFF4F5F6);

  @override
  Color get background => const Color(0xFFFDFDFD);

  @override
  Color get surfaceBorder => const Color(0xFFE6E8EC);

  @override
  Color get fontOnBackground => const Color(0xFF2C3131);

  @override
  Color get fontOnSurface => const Color(0xFF656564);

  @override
  Color get fontOnPrimary => Colors.white;

  @override
  Color get surface => const Color(0xFFFFFFFF);

  @override
  Color get success => Colors.green;

  @override
  Color get danger => const Color(0xFF951717);

  @override
  Color get bodyText => const Color(0xFFA1A8B0);

  @override
  Color get labelText => const Color(0xFF6F767E);

  @override
  Color get meduimText => const Color(0xFF353945);

  @override
  Color get headerText => const Color(0xFF333333);

  @override
  Color get iconColor => const Color(0xFF808191);

  @override
  Color get primaryBackground => const Color(0xFFE5FFEE);

  @override
  Color get iconSurface => const Color(0xFFF4F5F6);

  @override
  Color get primaryBgDark => const Color(0xFFBCDED3);
  @override
  Color get red => const Color(0xFFF42929);

  @override
  Color get inputBackground => const Color(0xFFF4F5F6);
}
