import 'package:smart_cleaning_application/features/screens/user_managment/data/model/delete_user_model.dart';

abstract class UserManagementState {}

class UserManagementInitialState extends UserManagementState {}

class UserManagementLoadingState extends UserManagementState {}

class UserManagementSuccessState extends UserManagementState {}

class UserManagementErrorState extends UserManagementState {
  final String error;
  UserManagementErrorState(this.error);
}
//***************** */

class UserDeleteLoadingState extends UserManagementState {}

class UserDeleteSuccessState extends UserManagementState {
  final DeleteUserModel deleteUserModel;

  UserDeleteSuccessState(this.deleteUserModel);
}

class UserDeleteErrorState extends UserManagementState {
  final String error;
  UserDeleteErrorState(this.error);
}
