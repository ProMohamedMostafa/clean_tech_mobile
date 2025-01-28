import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';

abstract class AttendanceHistoryState {}

class AttendanceHistoryInitialState extends AttendanceHistoryState {}

class AttendanceHistoryLoadingState extends AttendanceHistoryState {}

class AttendanceHistorySuccessState extends AttendanceHistoryState {}

class AttendanceHistoryErrorState extends AttendanceHistoryState {
  final String error;
  AttendanceHistoryErrorState(this.error);
}

//********************** */
class HistoryLoadingState extends AttendanceHistoryState {}

class HistorySuccessState extends AttendanceHistoryState {
  final AttendanceHistoryModel attendanceHistoryModel;

  HistorySuccessState(this.attendanceHistoryModel);
}

class HistoryErrorState extends AttendanceHistoryState {
  final String error;
  HistoryErrorState(this.error);
}
//**************************** */

class RoleLoadingState extends AttendanceHistoryState {}

class RoleSuccessState extends AttendanceHistoryState {
  final RoleModel rolemodel;

  RoleSuccessState(this.rolemodel);
}

class RoleErrorState extends AttendanceHistoryState {
  final String error;
  RoleErrorState(this.error);
}

//**************************** */

class ShiftLoadingState extends AttendanceHistoryState {}

class ShiftSuccessState extends AttendanceHistoryState {
  final ShiftModel shiftModel;
  ShiftSuccessState(this.shiftModel);
}

class ShiftErrorState extends AttendanceHistoryState {
  final String error;
  ShiftErrorState(this.error);
}
