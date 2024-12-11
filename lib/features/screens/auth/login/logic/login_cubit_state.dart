import 'package:flutter/material.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  // final SignInModel signinmodel;

  // LoginStateSuccessState(this.signinmodel);
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}

//************ */
class ChangeSuffixIconVisiabiltyState extends LoginStates {}

//************ */
// Locale state
class ChangeLocaleState extends LoginStates {
  final Locale locale;
  ChangeLocaleState({required this.locale});
}
