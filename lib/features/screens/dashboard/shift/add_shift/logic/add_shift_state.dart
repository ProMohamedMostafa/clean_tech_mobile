import 'package:smart_cleaning_application/features/screens/dashboard/shift/add_shift/data/model/create_shift_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/section_list_model.dart';

abstract class AddShiftState {}

class AddShiftInitialState extends AddShiftState {}

class AddShiftLoadingState extends AddShiftState {}

class AddShiftSuccessState extends AddShiftState {
  final CreateShiftModel createShiftModel;

  AddShiftSuccessState(this.createShiftModel);
}

class AddShiftErrorState extends AddShiftState {
  final String error;
  AddShiftErrorState(this.error);
}

//**************************** */
class OrganizationLoadingState extends AddShiftState {}

class OrganizationSuccessState extends AddShiftState {
  final OrganizationListModel organizationListModel;

  OrganizationSuccessState(this.organizationListModel);
}

class OrganizationErrorState extends AddShiftState {
  final String error;
  OrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends AddShiftState {}

class GetBuildingSuccessState extends AddShiftState {
  final BuildingListModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends AddShiftState {
  final String error;
  GetBuildingErrorState(this.error);
}

//**************************** */
class GetFloorLoadingState extends AddShiftState {}

class GetFloorSuccessState extends AddShiftState {
  final FloorListModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends AddShiftState {
  final String error;
  GetFloorErrorState(this.error);
}

//**************************** */

class GetSectionLoadingState extends AddShiftState {}

class GetSectionSuccessState extends AddShiftState {
  final SectionListModel sectionsModel;

  GetSectionSuccessState(this.sectionsModel);
}

class GetSectionErrorState extends AddShiftState {
  final String error;
  GetSectionErrorState(this.error);
}

