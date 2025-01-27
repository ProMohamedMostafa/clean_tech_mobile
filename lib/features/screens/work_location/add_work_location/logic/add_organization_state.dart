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


abstract class AddOrganizationState {}

class AddOrganizationInitialState extends AddOrganizationState {}

class AddOrganizationLoadingState extends AddOrganizationState {}

class AddOrganizationSuccessState extends AddOrganizationState {}

class AddOrganizationErrorState extends AddOrganizationState {
  final String error;
  AddOrganizationErrorState(this.error);
}

//**************************** */

class GetNationalityLoadingState extends AddOrganizationState {}

class GetNationalitySuccessState extends AddOrganizationState {
  final NationalityModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends AddOrganizationState {
  final String error;
  GetNationalityErrorState(this.error);
}
//**************************** */

class GetAreaLoadingState extends AddOrganizationState {}

class GetAreaSuccessState extends AddOrganizationState {
  final AreaModel areaModel;

  GetAreaSuccessState(this.areaModel);
}

class GetAreaErrorState extends AddOrganizationState {
  final String error;
  GetAreaErrorState(this.error);
}
//**************************** */

class GetCityLoadingState extends AddOrganizationState {}

class GetCitySuccessState extends AddOrganizationState {
  final CityModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends AddOrganizationState {
  final String error;
  GetCityErrorState(this.error);
}
//**************************** */

class GetOrganizationLoadingState extends AddOrganizationState {}

class GetOrganizationSuccessState extends AddOrganizationState {
  final OrganizationModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends AddOrganizationState {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends AddOrganizationState {}

class GetBuildingSuccessState extends AddOrganizationState {
  final BuildingModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends AddOrganizationState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends AddOrganizationState {}

class GetFloorSuccessState extends AddOrganizationState {
  final FloorModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends AddOrganizationState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetPointLoadingState extends AddOrganizationState {}

class GetPointSuccessState extends AddOrganizationState {
  final PointsModel pointsModel;

  GetPointSuccessState(this.pointsModel);
}

class GetPointErrorState extends AddOrganizationState {
  final String error;
  GetPointErrorState(this.error);
}
//**************************** */

class AllManagersLoadingState extends AddOrganizationState {}

class AllManagersSuccessState extends AddOrganizationState {
  final AllManagersModel allManagersModel;

  AllManagersSuccessState(this.allManagersModel);
}

class AllManagersErrorState extends AddOrganizationState {
  final String error;
  AllManagersErrorState(this.error);
}
//**************************** */

class AllSupervisorsLoadingState extends AddOrganizationState {}

class AllSupervisorsSuccessState extends AddOrganizationState {
  final AllSupervisorsModel allSupervisorsModel;

  AllSupervisorsSuccessState(this.allSupervisorsModel);
}

class AllSupervisorsErrorState extends AddOrganizationState {
  final String error;
  AllSupervisorsErrorState(this.error);
}

//**************************** */

class AllCleanersLoadingState extends AddOrganizationState {}

class AllCleanersSuccessState extends AddOrganizationState {
  final AllCleanersModel allCleanersModel;

  AllCleanersSuccessState(this.allCleanersModel);
}

class AllCleanersErrorState extends AddOrganizationState {
  final String error;
  AllCleanersErrorState(this.error);
}
//***************** */

class CreateAreaLoadingState extends AddOrganizationState {}

class CreateAreaSuccessState extends AddOrganizationState {
  final String message;

  CreateAreaSuccessState(this.message);
}

class CreateAreaErrorState extends AddOrganizationState {
  final String error;
  CreateAreaErrorState(this.error);
}
//***************** */

class CreateCityLoadingState extends AddOrganizationState {}

class CreateCitySuccessState extends AddOrganizationState {
  final String message;

  CreateCitySuccessState(this.message);
}

class CreateCityErrorState extends AddOrganizationState {
  final String error;
  CreateCityErrorState(this.error);
}

//***************** */

class CreateOrganizationLoadingState extends AddOrganizationState {}

class CreateOrganizationSuccessState extends AddOrganizationState {
  final String message;

  CreateOrganizationSuccessState(this.message);
}

class CreateOrganizationErrorState extends AddOrganizationState {
  final String error;
  CreateOrganizationErrorState(this.error);
}
//***************** */

class CreateBuildingLoadingState extends AddOrganizationState {}

class CreateBuildingSuccessState extends AddOrganizationState {
  final String message;

  CreateBuildingSuccessState(this.message);
}

class CreateBuildingErrorState extends AddOrganizationState {
  final String error;
  CreateBuildingErrorState(this.error);
}

//***************** */

class CreateFloorLoadingState extends AddOrganizationState {}

class CreateFloorSuccessState extends AddOrganizationState {
  final String message;

  CreateFloorSuccessState(this.message);
}

class CreateFloorErrorState extends AddOrganizationState {
  final String error;
  CreateFloorErrorState(this.error);
} //***************** */

class CreatePointLoadingState extends AddOrganizationState {}

class CreatePointSuccessState extends AddOrganizationState {
  final String message;

  CreatePointSuccessState(this.message);
}

class CreatePointErrorState extends AddOrganizationState {
  final String error;
  CreatePointErrorState(this.error);
}
//**************************** */

class ShiftLoadingState extends AddOrganizationState {}

class ShiftSuccessState extends AddOrganizationState {
  final ShiftModel shiftModel;
  ShiftSuccessState(this.shiftModel);
}

class ShiftErrorState extends AddOrganizationState {
  final String error;
  ShiftErrorState(this.error);
}