part of 'user_details_cubit.dart';

abstract class UserDetailsState {}

final class UserDetailsInitial extends UserDetailsState {}

class UserDetailsLoadingState extends UserDetailsState {}

class UserDetailsSuccessState extends UserDetailsState {
  final UserDetailsModel userDetailsModelModel;

  UserDetailsSuccessState(this.userDetailsModelModel);
}

class UserDetailsErrorState extends UserDetailsState {
  final String error;
  UserDetailsErrorState(this.error);
}


//*********************** */

class UserWorkLocationDetailsLoadingState extends UserDetailsState {}

class UserWorkLocationDetailsSuccessState extends UserDetailsState {
  final UserWorkLocationDetailsModel userWorkLocationDetailsModel;

  UserWorkLocationDetailsSuccessState(this.userWorkLocationDetailsModel);
}

class UserWorkLocationDetailsErrorState extends UserDetailsState {
  final String error;
  UserWorkLocationDetailsErrorState(this.error);
}

//********************************* */
class UserShiftDetailsLoadingState extends UserDetailsState {}

class UserShiftDetailsSuccessState extends UserDetailsState {
  final UserShiftDetailsModel userShiftDetailsModel;

  UserShiftDetailsSuccessState(this.userShiftDetailsModel);
}

class UserShiftDetailsErrorState extends UserDetailsState {
  final String error;
  UserShiftDetailsErrorState(this.error);
}
//*********************** */

class UserTaskDetailsLoadingState extends UserDetailsState {}

class UserTaskDetailsSuccessState extends UserDetailsState {
  final AllTasksModel userTaskDetailsModel;

  UserTaskDetailsSuccessState(this.userTaskDetailsModel);
}

class UserTaskDetailsErrorState extends UserDetailsState {
  final String error;
  UserTaskDetailsErrorState(this.error);
}

//********************** */
class HistoryLoadingState extends UserDetailsState {}

class HistorySuccessState extends UserDetailsState {
  final AttendanceHistoryModel attendanceHistoryModel;

  HistorySuccessState(this.attendanceHistoryModel);
}

class HistoryErrorState extends UserDetailsState {
  final String error;
  HistoryErrorState(this.error);
}

//********************** */
class LeavesLoadingState extends UserDetailsState {}

class LeavesSuccessState extends UserDetailsState {
  final AttendanceLeavesModel attendanceLeavesModel;

  LeavesSuccessState(this.attendanceLeavesModel);
}

class LeavesErrorState extends UserDetailsState {
  final String error;
  LeavesErrorState(this.error);
}

//***************** */

class UserDeleteLoadingState extends UserDetailsState {}

class UserDeleteSuccessState extends UserDetailsState {
  final DeleteUserModel deleteUserModel;

  UserDeleteSuccessState(this.deleteUserModel);
}

class UserDeleteErrorState extends UserDetailsState {
  final String error;
  UserDeleteErrorState(this.error);
}
