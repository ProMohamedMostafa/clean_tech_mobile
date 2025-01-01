import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/floor_organization_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_floor/data/model/edit_floor_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_floor/data/model/floor_details_in_edit_model.dart';

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
  final OrganizationNationalityModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends EditFloorState {
  final String error;
  GetNationalityErrorState(this.error);
}
//**************************** */

class GetAreaLoadingState extends EditFloorState {}

class GetAreaSuccessState extends EditFloorState {
  final AreaModel areaModel;

  GetAreaSuccessState(this.areaModel);
}

class GetAreaErrorState extends EditFloorState {
  final String error;
  GetAreaErrorState(this.error);
}

//**************************** */
class GetCityLoadingState extends EditFloorState {}

class GetCitySuccessState extends EditFloorState {
  final CityModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends EditFloorState {
  final String error;
  GetCityErrorState(this.error);
}

//**************************** */
class GetOrganizationsLoadingState extends EditFloorState {}

class GetOrganizationsSuccessState extends EditFloorState {
  final OrganizationModel organizationModel;

  GetOrganizationsSuccessState(this.organizationModel);
}

class GetOrganizationsErrorState extends EditFloorState {
  final String error;
  GetOrganizationsErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends EditFloorState {}

class GetBuildingSuccessState extends EditFloorState {
  final BuildingModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends EditFloorState {
  final String error;
  GetBuildingErrorState(this.error);
}

//**************************** */
class GetFloorLoadingState extends EditFloorState {}

class GetFloorSuccessState extends EditFloorState {
  final FloorModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends EditFloorState {
  final String error;
  GetFloorErrorState(this.error);
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
