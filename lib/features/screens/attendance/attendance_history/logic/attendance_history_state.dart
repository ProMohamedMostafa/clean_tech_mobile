import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/data/models/attendance_history_model.dart';

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
