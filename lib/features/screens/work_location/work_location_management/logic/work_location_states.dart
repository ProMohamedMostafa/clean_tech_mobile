import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/points_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/all_tasks_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/area_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/area_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/building_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/building_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/building_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/city_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/city_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/floor_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/floor_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/floor_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/organization_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/area_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_point_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/organization_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/organization_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/point_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/point_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/point_shifts_details_model.dart';

import '../../../integrations/data/models/city_model.dart';

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

class GetCityLoadingState extends WorkLocationState {}

class GetCitySuccessState extends WorkLocationState {
  final CityModel cityDetailsModel;

  GetCitySuccessState(this.cityDetailsModel);
}

class GetCityErrorState extends WorkLocationState {
  final String error;
  GetCityErrorState(this.error);
}

//******************************** */

class AreaDetailsLoadingState extends WorkLocationState {}

class AreaDetailsSuccessState extends WorkLocationState {
  final AreaDetailsModel areaDetailsModel;

  AreaDetailsSuccessState(this.areaDetailsModel);
}

class AreaDetailsErrorState extends WorkLocationState {
  final String error;
  AreaDetailsErrorState(this.error);
}
//******************************** */

class AreaManagersDetailsLoadingState extends WorkLocationState {}

class AreaManagersDetailsSuccessState extends WorkLocationState {
  final AreaManagersDetailsModel areaManagersDetailsModel;

  AreaManagersDetailsSuccessState(this.areaManagersDetailsModel);
}

class AreaManagersDetailsErrorState extends WorkLocationState {
  final String error;
  AreaManagersDetailsErrorState(this.error);
}
//******************************** */

class OrganizationDetailsLoadingState extends WorkLocationState {}

class OrganizationDetailsSuccessState extends WorkLocationState {
  final OrganizationDetailsModel organizationDetailsModel;

  OrganizationDetailsSuccessState(this.organizationDetailsModel);
}

class OrganizationDetailsErrorState extends WorkLocationState {
  final String error;
  OrganizationDetailsErrorState(this.error);
}
//********************************* */

class OrganizationManagersDetailsLoadingState extends WorkLocationState {}

class OrganizationManagersDetailsSuccessState extends WorkLocationState {
  final OrganizationManagersDetailsModel organizationManagersDetailsModel;

  OrganizationManagersDetailsSuccessState(
      this.organizationManagersDetailsModel);
}

class OrganizationManagersDetailsErrorState extends WorkLocationState {
  final String error;
  OrganizationManagersDetailsErrorState(this.error);
}

//********************************* */
class OrganizationShiftsDetailsLoadingState extends WorkLocationState {}

class OrganizationShiftsDetailsSuccessState extends WorkLocationState {
  final OrganizationShiftsDetailsModel organizationShiftsDetailsModel;

  OrganizationShiftsDetailsSuccessState(this.organizationShiftsDetailsModel);
}

class OrganizationShiftsDetailsErrorState extends WorkLocationState {
  final String error;
  OrganizationShiftsDetailsErrorState(this.error);
}

//******************************** */

class CityDetailsLoadingState extends WorkLocationState {}

class CityDetailsSuccessState extends WorkLocationState {
  final CityDetailsModel cityDetailsModel;

  CityDetailsSuccessState(this.cityDetailsModel);
}

class CityDetailsErrorState extends WorkLocationState {
  final String error;
  CityDetailsErrorState(this.error);
}

//********************************* */
class CityManagersDetailsLoadingState extends WorkLocationState {}

class CityManagersDetailsSuccessState extends WorkLocationState {
  final CityManagersDetailsModel cityManagersDetailsModel;

  CityManagersDetailsSuccessState(this.cityManagersDetailsModel);
}

class CityManagersDetailsErrorState extends WorkLocationState {
  final String error;
  CityManagersDetailsErrorState(this.error);
}

//******************************** */

class BuildingDetailsLoadingState extends WorkLocationState {}

class BuildingDetailsSuccessState extends WorkLocationState {
  final BuildingDetailsModel buildingDetailsModel;

  BuildingDetailsSuccessState(this.buildingDetailsModel);
}

class BuildingDetailsErrorState extends WorkLocationState {
  final String error;
  BuildingDetailsErrorState(this.error);
}

//********************************* */
class BuildingManagersDetailsLoadingState extends WorkLocationState {}

class BuildingManagersDetailsSuccessState extends WorkLocationState {
  final BuildingManagersDetailsModel buildingManagersDetailsModel;

  BuildingManagersDetailsSuccessState(this.buildingManagersDetailsModel);
}

class BuildingManagersDetailsErrorState extends WorkLocationState {
  final String error;
  BuildingManagersDetailsErrorState(this.error);
}

//********************************* */
class BuildingShiftsDetailsLoadingState extends WorkLocationState {}

class BuildingShiftsDetailsSuccessState extends WorkLocationState {
  final BuildingShiftsDetailsModel buildingShiftsDetailsModel;

  BuildingShiftsDetailsSuccessState(this.buildingShiftsDetailsModel);
}

class BuildingShiftsDetailsErrorState extends WorkLocationState {
  final String error;
  BuildingShiftsDetailsErrorState(this.error);
}
//******************************** */

class FloorDetailsLoadingState extends WorkLocationState {}

class FloorDetailsSuccessState extends WorkLocationState {
  final FloorDetailsModel floorDetailsModel;

  FloorDetailsSuccessState(this.floorDetailsModel);
}

class FloorDetailsErrorState extends WorkLocationState {
  final String error;
  FloorDetailsErrorState(this.error);
}

//********************************* */
class FloorManagersDetailsLoadingState extends WorkLocationState {}

class FloorManagersDetailsSuccessState extends WorkLocationState {
  final FloorManagersDetailsModel floorManagersDetailsModel;

  FloorManagersDetailsSuccessState(this.floorManagersDetailsModel);
}

class FloorManagersDetailsErrorState extends WorkLocationState {
  final String error;
  FloorManagersDetailsErrorState(this.error);
}

//********************************* */
class FloorShiftsDetailsLoadingState extends WorkLocationState {}

class FloorShiftsDetailsSuccessState extends WorkLocationState {
  final FloorShiftsDetailsModel floorShiftsDetailsModel;

  FloorShiftsDetailsSuccessState(this.floorShiftsDetailsModel);
}

class FloorShiftsDetailsErrorState extends WorkLocationState {
  final String error;
  FloorShiftsDetailsErrorState(this.error);
}
//******************************** */

class PointDetailsLoadingState extends WorkLocationState {}

class PointDetailsSuccessState extends WorkLocationState {
  final PointDetailsModel pointDetailsModel;

  PointDetailsSuccessState(this.pointDetailsModel);
}

class PointDetailsErrorState extends WorkLocationState {
  final String error;
  PointDetailsErrorState(this.error);
}

//********************************* */
class PointManagersDetailsLoadingState extends WorkLocationState {}

class PointManagersDetailsSuccessState extends WorkLocationState {
  final PointManagersDetailsModel pointManagersDetailsModel;

  PointManagersDetailsSuccessState(this.pointManagersDetailsModel);
}

class PointManagersDetailsErrorState extends WorkLocationState {
  final String error;
  PointManagersDetailsErrorState(this.error);
}

//********************************* */
class PointShiftsDetailsLoadingState extends WorkLocationState {}

class PointShiftsDetailsSuccessState extends WorkLocationState {
  final PointShiftsDetailsModel pointShiftsDetailsModel;

  PointShiftsDetailsSuccessState(this.pointShiftsDetailsModel);
}

class PointShiftsDetailsErrorState extends WorkLocationState {
  final String error;
  PointShiftsDetailsErrorState(this.error);
}
//******************************** */

class AreaDeleteLoadingState extends WorkLocationState {}

class AreaDeleteSuccessState extends WorkLocationState {
  final String message;

  AreaDeleteSuccessState(this.message);
}

class AreaDeleteErrorState extends WorkLocationState {
  final String error;
  AreaDeleteErrorState(this.error);
}

//******************************** */
class CityDeleteLoadingState extends WorkLocationState {}

class CityDeleteSuccessState extends WorkLocationState {
  final String message;

  CityDeleteSuccessState(this.message);
}

class CityDeleteErrorState extends WorkLocationState {
  final String error;
  CityDeleteErrorState(this.error);
}

//******************************** */
class OrganizationDeleteLoadingState extends WorkLocationState {}

class OrganizationDeleteSuccessState extends WorkLocationState {
  final String message;

  OrganizationDeleteSuccessState(this.message);
}

class OrganizationDeleteErrorState extends WorkLocationState {
  final String error;
  OrganizationDeleteErrorState(this.error);
}

//******************************** */
class BuildingDeleteLoadingState extends WorkLocationState {}

class BuildingDeleteSuccessState extends WorkLocationState {
  final String message;

  BuildingDeleteSuccessState(this.message);
}

class BuildingDeleteErrorState extends WorkLocationState {
  final String error;
  BuildingDeleteErrorState(this.error);
}
//******************************** */

class FloorDeleteLoadingState extends WorkLocationState {}

class FloorDeleteSuccessState extends WorkLocationState {
  final String message;

  FloorDeleteSuccessState(this.message);
}

class FloorDeleteErrorState extends WorkLocationState {
  final String error;
  FloorDeleteErrorState(this.error);
}
//******************************** */

class PointDeleteLoadingState extends WorkLocationState {}

class PointDeleteSuccessState extends WorkLocationState {
  final String message;

  PointDeleteSuccessState(this.message);
}

class PointDeleteErrorState extends WorkLocationState {
  final String error;
  PointDeleteErrorState(this.error);
}
//********************************************************** */

class DeleteOrganizationsLoadingState extends WorkLocationState {}

class DeleteOrganizationsSuccessState extends WorkLocationState {
  final String message;
  DeleteOrganizationsSuccessState(this.message);
}

class DeleteOrganizationsErrorState extends WorkLocationState {
  final String error;
  DeleteOrganizationsErrorState(this.error);
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

class DeleteRestoreAreaLoadingState extends WorkLocationState {}

class DeleteRestoreAreaSuccessState extends WorkLocationState {
  final String message;
  DeleteRestoreAreaSuccessState(this.message);
}

class DeleteRestoreAreaErrorState extends WorkLocationState {
  final String error;
  DeleteRestoreAreaErrorState(this.error);
}

//******************************** */
class DeleteRestoreCityLoadingState extends WorkLocationState {}

class DeleteRestoreCitySuccessState extends WorkLocationState {
  final String message;
  DeleteRestoreCitySuccessState(this.message);
}

class DeleteRestoreCityErrorState extends WorkLocationState {
  final String error;
  DeleteRestoreCityErrorState(this.error);
}

//******************************** */
class DeleteRestoreOrganizationLoadingState extends WorkLocationState {}

class DeleteRestoreOrganizationSuccessState extends WorkLocationState {
  final String message;
  DeleteRestoreOrganizationSuccessState(this.message);
}

class DeleteRestoreOrganizationErrorState extends WorkLocationState {
  final String error;
  DeleteRestoreOrganizationErrorState(this.error);
}

//******************************** */
class DeleteRestoreBuildingLoadingState extends WorkLocationState {}

class DeleteRestoreBuildingSuccessState extends WorkLocationState {
  final String message;
  DeleteRestoreBuildingSuccessState(this.message);
}

class DeleteRestoreBuildingErrorState extends WorkLocationState {
  final String error;
  DeleteRestoreBuildingErrorState(this.error);
}

//******************************** */
class DeleteRestoreFloorLoadingState extends WorkLocationState {}

class DeleteRestoreFloorSuccessState extends WorkLocationState {
  final String message;
  DeleteRestoreFloorSuccessState(this.message);
}

class DeleteRestoreFloorErrorState extends WorkLocationState {
  final String error;
  DeleteRestoreFloorErrorState(this.error);
}

//******************************** */
class DeleteRestorePointLoadingState extends WorkLocationState {}

class DeleteRestorePointSuccessState extends WorkLocationState {
  final String message;
  DeleteRestorePointSuccessState(this.message);
}

class DeleteRestorePointErrorState extends WorkLocationState {
  final String error;
  DeleteRestorePointErrorState(this.error);
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

class DeleteForcePointLoadingState extends WorkLocationState {}

class DeleteForcePointSuccessState extends WorkLocationState {
  final String message;
  DeleteForcePointSuccessState(this.message);
}

class DeleteForcePointErrorState extends WorkLocationState {
  final String error;
  DeleteForcePointErrorState(this.error);
}

//**************************** */
class GetNationalityLoadingState extends WorkLocationState {}

class GetNationalitySuccessState extends WorkLocationState {
  final NationalityModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends WorkLocationState {
  final String error;
  GetNationalityErrorState(this.error);
}

//**************************** */

class GetAreaLoadingState extends WorkLocationState {}

class GetAreaSuccessState extends WorkLocationState {
  final AreaModel areaModel;

  GetAreaSuccessState(this.areaModel);
}

class GetAreaErrorState extends WorkLocationState {
  final String error;
  GetAreaErrorState(this.error);
}
//**************************** */

class GetCityyLoadingState extends WorkLocationState {}

class GetCityySuccessState extends WorkLocationState {
  final CityModel cityModel;

  GetCityySuccessState(this.cityModel);
}

class GetCityyErrorState extends WorkLocationState {
  final String error;
  GetCityyErrorState(this.error);
}

class GetOrganizationLoadingState extends WorkLocationState {}

class GetOrganizationSuccessState extends WorkLocationState {
  final OrganizationModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends WorkLocationState {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends WorkLocationState {}

class GetBuildingSuccessState extends WorkLocationState {
  final BuildingModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends WorkLocationState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends WorkLocationState {}

class GetFloorSuccessState extends WorkLocationState {
  final FloorModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends WorkLocationState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetPointsLoadingState extends WorkLocationState {}

class GetPointsSuccessState extends WorkLocationState {
  final PointsModel pointsModel;

  GetPointsSuccessState(this.pointsModel);
}

class GetPointsErrorState extends WorkLocationState {
  final String error;
  GetPointsErrorState(this.error);
}
//**************************** */

class AreaTreeLoadingState extends WorkLocationState {}

class AreaTreeSuccessState extends WorkLocationState {
  final AreaTreeModel areaTreeModel;

  AreaTreeSuccessState(this.areaTreeModel);
}

class AreaTreeErrorState extends WorkLocationState {
  final String error;
  AreaTreeErrorState(this.error);
}

//**************************** */

class CityTreeLoadingState extends WorkLocationState {}

class CityTreeSuccessState extends WorkLocationState {
  final CityTreeModel cityTreeModel;

  CityTreeSuccessState(this.cityTreeModel);
}

class CityTreeErrorState extends WorkLocationState {
  final String error;
  CityTreeErrorState(this.error);
}

//**************************** */

class OrganizationTreeLoadingState extends WorkLocationState {}

class OrganizationTreeSuccessState extends WorkLocationState {
  final OrganizationTreeModel organizationTreeModel;

  OrganizationTreeSuccessState(this.organizationTreeModel);
}

class OrganizationTreeErrorState extends WorkLocationState {
  final String error;
  OrganizationTreeErrorState(this.error);
}

//**************************** */

class BuildingTreeLoadingState extends WorkLocationState {}

class BuildingTreeSuccessState extends WorkLocationState {
  final BuildingTreeModel buildingTreeModel;

  BuildingTreeSuccessState(this.buildingTreeModel);
}

class BuildingTreeErrorState extends WorkLocationState {
  final String error;
  BuildingTreeErrorState(this.error);
}

//**************************** */

class FloorTreeLoadingState extends WorkLocationState {}

class FloorTreeSuccessState extends WorkLocationState {
  final FloorTreeModel floorTreeModel;

  FloorTreeSuccessState(this.floorTreeModel);
}

class FloorTreeErrorState extends WorkLocationState {
  final String error;
  FloorTreeErrorState(this.error);
}
//**************************************** */

class GetAllTasksLoadingState extends WorkLocationState {}

class GetAllTasksSuccessState extends WorkLocationState {
  final AllTasksModel allPointTasksModel;

  GetAllTasksSuccessState(this.allPointTasksModel);
}

class GetAllTasksErrorState extends WorkLocationState {
  final String error;
  GetAllTasksErrorState(this.error);
}

//********************** */

class AttendanceHistoryAreaLoadingState extends WorkLocationState {}

class AttendanceHistoryAreaSuccessState extends WorkLocationState {
  final AttendanceHistoryModel attendanceHistoryArea;

  AttendanceHistoryAreaSuccessState(this.attendanceHistoryArea);
}

class AttendanceHistoryAreaErrorState extends WorkLocationState {
  final String error;
  AttendanceHistoryAreaErrorState(this.error);
}

//********************** */
class AttendanceHistoryCityLoadingState extends WorkLocationState {}

class AttendanceHistoryCitySuccessState extends WorkLocationState {
  final AttendanceHistoryModel attendanceHistoryCity;

  AttendanceHistoryCitySuccessState(this.attendanceHistoryCity);
}

class AttendanceHistoryCityErrorState extends WorkLocationState {
  final String error;
  AttendanceHistoryCityErrorState(this.error);
}

//********************** */

class AttendanceHistoryOrganizationLoadingState extends WorkLocationState {}

class AttendanceHistoryOrganizationSuccessState extends WorkLocationState {
  final AttendanceHistoryModel attendanceHistoryOrganization;

  AttendanceHistoryOrganizationSuccessState(this.attendanceHistoryOrganization);
}

class AttendanceHistoryOrganizationErrorState extends WorkLocationState {
  final String error;
  AttendanceHistoryOrganizationErrorState(this.error);
}

//********************** */
class AttendanceHistoryBuildingLoadingState extends WorkLocationState {}

class AttendanceHistoryBuildingSuccessState extends WorkLocationState {
  final AttendanceHistoryModel attendanceHistoryBuilding;

  AttendanceHistoryBuildingSuccessState(this.attendanceHistoryBuilding);
}

class AttendanceHistoryBuildingErrorState extends WorkLocationState {
  final String error;
  AttendanceHistoryBuildingErrorState(this.error);
}

//********************** */

class AttendanceHistoryFloorLoadingState extends WorkLocationState {}

class AttendanceHistoryFloorSuccessState extends WorkLocationState {
  final AttendanceHistoryModel attendanceHistoryFloor;

  AttendanceHistoryFloorSuccessState(this.attendanceHistoryFloor);
}

class AttendanceHistoryFloorErrorState extends WorkLocationState {
  final String error;
  AttendanceHistoryFloorErrorState(this.error);
}

//********************** */

class AttendanceHistoryPointLoadingState extends WorkLocationState {}

class AttendanceHistoryPointSuccessState extends WorkLocationState {
  final AttendanceHistoryModel attendanceHistoryPoint;

  AttendanceHistoryPointSuccessState(this.attendanceHistoryPoint);
}

class AttendanceHistoryPointErrorState extends WorkLocationState {
  final String error;
  AttendanceHistoryPointErrorState(this.error);
}

//********************** */
class LeavesLoadingState extends WorkLocationState {}

class LeavesSuccessState extends WorkLocationState {
  final AttendanceLeavesModel attendanceLeavesPointModel;

  LeavesSuccessState(this.attendanceLeavesPointModel);
}

class LeavesErrorState extends WorkLocationState {
  final String error;
  LeavesErrorState(this.error);
}
