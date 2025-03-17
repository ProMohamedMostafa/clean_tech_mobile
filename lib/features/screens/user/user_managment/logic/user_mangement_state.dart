import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/delete_user_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/deleted_list_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_status_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_task_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_work_location_details.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/section_model.dart';

import '../../../integrations/data/models/nationality_model.dart';
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
  final AreaListModel areaModel;

  GetAreaSuccessState(this.areaModel);
}

class GetAreaErrorState extends UserManagementState {
  final String error;
  GetAreaErrorState(this.error);
}
//**************************** */

class GetCityLoadingState extends UserManagementState {}

class GetCitySuccessState extends UserManagementState {
  final CityListModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends UserManagementState {
  final String error;
  GetCityErrorState(this.error);
}
class GetOrganizationLoadingState extends UserManagementState {}

class GetOrganizationSuccessState extends UserManagementState {
  final OrganizationListModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends UserManagementState {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends UserManagementState {}

class GetBuildingSuccessState extends UserManagementState {
  final BuildingListModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends UserManagementState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends UserManagementState {}

class GetFloorSuccessState extends UserManagementState {
  final FloorListModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends UserManagementState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetSectionLoadingState extends UserManagementState {}

class GetSectionSuccessState extends UserManagementState {
  final SectionListModel sectionModel;

  GetSectionSuccessState(this.sectionModel);
}

class GetSectionErrorState extends UserManagementState {
  final String error;
  GetSectionErrorState(this.error);
}
//**************************** */

class GetPointLoadingState extends UserManagementState {}

class GetPointSuccessState extends UserManagementState {
  final PointListModel pointsModel;

  GetPointSuccessState(this.pointsModel);
}

class GetPointErrorState extends UserManagementState {
  final String error;
  GetPointErrorState(this.error);
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

//********************************* */


class GetAllAreaLoadingState extends UserManagementState {}

class GetAllAreaSuccessState extends UserManagementState {
  final AllAreaModel allAreaModel;

  GetAllAreaSuccessState(this.allAreaModel);
}

class GetAllAreaErrorState extends UserManagementState {
  final String error;
  GetAllAreaErrorState(this.error);
}



//********************************* */


class UserStatusLoadingState extends UserManagementState {}

class UserStatusSuccessState extends UserManagementState {
  final UserStatusModel userStatusModel;

  UserStatusSuccessState(this.userStatusModel);
}

class UserStatusErrorState extends UserManagementState {
  final String error;
  UserStatusErrorState(this.error);
}

//*************************************** */

class AllProvidersLoadingState extends UserManagementState {}

class AllProvidersSuccessState extends UserManagementState {
  final ProvidersModel providersModel;

  AllProvidersSuccessState(this.providersModel);
}

class AllProvidersErrorState extends UserManagementState {
  final String error;
  AllProvidersErrorState(this.error);
}

//**************************** */

class ShiftLoadingState extends UserManagementState {}

class ShiftSuccessState extends UserManagementState {
  final ShiftModel shiftModel;
  ShiftSuccessState(this.shiftModel);
}

class ShiftErrorState extends UserManagementState {
  final String error;
  ShiftErrorState(this.error);
}

