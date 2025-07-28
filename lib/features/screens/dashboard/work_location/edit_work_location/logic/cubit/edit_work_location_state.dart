part of 'edit_work_location_cubit.dart';

abstract class EditWorkLocationState {}

final class EditWorkLocationInitial extends EditWorkLocationState {}

class EditWorkLocationLoadingState extends EditWorkLocationState {}

class EditWorkLocationSuccessState extends EditWorkLocationState {
  final String message;

  EditWorkLocationSuccessState(this.message);
}

class EditWorkLocationErrorState extends EditWorkLocationState {
  final String error;
  EditWorkLocationErrorState(this.error);
}

//******************************** */

class GetNationalityLoadingState extends EditWorkLocationState {}

class GetNationalitySuccessState extends EditWorkLocationState {
  final NationalityListModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends EditWorkLocationState {
  final String error;
  GetNationalityErrorState(this.error);
}

//********************************** */

class GetAreaLoadingState extends EditWorkLocationState {}

class GetAreaSuccessState extends EditWorkLocationState {
  final AreaListModel areaModel;

  GetAreaSuccessState(this.areaModel);
}

class GetAreaErrorState extends EditWorkLocationState {
  final String error;
  GetAreaErrorState(this.error);
}
//**************************** */

class GetCityLoadingState extends EditWorkLocationState {}

class GetCitySuccessState extends EditWorkLocationState {
  final CityListModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends EditWorkLocationState {
  final String error;
  GetCityErrorState(this.error);
}

//**************************** */
class GetOrganizationLoadingState extends EditWorkLocationState {}

class GetOrganizationSuccessState extends EditWorkLocationState {
  final OrganizationListModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends EditWorkLocationState {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends EditWorkLocationState {}

class GetBuildingSuccessState extends EditWorkLocationState {
  final BuildingListModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends EditWorkLocationState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends EditWorkLocationState {}

class GetFloorSuccessState extends EditWorkLocationState {
  final FloorListModel buildingModel;

  GetFloorSuccessState(this.buildingModel);
}

class GetFloorErrorState extends EditWorkLocationState {
  final String error;
  GetFloorErrorState(this.error);
} //**************************** */

class GetSectionLoadingState extends EditWorkLocationState {}

class GetSectionSuccessState extends EditWorkLocationState {
  final SectionListModel sectionListModel;

  GetSectionSuccessState(this.sectionListModel);
}

class GetSectionErrorState extends EditWorkLocationState {
  final String error;
  GetSectionErrorState(this.error);
}
//******************************** */

class AreaEmployeesDetailsLoadingState extends EditWorkLocationState {}

class AreaEmployeesDetailsSuccessState extends EditWorkLocationState {
  final AreaUsersDetailsModel areaUsersDetailsModel;

  AreaEmployeesDetailsSuccessState(this.areaUsersDetailsModel);
}

class AreaEmployeesDetailsErrorState extends EditWorkLocationState {
  final String error;
  AreaEmployeesDetailsErrorState(this.error);
}

//**************************** */
class CityEmployeesDetailsLoadingState extends EditWorkLocationState {}

class CityEmployeesDetailsSuccessState extends EditWorkLocationState {
  final CityUsersDetailsModel cityUsersDetailsModel;

  CityEmployeesDetailsSuccessState(this.cityUsersDetailsModel);
}

class CityEmployeesDetailsErrorState extends EditWorkLocationState {
  final String error;
  CityEmployeesDetailsErrorState(this.error);
}
//**************************** */

class OrganizationEmployeesDetailsLoadingState extends EditWorkLocationState {}

class OrganizationEmployeesDetailsSuccessState extends EditWorkLocationState {
  final OrganizationUsersShiftsDetailsModel organizationEmployeesDetailsModel;

  OrganizationEmployeesDetailsSuccessState(
      this.organizationEmployeesDetailsModel);
}

class OrganizationEmployeesDetailsErrorState extends EditWorkLocationState {
  final String error;
  OrganizationEmployeesDetailsErrorState(this.error);
}

//********************************* */
class BuildingEmployeesDetailsLoadingState extends EditWorkLocationState {}

class BuildingEmployeesDetailsSuccessState extends EditWorkLocationState {
  final BuildingUsersShiftsDetailsModel buildingUsersShiftsDetailsModel;

  BuildingEmployeesDetailsSuccessState(this.buildingUsersShiftsDetailsModel);
}

class BuildingEmployeesDetailsErrorState extends EditWorkLocationState {
  final String error;
  BuildingEmployeesDetailsErrorState(this.error);
}

//********************************* */
class FloorEmployeesDetailsLoadingState extends EditWorkLocationState {}

class FloorEmployeesDetailsSuccessState extends EditWorkLocationState {
  final FloorUsersShiftsDetailsModel floorUsersShiftsDetailsModel;

  FloorEmployeesDetailsSuccessState(this.floorUsersShiftsDetailsModel);
}

class FloorEmployeesDetailsErrorState extends EditWorkLocationState {
  final String error;
  FloorEmployeesDetailsErrorState(this.error);
}

//********************************* */
class SectionEmployeesDetailsLoadingState extends EditWorkLocationState {}

class SectionEmployeesDetailsSuccessState extends EditWorkLocationState {
  final SectionUsersShiftsDetailsModel sectionUsersDetailsModel;

  SectionEmployeesDetailsSuccessState(this.sectionUsersDetailsModel);
}

class SectionEmployeesDetailsErrorState extends EditWorkLocationState {
  final String error;
  SectionEmployeesDetailsErrorState(this.error);
}

//********************************* */
class PointEmployeesDetailsLoadingState extends EditWorkLocationState {}

class PointEmployeesDetailsSuccessState extends EditWorkLocationState {
  final PointUsersDetailsModel pointUsersDetailsModel;

  PointEmployeesDetailsSuccessState(this.pointUsersDetailsModel);
}

class PointEmployeesDetailsErrorState extends EditWorkLocationState {
  final String error;
  PointEmployeesDetailsErrorState(this.error);
}
//**************************** */

class AllUsersLoadingState extends EditWorkLocationState {}

class AllUsersSuccessState extends EditWorkLocationState {
  final UsersModel usersModel;

  AllUsersSuccessState(this.usersModel);
}

class AllUsersErrorState extends EditWorkLocationState {
  final String error;
  AllUsersErrorState(this.error);
}
//**************************** */

class ShiftLoadingState extends EditWorkLocationState {}

class ShiftSuccessState extends EditWorkLocationState {
  final ShiftModel shiftModel;
  ShiftSuccessState(this.shiftModel);
}

class ShiftErrorState extends EditWorkLocationState {
  final String error;
  ShiftErrorState(this.error);
}
//**************************** */

class SensorLoading extends EditWorkLocationState {}

class SensorSuccess extends EditWorkLocationState {
  final SensorModel sensorModel;
  SensorSuccess(this.sensorModel);
}

class SensorError extends EditWorkLocationState {
  final String error;
  SensorError(this.error);
}

//********************************* */
class IsCountableChanged extends EditWorkLocationState {}
