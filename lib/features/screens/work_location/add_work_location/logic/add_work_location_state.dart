import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/points_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_cleaners_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_managers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_supervisors_model.dart';


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
  final NationalityModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends AddWorkLocationState {
  final String error;
  GetNationalityErrorState(this.error);
}
//**************************** */

class GetAreaLoadingState extends AddWorkLocationState {}

class GetAreaSuccessState extends AddWorkLocationState {
  final AreaModel areaModel;

  GetAreaSuccessState(this.areaModel);
}

class GetAreaErrorState extends AddWorkLocationState {
  final String error;
  GetAreaErrorState(this.error);
}
//**************************** */

class GetCityLoadingState extends AddWorkLocationState {}

class GetCitySuccessState extends AddWorkLocationState {
  final CityModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends AddWorkLocationState {
  final String error;
  GetCityErrorState(this.error);
}
//**************************** */

class GetOrganizationLoadingState extends AddWorkLocationState {}

class GetOrganizationSuccessState extends AddWorkLocationState {
  final OrganizationModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends AddWorkLocationState {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends AddWorkLocationState {}

class GetBuildingSuccessState extends AddWorkLocationState {
  final BuildingModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends AddWorkLocationState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends AddWorkLocationState {}

class GetFloorSuccessState extends AddWorkLocationState {
  final FloorModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends AddWorkLocationState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetPointLoadingState extends AddWorkLocationState {}

class GetPointSuccessState extends AddWorkLocationState {
  final PointsModel pointsModel;

  GetPointSuccessState(this.pointsModel);
}

class GetPointErrorState extends AddWorkLocationState {
  final String error;
  GetPointErrorState(this.error);
}
//**************************** */

class AllManagersLoadingState extends AddWorkLocationState {}

class AllManagersSuccessState extends AddWorkLocationState {
  final AllManagersModel allManagersModel;

  AllManagersSuccessState(this.allManagersModel);
}

class AllManagersErrorState extends AddWorkLocationState {
  final String error;
  AllManagersErrorState(this.error);
}
//**************************** */

class AllSupervisorsLoadingState extends AddWorkLocationState {}

class AllSupervisorsSuccessState extends AddWorkLocationState {
  final AllSupervisorsModel allSupervisorsModel;

  AllSupervisorsSuccessState(this.allSupervisorsModel);
}

class AllSupervisorsErrorState extends AddWorkLocationState {
  final String error;
  AllSupervisorsErrorState(this.error);
}

//**************************** */

class AllCleanersLoadingState extends AddWorkLocationState {}

class AllCleanersSuccessState extends AddWorkLocationState {
  final AllCleanersModel allCleanersModel;

  AllCleanersSuccessState(this.allCleanersModel);
}

class AllCleanersErrorState extends AddWorkLocationState {
  final String error;
  AllCleanersErrorState(this.error);
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