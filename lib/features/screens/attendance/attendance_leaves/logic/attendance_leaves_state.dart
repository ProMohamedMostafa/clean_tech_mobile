import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';

abstract class AttendanceLeavesState {}

class AttendanceLeavesInitialState extends AttendanceLeavesState {}

class AttendanceLeavesLoadingState extends AttendanceLeavesState {}

class AttendanceLeavesSuccessState extends AttendanceLeavesState {}

class AttendanceLeavesErrorState extends AttendanceLeavesState {
  final String error;
  AttendanceLeavesErrorState(this.error);
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