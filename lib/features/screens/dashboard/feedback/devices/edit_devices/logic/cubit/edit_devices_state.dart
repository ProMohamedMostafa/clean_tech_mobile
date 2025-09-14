part of 'edit_devices_cubit.dart';

abstract class EditDevicesState {}

final class EditDeviceInitial extends EditDevicesState {}

final class EditDeviceLoadingState extends EditDevicesState {}

final class EditDeviceSuccessState extends EditDevicesState {
  final String message;
  EditDeviceSuccessState(this.message);
}

final class EditDeviceErrorState extends EditDevicesState {
  final String error;
  EditDeviceErrorState(this.error);
}

//************************ */
final class DeviceDetailsLoadingState extends EditDevicesState {}

final class DeviceDetailsSuccessState extends EditDevicesState {
  final DeviceDetails deviceDetailsModel;
  DeviceDetailsSuccessState(this.deviceDetailsModel);
}

final class DeviceDetailsErrorState extends EditDevicesState {
  final String error;
  DeviceDetailsErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends EditDevicesState {}

class GetBuildingSuccessState extends EditDevicesState {
  final BuildingBasicModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends EditDevicesState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends EditDevicesState {}

class GetFloorSuccessState extends EditDevicesState {
  final FloorListModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends EditDevicesState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetSectionLoadingState extends EditDevicesState {}

class GetSectionSuccessState extends EditDevicesState {
  final SectionListModel sectionModel;

  GetSectionSuccessState(this.sectionModel);
}

class GetSectionErrorState extends EditDevicesState {
  final String error;
  GetSectionErrorState(this.error);
}