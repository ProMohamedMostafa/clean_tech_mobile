import 'package:smart_cleaning_application/features/screens/assign/data/assign_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/all_shifts_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/point_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/section_list_model.dart';

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
  final AllShiftsModel allShiftsModel;
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
//**************************** */

class AssignClearState extends AssignStates {}
class UsersClearedState extends AssignStates {}
class LevelChanged extends AssignStates {}
class UpdateUsersDropdownState extends AssignStates {}
