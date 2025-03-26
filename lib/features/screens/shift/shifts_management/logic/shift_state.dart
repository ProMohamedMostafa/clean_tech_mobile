import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_area_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/data/models/shift_building_details.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/data/models/shift_floor_details.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/data/models/shift_organization_details.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/data/models/shift_section_details.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/all_shifts_deleted_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/all_shifts_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/shift_users_details.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/section_model.dart';

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
class ShiftOrganizationDetailsLoadingState extends ShiftState {}

class ShiftOrganizationDetailsSuccessState extends ShiftState {
  final ShiftOrganizationDetailsModel shiftOrganizationDetailsModel;
  ShiftOrganizationDetailsSuccessState(this.shiftOrganizationDetailsModel);
}

class ShiftOrganizationDetailsErrorState extends ShiftState {
  final String error;
  ShiftOrganizationDetailsErrorState(this.error);
} //******************** */

class ShiftBuildingDetailsLoadingState extends ShiftState {}

class ShiftBuildingDetailsSuccessState extends ShiftState {
  final ShiftBuildingsDetailsModel shiftBuildingsDetailsModel;
  ShiftBuildingDetailsSuccessState(this.shiftBuildingsDetailsModel);
}

class ShiftBuildingDetailsErrorState extends ShiftState {
  final String error;
  ShiftBuildingDetailsErrorState(this.error);
} //******************** */

class ShiftFloorDetailsLoadingState extends ShiftState {}

class ShiftFloorDetailsSuccessState extends ShiftState {
  final ShiftFloorDetailsModel shiftFloorDetailsModel;
  ShiftFloorDetailsSuccessState(this.shiftFloorDetailsModel);
}

class ShiftFloorDetailsErrorState extends ShiftState {
  final String error;
  ShiftFloorDetailsErrorState(this.error);
} //******************** */

class ShiftSectionDetailsLoadingState extends ShiftState {}

class ShiftSectionDetailsSuccessState extends ShiftState {
  final ShiftSectionDetailsModel shiftSectionDetailsModel;
  ShiftSectionDetailsSuccessState(this.shiftSectionDetailsModel);
}

class ShiftSectionDetailsErrorState extends ShiftState {
  final String error;
  ShiftSectionDetailsErrorState(this.error);
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
  final CityListModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends ShiftState {
  final String error;
  GetCityErrorState(this.error);
}
//**************************** */

class GetOrganizationLoadingState extends ShiftState {}

class GetOrganizationSuccessState extends ShiftState {
  final OrganizationListModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends ShiftState {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends ShiftState {}

class GetBuildingSuccessState extends ShiftState {
  final BuildingListModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends ShiftState {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends ShiftState {}

class GetFloorSuccessState extends ShiftState {
  final FloorListModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends ShiftState {
  final String error;
  GetFloorErrorState(this.error);
} //**************************** */

class GetSectionLoadingState extends ShiftState {}

class GetSectionSuccessState extends ShiftState {
  final SectionListModel sectionsModel;

  GetSectionSuccessState(this.sectionsModel);
}

class GetSectionErrorState extends ShiftState {
  final String error;
  GetSectionErrorState(this.error);
}
//**************************** */

class GetPointLoadingState extends ShiftState {}

class GetPointSuccessState extends ShiftState {
  final PointListModel pointsModel;

  GetPointSuccessState(this.pointsModel);
}

class GetPointErrorState extends ShiftState {
  final String error;
  GetPointErrorState(this.error);
}
//*************************************** */

class AllProvidersLoadingState extends ShiftState {}

class AllProvidersSuccessState extends ShiftState {
  final ProvidersModel providersModel;

  AllProvidersSuccessState(this.providersModel);
}

class AllProvidersErrorState extends ShiftState {
  final String error;
  AllProvidersErrorState(this.error);
}
