import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/provider/provider_management/data/models/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/user/edit_user/data/model/edit_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/data/models/user_details_model.dart';

abstract class EditUserState {}

class EditUserInitialState extends EditUserState {}

class EditUserLoadingState extends EditUserState {}

class EditUserSuccessState extends EditUserState {
  final EditModel editModel;
  EditUserSuccessState(this.editModel);
}

class EditUserErrorState extends EditUserState {
  final String error;
  EditUserErrorState(this.error);
}

//************************* */

class UserLoadingState extends EditUserState {}

class UserSuccessState extends EditUserState {
  final UserDetailsModel userDetailsModel;

  UserSuccessState(this.userDetailsModel);
}

class UserErrorState extends EditUserState {
  final String error;
  UserErrorState(this.error);
}

//**************************** */
class GetNationalityLoadingState extends EditUserState {}

class GetNationalitySuccessState extends EditUserState {
  final NationalityListModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends EditUserState {
  final String error;
  GetNationalityErrorState(this.error);
}

//**************************** */

class RoleLoadingState extends EditUserState {}

class RoleSuccessState extends EditUserState {
  final RoleModel rolemodel;

  RoleSuccessState(this.rolemodel);
}

class RoleErrorState extends EditUserState {
  final String error;
  RoleErrorState(this.error);
}

//**************************** */

class AllProvidersLoadingState extends EditUserState {}

class AllProvidersSuccessState extends EditUserState {
  final ProvidersModel providersModel;

  AllProvidersSuccessState(this.providersModel);
}

class AllProvidersErrorState extends EditUserState {
  final String error;
  AllProvidersErrorState(this.error);
}
//***************** */

class AllUsersLoadingState extends EditUserState {}

class AllUsersSuccessState extends EditUserState {
  final UsersModel usersModel;

  AllUsersSuccessState(this.usersModel);
}

class AllUsersErrorState extends EditUserState {
  final String error;
  AllUsersErrorState(this.error);
}
//*************************** */

class ChangeSuffixIconVisiabiltyState extends EditUserState {}

//*************************** */
class ImageSelectedState extends EditUserState {
  final XFile image;
  ImageSelectedState(this.image);
}
//*************************** */

class PasswordValidationChangedState extends EditUserState {}