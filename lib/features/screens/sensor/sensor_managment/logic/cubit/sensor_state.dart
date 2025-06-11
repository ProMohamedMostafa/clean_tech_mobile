part of 'sensor_cubit.dart';

abstract class SensorState {}

final class SensorInitial extends SensorState {}

class SensorManagementLoading extends SensorState {}

class SensorManagementSuccess extends SensorState {
  final SensorModel sensorModel;

  SensorManagementSuccess(this.sensorModel);
}

class SensorManagementError extends SensorState {
  final String error;
  SensorManagementError(this.error);
}
//***************** */

class DeletedSensorsLoadingState extends SensorState {}

class DeletedSensorsSuccessState extends SensorState {
  final DeletedSensorListModel deletedSensorListModel;

  DeletedSensorsSuccessState(this.deletedSensorListModel);
}

class DeletedSensorsErrorState extends SensorState {
  final String error;
  DeletedSensorsErrorState(this.error);
}
//***************** */

class RestoreSensorLoadingState extends SensorState {}

class RestoreSensorSuccessState extends SensorState {
  final String message;

  RestoreSensorSuccessState(this.message);
}

class RestoreSensorErrorState extends SensorState {
  final String error;
  RestoreSensorErrorState(this.error);
}