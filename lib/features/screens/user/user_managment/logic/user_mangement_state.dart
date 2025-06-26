import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/delete_user_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/deleted_list_model.dart';

import '../../../integrations/data/models/users_model.dart';

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

class AllDeletedUsersLoadingState extends UserManagementState {}

class AllDeletedUsersSuccessState extends UserManagementState {
  final DeletedListModel deletedListModel;

  AllDeletedUsersSuccessState(this.deletedListModel);
}

class AllDeletedUsersErrorState extends UserManagementState {
  final String error;
  AllDeletedUsersErrorState(this.error);
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

class ForceDeleteUsersSuccessState extends UserManagementState {
  final String message;

  ForceDeleteUsersSuccessState(this.message);
}

class ForceDeleteUsersErrorState extends UserManagementState {
  final String error;
  ForceDeleteUsersErrorState(this.error);
}
