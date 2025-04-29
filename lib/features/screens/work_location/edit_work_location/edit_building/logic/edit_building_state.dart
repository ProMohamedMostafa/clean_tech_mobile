import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_building/data/model/building_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_building/data/model/edit_building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/building_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_list_model.dart';

abstract class EditBuildingState {}

class EditBuildingInitialState extends EditBuildingState {}

class EditBuildingLoadingState extends EditBuildingState {}

class EditBuildingSuccessState extends EditBuildingState {
  final BuildingEditModel buildingEditModel;
  EditBuildingSuccessState(this.buildingEditModel);
}

class EditBuildingErrorState extends EditBuildingState {
  final String error;
  EditBuildingErrorState(this.error);
}

//******************************** */

class GetNationalityLoadingState extends EditBuildingState {}

class GetNationalitySuccessState extends EditBuildingState {
  final NationalityListModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends EditBuildingState {
  final String error;
  GetNationalityErrorState(this.error);
}
//**************************** */

class GetAreaLoadingState extends EditBuildingState {}

class GetAreaSuccessState extends EditBuildingState {
  final AreaListModel areaModel;

  GetAreaSuccessState(this.areaModel);
}

class GetAreaErrorState extends EditBuildingState {
  final String error;
  GetAreaErrorState(this.error);
}

//**************************** */
class GetCityLoadingState extends EditBuildingState {}

class GetCitySuccessState extends EditBuildingState {
  final CityListModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends EditBuildingState {
  final String error;
  GetCityErrorState(this.error);
}

//**************************** */
class GetOrganizationLoadingState extends EditBuildingState {}

class GetOrganizationSuccessState extends EditBuildingState {
  final OrganizationListModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends EditBuildingState {
  final String error;
  GetOrganizationErrorState(this.error);
}

//**************************** */

class GetBuildingDetailsLoadingState extends EditBuildingState {}

class GetBuildingDetailsSuccessState extends EditBuildingState {
  final BuildingDetailsInEditModel buildingDetailsInEditModel;

  GetBuildingDetailsSuccessState(this.buildingDetailsInEditModel);
}

class GetBuildingDetailsErrorState extends EditBuildingState {
  final String error;
  GetBuildingDetailsErrorState(this.error);
}

//**************************** */

class ShiftLoadingState extends EditBuildingState {}

class ShiftSuccessState extends EditBuildingState {
  final ShiftModel shiftModel;
  ShiftSuccessState(this.shiftModel);
}

class ShiftErrorState extends EditBuildingState {
  final String error;
  ShiftErrorState(this.error);
}

//********************************* */
class BuildingManagersDetailsLoadingState extends EditBuildingState {}

class BuildingManagersDetailsSuccessState extends EditBuildingState {
  final BuildingUsersShiftsDetailsModel buildingUsersShiftsDetailsModel;

  BuildingManagersDetailsSuccessState(this.buildingUsersShiftsDetailsModel);
}

class BuildingManagersDetailsErrorState extends EditBuildingState {
  final String error;
  BuildingManagersDetailsErrorState(this.error);
}
