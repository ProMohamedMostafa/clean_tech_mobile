import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/floor_organization_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/points_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_point/data/model/edit_point_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_point/data/model/point_details_in_edit_model.dart';

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
  final OrganizationNationalityModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends EditPointState {
  final String error;
  GetNationalityErrorState(this.error);
}
//**************************** */

class GetAreaLoadingState extends EditPointState {}

class GetAreaSuccessState extends EditPointState {
  final AreaModel areaModel;

  GetAreaSuccessState(this.areaModel);
}

class GetAreaErrorState extends EditPointState {
  final String error;
  GetAreaErrorState(this.error);
}

//**************************** */
class GetCityLoadingState extends EditPointState {}

class GetCitySuccessState extends EditPointState {
  final CityModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends EditPointState {
  final String error;
  GetCityErrorState(this.error);
}

//**************************** */
class GetOrganizationsLoadingState extends EditPointState {}

class GetOrganizationsSuccessState extends EditPointState {
  final OrganizationModel organizationModel;

  GetOrganizationsSuccessState(this.organizationModel);
}

class GetOrganizationsErrorState extends EditPointState {
  final String error;
  GetOrganizationsErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends EditPointState {}

class GetBuildingSuccessState extends EditPointState {
  final BuildingModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends EditPointState {
  final String error;
  GetBuildingErrorState(this.error);
}

//**************************** */
class GetFloorLoadingState extends EditPointState {}

class GetFloorSuccessState extends EditPointState {
  final FloorModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends EditPointState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetPointLoadingState extends EditPointState {}

class GetPointSuccessState extends EditPointState {
  final PointsModel pointModel;

  GetPointSuccessState(this.pointModel);
}

class GetPointErrorState extends EditPointState {
  final String error;
  GetPointErrorState(this.error);
}
//**************************** */

class GetPointDetailsLoadingState extends EditPointState {}

class GetPointDetailsSuccessState extends EditPointState {
  final PointDetailsInEditModel pointDetailsInEditModel;

  GetPointDetailsSuccessState(this.pointDetailsInEditModel);
}

class GetPointDetailsErrorState extends EditPointState {
  final String error;
  GetPointDetailsErrorState(this.error);
}
