import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/all_deleted_providers_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/user_create.dart';
import '../../../integrations/data/models/role_model.dart';
import '../../../integrations/data/models/role_user_model.dart';
import '../../../integrations/data/models/shift_model.dart';

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
//***************** */

class AllDeletedrovidersLoadingState extends AddUserState {}

class AllDeletedrovidersSuccessState extends AddUserState {
  final AllDeletedProvidersModel allDeletedProvidersModel;

  AllDeletedrovidersSuccessState(this.allDeletedProvidersModel);
}

class AllDeletedrovidersErrorState extends AddUserState {
  final String error;
  AllDeletedrovidersErrorState(this.error);
}

//***************** */

class DeletedProviderLoadingState extends AddUserState {}

class DeletedProviderSuccessState extends AddUserState {
  final String message;
  DeletedProviderSuccessState(this.message);
}

class DeletedProviderErrorState extends AddUserState {
  final String error;
  DeletedProviderErrorState(this.error);
}
//***************** */

class RestoreProviderLoadingState extends AddUserState {}

class RestoreProviderSuccessState extends AddUserState {
  final String message;

  RestoreProviderSuccessState(this.message);
}

class RestoreProviderErrorState extends AddUserState {
  final String error;
  RestoreProviderErrorState(this.error);
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

class AllProvidersLoadingState extends AddUserState {}

class AllProvidersSuccessState extends AddUserState {
  final ProvidersModel providersModel;

  AllProvidersSuccessState(this.providersModel);
}

class AllProvidersErrorState extends AddUserState {
  final String error;
  AllProvidersErrorState(this.error);
}
//**************************** */

class ShiftLoadingState extends AddUserState {}

class ShiftSuccessState extends AddUserState {
  final ShiftModel shiftModel;
  ShiftSuccessState(this.shiftModel);
}

class ShiftErrorState extends AddUserState {
  final String error;
  ShiftErrorState(this.error);
}

//**************************** */

class RoleUserLoadingState extends AddUserState {}

class RoleUserSuccessState extends AddUserState {
  final RoleUserModel roleUsermodel;

  RoleUserSuccessState(this.roleUsermodel);
}

class RoleUserErrorState extends AddUserState {
  final String error;
  RoleUserErrorState(this.error);
}

//*************************** */

class ChangeSuffixIconVisiabiltyState extends AddUserState {}

//*************************** */
class ImageSelectedState extends AddUserState {
  final XFile image;
  ImageSelectedState(this.image);
}
