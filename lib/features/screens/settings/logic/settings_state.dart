import 'package:smart_cleaning_application/features/screens/settings/data/model/profile_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/data/models/user_status_model.dart';

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
  final ProfileModel profileModel;

  UserDetailsSuccessState(this.profileModel);
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

//********************************* */


class LogOutLoadingState extends SettingsState {}

class LogOutSuccessState extends SettingsState {
  final String messsage;

  LogOutSuccessState(this.messsage);
}

class LogOutErrorState extends SettingsState {
  final String error;
 LogOutErrorState(this.error);
}