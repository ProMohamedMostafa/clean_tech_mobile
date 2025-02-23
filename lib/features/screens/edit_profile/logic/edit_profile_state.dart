import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/features/screens/edit_profile/data/model/edit_profile_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_user_model.dart';
import 'package:smart_cleaning_application/features/screens/settings/data/model/profile_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_shift_details_model.dart';

abstract class EditProfileState {}

class EditProfileInitialState extends EditProfileState {}

class EditProfileLoadingState extends EditProfileState {}

class EditProfileSuccessState extends EditProfileState {
  final EditProfileModel editProfileModel;
  EditProfileSuccessState(this.editProfileModel);
}

class EditProfileErrorState extends EditProfileState {
  final String error;
  EditProfileErrorState(this.error);
}

//***************** */

class UserProfileDetailsLoadingState extends EditProfileState {}

class UserProfileDetailsSuccessState extends EditProfileState {
  final ProfileModel userProfileDetailsModelModel;

  UserProfileDetailsSuccessState(this.userProfileDetailsModelModel);
}

class UserProfileDetailsErrorState extends EditProfileState {
  final String error;
  UserProfileDetailsErrorState(this.error);
}
//*********************** */

class UserShiftDetailsLoadingState extends EditProfileState {}

class UserShiftDetailsSuccessState extends EditProfileState {
  final UserShiftDetailsModel userShiftDetailsModel;

  UserShiftDetailsSuccessState(this.userShiftDetailsModel);
}

class UserShiftDetailsErrorState extends EditProfileState {
  final String error;
  UserShiftDetailsErrorState(this.error);
}

//*************************** */
class ImageSelectedState extends EditProfileState {
  final XFile image;
  ImageSelectedState(this.image);
}

//**************************** */
class GetNationalityLoadingState extends EditProfileState {}

class GetNationalitySuccessState extends EditProfileState {
  final NationalityModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends EditProfileState {
  final String error;
  GetNationalityErrorState(this.error);
}

//**************************** */

class RoleLoadingState extends EditProfileState {}

class RoleSuccessState extends EditProfileState {
  final RoleModel rolemodel;

  RoleSuccessState(this.rolemodel);
}

class RoleErrorState extends EditProfileState {
  final String error;
  RoleErrorState(this.error);
}

//**************************** */

class AllProvidersLoadingState extends EditProfileState {}

class AllProvidersSuccessState extends EditProfileState {
  final ProvidersModel providersModel;

  AllProvidersSuccessState(this.providersModel);
}

class AllProvidersErrorState extends EditProfileState {
  final String error;
  AllProvidersErrorState(this.error);
}

//**************************** */

class RoleUserLoadingState extends EditProfileState {}

class RoleUserSuccessState extends EditProfileState {
  final RoleUserModel roleUsermodel;

  RoleUserSuccessState(this.roleUsermodel);
}

class RoleUserErrorState extends EditProfileState {
  final String error;
  RoleUserErrorState(this.error);
}
