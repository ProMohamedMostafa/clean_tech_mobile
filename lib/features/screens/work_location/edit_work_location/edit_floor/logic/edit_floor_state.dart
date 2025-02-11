import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_cleaners_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_managers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_supervisors_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_floor/data/model/edit_floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_floor/data/model/floor_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/floor_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/floor_shifts_details_model.dart';

abstract class EditFloorState {}

class EditFloorInitialState extends EditFloorState {}

class EditFloorLoadingState extends EditFloorState {}

class EditFloorSuccessState extends EditFloorState {
  final FloorEditModel floorEditModel;
  EditFloorSuccessState(this.floorEditModel);
}

class EditFloorErrorState extends EditFloorState {
  final String error;
  EditFloorErrorState(this.error);
}

//******************************** */

class GetNationalityLoadingState extends EditFloorState {}

class GetNationalitySuccessState extends EditFloorState {
  final NationalityModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends EditFloorState {
  final String error;
  GetNationalityErrorState(this.error);
}
//**************************** */

class GetAreaLoadingState extends EditFloorState {}

class GetAreaSuccessState extends EditFloorState {
  final AreaModel areaModel;

  GetAreaSuccessState(this.areaModel);
}

class GetAreaErrorState extends EditFloorState {
  final String error;
  GetAreaErrorState(this.error);
}

//**************************** */
class GetCityLoadingState extends EditFloorState {}

class GetCitySuccessState extends EditFloorState {
  final CityModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends EditFloorState {
  final String error;
  GetCityErrorState(this.error);
}

//**************************** */
class GetOrganizationsLoadingState extends EditFloorState {}

class GetOrganizationsSuccessState extends EditFloorState {
  final OrganizationModel organizationModel;

  GetOrganizationsSuccessState(this.organizationModel);
}

class GetOrganizationsErrorState extends EditFloorState {
  final String error;
  GetOrganizationsErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends EditFloorState {}

class GetBuildingSuccessState extends EditFloorState {
  final BuildingModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends EditFloorState {
  final String error;
  GetBuildingErrorState(this.error);
}

//**************************** */

class GetFloorDetailsLoadingState extends EditFloorState {}

class GetFloorDetailsSuccessState extends EditFloorState {
  final FloorDetailsInEditModel floorDetailsInEditModel;

  GetFloorDetailsSuccessState(this.floorDetailsInEditModel);
}

class GetFloorDetailsErrorState extends EditFloorState {
  final String error;
  GetFloorDetailsErrorState(this.error);
}
//**************************** */

class AllManagersLoadingState extends EditFloorState {}

class AllManagersSuccessState extends EditFloorState {
  final AllManagersModel allManagersModel;

  AllManagersSuccessState(this.allManagersModel);
}

class AllManagersErrorState extends EditFloorState {
  final String error;
  AllManagersErrorState(this.error);
}
//**************************** */

class AllSupervisorsLoadingState extends EditFloorState {}

class AllSupervisorsSuccessState extends EditFloorState {
  final AllSupervisorsModel allSupervisorsModel;

  AllSupervisorsSuccessState(this.allSupervisorsModel);
}

class AllSupervisorsErrorState extends EditFloorState {
  final String error;
  AllSupervisorsErrorState(this.error);
}

//**************************** */

class AllCleanersLoadingState extends EditFloorState {}

class AllCleanersSuccessState extends EditFloorState {
  final AllCleanersModel allCleanersModel;

  AllCleanersSuccessState(this.allCleanersModel);
}

class AllCleanersErrorState extends EditFloorState {
  final String error;
  AllCleanersErrorState(this.error);
}

//**************************** */

class ShiftLoadingState extends EditFloorState {}

class ShiftSuccessState extends EditFloorState {
  final ShiftModel shiftModel;
  ShiftSuccessState(this.shiftModel);
}

class ShiftErrorState extends EditFloorState {
  final String error;
  ShiftErrorState(this.error);
}

//********************************* */
class FloorManagersDetailsLoadingState extends EditFloorState {}

class FloorManagersDetailsSuccessState extends EditFloorState {
  final FloorManagersDetailsModel floorManagersDetailsModel;

  FloorManagersDetailsSuccessState(this.floorManagersDetailsModel);
}

class FloorManagersDetailsErrorState extends EditFloorState {
  final String error;
  FloorManagersDetailsErrorState(this.error);
}

//********************************* */
class FloorShiftsDetailsLoadingState extends EditFloorState {}

class FloorShiftsDetailsSuccessState extends EditFloorState {
  final FloorShiftsDetailsModel floorShiftsDetailsModel;

  FloorShiftsDetailsSuccessState(this.floorShiftsDetailsModel);
}

class FloorShiftsDetailsErrorState extends EditFloorState {
  final String error;
  FloorShiftsDetailsErrorState(this.error);
}
