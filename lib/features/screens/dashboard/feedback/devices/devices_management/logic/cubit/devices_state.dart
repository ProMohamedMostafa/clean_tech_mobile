part of 'devices_cubit.dart';

abstract class DevicesState {}

final class DevicesInitial extends DevicesState {}

final class DevicesLoadingState extends DevicesState {}

final class DevicesSuccessState extends DevicesState {
  final DevicesModel devicesModel;

  DevicesSuccessState(this.devicesModel);
}

final class DevicesErrorState extends DevicesState {
  final String error;

  DevicesErrorState(this.error);
}

//**************************** */

class GetSectionLoadingState extends DevicesState {}

class GetSectionSuccessState extends DevicesState {
  final SectionBasicModel sectionsModel;

  GetSectionSuccessState(this.sectionsModel);
}

class GetSectionErrorState extends DevicesState {
  final String error;
  GetSectionErrorState(this.error);
}

//***************** */

class ForceDeleteDeviceLoadingState extends DevicesState {}

class ForceDeleteDeviceSuccessState extends DevicesState {
  final String message;

  ForceDeleteDeviceSuccessState(this.message);
}

class ForceDeleteDeviceErrorState extends DevicesState {
  final String error;
  ForceDeleteDeviceErrorState(this.error);
}
