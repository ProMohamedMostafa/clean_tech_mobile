part of 'shift_details_cubit.dart';

abstract class ShiftDetailsState {}

final class ShiftDetailsInitial extends ShiftDetailsState {}

class ShiftDetailsLoadingState extends ShiftDetailsState {}

class ShiftDetailsSuccessState extends ShiftDetailsState {
  final ShiftDetailsModel shiftDetailsModel;
  ShiftDetailsSuccessState(this.shiftDetailsModel);
}

class ShiftDetailsErrorState extends ShiftDetailsState {
  final String error;
  ShiftDetailsErrorState(this.error);
}

//******************** */
class ShiftDeleteLoadingState extends ShiftDetailsState {}

class ShiftDeleteSuccessState extends ShiftDetailsState {
  final DeleteShiftModel deleteShiftModel;
  ShiftDeleteSuccessState(this.deleteShiftModel);
}

class ShiftDeleteErrorState extends ShiftDetailsState {
  final String error;
  ShiftDeleteErrorState(this.error);
}
