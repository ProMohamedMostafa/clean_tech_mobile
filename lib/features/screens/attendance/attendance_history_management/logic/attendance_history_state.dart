import 'package:smart_cleaning_application/features/screens/attendance/attendance_history_management/data/models/attendance_history_model.dart';

abstract class AttendanceHistoryState {}

class AttendanceHistoryInitialState extends AttendanceHistoryState {}

class HistoryLoadingState extends AttendanceHistoryState {}

class HistorySuccessState extends AttendanceHistoryState {
  final AttendanceHistoryModel attendanceHistoryModel;

  HistorySuccessState(this.attendanceHistoryModel);
}

class HistoryErrorState extends AttendanceHistoryState {
  final String error;
  HistoryErrorState(this.error);
}
