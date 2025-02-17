import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_status_model.dart';

abstract class SettingsState {}

class SettingsInitialState extends SettingsState {}

class SettingsLoadingState extends SettingsState {}

class SettingsSuccessState extends SettingsState {}

class SettingsErrorState extends SettingsState {
  final String error;
  SettingsErrorState(this.error);
}

//******************************* */

class UserDetailsLoadingState extends SettingsState {}

class UserDetailsSuccessState extends SettingsState {
  final UserDetailsModel userDetailsModelModel;

  UserDetailsSuccessState(this.userDetailsModelModel);
}

class UserDetailsErrorState extends SettingsState {
  final String error;
  UserDetailsErrorState(this.error);
}

//********************************* */


class UserStatusLoadingState extends SettingsState {}

class UserStatusSuccessState extends SettingsState {
  final UserStatusModel userStatusModel;

  UserStatusSuccessState(this.userStatusModel);
}

class UserStatusErrorState extends SettingsState {
  final String error;
  UserStatusErrorState(this.error);
}