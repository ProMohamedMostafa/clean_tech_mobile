import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/settings/data/model/profile_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/all_shifts_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/data/models/user_shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/data/models/user_status_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/data/models/user_task_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/data/models/user_work_location_details.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/point_list_model.dart';

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
  final UserTaskDetailsModel userTaskDetailsModel;

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

//********************************* */

class GetAllAreaLoadingState extends ProfileState {}

class GetAllAreaSuccessState extends ProfileState {
  final AreaListModel areaListModel;

  GetAllAreaSuccessState(this.areaListModel);
}

class GetAllAreaErrorState extends ProfileState {
  final String error;
  GetAllAreaErrorState(this.error);
}

//***************************** */
class ShiftLoadingState extends ProfileState {}

class ShiftSuccessState extends ProfileState {
  final ShiftModel shiftModel;
  ShiftSuccessState(this.shiftModel);
}

class ShiftErrorState extends ProfileState {
  final String error;
  ShiftErrorState(this.error);
}
//********************************* */


class UserStatusLoadingState extends ProfileState {}

class UserStatusSuccessState extends ProfileState {
  final UserStatusModel userStatusModel;

  UserStatusSuccessState(this.userStatusModel);
}

class UserStatusErrorState extends ProfileState {
  final String error;
  UserStatusErrorState(this.error);
}

//***************************** */
class ShiftAllLoadingState extends ProfileState {}

class ShiftAllSuccessState extends ProfileState {
  final AllShiftsModel allShiftsModel;
  ShiftAllSuccessState(this.allShiftsModel);
}

class ShiftAllErrorState extends ProfileState {
  final String error;
  ShiftAllErrorState(this.error);
}

//**************************** */

class RoleLoadingState extends ProfileState {}

class RoleSuccessState extends ProfileState {
  final RoleModel rolemodel;

  RoleSuccessState(this.rolemodel);
}

class RoleErrorState extends ProfileState {
  final String error;
  RoleErrorState(this.error);
}
//**************************** */

class GetAreaLoadingState extends ProfileState {}

class GetAreaSuccessState extends ProfileState {
  final AreaListModel areaModel;

  GetAreaSuccessState(this.areaModel);
}

class GetAreaErrorState extends ProfileState {
  final String error;
  GetAreaErrorState(this.error);
}
//**************************** */

class GetCityLoadingState extends ProfileState {}

class GetCitySuccessState extends ProfileState {
  final CityListModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends ProfileState {
  final String error;
  GetCityErrorState(this.error);
}
class GetOrganizationLoadingState extends ProfileState {}

class GetOrganizationSuccessState extends ProfileState {
  final OrganizationListModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends ProfileState {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends ProfileState {}

class GetBuildingSuccessState extends ProfileState {
  final BuildingListModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends ProfileState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends ProfileState {}

class GetFloorSuccessState extends ProfileState {
  final FloorListModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends ProfileState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetPointsLoadingState extends ProfileState {}

class GetPointsSuccessState extends ProfileState {
  final PointListModel pointsModel;

  GetPointsSuccessState(this.pointsModel);
}

class GetPointsErrorState extends ProfileState {
  final String error;
  GetPointsErrorState(this.error);
}
//*************************************** */

class AllProvidersLoadingState extends ProfileState {}

class AllProvidersSuccessState extends ProfileState {
  final ProvidersModel providersModel;

  AllProvidersSuccessState(this.providersModel);
}

class AllProvidersErrorState extends ProfileState {
  final String error;
  AllProvidersErrorState(this.error);
}

//***************** */

class AllUsersLoadingState extends ProfileState {}

class AllUsersSuccessState extends ProfileState {
  final UsersModel usersModel;

  AllUsersSuccessState(this.usersModel);
}

class AllUsersErrorState extends ProfileState {
  final String error;
  AllUsersErrorState(this.error);
}