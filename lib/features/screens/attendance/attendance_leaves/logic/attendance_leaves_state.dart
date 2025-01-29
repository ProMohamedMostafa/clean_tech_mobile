import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_edit/data/models/leaves_details_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';

abstract class AttendanceLeavesState {}

class AttendanceLeavesInitialState extends AttendanceLeavesState {}

class AttendanceLeavesLoadingState extends AttendanceLeavesState {}

class AttendanceLeavesSuccessState extends AttendanceLeavesState {}

class AttendanceLeavesErrorState extends AttendanceLeavesState {
  final String error;
  AttendanceLeavesErrorState(this.error);
}

//********************** */
class LeavesLoadingState extends AttendanceLeavesState {}

class LeavesSuccessState extends AttendanceLeavesState {
  final AttendanceLeavesModel attendanceLeavesModel;

  LeavesSuccessState(this.attendanceLeavesModel);
}

class LeavesErrorState extends AttendanceLeavesState {
  final String error;
  LeavesErrorState(this.error);
}
//**************************** */

class RoleLoadingState extends AttendanceLeavesState {}

class RoleSuccessState extends AttendanceLeavesState {
  final RoleModel rolemodel;

  RoleSuccessState(this.rolemodel);
}

class RoleErrorState extends AttendanceLeavesState {
  final String error;
  RoleErrorState(this.error);
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
//***************** */

class LeavesDetailsLoadingState extends AttendanceLeavesState {}

class LeavesDetailsSuccessState extends AttendanceLeavesState {
  final LeavesDetailsModel leavesDetailsModel;

  LeavesDetailsSuccessState(this.leavesDetailsModel);
}

class LeavesDetailsErrorState extends AttendanceLeavesState {
  final String error;
  LeavesDetailsErrorState(this.error);
}