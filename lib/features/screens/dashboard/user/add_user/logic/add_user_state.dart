import 'package:image_picker/image_picker.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/nationality_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/point_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/section_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/provider/provider_management/data/models/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/add_user/data/model/user_create.dart';
import '../../../integrations/data/models/role_model.dart';

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
  final NationalityListModel nationalitymodel;

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

//***************** */

class AllUsersLoadingState extends AddUserState {}

class AllUsersSuccessState extends AddUserState {
  final UsersModel usersModel;

  AllUsersSuccessState(this.usersModel);
}

class AllUsersErrorState extends AddUserState {
  final String error;
  AllUsersErrorState(this.error);
} //**************************** */

class GetAreaLoadingState extends AddUserState {}

class GetAreaSuccessState extends AddUserState {
  final AreaListModel areaListModel;

  GetAreaSuccessState(this.areaListModel);
}

class GetAreaErrorState extends AddUserState {
  final String error;
  GetAreaErrorState(this.error);
}
//**************************** */

class GetCityLoadingState extends AddUserState {}

class GetCitySuccessState extends AddUserState {
  final CityListModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends AddUserState {
  final String error;
  GetCityErrorState(this.error);
}
//**************************** */

class GetOrganizationLoadingState extends AddUserState {}

class GetOrganizationSuccessState extends AddUserState {
  final OrganizationListModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends AddUserState {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends AddUserState {}

class GetBuildingSuccessState extends AddUserState {
  final BuildingListModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends AddUserState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends AddUserState {}

class GetFloorSuccessState extends AddUserState {
  final FloorListModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends AddUserState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetSectionLoadingState extends AddUserState {}

class GetSectionSuccessState extends AddUserState {
  final SectionListModel sectionModel;

  GetSectionSuccessState(this.sectionModel);
}

class GetSectionErrorState extends AddUserState {
  final String error;
  GetSectionErrorState(this.error);
}
//**************************** */

class GetPointLoadingState extends AddUserState {}

class GetPointSuccessState extends AddUserState {
  final PointListModel pointsModel;

  GetPointSuccessState(this.pointsModel);
}

class GetPointErrorState extends AddUserState {
  final String error;
  GetPointErrorState(this.error);
}

//*************************** */
class ShiftLoadingState extends AddUserState {}

class ShiftSuccessState extends AddUserState {
  final ShiftModel allShiftsModel;
  ShiftSuccessState(this.allShiftsModel);
}

class ShiftErrorState extends AddUserState {
  final String error;
  ShiftErrorState(this.error);
}

//**************************** */
class ChangeSuffixIconVisiabiltyState extends AddUserState {}

//*************************** */
class ImageSelectedState extends AddUserState {
  final XFile image;
  ImageSelectedState(this.image);
}

//*************************** */
class PasswordValidationChangedState extends AddUserState {}

//*************************** */
class DateSelectedState extends AddUserState {}

class LevelChanged extends AddUserState {}
