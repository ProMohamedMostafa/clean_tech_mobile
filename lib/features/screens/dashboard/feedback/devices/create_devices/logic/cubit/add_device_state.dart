part of 'add_device_cubit.dart';

abstract class AddDeviceState {}

final class AddDeviceInitial extends AddDeviceState {}

final class AddDeviceLoadingState extends AddDeviceState {}

final class AddDeviceSuccessState extends AddDeviceState {
  final String message;
  AddDeviceSuccessState(this.message);
}

final class AddDeviceErrorState extends AddDeviceState {
  final String error;
  AddDeviceErrorState(this.error);
}

//**************************** */

class GetBuildingLoadingState extends AddDeviceState {}

class GetBuildingSuccessState extends AddDeviceState {
  final BuildingBasicModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends AddDeviceState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends AddDeviceState {}

class GetFloorSuccessState extends AddDeviceState {
  final FloorListModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends AddDeviceState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetSectionLoadingState extends AddDeviceState {}

class GetSectionSuccessState extends AddDeviceState {
  final SectionListModel sectionModel;

  GetSectionSuccessState(this.sectionModel);
}

class GetSectionErrorState extends AddDeviceState {
  final String error;
  GetSectionErrorState(this.error);
}
