import 'package:smart_cleaning_application/features/screens/add_user/data/model/users_model.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/data/model/user_model.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/data/model/delete_user_model.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/data/model/deleted_list_model.dart';

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

//***************** */

class DeletedUsersLoadingState extends UserManagementState {}

class DeletedUsersSuccessState extends UserManagementState {
  final DeletedListModel deletedListModel;

  DeletedUsersSuccessState(this.deletedListModel);
}

class DeletedUsersErrorState extends UserManagementState {
  final String error;
  DeletedUsersErrorState(this.error);
}
//***************** */

class RestoreUsersLoadingState extends UserManagementState {}

class RestoreUsersSuccessState extends UserManagementState {
  final String message;

  RestoreUsersSuccessState(this.message); 
}

class RestoreUsersErrorState extends UserManagementState {
  final String error;
  RestoreUsersErrorState(this.error);
}
//***************** */

class ForceDeleteUsersLoadingState extends UserManagementState {}

class ForceDeleteUsersSuccessState extends UserManagementState {}

class ForceDeleteUsersErrorState extends UserManagementState {
  final String error;
  ForceDeleteUsersErrorState(this.error);
}
//*********************** */


class UserLoadingState extends UserManagementState {}

class UserSuccessState extends UserManagementState {
  final UserModel userModel;

  UserSuccessState(this.userModel);
}

class UserErrorState extends UserManagementState {
  final String error;
  UserErrorState(this.error);
}
//****************** */

class UserDeleteInDetailsLoadingState extends UserManagementState {}

class UserDeleteInDetailsSuccessState extends UserManagementState {
  final DeleteUserModel deleteUserDetailsModel;

  UserDeleteInDetailsSuccessState(this.deleteUserDetailsModel);
}

class UserDeleteInDetailsErrorState extends UserManagementState {
  final String error;
  UserDeleteInDetailsErrorState(this.error);
}
