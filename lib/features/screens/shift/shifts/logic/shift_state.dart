import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/all_shifts_deleted_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/all_shifts_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/shift_details_model.dart';

abstract class ShiftState {}

class ShiftInitialState extends ShiftState {}

class ShiftLoadingState extends ShiftState {}

class ShiftSuccessState extends ShiftState {
  final AllShiftsModel allShiftsModel;
  ShiftSuccessState(this.allShiftsModel);
}

class ShiftErrorState extends ShiftState {
  final String error;
  ShiftErrorState(this.error);
}

//******************** */
class ShiftDetailsLoadingState extends ShiftState {}

class ShiftDetailsSuccessState extends ShiftState {
  final ShiftDetailsModel shiftDetailsModel;
  ShiftDetailsSuccessState(this.shiftDetailsModel);
}

class ShiftDetailsErrorState extends ShiftState {
  final String error;
  ShiftDetailsErrorState(this.error);
}

//******************** */
class ShiftDeleteLoadingState extends ShiftState {}

class ShiftDeleteSuccessState extends ShiftState {
  final String message;
  ShiftDeleteSuccessState(this.message);
}

class ShiftDeleteErrorState extends ShiftState {
  final String error;
  ShiftDeleteErrorState(this.error);
}

//******************** */
class AllShiftDeleteLoadingState extends ShiftState {}

class AllShiftDeleteSuccessState extends ShiftState {
  final AllShiftsDeletedModel allShiftsDeletedModel;
  AllShiftDeleteSuccessState(this.allShiftsDeletedModel);
}

class AllShiftDeleteErrorState extends ShiftState {
  final String error;
  AllShiftDeleteErrorState(this.error);
}

//******************** */
class RestoreShiftLoadingState extends ShiftState {}

class RestoreShiftSuccessState extends ShiftState {
  final String message;
  RestoreShiftSuccessState(this.message);
}

class RestoreShiftErrorState extends ShiftState {
  final String error;
  RestoreShiftErrorState(this.error);
}

//******************** */
class ForceDeleteShiftLoadingState extends ShiftState {}

class ForceDeleteShiftSuccessState extends ShiftState {
  final String message;
  ForceDeleteShiftSuccessState(this.message);
}

class ForceDeleteShiftErrorState extends ShiftState {
  final String error;
  ForceDeleteShiftErrorState(this.error);
}
