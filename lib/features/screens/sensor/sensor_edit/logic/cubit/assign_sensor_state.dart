part of 'assign_sensor_cubit.dart';

abstract class AssignSensorState {}

final class AssignSensorInitial extends AssignSensorState {}

final class AssignSensorLoading extends AssignSensorState {}

final class AssignSensorSuccess extends AssignSensorState {}

final class AssignSensorError extends AssignSensorState {
  final String error;

  AssignSensorError(this.error);
}

//**************************** */
class SensorDetailsLoadingState extends AssignSensorState {}

class SensorDetailsSuccessState extends AssignSensorState {
  final SensorDetailsModel sensorDetailsModel;

  SensorDetailsSuccessState(this.sensorDetailsModel);
}

class SensorDetailsErrorState extends AssignSensorState {
  final String error;
  SensorDetailsErrorState(this.error);
}

//**************************** */
class OrganizationLoadingState extends AssignSensorState {}

class OrganizationSuccessState extends AssignSensorState {
  final OrganizationListModel organizationListModel;

  OrganizationSuccessState(this.organizationListModel);
}

class OrganizationErrorState extends AssignSensorState {
  final String error;
  OrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends AssignSensorState {}

class GetBuildingSuccessState extends AssignSensorState {
  final BuildingListModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends AssignSensorState {
  final String error;
  GetBuildingErrorState(this.error);
}

//**************************** */
class GetFloorLoadingState extends AssignSensorState {}

class GetFloorSuccessState extends AssignSensorState {
  final FloorListModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends AssignSensorState {
  final String error;
  GetFloorErrorState(this.error);
}

//**************************** */

class GetSectionLoadingState extends AssignSensorState {}

class GetSectionSuccessState extends AssignSensorState {
  final SectionListModel sectionsModel;

  GetSectionSuccessState(this.sectionsModel);
}

class GetSectionErrorState extends AssignSensorState {
  final String error;
  GetSectionErrorState(this.error);
}

//**************************** */

class GetPointLoadingState extends AssignSensorState {}

class GetPointSuccessState extends AssignSensorState {
  final PointListModel pointsModel;

  GetPointSuccessState(this.pointsModel);
}

class GetPointErrorState extends AssignSensorState {
  final String error;
  GetPointErrorState(this.error);
}
//**************************** */

class AssignSensorLoadingState extends AssignSensorState {}

class AssignSensorSuccessState extends AssignSensorState {
  final AssignSensorModel assignSensorModel;

  AssignSensorSuccessState(this.assignSensorModel);
}

class AssignSensorErrorState extends AssignSensorState {
  final String error;
  AssignSensorErrorState(this.error);
}
//**************************** */

class EditLimitSensorLoadingState extends AssignSensorState {}

class EditLimitSensorSuccessState extends AssignSensorState {
  final String messsage;

  EditLimitSensorSuccessState(this.messsage);
}

class EditLimitSensorErrorState extends AssignSensorState {
  final String error;
  EditLimitSensorErrorState(this.error);
}
