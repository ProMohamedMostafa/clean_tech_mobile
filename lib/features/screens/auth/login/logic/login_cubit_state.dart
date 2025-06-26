import 'package:smart_cleaning_application/features/screens/auth/login/data/model/log_in_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModel loginmodel;

  LoginSuccessState(this.loginmodel);
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}

//************ */
class ChangeSuffixIconVisiabiltyState extends LoginStates {}

//****************** */
class NotificationLoadingState extends LoginStates {}

class NotificationSuccessState extends LoginStates {}

class NotificationErrorState extends LoginStates {
  final String error;
  NotificationErrorState(this.error);
}
