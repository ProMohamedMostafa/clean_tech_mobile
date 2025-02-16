import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/points_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';

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

class GetAllAreaLoadingState extends AttendanceHistoryState {}

class GetAllAreaSuccessState extends AttendanceHistoryState {
  final AllAreaModel allAreaModel;

  GetAllAreaSuccessState(this.allAreaModel);
}

class GetAllAreaErrorState extends AttendanceHistoryState {
  final String error;
  GetAllAreaErrorState(this.error);
}

//**************************** */

class GetCityLoadingState extends AttendanceHistoryState {}

class GetCitySuccessState extends AttendanceHistoryState {
  final CityModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends AttendanceHistoryState {
  final String error;
  GetCityErrorState(this.error);
}

class GetOrganizationLoadingState extends AttendanceHistoryState {}

class GetOrganizationSuccessState extends AttendanceHistoryState {
  final OrganizationModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends AttendanceHistoryState {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends AttendanceHistoryState {}

class GetBuildingSuccessState extends AttendanceHistoryState {
  final BuildingModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends AttendanceHistoryState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends AttendanceHistoryState {}

class GetFloorSuccessState extends AttendanceHistoryState {
  final FloorModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends AttendanceHistoryState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetPointsLoadingState extends AttendanceHistoryState {}

class GetPointsSuccessState extends AttendanceHistoryState {
  final PointsModel pointsModel;

  GetPointsSuccessState(this.pointsModel);
}

class GetPointsErrorState extends AttendanceHistoryState {
  final String error;
  GetPointsErrorState(this.error);
}
