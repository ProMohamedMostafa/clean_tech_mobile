import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_organization_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/edit_shift/data/model/edit_shift_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/data/models/shift_building_details.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/data/models/shift_floor_details.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/data/models/shift_organization_details.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/data/models/shift_section_details.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/section_model.dart';

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

//******************** */
class ShiftOrganizationDetailsLoadingState extends EditShiftState {}

class ShiftOrganizationDetailsSuccessState extends EditShiftState {
  final ShiftOrganizationDetailsModel shiftOrganizationDetailsModel;
  ShiftOrganizationDetailsSuccessState(this.shiftOrganizationDetailsModel);
}

class ShiftOrganizationDetailsErrorState extends EditShiftState {
  final String error;
  ShiftOrganizationDetailsErrorState(this.error);
} //******************** */

class ShiftBuildingDetailsLoadingState extends EditShiftState {}

class ShiftBuildingDetailsSuccessState extends EditShiftState {
  final ShiftBuildingsDetailsModel shiftBuildingsDetailsModel;
  ShiftBuildingDetailsSuccessState(this.shiftBuildingsDetailsModel);
}

class ShiftBuildingDetailsErrorState extends EditShiftState {
  final String error;
  ShiftBuildingDetailsErrorState(this.error);
} //******************** */

class ShiftFloorDetailsLoadingState extends EditShiftState {}

class ShiftFloorDetailsSuccessState extends EditShiftState {
  final ShiftFloorDetailsModel shiftFloorDetailsModel;
  ShiftFloorDetailsSuccessState(this.shiftFloorDetailsModel);
}

class ShiftFloorDetailsErrorState extends EditShiftState {
  final String error;
  ShiftFloorDetailsErrorState(this.error);
} //******************** */

class ShiftSectionDetailsLoadingState extends EditShiftState {}

class ShiftSectionDetailsSuccessState extends EditShiftState {
  final ShiftSectionDetailsModel shiftSectionDetailsModel;
  ShiftSectionDetailsSuccessState(this.shiftSectionDetailsModel);
}

class ShiftSectionDetailsErrorState extends EditShiftState {
  final String error;
  ShiftSectionDetailsErrorState(this.error);
}

//**************************** */
class OrganizationLoadingState extends EditShiftState {}

class OrganizationSuccessState extends EditShiftState {
  final AllOrganizationModel allOrganizationModel;

  OrganizationSuccessState(this.allOrganizationModel);
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
