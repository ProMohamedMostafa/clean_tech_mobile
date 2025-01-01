import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/role_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/user_create.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/users_model.dart';

abstract class AddUserState {}

class AddUserInitialState extends AddUserState {}

class AddUserLoadingState extends AddUserState {}

class AddUserSuccessState extends AddUserState {
  final UserCreateModel userCreateModel;

  AddUserSuccessState(this.userCreateModel);
}

class AddUserErrorState extends AddUserState {
  final String error;
  AddUserErrorState(this.error);
}

//**************************** */

class GetNationalityLoadingState extends AddUserState {}

class GetNationalitySuccessState extends AddUserState {
  final NationalityModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends AddUserState {
  final String error;
  GetNationalityErrorState(this.error);
}

//**************************** */

class RoleLoadingState extends AddUserState {}

class RoleSuccessState extends AddUserState {
  final RoleModel rolemodel;

  RoleSuccessState(this.rolemodel);
}

class RoleErrorState extends AddUserState {
  final String error;
  RoleErrorState(this.error);
}

//**************************** */

class AllUsersLoadingState extends AddUserState {}

class AllUsersSuccessState extends AddUserState {
  final UsersModel usermodel;

  AllUsersSuccessState(this.usermodel);
}

class AllUsersErrorState extends AddUserState {
  final String error;
  AllUsersErrorState(this.error);
}
//**************************** */

class AllProvidersLoadingState extends AddUserState {}

class AllProvidersSuccessState extends AddUserState {
  final ProvidersModel providersModel;

  AllProvidersSuccessState(this.providersModel);
}

class AllProvidersErrorState extends AddUserState {
  final String error;
  AllProvidersErrorState(this.error);
}
