import 'package:flutter/material.dart';

class AppColor {
  static const Color mainBlue = Color(0xFF247CFF);
  static const Color lightBlue = Color(0xFFF4F8FF);
  static const Color buttonColor = Color(0xFF364653);

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
