part of 'work_location_details_cubit.dart';

abstract class WorkLocationDetailsState {}

final class WorkLocationDetailsInitial extends WorkLocationDetailsState {}
//********************** */

class AttendanceHistoryAreaLoadingState extends WorkLocationDetailsState {}

class AttendanceHistoryAreaSuccessState extends WorkLocationDetailsState {
  final AttendanceHistoryModel attendanceHistoryArea;

  AttendanceHistoryAreaSuccessState(this.attendanceHistoryArea);
}

class AttendanceHistoryAreaErrorState extends WorkLocationDetailsState {
  final String error;
  AttendanceHistoryAreaErrorState(this.error);
}

//********************** */
class AttendanceHistoryCityLoadingState extends WorkLocationDetailsState {}

class AttendanceHistoryCitySuccessState extends WorkLocationDetailsState {
  final AttendanceHistoryModel attendanceHistoryCity;

  AttendanceHistoryCitySuccessState(this.attendanceHistoryCity);
}

class AttendanceHistoryCityErrorState extends WorkLocationDetailsState {
  final String error;
  AttendanceHistoryCityErrorState(this.error);
}

//********************** */

class AttendanceHistoryOrganizationLoadingState
    extends WorkLocationDetailsState {}

class AttendanceHistoryOrganizationSuccessState
    extends WorkLocationDetailsState {
  final AttendanceHistoryModel attendanceHistoryOrganization;

  AttendanceHistoryOrganizationSuccessState(this.attendanceHistoryOrganization);
}

class AttendanceHistoryOrganizationErrorState extends WorkLocationDetailsState {
  final String error;
  AttendanceHistoryOrganizationErrorState(this.error);
}

//********************** */
class AttendanceHistoryBuildingLoadingState extends WorkLocationDetailsState {}

class AttendanceHistoryBuildingSuccessState extends WorkLocationDetailsState {
  final AttendanceHistoryModel attendanceHistoryBuilding;

  AttendanceHistoryBuildingSuccessState(this.attendanceHistoryBuilding);
}

class AttendanceHistoryBuildingErrorState extends WorkLocationDetailsState {
  final String error;
  AttendanceHistoryBuildingErrorState(this.error);
}

//********************** */

class AttendanceHistoryFloorLoadingState extends WorkLocationDetailsState {}

class AttendanceHistoryFloorSuccessState extends WorkLocationDetailsState {
  final AttendanceHistoryModel attendanceHistoryFloor;

  AttendanceHistoryFloorSuccessState(this.attendanceHistoryFloor);
}

class AttendanceHistoryFloorErrorState extends WorkLocationDetailsState {
  final String error;
  AttendanceHistoryFloorErrorState(this.error);
}

//********************** */

class AttendanceHistorySectionLoadingState extends WorkLocationDetailsState {}

class AttendanceHistorySectionSuccessState extends WorkLocationDetailsState {
  final AttendanceHistoryModel attendanceHistorySection;

  AttendanceHistorySectionSuccessState(this.attendanceHistorySection);
}

class AttendanceHistorySectionErrorState extends WorkLocationDetailsState {
  final String error;
  AttendanceHistorySectionErrorState(this.error);
}

//********************** */

class AttendanceHistoryPointLoadingState extends WorkLocationDetailsState {}

class AttendanceHistoryPointSuccessState extends WorkLocationDetailsState {
  final AttendanceHistoryModel attendanceHistoryPoint;

  AttendanceHistoryPointSuccessState(this.attendanceHistoryPoint);
}

class AttendanceHistoryPointErrorState extends WorkLocationDetailsState {
  final String error;
  AttendanceHistoryPointErrorState(this.error);
}

//********************** */
class LeavesLoadingState extends WorkLocationDetailsState {}

class LeavesSuccessState extends WorkLocationDetailsState {
  final AttendanceLeavesModel attendanceLeavesPointModel;

  LeavesSuccessState(this.attendanceLeavesPointModel);
}

class LeavesErrorState extends WorkLocationDetailsState {
  final String error;
  LeavesErrorState(this.error);
}

//**************************************** */

class GetAllTasksLoadingState extends WorkLocationDetailsState {}

class GetAllTasksSuccessState extends WorkLocationDetailsState {
  final AllTasksModel allPointTasksModel;

  GetAllTasksSuccessState(this.allPointTasksModel);
}

class GetAllTasksErrorState extends WorkLocationDetailsState {
  final String error;
  GetAllTasksErrorState(this.error);
}

//**************************** */

class AreaTreeLoadingState extends WorkLocationDetailsState {}

class AreaTreeSuccessState extends WorkLocationDetailsState {
  final AreaTreeModel areaTreeModel;

  AreaTreeSuccessState(this.areaTreeModel);
}

class AreaTreeErrorState extends WorkLocationDetailsState {
  final String error;
  AreaTreeErrorState(this.error);
}

//**************************** */

class CityTreeLoadingState extends WorkLocationDetailsState {}

class CityTreeSuccessState extends WorkLocationDetailsState {
  final CityTreeModel cityTreeModel;

  CityTreeSuccessState(this.cityTreeModel);
}

class CityTreeErrorState extends WorkLocationDetailsState {
  final String error;
  CityTreeErrorState(this.error);
}

//**************************** */

class OrganizationTreeLoadingState extends WorkLocationDetailsState {}

class OrganizationTreeSuccessState extends WorkLocationDetailsState {
  final OrganizationTreeModel organizationTreeModel;

  OrganizationTreeSuccessState(this.organizationTreeModel);
}

class OrganizationTreeErrorState extends WorkLocationDetailsState {
  final String error;
  OrganizationTreeErrorState(this.error);
}

//**************************** */

class BuildingTreeLoadingState extends WorkLocationDetailsState {}

class BuildingTreeSuccessState extends WorkLocationDetailsState {
  final BuildingTreeModel buildingTreeModel;

  BuildingTreeSuccessState(this.buildingTreeModel);
}

class BuildingTreeErrorState extends WorkLocationDetailsState {
  final String error;
  BuildingTreeErrorState(this.error);
}

//**************************** */

class FloorTreeLoadingState extends WorkLocationDetailsState {}

class FloorTreeSuccessState extends WorkLocationDetailsState {
  final FloorTreeModel floorTreeModel;

  FloorTreeSuccessState(this.floorTreeModel);
}

class FloorTreeErrorState extends WorkLocationDetailsState {
  final String error;
  FloorTreeErrorState(this.error);
}

//**************************** */

class SectionTreeLoadingState extends WorkLocationDetailsState {}

class SectionTreeSuccessState extends WorkLocationDetailsState {
  final SectionTreeModel sectionTreeModel;

  SectionTreeSuccessState(this.sectionTreeModel);
}

class SectionTreeErrorState extends WorkLocationDetailsState {
  final String error;
  SectionTreeErrorState(this.error);
}

//******************************** */

class AreaUsersDetailsLoadingState extends WorkLocationDetailsState {}

class AreaUsersDetailsSuccessState extends WorkLocationDetailsState {
  final AreaUsersDetailsModel areaUsersDetailsModel;

  AreaUsersDetailsSuccessState(this.areaUsersDetailsModel);
}

class AreaUsersDetailsErrorState extends WorkLocationDetailsState {
  final String error;
  AreaUsersDetailsErrorState(this.error);
}

//********************************* */
class CityUsersDetailsLoadingState extends WorkLocationDetailsState {}

class CityUsersDetailsSuccessState extends WorkLocationDetailsState {
  final CityUsersDetailsModel cityUsersDetailsModel;

  CityUsersDetailsSuccessState(this.cityUsersDetailsModel);
}

class CityUsersDetailsErrorState extends WorkLocationDetailsState {
  final String error;
  CityUsersDetailsErrorState(this.error);
}

//********************************* */

class OrganizationUsersDetailsLoadingState extends WorkLocationDetailsState {}

class OrganizationUsersDetailsSuccessState extends WorkLocationDetailsState {
  final OrganizationUsersShiftsDetailsModel organizationUsersShiftsDetailsModel;

  OrganizationUsersDetailsSuccessState(
      this.organizationUsersShiftsDetailsModel);
}

class OrganizationUsersDetailsErrorState extends WorkLocationDetailsState {
  final String error;
  OrganizationUsersDetailsErrorState(this.error);
}

//********************************* */
class BuildingUsersDetailsLoadingState extends WorkLocationDetailsState {}

class BuildingUsersDetailsSuccessState extends WorkLocationDetailsState {
  final BuildingUsersShiftsDetailsModel buildingUsersShiftsDetailsModel;

  BuildingUsersDetailsSuccessState(this.buildingUsersShiftsDetailsModel);
}

class BuildingUsersDetailsErrorState extends WorkLocationDetailsState {
  final String error;
  BuildingUsersDetailsErrorState(this.error);
}

//********************************* */
class FloorUsersDetailsLoadingState extends WorkLocationDetailsState {}

class FloorUsersDetailsSuccessState extends WorkLocationDetailsState {
  final FloorUsersShiftsDetailsModel floorUsersShiftsDetailsModel;

  FloorUsersDetailsSuccessState(this.floorUsersShiftsDetailsModel);
}

class FloorUsersDetailsErrorState extends WorkLocationDetailsState {
  final String error;
  FloorUsersDetailsErrorState(this.error);
}

//********************************* */
class SectionUserDetailsLoadingState extends WorkLocationDetailsState {}

class SectionUserDetailsSuccessState extends WorkLocationDetailsState {
  final SectionUsersShiftsDetailsModel sectionUsersShiftsDetailsModel;

  SectionUserDetailsSuccessState(this.sectionUsersShiftsDetailsModel);
}

class SectionUserDetailsErrorState extends WorkLocationDetailsState {
  final String error;
  SectionUserDetailsErrorState(this.error);
}

//********************************* */
class PointUsersDetailsLoadingState extends WorkLocationDetailsState {}

class PointUsersDetailsSuccessState extends WorkLocationDetailsState {
  final PointUsersDetailsModel pointUsersDetailsModel;

  PointUsersDetailsSuccessState(this.pointUsersDetailsModel);
}

class PointUsersDetailsErrorState extends WorkLocationDetailsState {
  final String error;
  PointUsersDetailsErrorState(this.error);
}
//******************************** */

class AreaDeleteLoadingState extends WorkLocationDetailsState {}

class AreaDeleteSuccessState extends WorkLocationDetailsState {
  final DeleteAreaModel deleteAreaModel;

  AreaDeleteSuccessState(this.deleteAreaModel);
}

class AreaDeleteErrorState extends WorkLocationDetailsState {
  final String error;
  AreaDeleteErrorState(this.error);
}

//******************************** */
class CityDeleteLoadingState extends WorkLocationDetailsState {}

class CityDeleteSuccessState extends WorkLocationDetailsState {
  final DeleteCityModel deleteCityModel;

  CityDeleteSuccessState(this.deleteCityModel);
}

class CityDeleteErrorState extends WorkLocationDetailsState {
  final String error;
  CityDeleteErrorState(this.error);
}

//******************************** */
class OrganizationDeleteLoadingState extends WorkLocationDetailsState {}

class OrganizationDeleteSuccessState extends WorkLocationDetailsState {
  final DeleteOrganizationModel deleteOrganizationModel;

  OrganizationDeleteSuccessState(this.deleteOrganizationModel);
}

class OrganizationDeleteErrorState extends WorkLocationDetailsState {
  final String error;
  OrganizationDeleteErrorState(this.error);
}

//******************************** */
class BuildingDeleteLoadingState extends WorkLocationDetailsState {}

class BuildingDeleteSuccessState extends WorkLocationDetailsState {
  final DeleteBuildingModel deleteBuildingModel;

  BuildingDeleteSuccessState(this.deleteBuildingModel);
}

class BuildingDeleteErrorState extends WorkLocationDetailsState {
  final String error;
  BuildingDeleteErrorState(this.error);
}
//******************************** */

class FloorDeleteLoadingState extends WorkLocationDetailsState {}

class FloorDeleteSuccessState extends WorkLocationDetailsState {
  final DeleteFloorModel deleteFloorModel;

  FloorDeleteSuccessState(this.deleteFloorModel);
}

class FloorDeleteErrorState extends WorkLocationDetailsState {
  final String error;
  FloorDeleteErrorState(this.error);
}
//******************************** */

class SectionDeleteLoadingState extends WorkLocationDetailsState {}

class SectionDeleteSuccessState extends WorkLocationDetailsState {
  final DeleteSectionModel deleteSectionModel;

  SectionDeleteSuccessState(this.deleteSectionModel);
}

class SectionDeleteErrorState extends WorkLocationDetailsState {
  final String error;
  SectionDeleteErrorState(this.error);
}

//******************************** */

class PointDeleteLoadingState extends WorkLocationDetailsState {}

class PointDeleteSuccessState extends WorkLocationDetailsState {
  final DeletePointModel deletePointModel;

  PointDeleteSuccessState(this.deletePointModel);
}

class PointDeleteErrorState extends WorkLocationDetailsState {
  final String error;
  PointDeleteErrorState(this.error);
}

//******************************** */