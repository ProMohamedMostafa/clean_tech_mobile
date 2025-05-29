import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/edit_shift/data/model/edit_shift_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/section_list_model.dart';

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
class OrganizationLoadingState extends EditShiftState {}

class OrganizationSuccessState extends EditShiftState {
  final OrganizationListModel organizationListModel;

  OrganizationSuccessState(this.organizationListModel);
}

class OrganizationErrorState extends EditShiftState {
  final String error;
  OrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends EditShiftState {}

class GetBuildingSuccessState extends EditShiftState {
  final BuildingListModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends EditShiftState {
  final String error;
  GetBuildingErrorState(this.error);
}

//**************************** */
class GetFloorLoadingState extends EditShiftState {}

class GetFloorSuccessState extends EditShiftState {
  final FloorListModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends EditShiftState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetSectionLoadingState extends EditShiftState {}

class GetSectionSuccessState extends EditShiftState {
  final SectionListModel sectionModel;

  GetSectionSuccessState(this.sectionModel);
}

class GetSectionErrorState extends EditShiftState {
  final String error;
  GetSectionErrorState(this.error);
}
