import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/floor_organization_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/points_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/edit_shift/data/model/edit_shift_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/shift_details_model.dart';

abstract class EditShiftState {}

class EditShiftInitialState extends EditShiftState {}

class EditShiftLoadingState extends EditShiftState {}

class EditShiftSuccessState extends EditShiftState {
  final EditShiftDetailsModel editShiftDetailsModel;
  EditShiftSuccessState(this.editShiftDetailsModel);
}

class EditShiftErrorState extends EditShiftState {
  final String error;
  EditShiftErrorState(this.error);
}

//******************** */
class ShiftDetailsLoadingState extends EditShiftState {}

class ShiftDetailsSuccessState extends EditShiftState {
 final ShiftDetailsModel shiftDetailsModel;
  ShiftDetailsSuccessState(this.shiftDetailsModel);
}

class ShiftDetailsErrorState extends EditShiftState {
  final String error;
  ShiftDetailsErrorState(this.error);
}

//**************************** */
class GetOrganizationsLoadingState extends EditShiftState {}

class GetOrganizationsSuccessState extends EditShiftState {
  final OrganizationModel organizationModel;

  GetOrganizationsSuccessState(this.organizationModel);
}

class GetOrganizationsErrorState extends EditShiftState {
  final String error;
  GetOrganizationsErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends EditShiftState {}

class GetBuildingSuccessState extends EditShiftState {
  final BuildingModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends EditShiftState {
  final String error;
  GetBuildingErrorState(this.error);
}

//**************************** */
class GetFloorLoadingState extends EditShiftState {}

class GetFloorSuccessState extends EditShiftState {
  final FloorModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends EditShiftState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetPointLoadingState extends EditShiftState {}

class GetPointSuccessState extends EditShiftState {
  final PointsModel pointModel;

  GetPointSuccessState(this.pointModel);
}

class GetPointErrorState extends EditShiftState {
  final String error;
  GetPointErrorState(this.error);
}