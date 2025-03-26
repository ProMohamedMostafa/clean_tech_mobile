import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_edit/data/models/leaves_details_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/section_model.dart';

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

//*************************************** */

class AllProvidersLoadingState extends AttendanceLeavesState {}

class AllProvidersSuccessState extends AttendanceLeavesState {
  final ProvidersModel providersModel;

  AllProvidersSuccessState(this.providersModel);
}

class AllProvidersErrorState extends AttendanceLeavesState {
  final String error;
  AllProvidersErrorState(this.error);
}

//********************************* */

class GetAreaLoadingState extends AttendanceLeavesState {}

class GetAreaSuccessState extends AttendanceLeavesState {
  final AllAreaModel? allAreaModel;

  GetAreaSuccessState(this.allAreaModel);
}

class GetAreaErrorState extends AttendanceLeavesState {
  final String error;
  GetAreaErrorState(this.error);
}
//**************************** */

class GetCityLoadingState extends AttendanceLeavesState {}

class GetCitySuccessState extends AttendanceLeavesState {
  final CityListModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends AttendanceLeavesState {
  final String error;
  GetCityErrorState(this.error);
}

class GetOrganizationLoadingState extends AttendanceLeavesState {}

class GetOrganizationSuccessState extends AttendanceLeavesState {
  final OrganizationListModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends AttendanceLeavesState {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends AttendanceLeavesState {}

class GetBuildingSuccessState extends AttendanceLeavesState {
  final BuildingListModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends AttendanceLeavesState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends AttendanceLeavesState {}

class GetFloorSuccessState extends AttendanceLeavesState {
  final FloorListModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends AttendanceLeavesState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetSectionLoadingState extends AttendanceLeavesState {}

class GetSectionSuccessState extends AttendanceLeavesState {
  final SectionListModel sectionModel;

  GetSectionSuccessState(this.sectionModel);
}

class GetSectionErrorState extends AttendanceLeavesState {
  final String error;
  GetSectionErrorState(this.error);
}
//**************************** */

class GetPointLoadingState extends AttendanceLeavesState {}

class GetPointSuccessState extends AttendanceLeavesState {
  final PointListModel pointsModel;

  GetPointSuccessState(this.pointsModel);
}

class GetPointErrorState extends AttendanceLeavesState {
  final String error;
  GetPointErrorState(this.error);
}
//***************** */

class AllUsersLoadingState extends AttendanceLeavesState {}

class AllUsersSuccessState extends AttendanceLeavesState {
  final UsersModel usersModel;

  AllUsersSuccessState(this.usersModel);
}

class AllUsersErrorState extends AttendanceLeavesState {
  final String error;
  AllUsersErrorState(this.error);
}
