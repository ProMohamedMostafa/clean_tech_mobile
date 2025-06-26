import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/edit_shift/data/model/edit_shift_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/data/models/shift_details_model.dart';
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

class BuildingLoadingState extends EditShiftState {}

class BuildingSuccessState extends EditShiftState {
  final BuildingListModel buildingModel;

  BuildingSuccessState(this.buildingModel);
}

class BuildingErrorState extends EditShiftState {
  final String error;
  BuildingErrorState(this.error);
}

//**************************** */
class FloorLoadingState extends EditShiftState {}

class FloorSuccessState extends EditShiftState {
  final FloorListModel floorModel;

  FloorSuccessState(this.floorModel);
}

class FloorErrorState extends EditShiftState {
  final String error;
  FloorErrorState(this.error);
}
//**************************** */

class SectionLoadingState extends EditShiftState {}

class SectionSuccessState extends EditShiftState {
  final SectionListModel sectionModel;

  SectionSuccessState(this.sectionModel);
}

class SectionErrorState extends EditShiftState {
  final String error;
  SectionErrorState(this.error);
}
