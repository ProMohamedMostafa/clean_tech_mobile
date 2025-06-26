import 'package:smart_cleaning_application/features/screens/attendance/attendance_history_management/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_management/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/settings/data/model/profile_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/all_tasks_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/data/models/user_shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/data/models/user_work_location_details.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final String error;
  ProfileErrorState(this.error);
}
//***************** */

class UserProfileDetailsLoadingState extends ProfileState {}

class UserProfileDetailsSuccessState extends ProfileState {
  final ProfileModel userProfileDetailsModelModel;

  UserProfileDetailsSuccessState(this.userProfileDetailsModelModel);
}

class UserProfileDetailsErrorState extends ProfileState {
  final String error;
  UserProfileDetailsErrorState(this.error);
}

//*********************** */

class UserShiftDetailsLoadingState extends ProfileState {}

class UserShiftDetailsSuccessState extends ProfileState {
  final UserShiftDetailsModel userShiftDetailsModel;

  UserShiftDetailsSuccessState(this.userShiftDetailsModel);
}

class UserShiftDetailsErrorState extends ProfileState {
  final String error;
  UserShiftDetailsErrorState(this.error);
}

//*********************** */

class UserWorkLocationDetailsLoadingState extends ProfileState {}

class UserWorkLocationDetailsSuccessState extends ProfileState {
  final UserWorkLocationDetailsModel userWorkLocationDetailsModel;

  UserWorkLocationDetailsSuccessState(this.userWorkLocationDetailsModel);
}

class UserWorkLocationDetailsErrorState extends ProfileState {
  final String error;
  UserWorkLocationDetailsErrorState(this.error);
}

//*********************** */

class UserTaskDetailsLoadingState extends ProfileState {}

class UserTaskDetailsSuccessState extends ProfileState {
  final AllTasksModel userTaskDetailsModel;

  UserTaskDetailsSuccessState(this.userTaskDetailsModel);
}

class UserTaskDetailsErrorState extends ProfileState {
  final String error;
  UserTaskDetailsErrorState(this.error);
}

//********************** */
class HistoryLoadingState extends ProfileState {}

class HistorySuccessState extends ProfileState {
  final AttendanceHistoryModel attendanceHistoryModel;

  HistorySuccessState(this.attendanceHistoryModel);
}

class HistoryErrorState extends ProfileState {
  final String error;
  HistoryErrorState(this.error);
}

//********************** */
class LeavesLoadingState extends ProfileState {}

class LeavesSuccessState extends ProfileState {
  final AttendanceLeavesModel attendanceLeavesModel;

  LeavesSuccessState(this.attendanceLeavesModel);
}

class LeavesErrorState extends ProfileState {
  final String error;
  LeavesErrorState(this.error);
}
