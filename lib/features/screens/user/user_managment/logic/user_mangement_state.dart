import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/delete_user_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/deleted_list_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_task_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_work_location_details.dart';

import '../../../integrations/data/models/building_model.dart';
import '../../../integrations/data/models/floor_model.dart';
import '../../../integrations/data/models/nationality_model.dart';
import '../../../integrations/data/models/points_model.dart';
import '../../../integrations/data/models/role_model.dart';
import '../../../integrations/data/models/users_model.dart';

abstract class UserManagementState {}

class UserManagementInitialState extends UserManagementState {}

class UserManagementLoadingState extends UserManagementState {}

class UserManagementSuccessState extends UserManagementState {}

class UserManagementErrorState extends UserManagementState {
  final String error;
  UserManagementErrorState(this.error);
}
//***************** */

class UserDeleteLoadingState extends UserManagementState {}

class UserDeleteSuccessState extends UserManagementState {
  final DeleteUserModel deleteUserModel;

  UserDeleteSuccessState(this.deleteUserModel);
}

class UserDeleteErrorState extends UserManagementState {
  final String error;
  UserDeleteErrorState(this.error);
}

//***************** */

class AllUsersLoadingState extends UserManagementState {}

class AllUsersSuccessState extends UserManagementState {
  final UsersModel usersModel;

  AllUsersSuccessState(this.usersModel);
}

class AllUsersErrorState extends UserManagementState {
  final String error;
  AllUsersErrorState(this.error);
}

//***************** */

class DeletedUsersLoadingState extends UserManagementState {}

class DeletedUsersSuccessState extends UserManagementState {
  final DeletedListModel deletedListModel;

  DeletedUsersSuccessState(this.deletedListModel);
}

class DeletedUsersErrorState extends UserManagementState {
  final String error;
  DeletedUsersErrorState(this.error);
}
//***************** */

class RestoreUsersLoadingState extends UserManagementState {}

class RestoreUsersSuccessState extends UserManagementState {
  final String message;

  RestoreUsersSuccessState(this.message);
}

class RestoreUsersErrorState extends UserManagementState {
  final String error;
  RestoreUsersErrorState(this.error);
}
//***************** */

class ForceDeleteUsersLoadingState extends UserManagementState {}

class ForceDeleteUsersSuccessState extends UserManagementState {
  final String message;

  ForceDeleteUsersSuccessState(this.message);
}

class ForceDeleteUsersErrorState extends UserManagementState {
  final String error;
  ForceDeleteUsersErrorState(this.error);
}
//*********************** */

class UserDetailsLoadingState extends UserManagementState {}

class UserDetailsSuccessState extends UserManagementState {
  final UserDetailsModel userDetailsModelModel;

  UserDetailsSuccessState(this.userDetailsModelModel);
}

class UserDetailsErrorState extends UserManagementState {
  final String error;
  UserDetailsErrorState(this.error);
}
//*********************** */

class UserShiftDetailsLoadingState extends UserManagementState {}

class UserShiftDetailsSuccessState extends UserManagementState {
  final UserShiftDetailsModel userShiftDetailsModel;

  UserShiftDetailsSuccessState(this.userShiftDetailsModel);
}

class UserShiftDetailsErrorState extends UserManagementState {
  final String error;
  UserShiftDetailsErrorState(this.error);
}

//*********************** */

class UserWorkLocationDetailsLoadingState extends UserManagementState {}

class UserWorkLocationDetailsSuccessState extends UserManagementState {
  final UserWorkLocationDetailsModel userWorkLocationDetailsModel;

  UserWorkLocationDetailsSuccessState(this.userWorkLocationDetailsModel);
}

class UserWorkLocationDetailsErrorState extends UserManagementState {
  final String error;
  UserWorkLocationDetailsErrorState(this.error);
}

//*********************** */

class UserTaskDetailsLoadingState extends UserManagementState {}

class UserTaskDetailsSuccessState extends UserManagementState {
  final UserTaskDetailsModel userTaskDetailsModel;

  UserTaskDetailsSuccessState(this.userTaskDetailsModel);
}

class UserTaskDetailsErrorState extends UserManagementState {
  final String error;
  UserTaskDetailsErrorState(this.error);
}
//****************** */

class UserDeleteInDetailsLoadingState extends UserManagementState {}

class UserDeleteInDetailsSuccessState extends UserManagementState {
  final DeleteUserModel deleteUserDetailsModel;

  UserDeleteInDetailsSuccessState(this.deleteUserDetailsModel);
}

class UserDeleteInDetailsErrorState extends UserManagementState {
  final String error;
  UserDeleteInDetailsErrorState(this.error);
}

//**************************** */
class GetNationalityLoadingState extends UserManagementState {}

class GetNationalitySuccessState extends UserManagementState {
  final NationalityModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends UserManagementState {
  final String error;
  GetNationalityErrorState(this.error);
}

//**************************** */

class RoleLoadingState extends UserManagementState {}

class RoleSuccessState extends UserManagementState {
  final RoleModel rolemodel;

  RoleSuccessState(this.rolemodel);
}

class RoleErrorState extends UserManagementState {
  final String error;
  RoleErrorState(this.error);
}

//**************************** */

class GetAreaLoadingState extends UserManagementState {}

class GetAreaSuccessState extends UserManagementState {
  final AreaModel areaModel;

  GetAreaSuccessState(this.areaModel);
}

class GetAreaErrorState extends UserManagementState {
  final String error;
  GetAreaErrorState(this.error);
}
//**************************** */

class GetCityLoadingState extends UserManagementState {}

class GetCitySuccessState extends UserManagementState {
  final CityModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends UserManagementState {
  final String error;
  GetCityErrorState(this.error);
}
class GetOrganizationLoadingState extends UserManagementState {}

class GetOrganizationSuccessState extends UserManagementState {
  final OrganizationModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends UserManagementState {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends UserManagementState {}

class GetBuildingSuccessState extends UserManagementState {
  final BuildingModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends UserManagementState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends UserManagementState {}

class GetFloorSuccessState extends UserManagementState {
  final FloorModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends UserManagementState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetPointsLoadingState extends UserManagementState {}

class GetPointsSuccessState extends UserManagementState {
  final PointsModel pointsModel;

  GetPointsSuccessState(this.pointsModel);
}

class GetPointsErrorState extends UserManagementState {
  final String error;
  GetPointsErrorState(this.error);
}


//********************** */
class HistoryLoadingState extends UserManagementState {}

class HistorySuccessState extends UserManagementState {
  final AttendanceHistoryModel attendanceHistoryModel;

  HistorySuccessState(this.attendanceHistoryModel);
}

class HistoryErrorState extends UserManagementState {
  final String error;
  HistoryErrorState(this.error);
}

//********************** */
class LeavesLoadingState extends UserManagementState {}

class LeavesSuccessState extends UserManagementState {
  final AttendanceLeavesModel attendanceLeavesModel;

  LeavesSuccessState(this.attendanceLeavesModel);
}

class LeavesErrorState extends UserManagementState {
  final String error;
  LeavesErrorState(this.error);
}