import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/theming/theme/components/constant.dart';

import '../model/theme_base.dart';

class DarkTheme extends ThemeBase {
  @override
  String get name => AppKeys.darkThem;

  @override
  Color get primary => const Color(0xFF238668);

  @override
  Color get primaryHeaderIcon => const Color(0xFF76B6FE);

  @override
  Color get primaryHeader => const Color(0xFF273951);

  @override
  Color get secondary => const Color(0xFF8286F5);

  @override
  Color get labelText => const Color(0xFF6F767E);

  @override
  Color get background => const Color(0xFF18191B);

  @override
  Color get surfaceBorder => const Color(0xFF242527);

  @override
  Color get fontOnBackground => const Color(0xFFd3d3d3);

  @override
  Color get fontOnSurface => const Color(0xFFe2e2e2);

  @override
  Color get fontOnPrimary => Colors.white;

  @override
  Color get surface => Colors.black;

  @override
  Color get success => Colors.green;

  @override
  Color get danger => const Color(0xFFF13A3A);
  @override
  Color get primaryBackground => const Color(0xFFE5FFEE);
  @override
  Color get bodyText => const Color(0xFFA1A8B0);

  @override
  Color get headerText => const Color(0xFF333333);

  @override
  Color get iconColor => const Color(0xFF808191);

  @override
  Color get iconSurface => const Color(0xFFF4F5F6);

  @override
  Color get meduimText => const Color(0xFF353945);

  @override
  Color get primaryBgDark => const Color(0xFFE9F4F1);

  @override
  Color get red => const Color(0xFFF42929);
  @override
  Color get inputBackground => const Color(0xFFF4F5F6);
}
