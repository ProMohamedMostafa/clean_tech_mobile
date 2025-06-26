import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/all_shifts_deleted_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/all_shifts_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/delete_shift_model.dart';

abstract class ShiftState {}

class ShiftInitialState extends ShiftState {}

class AllShiftLoadingState extends ShiftState {}

class AllShiftSuccessState extends ShiftState {
  final AllShiftsModel allShiftsModel;
  AllShiftSuccessState(this.allShiftsModel);
}

class AllShiftErrorState extends ShiftState {
  final String error;
  AllShiftErrorState(this.error);
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

//******************** */
class ShiftDeleteLoadingState extends ShiftState {}

class ShiftDeleteSuccessState extends ShiftState {
  final DeleteShiftModel deleteShiftModel;
  ShiftDeleteSuccessState(this.deleteShiftModel);
}

class ShiftDeleteErrorState extends ShiftState {
  final String error;
  ShiftDeleteErrorState(this.error);
}
