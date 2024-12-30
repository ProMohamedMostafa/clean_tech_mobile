import 'package:smart_cleaning_application/features/screens/add_organizations/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/add_organizations/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/add_organizations/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/add_organizations/data/model/floor_organization_model.dart';
import 'package:smart_cleaning_application/features/screens/add_organizations/data/model/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/add_organizations/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/add_organizations/data/model/points_model.dart';
import 'package:smart_cleaning_application/features/screens/add_user/data/model/users_model.dart';

abstract class AddOrganizationState {}

class AddOrganizationInitialState extends AddOrganizationState {}

class AddOrganizationLoadingState extends AddOrganizationState {}

class AddOrganizationSuccessState extends AddOrganizationState {
  // final UserCreateModel userCreateModel;

  // AddOrganizationSuccessState(this.userCreateModel);
}

class AddOrganizationErrorState extends AddOrganizationState {
  final String error;
  AddOrganizationErrorState(this.error);
}

//**************************** */

class GetOrganizationNationalityLoadingState extends AddOrganizationState {}

class GetOrganizationNationalitySuccessState extends AddOrganizationState {
  final OrganizationNationalityModel nationalitymodel;

  GetOrganizationNationalitySuccessState(this.nationalitymodel);
}

class GetOrganizationNationalityErrorState extends AddOrganizationState {
  final String error;
  GetOrganizationNationalityErrorState(this.error);
}
//**************************** */

class GetOrganizationAreaLoadingState extends AddOrganizationState {}

class GetOrganizationAreaSuccessState extends AddOrganizationState {
  final AreaModel areaModel;

  GetOrganizationAreaSuccessState(this.areaModel);
}

class GetOrganizationAreaErrorState extends AddOrganizationState {
  final String error;
  GetOrganizationAreaErrorState(this.error);
}
//**************************** */

class GetOrganizationCityLoadingState extends AddOrganizationState {}

class GetOrganizationCitySuccessState extends AddOrganizationState {
  final CityModel cityModel;

  GetOrganizationCitySuccessState(this.cityModel);
}

class GetOrganizationCityErrorState extends AddOrganizationState {
  final String error;
  GetOrganizationCityErrorState(this.error);
}
//**************************** */

class GetOrganizationOrganizationsLoadingState extends AddOrganizationState {}

class GetOrganizationOrganizationsSuccessState extends AddOrganizationState {
  final OrganizationModel organizationModel;

  GetOrganizationOrganizationsSuccessState(this.organizationModel);
}

class GetOrganizationOrganizationsErrorState extends AddOrganizationState {
  final String error;
  GetOrganizationOrganizationsErrorState(this.error);
}
//**************************** */

class GetOrganizationBuildingLoadingState extends AddOrganizationState {}

class GetOrganizationBuildingSuccessState extends AddOrganizationState {
  final BuildingModel buildingModel;

  GetOrganizationBuildingSuccessState(this.buildingModel);
}

class GetOrganizationBuildingErrorState extends AddOrganizationState {
  final String error;
  GetOrganizationBuildingErrorState(this.error);
}
//**************************** */

class GetOrganizationFloorLoadingState extends AddOrganizationState {}

class GetOrganizationFloorSuccessState extends AddOrganizationState {
  final FloorModel floorModel;

  GetOrganizationFloorSuccessState(this.floorModel);
}

class GetOrganizationFloorErrorState extends AddOrganizationState {
  final String error;
  GetOrganizationFloorErrorState(this.error);
}
//**************************** */

class GetOrganizationPointsLoadingState extends AddOrganizationState {}

class GetOrganizationPointsSuccessState extends AddOrganizationState {
  final PointsModel pointsModel;

  GetOrganizationPointsSuccessState(this.pointsModel);
}

class GetOrganizationPointsErrorState extends AddOrganizationState {
  final String error;
  GetOrganizationPointsErrorState(this.error);
}
//**************************** */

class AllUsersLoadingState extends AddOrganizationState {}

class AllUsersSuccessState extends AddOrganizationState {
  final UsersModel usersModel;

  AllUsersSuccessState(this.usersModel);
}

class AllUsersErrorState extends AddOrganizationState {
  final String error;
  AllUsersErrorState(this.error);
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
}//***************** */

class CreatePointLoadingState extends AddOrganizationState {}

class CreatePointSuccessState extends AddOrganizationState {
  final String message;

  CreatePointSuccessState(this.message);
}

class CreatePointErrorState extends AddOrganizationState {
  final String error;
  CreatePointErrorState(this.error);
}