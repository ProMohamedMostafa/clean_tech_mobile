import 'package:flutter/material.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class ChangeLocaleState extends AppStates {
  final Locale locale;
  ChangeLocaleState({required this.locale});
}
