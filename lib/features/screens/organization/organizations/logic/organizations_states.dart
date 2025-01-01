import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_area_details/data/model/area_details_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_building_details/data/model/building_details_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_city_details/data/model/city_details_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_floor_details/data/model/floor_details_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_organization_details/data/model/organization_details_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/data/model/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/data/model/point_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_point_details/data/model/point_details_model.dart';

abstract class OrganizationsState {}

class OrganizationsInitialState extends OrganizationsState {}

class OrganizationsLoadingState extends OrganizationsState {}

class OrganizationsSuccessState extends OrganizationsState {}

class OrganizationsErrorState extends OrganizationsState {
  final String error;
  OrganizationsErrorState(this.error);
}

//******************************** */

class AreaLoadingState extends OrganizationsState {}

class AreaSuccessState extends OrganizationsState {
  final AreaListModel areaModel;

  AreaSuccessState(this.areaModel);
}

class AreaErrorState extends OrganizationsState {
  final String error;
  AreaErrorState(this.error);
}
//******************************** */

class CityLoadingState extends OrganizationsState {}

class CitySuccessState extends OrganizationsState {
  final CityListModel cityModel;

  CitySuccessState(this.cityModel);
}

class CityErrorState extends OrganizationsState {
  final String error;
  CityErrorState(this.error);
}
//******************************** */

class OrganizationLoadingState extends OrganizationsState {}

class OrganizationSuccessState extends OrganizationsState {
  final OrganizationListModel organizationModel;

  OrganizationSuccessState(this.organizationModel);
}

class OrganizationErrorState extends OrganizationsState {
  final String error;
  OrganizationErrorState(this.error);
}
//******************************** */

class BuildingLoadingState extends OrganizationsState {}

class BuildingSuccessState extends OrganizationsState {
  final BuildingListModel buildingModel;

  BuildingSuccessState(this.buildingModel);
}

class BuildingErrorState extends OrganizationsState {
  final String error;
  BuildingErrorState(this.error);
}
//******************************** */

class FloorLoadingState extends OrganizationsState {}

class FloorSuccessState extends OrganizationsState {
  final FloorListModel floorModel;

  FloorSuccessState(this.floorModel);
}

class FloorErrorState extends OrganizationsState {
  final String error;
  FloorErrorState(this.error);
}

//******************************** */

class PointLoadingState extends OrganizationsState {}

class PointSuccessState extends OrganizationsState {
  final PointListModel pointModel;

  PointSuccessState(this.pointModel);
}

class PointErrorState extends OrganizationsState {
  final String error;
  PointErrorState(this.error);
}
//******************************** */

class GetCityLoadingState extends OrganizationsState {}

class GetCitySuccessState extends OrganizationsState {
  final CityModel cityDetailsModel;

  GetCitySuccessState(this.cityDetailsModel);
}

class GetCityErrorState extends OrganizationsState {
  final String error;
  GetCityErrorState(this.error);
}

//******************************** */

class AreaDetailsLoadingState extends OrganizationsState {}

class AreaDetailsSuccessState extends OrganizationsState {
  final AreaDetailsModel areaDetailsModel;

  AreaDetailsSuccessState(this.areaDetailsModel);
}

class AreaDetailsErrorState extends OrganizationsState {
  final String error;
  AreaDetailsErrorState(this.error);
}

//******************************** */

class OrganizationDetailsLoadingState extends OrganizationsState {}

class OrganizationDetailsSuccessState extends OrganizationsState {
  final OrganizationDetailsModel organizationDetailsModel;

  OrganizationDetailsSuccessState(this.organizationDetailsModel);
}

class OrganizationDetailsErrorState extends OrganizationsState {
  final String error;
  OrganizationDetailsErrorState(this.error);
}

//******************************** */

class CityDetailsLoadingState extends OrganizationsState {}

class CityDetailsSuccessState extends OrganizationsState {
  final CityDetailsModel cityDetailsModel;

  CityDetailsSuccessState(this.cityDetailsModel);
}

class CityDetailsErrorState extends OrganizationsState {
  final String error;
  CityDetailsErrorState(this.error);
}

//******************************** */

class BuildingDetailsLoadingState extends OrganizationsState {}

class BuildingDetailsSuccessState extends OrganizationsState {
  final BuildingDetailsModel buildingDetailsModel;

  BuildingDetailsSuccessState(this.buildingDetailsModel);
}

class BuildingDetailsErrorState extends OrganizationsState {
  final String error;
  BuildingDetailsErrorState(this.error);
}
//******************************** */

class FloorDetailsLoadingState extends OrganizationsState {}

class FloorDetailsSuccessState extends OrganizationsState {
  final FloorDetailsModel floorDetailsModel;

  FloorDetailsSuccessState(this.floorDetailsModel);
}

class FloorDetailsErrorState extends OrganizationsState {
  final String error;
  FloorDetailsErrorState(this.error);
}
//******************************** */

class PointDetailsLoadingState extends OrganizationsState {}

class PointDetailsSuccessState extends OrganizationsState {
  final PointDetailsModel pointDetailsModel;

  PointDetailsSuccessState(this.pointDetailsModel);
}

class PointDetailsErrorState extends OrganizationsState {
  final String error;
  PointDetailsErrorState(this.error);
}