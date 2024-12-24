import 'package:smart_cleaning_application/features/screens/add_user/data/model/users_model.dart';
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



//***************** */

class AllUsersLoadingState extends UserManagementState {}

class AllUsersSuccessState extends UserManagementState {
  final UsersModel usersModel;

  AllUsersSuccessState(this.usersModel);
}

class AllUsersErrorState extends UserManagementState {
  final String error;
  AllUsersErrorState(this.error);
}
