part of 'sensor_details_cubit.dart';

abstract class SensorDetailsState {}

final class SensorDetailsInitial extends SensorDetailsState {}

//**************************** */
class SensorDetailsLoadingState extends SensorDetailsState {}

class SensorDetailsSuccessState extends SensorDetailsState {
  final SensorDetailsModel sensorDetailsModel;

  SensorDetailsSuccessState(this.sensorDetailsModel);
}

class SensorDetailsErrorState extends SensorDetailsState {
  final String error;
  SensorDetailsErrorState(this.error);
}

//**************************** */
class DeleteSensorLoadingState extends SensorDetailsState {}

class DeleteSensorSuccessState extends SensorDetailsState {
  final DeletedSensorModel deletedSensorModel;

  DeleteSensorSuccessState(this.deletedSensorModel);
}

class DeleteSensorErrorState extends SensorDetailsState {
  final String error;
  DeleteSensorErrorState(this.error);
}

//**************************** */

class DeleteLimitLoadingState extends SensorDetailsState {}

class DeleteLimitSuccessState extends SensorDetailsState {
  final String message;

  DeleteLimitSuccessState(this.message);
}

class DeleteLimitErrorState extends SensorDetailsState {
  final String error;
  DeleteLimitErrorState(this.error);
}
//**************************** */

class EditLimitSensorLoadingState extends SensorDetailsState {}

class EditLimitSensorSuccessState extends SensorDetailsState {
  final String message;

  EditLimitSensorSuccessState(this.message);
}

class EditLimitSensorErrorState extends SensorDetailsState {
  final String error;
  EditLimitSensorErrorState(this.error);
}
//**************************** */

class CreateLimitSensorLoadingState extends SensorDetailsState {}

class CreateLimitSensorSuccessState extends SensorDetailsState {
  final String message;

  CreateLimitSensorSuccessState(this.message);
}

class CreateLimitSensorErrorState extends SensorDetailsState {
  final String error;
  CreateLimitSensorErrorState(this.error);
}
//********************************** */
class SensorToggleSensor extends SensorDetailsState {}

class SensorToggleDescription extends SensorDetailsState {}

class SensorDetailsStateUpdated extends SensorDetailsState {}

class SensorTreeIndexChanged extends SensorDetailsState {}
