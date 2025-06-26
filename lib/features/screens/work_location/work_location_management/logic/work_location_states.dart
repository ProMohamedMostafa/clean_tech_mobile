import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_area_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_section_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_point_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_section_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/point_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/section_list_model.dart';

abstract class WorkLocationState {}

class OrganizationsInitialState extends WorkLocationState {}

class OrganizationsLoadingState extends WorkLocationState {}

class OrganizationsSuccessState extends WorkLocationState {}

class OrganizationsErrorState extends WorkLocationState {
  final String error;
  OrganizationsErrorState(this.error);
}

//******************************** */

class AreaLoadingState extends WorkLocationState {}

class AreaSuccessState extends WorkLocationState {
  final AreaListModel areaModel;

  AreaSuccessState(this.areaModel);
}

class AreaErrorState extends WorkLocationState {
  final String error;
  AreaErrorState(this.error);
}
//******************************** */

class CityLoadingState extends WorkLocationState {}

class CitySuccessState extends WorkLocationState {
  final CityListModel cityModel;

  CitySuccessState(this.cityModel);
}

class CityErrorState extends WorkLocationState {
  final String error;
  CityErrorState(this.error);
}
//******************************** */

class OrganizationLoadingState extends WorkLocationState {}

class OrganizationSuccessState extends WorkLocationState {
  final OrganizationListModel organizationModel;

  OrganizationSuccessState(this.organizationModel);
}

class OrganizationErrorState extends WorkLocationState {
  final String error;
  OrganizationErrorState(this.error);
}
//******************************** */

class BuildingLoadingState extends WorkLocationState {}

class BuildingSuccessState extends WorkLocationState {
  final BuildingListModel buildingModel;

  BuildingSuccessState(this.buildingModel);
}

class BuildingErrorState extends WorkLocationState {
  final String error;
  BuildingErrorState(this.error);
}
//******************************** */

class FloorLoadingState extends WorkLocationState {}

class FloorSuccessState extends WorkLocationState {
  final FloorListModel floorModel;

  FloorSuccessState(this.floorModel);
}

class FloorErrorState extends WorkLocationState {
  final String error;
  FloorErrorState(this.error);
}

//******************************** */
class SectionLoadingState extends WorkLocationState {}

class SectionSuccessState extends WorkLocationState {
  final SectionListModel sectionModel;

  SectionSuccessState(this.sectionModel);
}

class SectionErrorState extends WorkLocationState {
  final String error;
  SectionErrorState(this.error);
}

//******************************** */
class PointLoadingState extends WorkLocationState {}

class PointSuccessState extends WorkLocationState {
  final PointListModel pointModel;

  PointSuccessState(this.pointModel);
}

class PointErrorState extends WorkLocationState {
  final String error;
  PointErrorState(this.error);
}

//******************************** */

class AreaDeleteLoadingState extends WorkLocationState {}

class AreaDeleteSuccessState extends WorkLocationState {
  final DeleteAreaModel deleteAreaModel;

  AreaDeleteSuccessState(this.deleteAreaModel);
}

class AreaDeleteErrorState extends WorkLocationState {
  final String error;
  AreaDeleteErrorState(this.error);
}

//******************************** */
class CityDeleteLoadingState extends WorkLocationState {}

class CityDeleteSuccessState extends WorkLocationState {
  final DeleteCityModel deleteCityModel;

  CityDeleteSuccessState(this.deleteCityModel);
}

class CityDeleteErrorState extends WorkLocationState {
  final String error;
  CityDeleteErrorState(this.error);
}

//******************************** */
class OrganizationDeleteLoadingState extends WorkLocationState {}

class OrganizationDeleteSuccessState extends WorkLocationState {
  final DeleteOrganizationModel deleteOrganizationModel;

  OrganizationDeleteSuccessState(this.deleteOrganizationModel);
}

class OrganizationDeleteErrorState extends WorkLocationState {
  final String error;
  OrganizationDeleteErrorState(this.error);
}

//******************************** */
class BuildingDeleteLoadingState extends WorkLocationState {}

class BuildingDeleteSuccessState extends WorkLocationState {
  final DeleteBuildingModel deleteBuildingModel;

  BuildingDeleteSuccessState(this.deleteBuildingModel);
}

class BuildingDeleteErrorState extends WorkLocationState {
  final String error;
  BuildingDeleteErrorState(this.error);
}
//******************************** */

class FloorDeleteLoadingState extends WorkLocationState {}

class FloorDeleteSuccessState extends WorkLocationState {
  final DeleteFloorModel deleteFloorModel;

  FloorDeleteSuccessState(this.deleteFloorModel);
}

class FloorDeleteErrorState extends WorkLocationState {
  final String error;
  FloorDeleteErrorState(this.error);
}
//******************************** */

class SectionDeleteLoadingState extends WorkLocationState {}

class SectionDeleteSuccessState extends WorkLocationState {
  final DeleteSectionModel deleteSectionModel;

  SectionDeleteSuccessState(this.deleteSectionModel);
}

class SectionDeleteErrorState extends WorkLocationState {
  final String error;
  SectionDeleteErrorState(this.error);
}

//******************************** */

class PointDeleteLoadingState extends WorkLocationState {}

class PointDeleteSuccessState extends WorkLocationState {
  final DeletePointModel deletePointModel;

  PointDeleteSuccessState(this.deletePointModel);
}

class PointDeleteErrorState extends WorkLocationState {
  final String error;
  PointDeleteErrorState(this.error);
}

//******************************** */

class DeletedAreaLoadingState extends WorkLocationState {}

class DeletedAreaSuccessState extends WorkLocationState {
  final DeletedAreaList deletedAreaList;

  DeletedAreaSuccessState(this.deletedAreaList);
}

class DeletedAreaErrorState extends WorkLocationState {
  final String error;
  DeletedAreaErrorState(this.error);
}

//******************************** */

class DeletedCityLoadingState extends WorkLocationState {}

class DeletedCitySuccessState extends WorkLocationState {
  final DeletedCityList deletedCityList;

  DeletedCitySuccessState(this.deletedCityList);
}

class DeletedCityErrorState extends WorkLocationState {
  final String error;
  DeletedCityErrorState(this.error);
}

//******************************** */

class DeletedOrganizationLoadingState extends WorkLocationState {}

class DeletedOrganizationSuccessState extends WorkLocationState {
  final DeletedOrganizationList deletedOrganizationList;

  DeletedOrganizationSuccessState(this.deletedOrganizationList);
}

class DeletedOrganizationErrorState extends WorkLocationState {
  final String error;
  DeletedOrganizationErrorState(this.error);
}

//******************************** */

class DeletedBuildingLoadingState extends WorkLocationState {}

class DeletedBuildingSuccessState extends WorkLocationState {
  final DeletedBuildingList deletedBuildingList;

  DeletedBuildingSuccessState(this.deletedBuildingList);
}

class DeletedBuildingErrorState extends WorkLocationState {
  final String error;
  DeletedBuildingErrorState(this.error);
}

//******************************** */

class DeletedFloorLoadingState extends WorkLocationState {}

class DeletedFloorSuccessState extends WorkLocationState {
  final DeletedFloorList deletedFloorList;

  DeletedFloorSuccessState(this.deletedFloorList);
}

class DeletedFloorErrorState extends WorkLocationState {
  final String error;
  DeletedFloorErrorState(this.error);
} //******************************** */

class DeletedSectionLoadingState extends WorkLocationState {}

class DeletedSectionSuccessState extends WorkLocationState {
  final DeletedSectionList deletedSectionList;

  DeletedSectionSuccessState(this.deletedSectionList);
}

class DeletedSectionErrorState extends WorkLocationState {
  final String error;
  DeletedSectionErrorState(this.error);
}

//******************************** */

class DeletedPointLoadingState extends WorkLocationState {}

class DeletedPointSuccessState extends WorkLocationState {
  final DeletedPointList deletedPointList;

  DeletedPointSuccessState(this.deletedPointList);
}

class DeletedPointErrorState extends WorkLocationState {
  final String error;
  DeletedPointErrorState(this.error);
}

//******************************** */

class RestoreAreaLoadingState extends WorkLocationState {}

class RestoreAreaSuccessState extends WorkLocationState {
  final String message;
  RestoreAreaSuccessState(this.message);
}

class RestoreAreaErrorState extends WorkLocationState {
  final String error;
  RestoreAreaErrorState(this.error);
}

//******************************** */
class RestoreCityLoadingState extends WorkLocationState {}

class RestoreCitySuccessState extends WorkLocationState {
  final String message;
  RestoreCitySuccessState(this.message);
}

class RestoreCityErrorState extends WorkLocationState {
  final String error;
  RestoreCityErrorState(this.error);
}

//******************************** */
class RestoreOrganizationLoadingState extends WorkLocationState {}

class RestoreOrganizationSuccessState extends WorkLocationState {
  final String message;
  RestoreOrganizationSuccessState(this.message);
}

class RestoreOrganizationErrorState extends WorkLocationState {
  final String error;
  RestoreOrganizationErrorState(this.error);
}

//******************************** */
class RestoreBuildingLoadingState extends WorkLocationState {}

class RestoreBuildingSuccessState extends WorkLocationState {
  final String message;
  RestoreBuildingSuccessState(this.message);
}

class RestoreBuildingErrorState extends WorkLocationState {
  final String error;
  RestoreBuildingErrorState(this.error);
}

//******************************** */
class RestoreFloorLoadingState extends WorkLocationState {}

class RestoreFloorSuccessState extends WorkLocationState {
  final String message;
  RestoreFloorSuccessState(this.message);
}

class RestoreFloorErrorState extends WorkLocationState {
  final String error;
  RestoreFloorErrorState(this.error);
}

//******************************** */
class RestoreSectionLoadingState extends WorkLocationState {}

class RestoreSectionSuccessState extends WorkLocationState {
  final String message;
  RestoreSectionSuccessState(this.message);
}

class RestoreSectionErrorState extends WorkLocationState {
  final String error;
  RestoreSectionErrorState(this.error);
}

//******************************** */
class RestorePointLoadingState extends WorkLocationState {}

class RestorePointSuccessState extends WorkLocationState {
  final String message;
  RestorePointSuccessState(this.message);
}

class RestorePointErrorState extends WorkLocationState {
  final String error;
  RestorePointErrorState(this.error);
}

//******************************** */

class DeleteForceAreaLoadingState extends WorkLocationState {}

class DeleteForceAreaSuccessState extends WorkLocationState {
  final String message;
  DeleteForceAreaSuccessState(this.message);
}

class DeleteForceAreaErrorState extends WorkLocationState {
  final String error;
  DeleteForceAreaErrorState(this.error);
}
//******************************** */

class DeleteForceCityLoadingState extends WorkLocationState {}

class DeleteForceCitySuccessState extends WorkLocationState {
  final String message;
  DeleteForceCitySuccessState(this.message);
}

class DeleteForceCityErrorState extends WorkLocationState {
  final String error;
  DeleteForceCityErrorState(this.error);
}
//******************************** */

class DeleteForceOrganizationLoadingState extends WorkLocationState {}

class DeleteForceOrganizationSuccessState extends WorkLocationState {
  final String message;
  DeleteForceOrganizationSuccessState(this.message);
}

class DeleteForceOrganizationErrorState extends WorkLocationState {
  final String error;
  DeleteForceOrganizationErrorState(this.error);
}
//******************************** */

class DeleteForceBuildingLoadingState extends WorkLocationState {}

class DeleteForceBuildingSuccessState extends WorkLocationState {
  final String message;
  DeleteForceBuildingSuccessState(this.message);
}

class DeleteForceBuildingErrorState extends WorkLocationState {
  final String error;
  DeleteForceBuildingErrorState(this.error);
}
//******************************** */

class DeleteForceFloorLoadingState extends WorkLocationState {}

class DeleteForceFloorSuccessState extends WorkLocationState {
  final String message;
  DeleteForceFloorSuccessState(this.message);
}

class DeleteForceFloorErrorState extends WorkLocationState {
  final String error;
  DeleteForceFloorErrorState(this.error);
}
//******************************** */

class DeleteForceSectionLoadingState extends WorkLocationState {}

class DeleteForceSectionSuccessState extends WorkLocationState {
  final String message;
  DeleteForceSectionSuccessState(this.message);
}

class DeleteForceSectionErrorState extends WorkLocationState {
  final String error;
  DeleteForceSectionErrorState(this.error);
}
//******************************** */

class DeleteForcePointLoadingState extends WorkLocationState {}

class DeleteForcePointSuccessState extends WorkLocationState {
  final String message;
  DeleteForcePointSuccessState(this.message);
}

class DeleteForcePointErrorState extends WorkLocationState {
  final String error;
  DeleteForcePointErrorState(this.error);
}
