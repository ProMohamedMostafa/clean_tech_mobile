import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_leaves_management/data/models/attendance_leaves_model.dart';

abstract class AttendanceLeavesState {}

class AttendanceLeavesInitialState extends AttendanceLeavesState {}

class LeavesLoadingState extends AttendanceLeavesState {}

class LeavesSuccessState extends AttendanceLeavesState {
  final AttendanceLeavesModel attendanceLeavesModel;

  LeavesSuccessState(this.attendanceLeavesModel);
}

class LeavesErrorState extends AttendanceLeavesState {
  final String error;
  LeavesErrorState(this.error);
}

//***************** */

class LeavesDeleteLoadingState extends AttendanceLeavesState {}

class LeavesDeleteSuccessState extends AttendanceLeavesState {
  final String message;

  LeavesDeleteSuccessState(this.message);
}

class LeavesDeleteErrorState extends AttendanceLeavesState {
  final String error;
  LeavesDeleteErrorState(this.error);
}
