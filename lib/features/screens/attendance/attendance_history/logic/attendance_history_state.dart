import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/section_model.dart';

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
//**************************** */

class RoleLoadingState extends AttendanceHistoryState {}

class RoleSuccessState extends AttendanceHistoryState {
  final RoleModel rolemodel;

  RoleSuccessState(this.rolemodel);
}

class RoleErrorState extends AttendanceHistoryState {
  final String error;
  RoleErrorState(this.error);
}

//**************************** */

class ShiftLoadingState extends AttendanceHistoryState {}

class ShiftSuccessState extends AttendanceHistoryState {
  final ShiftModel shiftModel;
  ShiftSuccessState(this.shiftModel);
}

class ShiftErrorState extends AttendanceHistoryState {
  final String error;
  ShiftErrorState(this.error);
}
//*************************************** */

class AllProvidersLoadingState extends AttendanceHistoryState {}

class AllProvidersSuccessState extends AttendanceHistoryState {
  final ProvidersModel providersModel;

  AllProvidersSuccessState(this.providersModel);
}

class AllProvidersErrorState extends AttendanceHistoryState {
  final String error;
  AllProvidersErrorState(this.error);
}

//********************************* */

class GetAreaLoadingState extends AttendanceHistoryState {}

class GetAreaSuccessState extends AttendanceHistoryState {
  final AllAreaModel? allAreaModel;

  GetAreaSuccessState(this.allAreaModel);
}

class GetAreaErrorState extends AttendanceHistoryState {
  final String error;
  GetAreaErrorState(this.error);
}
//**************************** */

class GetCityLoadingState extends AttendanceHistoryState {}

class GetCitySuccessState extends AttendanceHistoryState {
  final CityListModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends AttendanceHistoryState {
  final String error;
  GetCityErrorState(this.error);
}

class GetOrganizationLoadingState extends AttendanceHistoryState {}

class GetOrganizationSuccessState extends AttendanceHistoryState {
  final OrganizationListModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends AttendanceHistoryState {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends AttendanceHistoryState {}

class GetBuildingSuccessState extends AttendanceHistoryState {
  final BuildingListModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends AttendanceHistoryState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends AttendanceHistoryState {}

class GetFloorSuccessState extends AttendanceHistoryState {
  final FloorListModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends AttendanceHistoryState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetSectionLoadingState extends AttendanceHistoryState {}

class GetSectionSuccessState extends AttendanceHistoryState {
  final SectionListModel sectionModel;

  GetSectionSuccessState(this.sectionModel);
}

class GetSectionErrorState extends AttendanceHistoryState {
  final String error;
  GetSectionErrorState(this.error);
}
//**************************** */

class GetPointLoadingState extends AttendanceHistoryState {}

class GetPointSuccessState extends AttendanceHistoryState {
  final PointListModel pointsModel;

  GetPointSuccessState(this.pointsModel);
}

class GetPointErrorState extends AttendanceHistoryState {
  final String error;
  GetPointErrorState(this.error);
}
//***************** */

class AllUsersLoadingState extends AttendanceHistoryState {}

class AllUsersSuccessState extends AttendanceHistoryState {
  final UsersModel usersModel;

  AllUsersSuccessState(this.usersModel);
}

class AllUsersErrorState extends AttendanceHistoryState {
  final String error;
  AllUsersErrorState(this.error);
}
