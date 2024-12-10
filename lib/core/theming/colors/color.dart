import 'package:flutter/material.dart';

class AppColor {
  static const Color secondaryColor = Color(0xFF247CFF);
  static const Color thirdColor = Color(0xFF8391A1);
  static const Color primaryColor = Color(0xFF364653);

  static List<Color> splashColor = const [
    Color(0xff68B9FD),
    Color(0xff0B0B0B),
  ];
  static BoxDecoration gradientDecoration = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: const [0.18, 0.82],
          colors: splashColor));
}
