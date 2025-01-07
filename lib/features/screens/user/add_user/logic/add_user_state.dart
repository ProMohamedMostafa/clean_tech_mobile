import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/manager_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/role_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/user_create.dart';

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
class AddProviderLoadingState extends AddUserState {}

class AddProviderSuccessState extends AddUserState {
  final String message;

  AddProviderSuccessState(this.message);
}

class AddProviderErrorState extends AddUserState {
  final String error;
  AddProviderErrorState(this.error);
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

class ManagerLoadingState extends AddUserState {}

class  ManagerSuccessState extends AddUserState {
  final ManagerModel managerModel;

   ManagerSuccessState(this.managerModel);
}

class  ManagerErrorState extends AddUserState {
  final String error;
   ManagerErrorState(this.error);
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
