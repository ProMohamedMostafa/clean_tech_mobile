import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/points_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/add_shift/data/model/create_shift_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';

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
  final BuildingModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends AddShiftState {
  final String error;
  GetBuildingErrorState(this.error);
}

//**************************** */
class GetFloorLoadingState extends AddShiftState {}

class GetFloorSuccessState extends AddShiftState {
  final FloorModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends AddShiftState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetPointLoadingState extends AddShiftState {}

class GetPointSuccessState extends AddShiftState {
  final PointsModel pointModel;

  GetPointSuccessState(this.pointModel);
}

class GetPointErrorState extends AddShiftState {
  final String error;
  GetPointErrorState(this.error);
}
