import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_building/data/model/building_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_building/data/model/edit_building_model.dart';

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
  final OrganizationNationalityModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends EditBuildingState {
  final String error;
  GetNationalityErrorState(this.error);
}
//**************************** */

class GetAreaLoadingState extends EditBuildingState {}

class GetAreaSuccessState extends EditBuildingState {
  final AreaModel areaModel;

  GetAreaSuccessState(this.areaModel);
}

class GetAreaErrorState extends EditBuildingState {
  final String error;
  GetAreaErrorState(this.error);
}

//**************************** */
class GetCityLoadingState extends EditBuildingState {}

class GetCitySuccessState extends EditBuildingState {
  final CityModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends EditBuildingState {
  final String error;
  GetCityErrorState(this.error);
}

//**************************** */
class GetOrganizationsLoadingState extends EditBuildingState {}

class GetOrganizationsSuccessState extends EditBuildingState {
  final OrganizationModel organizationModel;

  GetOrganizationsSuccessState(this.organizationModel);
}

class GetOrganizationsErrorState extends EditBuildingState {
  final String error;
  GetOrganizationsErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends EditBuildingState {}

class GetBuildingSuccessState extends EditBuildingState {
  final BuildingModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends EditBuildingState {
  final String error;
  GetBuildingErrorState(this.error);
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
