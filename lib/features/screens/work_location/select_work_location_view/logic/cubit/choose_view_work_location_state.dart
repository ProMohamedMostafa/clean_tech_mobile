part of 'choose_view_work_location_cubit.dart';

abstract class ChooseViewWorkLocationState {}

final class ChooseViewWorkLocationInitial extends ChooseViewWorkLocationState {}
final class WorkLocationsDetailsLoadingState extends ChooseViewWorkLocationState {}
final class WorkLocationsDetailsSuccessState extends ChooseViewWorkLocationState {
  final ChooseViewWorkLocationModel chooseViewWorkLocationModel;

  WorkLocationsDetailsSuccessState(this.chooseViewWorkLocationModel);
}
final class WorkLocationsDetailsErrorState extends ChooseViewWorkLocationState {
  final String error;

  WorkLocationsDetailsErrorState(this.error); 
}
