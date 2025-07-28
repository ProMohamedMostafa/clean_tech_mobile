import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/features/screens/setting/edit_profile/data/model/edit_profile_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/nationality_list_model.dart';
import 'package:smart_cleaning_application/features/screens/setting/settings/data/model/profile_model.dart';


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

//**************************** */
class GetNationalityLoadingState extends EditProfileState {}

class GetNationalitySuccessState extends EditProfileState {
  final NationalityListModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends EditProfileState {
  final String error;
  GetNationalityErrorState(this.error);
}

//*************************** */
class ImageSelectedState extends EditProfileState {
  final XFile image;
  ImageSelectedState(this.image);
}
