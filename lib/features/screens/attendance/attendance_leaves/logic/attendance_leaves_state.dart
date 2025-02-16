import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_edit/data/models/leaves_details_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/points_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';

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


class GetAllAreaLoadingState extends AttendanceLeavesState {}

class GetAllAreaSuccessState extends AttendanceLeavesState {
  final AllAreaModel allAreaModel;

  GetAllAreaSuccessState(this.allAreaModel);
}

class GetAllAreaErrorState extends AttendanceLeavesState {
  final String error;
  GetAllAreaErrorState(this.error);
}

//**************************** */

class GetCityLoadingState extends AttendanceLeavesState {}

class GetCitySuccessState extends AttendanceLeavesState {
  final CityModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends AttendanceLeavesState {
  final String error;
  GetCityErrorState(this.error);
}
class GetOrganizationLoadingState extends AttendanceLeavesState {}

class GetOrganizationSuccessState extends AttendanceLeavesState {
  final OrganizationModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends AttendanceLeavesState {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends AttendanceLeavesState {}

class GetBuildingSuccessState extends AttendanceLeavesState {
  final BuildingModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends AttendanceLeavesState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends AttendanceLeavesState {}

class GetFloorSuccessState extends AttendanceLeavesState {
  final FloorModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends AttendanceLeavesState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetPointsLoadingState extends AttendanceLeavesState {}

class GetPointsSuccessState extends AttendanceLeavesState {
  final PointsModel pointsModel;

  GetPointsSuccessState(this.pointsModel);
}

class GetPointsErrorState extends AttendanceLeavesState {
  final String error;
  GetPointsErrorState(this.error);
}