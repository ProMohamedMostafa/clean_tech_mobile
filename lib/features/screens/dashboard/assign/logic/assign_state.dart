import 'package:smart_cleaning_application/features/screens/dashboard/assign/data/assign_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/assign/data/user_shift_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/role_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/point_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/section_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/data/models/area_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/data/models/building_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/data/models/city_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/data/models/floor_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/data/models/organization_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/data/models/point_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/data/models/section_users_shifts_details_model.dart';

abstract class AssignStates {}

class AssignInitialState extends AssignStates {}

class AssignLoadingState extends AssignStates {}

class AssignSuccessState extends AssignStates {
  final AssignModel assignModel;
  AssignSuccessState(this.assignModel);
}

class AssignErrorState extends AssignStates {
  final String error;
  AssignErrorState(this.error);
}

//**************************** */

class ShiftLoadingState extends AssignStates {}

class ShiftSuccessState extends AssignStates {
  final ShiftModel allShiftsModel;
  ShiftSuccessState(this.allShiftsModel);
}

class ShiftErrorState extends AssignStates {
  final String error;
  ShiftErrorState(this.error);
}
//**************************** */

class RoleLoadingState extends AssignStates {}

class RoleSuccessState extends AssignStates {
  final RoleModel rolemodel;

  RoleSuccessState(this.rolemodel);
}

class RoleErrorState extends AssignStates {
  final String error;
  RoleErrorState(this.error);
}

//***************** */

class AllUsersLoadingState extends AssignStates {}

class AllUsersSuccessState extends AssignStates {
  final UsersModel usersModel;

  AllUsersSuccessState(this.usersModel);
}

class AllUsersErrorState extends AssignStates {
  final String error;
  AllUsersErrorState(this.error);
}

//***************** */

class UserShiftLoadingState extends AssignStates {}

class UserShiftSuccessState extends AssignStates {
  final UserShiftModel userShiftModel;

  UserShiftSuccessState(this.userShiftModel);
}

class UserShiftErrorState extends AssignStates {
  final String error;
  UserShiftErrorState(this.error);
}

//**************************** */

class GetAreaLoadingState extends AssignStates {}

class GetAreaSuccessState extends AssignStates {
  final AreaListModel areaListModel;

  GetAreaSuccessState(this.areaListModel);
}

class GetAreaErrorState extends AssignStates {
  final String error;
  GetAreaErrorState(this.error);
}
//**************************** */

class GetCityLoadingState extends AssignStates {}

class GetCitySuccessState extends AssignStates {
  final CityListModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends AssignStates {
  final String error;
  GetCityErrorState(this.error);
}
//**************************** */

class GetOrganizationLoadingState extends AssignStates {}

class GetOrganizationSuccessState extends AssignStates {
  final OrganizationListModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends AssignStates {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends AssignStates {}

class GetBuildingSuccessState extends AssignStates {
  final BuildingListModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends AssignStates {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends AssignStates {}

class GetFloorSuccessState extends AssignStates {
  final FloorListModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends AssignStates {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetSectionLoadingState extends AssignStates {}

class GetSectionSuccessState extends AssignStates {
  final SectionListModel sectionModel;

  GetSectionSuccessState(this.sectionModel);
}

class GetSectionErrorState extends AssignStates {
  final String error;
  GetSectionErrorState(this.error);
}
//**************************** */

class GetPointLoadingState extends AssignStates {}

class GetPointSuccessState extends AssignStates {
  final PointListModel pointsModel;

  GetPointSuccessState(this.pointsModel);
}

class GetPointErrorState extends AssignStates {
  final String error;
  GetPointErrorState(this.error);
}
//******************************** */

class AllOrganizationLoadingState extends AssignStates {}

class AllOrganizationSuccessState extends AssignStates {
  final OrganizationListModel organizationListModel;

  AllOrganizationSuccessState(this.organizationListModel);
}

class AllOrganizationErrorState extends AssignStates {
  final String error;
  AllOrganizationErrorState(this.error);
}

//******************************** */
class AreaEmployeesDetailsLoadingState extends AssignStates {}

class AreaEmployeesDetailsSuccessState extends AssignStates {
  final AreaUsersDetailsModel areaUsersDetailsModel;

  AreaEmployeesDetailsSuccessState(this.areaUsersDetailsModel);
}

class AreaEmployeesDetailsErrorState extends AssignStates {
  final String error;
  AreaEmployeesDetailsErrorState(this.error);
}

//**************************** */
class CityEmployeesDetailsLoadingState extends AssignStates {}

class CityEmployeesDetailsSuccessState extends AssignStates {
  final CityUsersDetailsModel cityUsersDetailsModel;

  CityEmployeesDetailsSuccessState(this.cityUsersDetailsModel);
}

class CityEmployeesDetailsErrorState extends AssignStates {
  final String error;
  CityEmployeesDetailsErrorState(this.error);
}
//**************************** */

class OrganizationEmployeesDetailsLoadingState extends AssignStates {}

class OrganizationEmployeesDetailsSuccessState extends AssignStates {
  final OrganizationUsersShiftsDetailsModel organizationEmployeesDetailsModel;

  OrganizationEmployeesDetailsSuccessState(
      this.organizationEmployeesDetailsModel);
}

class OrganizationEmployeesDetailsErrorState extends AssignStates {
  final String error;
  OrganizationEmployeesDetailsErrorState(this.error);
}

//********************************* */
class BuildingEmployeesDetailsLoadingState extends AssignStates {}

class BuildingEmployeesDetailsSuccessState extends AssignStates {
  final BuildingUsersShiftsDetailsModel buildingUsersShiftsDetailsModel;

  BuildingEmployeesDetailsSuccessState(this.buildingUsersShiftsDetailsModel);
}

class BuildingEmployeesDetailsErrorState extends AssignStates {
  final String error;
  BuildingEmployeesDetailsErrorState(this.error);
}

//********************************* */
class FloorEmployeesDetailsLoadingState extends AssignStates {}

class FloorEmployeesDetailsSuccessState extends AssignStates {
  final FloorUsersShiftsDetailsModel floorUsersShiftsDetailsModel;

  FloorEmployeesDetailsSuccessState(this.floorUsersShiftsDetailsModel);
}

class FloorEmployeesDetailsErrorState extends AssignStates {
  final String error;
  FloorEmployeesDetailsErrorState(this.error);
}

//********************************* */
class SectionEmployeesDetailsLoadingState extends AssignStates {}

class SectionEmployeesDetailsSuccessState extends AssignStates {
  final SectionUsersShiftsDetailsModel sectionUsersDetailsModel;

  SectionEmployeesDetailsSuccessState(this.sectionUsersDetailsModel);
}

class SectionEmployeesDetailsErrorState extends AssignStates {
  final String error;
  SectionEmployeesDetailsErrorState(this.error);
}

//********************************* */
class PointEmployeesDetailsLoadingState extends AssignStates {}

class PointEmployeesDetailsSuccessState extends AssignStates {
  final PointUsersDetailsModel pointUsersDetailsModel;

  PointEmployeesDetailsSuccessState(this.pointUsersDetailsModel);
}

class PointEmployeesDetailsErrorState extends AssignStates {
  final String error;
  PointEmployeesDetailsErrorState(this.error);
}

//******************************** */

class AreaUsersDetailsLoadingState extends AssignStates {}

class AreaUsersDetailsSuccessState extends AssignStates {
  final AreaUsersDetailsModel areaUsersDetailsModel;

  AreaUsersDetailsSuccessState(this.areaUsersDetailsModel);
}

class AreaUsersDetailsErrorState extends AssignStates {
  final String error;
  AreaUsersDetailsErrorState(this.error);
}
//********************************* */
class CityUsersDetailsLoadingState extends AssignStates {}

class CityUsersDetailsSuccessState extends AssignStates {
  final CityUsersDetailsModel cityUsersDetailsModel;

  CityUsersDetailsSuccessState(this.cityUsersDetailsModel);
}

class CityUsersDetailsErrorState extends AssignStates {
  final String error;
  CityUsersDetailsErrorState(this.error);
}
//********************************* */
class PointUsersDetailsLoadingState extends AssignStates {}

class PointUsersDetailsSuccessState extends AssignStates {
  final PointUsersDetailsModel pointUsersDetailsModel;

  PointUsersDetailsSuccessState(this.pointUsersDetailsModel);
}

class PointUsersDetailsErrorState extends AssignStates {
  final String error;
  PointUsersDetailsErrorState(this.error);
}
//**************************** */

class ControllersClearedState extends AssignStates {}

class LevelChanged extends AssignStates {}

class UpdateUsersDropdownState extends AssignStates {}
