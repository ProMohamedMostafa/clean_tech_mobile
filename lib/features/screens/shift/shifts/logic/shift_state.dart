import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/points_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/all_shifts_deleted_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/all_shifts_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/shift_level_details_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/shift_users_details.dart';

abstract class ShiftState {}

class ShiftInitialState extends ShiftState {}

class ShiftLoadingState extends ShiftState {}

class ShiftSuccessState extends ShiftState {
  final AllShiftsModel allShiftsModel;
  ShiftSuccessState(this.allShiftsModel);
}

class ShiftErrorState extends ShiftState {
  final String error;
  ShiftErrorState(this.error);
}

//******************** */
class ShiftDetailsLoadingState extends ShiftState {}

class ShiftDetailsSuccessState extends ShiftState {
  final ShiftDetailsModel shiftDetailsModel;
  ShiftDetailsSuccessState(this.shiftDetailsModel);
}

class ShiftDetailsErrorState extends ShiftState {
  final String error;
  ShiftDetailsErrorState(this.error);
}

//******************** */
class ShiftUsersDetailsLoadingState extends ShiftState {}

class ShiftUsersDetailsSuccessState extends ShiftState {
  final ShiftUsersModel shiftUsersModel;
  ShiftUsersDetailsSuccessState(this.shiftUsersModel);
}

class ShiftUsersDetailsErrorState extends ShiftState {
  final String error;
  ShiftUsersDetailsErrorState(this.error);
}

//******************** */
class ShiftDeleteLoadingState extends ShiftState {}

class ShiftDeleteSuccessState extends ShiftState {
  final String message;
  ShiftDeleteSuccessState(this.message);
}

class ShiftDeleteErrorState extends ShiftState {
  final String error;
  ShiftDeleteErrorState(this.error);
}

//******************** */
class AllShiftDeleteLoadingState extends ShiftState {}

class AllShiftDeleteSuccessState extends ShiftState {
  final AllShiftsDeletedModel allShiftsDeletedModel;
  AllShiftDeleteSuccessState(this.allShiftsDeletedModel);
}

class AllShiftDeleteErrorState extends ShiftState {
  final String error;
  AllShiftDeleteErrorState(this.error);
}

//******************** */
class RestoreShiftLoadingState extends ShiftState {}

class RestoreShiftSuccessState extends ShiftState {
  final String message;
  RestoreShiftSuccessState(this.message);
}

class RestoreShiftErrorState extends ShiftState {
  final String error;
  RestoreShiftErrorState(this.error);
}

//******************** */
class ForceDeleteShiftLoadingState extends ShiftState {}

class ForceDeleteShiftSuccessState extends ShiftState {
  final String message;
  ForceDeleteShiftSuccessState(this.message);
}

class ForceDeleteShiftErrorState extends ShiftState {
  final String error;
  ForceDeleteShiftErrorState(this.error);
}

//******************** */
class ShiftLevelDetailsLoadingState extends ShiftState {}

class ShiftLevelDetailsSuccessState extends ShiftState {
  final ShiftLevelDetailsModel shiftLevelDetailsModel;
  ShiftLevelDetailsSuccessState(this.shiftLevelDetailsModel);
}

class ShiftLevelDetailsErrorState extends ShiftState {
  final String error;
  ShiftLevelDetailsErrorState(this.error);
}
//**************************** */

class GetAreaLoadingState extends ShiftState {}

class GetAreaSuccessState extends ShiftState {
  final AllAreaModel allAreaModel;

  GetAreaSuccessState(this.allAreaModel);
}

class GetAreaErrorState extends ShiftState {
  final String error;
  GetAreaErrorState(this.error);
}
//**************************** */

class GetCityLoadingState extends ShiftState {}

class GetCitySuccessState extends ShiftState {
  final CityModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends ShiftState {
  final String error;
  GetCityErrorState(this.error);
}
//**************************** */

class GetOrganizationLoadingState extends ShiftState {}

class GetOrganizationSuccessState extends ShiftState {
  final OrganizationModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends ShiftState {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends ShiftState {}

class GetBuildingSuccessState extends ShiftState {
  final BuildingModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends ShiftState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends ShiftState {}

class GetFloorSuccessState extends ShiftState {
  final FloorModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends ShiftState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetPointLoadingState extends ShiftState {}

class GetPointSuccessState extends ShiftState {
  final PointsModel pointsModel;

  GetPointSuccessState(this.pointsModel);
}

class GetPointErrorState extends ShiftState {
  final String error;
  GetPointErrorState(this.error);
}