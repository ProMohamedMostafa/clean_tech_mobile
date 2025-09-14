part of 'device_answers_cubit.dart';

abstract class DeviceAnswersState {}

final class DeviceAnswersInitial extends DeviceAnswersState {}

final class DeviceAnswersLoadingState extends DeviceAnswersState {}

final class DeviceAnswersSuccessState extends DeviceAnswersState {
  final DeviceAnswersModel devicesAnswersModel;

  DeviceAnswersSuccessState(this.devicesAnswersModel);
}

final class DeviceAnswersErrorState extends DeviceAnswersState {
  final String error;

  DeviceAnswersErrorState(this.error);
}
