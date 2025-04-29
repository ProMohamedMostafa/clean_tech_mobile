import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_floor/data/model/edit_floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_floor/data/model/floor_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/floor_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_list_model.dart';

abstract class EditFloorState {}

class EditFloorInitialState extends EditFloorState {}

class EditFloorLoadingState extends EditFloorState {}

class EditFloorSuccessState extends EditFloorState {
  final FloorEditModel floorEditModel;
  EditFloorSuccessState(this.floorEditModel);
}

class EditFloorErrorState extends EditFloorState {
  final String error;
  EditFloorErrorState(this.error);
}

//******************************** */

class GetNationalityLoadingState extends EditFloorState {}

class GetNationalitySuccessState extends EditFloorState {
  final NationalityListModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends EditFloorState {
  final String error;
  GetNationalityErrorState(this.error);
}
//**************************** */

class GetAreaLoadingState extends EditFloorState {}

class GetAreaSuccessState extends EditFloorState {
  final AreaListModel areaModel;

  GetAreaSuccessState(this.areaModel);
}

class GetAreaErrorState extends EditFloorState {
  final String error;
  GetAreaErrorState(this.error);
}

//**************************** */
class GetCityLoadingState extends EditFloorState {}

class GetCitySuccessState extends EditFloorState {
  final CityListModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends EditFloorState {
  final String error;
  GetCityErrorState(this.error);
}

//**************************** */
class GetOrganizationLoadingState extends EditFloorState {}

class GetOrganizationSuccessState extends EditFloorState {
  final OrganizationListModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends EditFloorState {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends EditFloorState {}

class GetBuildingSuccessState extends EditFloorState {
  final BuildingListModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends EditFloorState {
  final String error;
  GetBuildingErrorState(this.error);
}

//**************************** */

class GetFloorDetailsLoadingState extends EditFloorState {}

class GetFloorDetailsSuccessState extends EditFloorState {
  final FloorDetailsInEditModel floorDetailsInEditModel;

  GetFloorDetailsSuccessState(this.floorDetailsInEditModel);
}

class GetFloorDetailsErrorState extends EditFloorState {
  final String error;
  GetFloorDetailsErrorState(this.error);
}
//**************************** */

class ShiftLoadingState extends EditFloorState {}

class ShiftSuccessState extends EditFloorState {
  final ShiftModel shiftModel;
  ShiftSuccessState(this.shiftModel);
}

class ShiftErrorState extends EditFloorState {
  final String error;
  ShiftErrorState(this.error);
}

//********************************* */
class FloorManagersDetailsLoadingState extends EditFloorState {}

class FloorManagersDetailsSuccessState extends EditFloorState {
  final FloorUsersShiftsDetailsModel floorUsersShiftsDetailsModel;

  FloorManagersDetailsSuccessState(this.floorUsersShiftsDetailsModel);
}

class FloorManagersDetailsErrorState extends EditFloorState {
  final String error;
  FloorManagersDetailsErrorState(this.error);
}
