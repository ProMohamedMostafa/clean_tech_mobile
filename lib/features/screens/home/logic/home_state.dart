import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/settings/data/model/profile_model.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {}

class HomeErrorState extends HomeState {
  final String error;
  HomeErrorState(this.error);
}

//******************************* */

class UserDetailsLoadingState extends HomeState {}

class UserDetailsSuccessState extends HomeState {
  final ProfileModel profileModel;

  UserDetailsSuccessState(this.profileModel);
}

class UserDetailsErrorState extends HomeState {
  final String error;
  UserDetailsErrorState(this.error);
}

//******************************* */

class ClockInOutLoadingState extends HomeState {}

class ClockInOutSuccessState extends HomeState {
 final String message;

  ClockInOutSuccessState(this.message);
}

class ClockInOutErrorState extends HomeState {
  final String error;
  ClockInOutErrorState(this.error);
}
//********************************* */


class UserStatusLoadingState extends HomeState {}

class UserStatusSuccessState extends HomeState {
  final AttendanceHistoryModel attendanceHistoryModel;

  UserStatusSuccessState(this.attendanceHistoryModel);
}

class UserStatusErrorState extends HomeState {
  final String error;
  UserStatusErrorState(this.error);
}
