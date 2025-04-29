import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_point/data/model/edit_point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/point_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_list_model.dart';

abstract class EditPointState {}

class EditPointInitialState extends EditPointState {}

class EditPointLoadingState extends EditPointState {}

class EditPointSuccessState extends EditPointState {
  final PointEditModel pointEditModel;
  EditPointSuccessState(this.pointEditModel);
}

class EditPointErrorState extends EditPointState {
  final String error;
  EditPointErrorState(this.error);
}

//******************************** */

class GetNationalityLoadingState extends EditPointState {}

class GetNationalitySuccessState extends EditPointState {
  final NationalityListModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends EditPointState {
  final String error;
  GetNationalityErrorState(this.error);
}
//**************************** */

class GetAreaLoadingState extends EditPointState {}

class GetAreaSuccessState extends EditPointState {
  final AreaListModel areaModel;

  GetAreaSuccessState(this.areaModel);
}

class GetAreaErrorState extends EditPointState {
  final String error;
  GetAreaErrorState(this.error);
}

//**************************** */
class GetCityLoadingState extends EditPointState {}

class GetCitySuccessState extends EditPointState {
  final CityListModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends EditPointState {
  final String error;
  GetCityErrorState(this.error);
}

//**************************** */
class GetOrganizationLoadingState extends EditPointState {}

class GetOrganizationSuccessState extends EditPointState {
  final OrganizationListModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends EditPointState {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends EditPointState {}

class GetBuildingSuccessState extends EditPointState {
  final BuildingListModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends EditPointState {
  final String error;
  GetBuildingErrorState(this.error);
}

//**************************** */
class GetFloorLoadingState extends EditPointState {}

class GetFloorSuccessState extends EditPointState {
  final FloorListModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends EditPointState {
  final String error;
  GetFloorErrorState(this.error);
}

//**************************** */

class ShiftLoadingState extends EditPointState {}

class ShiftSuccessState extends EditPointState {
  final ShiftModel shiftModel;
  ShiftSuccessState(this.shiftModel);
}

class ShiftErrorState extends EditPointState {
  final String error;
  ShiftErrorState(this.error);
}

//********************************* */
class PointManagersDetailsLoadingState extends EditPointState {}

class PointManagersDetailsSuccessState extends EditPointState {
  final PointUsersDetailsModel pointUsersDetailsModel;

  PointManagersDetailsSuccessState(this.pointUsersDetailsModel);
}

class PointManagersDetailsErrorState extends EditPointState {
  final String error;
  PointManagersDetailsErrorState(this.error);
}

//*************************************** */

class GetPointDetailsLoadingState extends EditPointState {}

class GetPointDetailsSuccessState extends EditPointState {
  final PointUsersDetailsModel pointUsersDetailsModel;

  GetPointDetailsSuccessState(this.pointUsersDetailsModel);
}

class GetPointDetailsErrorState extends EditPointState {
  final String error;
  GetPointDetailsErrorState(this.error);
}
