import 'package:smart_cleaning_application/features/screens/organization/delete_organizations/data/model/deleted_area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/delete_organizations/data/model/deleted_building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/delete_organizations/data/model/deleted_city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/delete_organizations/data/model/deleted_floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/delete_organizations/data/model/deleted_organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/delete_organizations/data/model/deleted_point_list_model.dart';

abstract class DeleteOrganizationsState {}

class DeleteOrganizationsInitialState extends DeleteOrganizationsState {}

class DeleteOrganizationsLoadingState extends DeleteOrganizationsState {}

class DeleteOrganizationsSuccessState extends DeleteOrganizationsState {
  final String message;
  DeleteOrganizationsSuccessState(this.message);
}

class DeleteOrganizationsErrorState extends DeleteOrganizationsState {
  final String error;
  DeleteOrganizationsErrorState(this.error);
}

//******************************** */

class DeletedAreaLoadingState extends DeleteOrganizationsState {}

class DeletedAreaSuccessState extends DeleteOrganizationsState {
  final DeletedAreaList deletedAreaList;

  DeletedAreaSuccessState(this.deletedAreaList);
}

class DeletedAreaErrorState extends DeleteOrganizationsState {
  final String error;
  DeletedAreaErrorState(this.error);
}

//******************************** */

class DeletedCityLoadingState extends DeleteOrganizationsState {}

class DeletedCitySuccessState extends DeleteOrganizationsState {
  final DeletedCityList deletedCityList;

  DeletedCitySuccessState(this.deletedCityList);
}

class DeletedCityErrorState extends DeleteOrganizationsState {
  final String error;
  DeletedCityErrorState(this.error);
}

//******************************** */

class DeletedOrganizationLoadingState extends DeleteOrganizationsState {}

class DeletedOrganizationSuccessState extends DeleteOrganizationsState {
  final DeletedOrganizationList deletedOrganizationList;

  DeletedOrganizationSuccessState(this.deletedOrganizationList);
}

class DeletedOrganizationErrorState extends DeleteOrganizationsState {
  final String error;
  DeletedOrganizationErrorState(this.error);
}

//******************************** */

class DeletedBuildingLoadingState extends DeleteOrganizationsState {}

class DeletedBuildingSuccessState extends DeleteOrganizationsState {
  final DeletedBuildingList deletedBuildingList;

  DeletedBuildingSuccessState(this.deletedBuildingList);
}

class DeletedBuildingErrorState extends DeleteOrganizationsState {
  final String error;
  DeletedBuildingErrorState(this.error);
}

//******************************** */

class DeletedFloorLoadingState extends DeleteOrganizationsState {}

class DeletedFloorSuccessState extends DeleteOrganizationsState {
  final DeletedFloorList deletedFloorList;

  DeletedFloorSuccessState(this.deletedFloorList);
}

class DeletedFloorErrorState extends DeleteOrganizationsState {
  final String error;
  DeletedFloorErrorState(this.error);
}

//******************************** */

class DeletedPointLoadingState extends DeleteOrganizationsState {}

class DeletedPointSuccessState extends DeleteOrganizationsState {
  final DeletedPointList deletedPointList;

  DeletedPointSuccessState(this.deletedPointList);
}

class DeletedPointErrorState extends DeleteOrganizationsState {
  final String error;
  DeletedPointErrorState(this.error);
}


//******************************** */

class DeleteRestoreAreaLoadingState extends DeleteOrganizationsState {}

class DeleteRestoreAreaSuccessState extends DeleteOrganizationsState {
  final String message;
  DeleteRestoreAreaSuccessState(this.message);
}

class DeleteRestoreAreaErrorState extends DeleteOrganizationsState {
  final String error;
  DeleteRestoreAreaErrorState(this.error);
}

//******************************** */
class DeleteRestoreCityLoadingState extends DeleteOrganizationsState {}

class DeleteRestoreCitySuccessState extends DeleteOrganizationsState {
  final String message;
  DeleteRestoreCitySuccessState(this.message);
}

class DeleteRestoreCityErrorState extends DeleteOrganizationsState {
  final String error;
  DeleteRestoreCityErrorState(this.error);
}

//******************************** */
class DeleteRestoreOrganizationLoadingState extends DeleteOrganizationsState {}

class DeleteRestoreOrganizationSuccessState extends DeleteOrganizationsState {
  final String message;
  DeleteRestoreOrganizationSuccessState(this.message);
}

class DeleteRestoreOrganizationErrorState extends DeleteOrganizationsState {
  final String error;
  DeleteRestoreOrganizationErrorState(this.error);
}

//******************************** */
class DeleteRestoreBuildingLoadingState extends DeleteOrganizationsState {}

class DeleteRestoreBuildingSuccessState extends DeleteOrganizationsState {
  final String message;
  DeleteRestoreBuildingSuccessState(this.message);
}

class DeleteRestoreBuildingErrorState extends DeleteOrganizationsState {
  final String error;
  DeleteRestoreBuildingErrorState(this.error);
}

//******************************** */
class DeleteRestoreFloorLoadingState extends DeleteOrganizationsState {}

class DeleteRestoreFloorSuccessState extends DeleteOrganizationsState {
  final String message;
  DeleteRestoreFloorSuccessState(this.message);
}

class DeleteRestoreFloorErrorState extends DeleteOrganizationsState {
  final String error;
  DeleteRestoreFloorErrorState(this.error);
}

//******************************** */
class DeleteRestorePointLoadingState extends DeleteOrganizationsState {}

class DeleteRestorePointSuccessState extends DeleteOrganizationsState {
  final String message;
  DeleteRestorePointSuccessState(this.message);
}

class DeleteRestorePointErrorState extends DeleteOrganizationsState {
  final String error;
  DeleteRestorePointErrorState(this.error);
}

//******************************** */

class DeleteForceAreaLoadingState extends DeleteOrganizationsState {}

class DeleteForceAreaSuccessState extends DeleteOrganizationsState {
  final String message;
  DeleteForceAreaSuccessState(this.message);
}

class DeleteForceAreaErrorState extends DeleteOrganizationsState {
  final String error;
  DeleteForceAreaErrorState(this.error);
}
//******************************** */

class DeleteForceCityLoadingState extends DeleteOrganizationsState {}

class DeleteForceCitySuccessState extends DeleteOrganizationsState {
  final String message;
  DeleteForceCitySuccessState(this.message);
}

class DeleteForceCityErrorState extends DeleteOrganizationsState {
  final String error;
  DeleteForceCityErrorState(this.error);
}
//******************************** */

class DeleteForceOrganizationLoadingState extends DeleteOrganizationsState {}

class DeleteForceOrganizationSuccessState extends DeleteOrganizationsState {
  final String message;
  DeleteForceOrganizationSuccessState(this.message);
}

class DeleteForceOrganizationErrorState extends DeleteOrganizationsState {
  final String error;
  DeleteForceOrganizationErrorState(this.error);
}
//******************************** */

class DeleteForceBuildingLoadingState extends DeleteOrganizationsState {}

class DeleteForceBuildingSuccessState extends DeleteOrganizationsState {
  final String message;
  DeleteForceBuildingSuccessState(this.message);
}

class DeleteForceBuildingErrorState extends DeleteOrganizationsState {
  final String error;
  DeleteForceBuildingErrorState(this.error);
}
//******************************** */

class DeleteForceFloorLoadingState extends DeleteOrganizationsState {}

class DeleteForceFloorSuccessState extends DeleteOrganizationsState {
  final String message;
  DeleteForceFloorSuccessState(this.message);
}

class DeleteForceFloorErrorState extends DeleteOrganizationsState {
  final String error;
  DeleteForceFloorErrorState(this.error);
}
//******************************** */

class DeleteForcePointLoadingState extends DeleteOrganizationsState {}

class DeleteForcePointSuccessState extends DeleteOrganizationsState {
  final String message;
  DeleteForcePointSuccessState(this.message);
}

class DeleteForcePointErrorState extends DeleteOrganizationsState {
  final String error;
  DeleteForcePointErrorState(this.error);
}