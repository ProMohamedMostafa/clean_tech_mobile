part of 'edit_sensor_cubit.dart';

abstract class EditSensorState {}

final class EditSensorInitial extends EditSensorState {}

final class EditSensorLoading extends EditSensorState {}

final class EditSensorSuccess extends EditSensorState {}

final class EditSensorError extends EditSensorState {
  final String error;

  EditSensorError(this.error);
}

//**************************** */
class SensorDetailsLoadingState extends EditSensorState {}

class SensorDetailsSuccessState extends EditSensorState {
  final SensorDetailsModel sensorDetailsModel;

  SensorDetailsSuccessState(this.sensorDetailsModel);
}

class SensorDetailsErrorState extends EditSensorState {
  final String error;
  SensorDetailsErrorState(this.error);
}

//**************************** */
class OrganizationLoadingState extends EditSensorState {}

class OrganizationSuccessState extends EditSensorState {
  final OrganizationListModel organizationListModel;

  OrganizationSuccessState(this.organizationListModel);
}

class OrganizationErrorState extends EditSensorState {
  final String error;
  OrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends EditSensorState {}

class GetBuildingSuccessState extends EditSensorState {
  final BuildingListModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends EditSensorState {
  final String error;
  GetBuildingErrorState(this.error);
}

//**************************** */
class GetFloorLoadingState extends EditSensorState {}

class GetFloorSuccessState extends EditSensorState {
  final FloorListModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends EditSensorState {
  final String error;
  GetFloorErrorState(this.error);
}

//**************************** */

class GetSectionLoadingState extends EditSensorState {}

class GetSectionSuccessState extends EditSensorState {
  final SectionListModel sectionsModel;

  GetSectionSuccessState(this.sectionsModel);
}

class GetSectionErrorState extends EditSensorState {
  final String error;
  GetSectionErrorState(this.error);
}

//**************************** */

class GetPointLoadingState extends EditSensorState {}

class GetPointSuccessState extends EditSensorState {
  final PointListModel pointsModel;

  GetPointSuccessState(this.pointsModel);
}

class GetPointErrorState extends EditSensorState {
  final String error;
  GetPointErrorState(this.error);
}
//**************************** */

class EditSensorLoadingState extends EditSensorState {}

class EditSensorSuccessState extends EditSensorState {
  final EditSensorModel editSensorModel;

  EditSensorSuccessState(this.editSensorModel);
}

class EditSensorErrorState extends EditSensorState {
  final String error;
  EditSensorErrorState(this.error);
}
//**************************** */

class EditLimitSensorLoadingState extends EditSensorState {}

class EditLimitSensorSuccessState extends EditSensorState {
  final String messsage;

  EditLimitSensorSuccessState(this.messsage);
}

class EditLimitSensorErrorState extends EditSensorState {
  final String error;
  EditLimitSensorErrorState(this.error);
}
