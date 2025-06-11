import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/point_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/section_list_model.dart';
import 'package:smart_cleaning_application/features/screens/sensor/sensor_managment/data/model/sensor_model.dart';

abstract class AddWorkLocationState {}

class AddWorkLocationInitialState extends AddWorkLocationState {}

class AddWorkLocationLoadingState extends AddWorkLocationState {}

class AddWorkLocationSuccessState extends AddWorkLocationState {}

class AddWorkLocationErrorState extends AddWorkLocationState {
  final String error;
  AddWorkLocationErrorState(this.error);
}

//**************************** */

class GetNationalityLoadingState extends AddWorkLocationState {}

class GetNationalitySuccessState extends AddWorkLocationState {
  final NationalityListModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends AddWorkLocationState {
  final String error;
  GetNationalityErrorState(this.error);
}
//**************************** */

class GetAreaLoadingState extends AddWorkLocationState {}

class GetAreaSuccessState extends AddWorkLocationState {
  final AreaListModel areaListModel;

  GetAreaSuccessState(this.areaListModel);
}

class GetAreaErrorState extends AddWorkLocationState {
  final String error;
  GetAreaErrorState(this.error);
}
//**************************** */

class GetCityLoadingState extends AddWorkLocationState {}

class GetCitySuccessState extends AddWorkLocationState {
  final CityListModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends AddWorkLocationState {
  final String error;
  GetCityErrorState(this.error);
}
//**************************** */

class GetOrganizationLoadingState extends AddWorkLocationState {}

class GetOrganizationSuccessState extends AddWorkLocationState {
  final OrganizationListModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends AddWorkLocationState {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends AddWorkLocationState {}

class GetBuildingSuccessState extends AddWorkLocationState {
  final BuildingListModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends AddWorkLocationState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends AddWorkLocationState {}

class GetFloorSuccessState extends AddWorkLocationState {
  final FloorListModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends AddWorkLocationState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetSectionLoadingState extends AddWorkLocationState {}

class GetSectionSuccessState extends AddWorkLocationState {
  final SectionListModel sectionsModel;

  GetSectionSuccessState(this.sectionsModel);
}

class GetSectionErrorState extends AddWorkLocationState {
  final String error;
  GetSectionErrorState(this.error);
}

//**************************** */

class GetPointLoadingState extends AddWorkLocationState {}

class GetPointSuccessState extends AddWorkLocationState {
  final PointListModel pointsModel;

  GetPointSuccessState(this.pointsModel);
}

class GetPointErrorState extends AddWorkLocationState {
  final String error;
  GetPointErrorState(this.error);
}
//**************************** */

class AllUsersLoadingState extends AddWorkLocationState {}

class AllUsersSuccessState extends AddWorkLocationState {
  final UsersModel usersModel;

  AllUsersSuccessState(this.usersModel);
}

class AllUsersErrorState extends AddWorkLocationState {
  final String error;
  AllUsersErrorState(this.error);
}

//***************** */

class CreateAreaLoadingState extends AddWorkLocationState {}

class CreateAreaSuccessState extends AddWorkLocationState {
  final String message;

  CreateAreaSuccessState(this.message);
}

class CreateAreaErrorState extends AddWorkLocationState {
  final String error;
  CreateAreaErrorState(this.error);
}
//***************** */

class CreateCityLoadingState extends AddWorkLocationState {}

class CreateCitySuccessState extends AddWorkLocationState {
  final String message;

  CreateCitySuccessState(this.message);
}

class CreateCityErrorState extends AddWorkLocationState {
  final String error;
  CreateCityErrorState(this.error);
}

//***************** */

class CreateOrganizationLoadingState extends AddWorkLocationState {}

class CreateOrganizationSuccessState extends AddWorkLocationState {
  final String message;

  CreateOrganizationSuccessState(this.message);
}

class CreateOrganizationErrorState extends AddWorkLocationState {
  final String error;
  CreateOrganizationErrorState(this.error);
}
//***************** */

class CreateBuildingLoadingState extends AddWorkLocationState {}

class CreateBuildingSuccessState extends AddWorkLocationState {
  final String message;

  CreateBuildingSuccessState(this.message);
}

class CreateBuildingErrorState extends AddWorkLocationState {
  final String error;
  CreateBuildingErrorState(this.error);
}

//***************** */

class CreateFloorLoadingState extends AddWorkLocationState {}

class CreateFloorSuccessState extends AddWorkLocationState {
  final String message;

  CreateFloorSuccessState(this.message);
}

class CreateFloorErrorState extends AddWorkLocationState {
  final String error;
  CreateFloorErrorState(this.error);
} //***************** */

class CreateSectionLoadingState extends AddWorkLocationState {}

class CreateSectionSuccessState extends AddWorkLocationState {
  final String message;

  CreateSectionSuccessState(this.message);
}

class CreateSectionErrorState extends AddWorkLocationState {
  final String error;
  CreateSectionErrorState(this.error);
} //***************** */

class CreatePointLoadingState extends AddWorkLocationState {}

class CreatePointSuccessState extends AddWorkLocationState {
  final String message;

  CreatePointSuccessState(this.message);
}

class CreatePointErrorState extends AddWorkLocationState {
  final String error;
  CreatePointErrorState(this.error);
}
//**************************** */

class ShiftLoadingState extends AddWorkLocationState {}

class ShiftSuccessState extends AddWorkLocationState {
  final ShiftModel shiftModel;
  ShiftSuccessState(this.shiftModel);
}

class ShiftErrorState extends AddWorkLocationState {
  final String error;
  ShiftErrorState(this.error);
}
//**************************** */

class SensorManagementLoading extends AddWorkLocationState {}

class SensorManagementSuccess extends AddWorkLocationState {
  final SensorModel sensorModel;
  SensorManagementSuccess(this.sensorModel);
}

class SensorManagementError extends AddWorkLocationState {
  final String error;
  SensorManagementError(this.error);
}
