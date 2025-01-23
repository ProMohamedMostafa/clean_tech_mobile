import 'package:smart_cleaning_application/features/screens/assign/data/assign_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_user_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';

import '../../integrations/data/models/building_model.dart';
import '../../integrations/data/models/city_model.dart';
import '../../integrations/data/models/floor_model.dart';
import '../../integrations/data/models/points_model.dart';

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
  final ShiftModel shiftModel;
  ShiftSuccessState(this.shiftModel);
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

//**************************** */

class RoleUserLoadingState extends AssignStates {}

class RoleUserSuccessState extends AssignStates {
  final RoleUserModel roleUsermodel;

  RoleUserSuccessState(this.roleUsermodel);
}

class RoleUserErrorState extends AssignStates {
  final String error;
  RoleUserErrorState(this.error);
}

//**************************************** */
class GetAreaLoadingState extends AssignStates {}

class GetAreaSuccessState extends AssignStates {
  final AreaModel areaModel;

  GetAreaSuccessState(this.areaModel);
}

class GetAreaErrorState extends AssignStates {
  final String error;
  GetAreaErrorState(this.error);
}
//**************************** */

class GetCityLoadingState extends AssignStates {}

class GetCitySuccessState extends AssignStates {
  final CityModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends AssignStates {
  final String error;
  GetCityErrorState(this.error);
}
//**************************** */

class GetOrganizationLoadingState extends AssignStates {}

class GetOrganizationSuccessState extends AssignStates {
  final OrganizationModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends AssignStates {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends AssignStates {}

class GetBuildingSuccessState extends AssignStates {
  final BuildingModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends AssignStates {
  final String error;
  GetBuildingErrorState(this.error);
}
//**************************** */

class GetFloorLoadingState extends AssignStates {}

class GetFloorSuccessState extends AssignStates {
  final FloorModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends AssignStates {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetPointLoadingState extends AssignStates {}

class GetPointSuccessState extends AssignStates {
  final PointsModel pointsModel;

  GetPointSuccessState(this.pointsModel);
}

class GetPointErrorState extends AssignStates {
  final String error;
  GetPointErrorState(this.error);
}
