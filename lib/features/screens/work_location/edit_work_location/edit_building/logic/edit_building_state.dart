import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_cleaners_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_managers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_supervisors_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_building/data/model/building_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_building/data/model/edit_building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_building_details/data/model/building_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_building_details/data/model/building_shifts_details_model.dart';

abstract class EditBuildingState {}

class EditBuildingInitialState extends EditBuildingState {}

class EditBuildingLoadingState extends EditBuildingState {}

class EditBuildingSuccessState extends EditBuildingState {
  final BuildingEditModel buildingEditModel;
  EditBuildingSuccessState(this.buildingEditModel);
}

class EditBuildingErrorState extends EditBuildingState {
  final String error;
  EditBuildingErrorState(this.error);
}

//******************************** */

class GetNationalityLoadingState extends EditBuildingState {}

class GetNationalitySuccessState extends EditBuildingState {
  final NationalityModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends EditBuildingState {
  final String error;
  GetNationalityErrorState(this.error);
}
//**************************** */

class GetAreaLoadingState extends EditBuildingState {}

class GetAreaSuccessState extends EditBuildingState {
  final AreaModel areaModel;

  GetAreaSuccessState(this.areaModel);
}

class GetAreaErrorState extends EditBuildingState {
  final String error;
  GetAreaErrorState(this.error);
}

//**************************** */
class GetCityLoadingState extends EditBuildingState {}

class GetCitySuccessState extends EditBuildingState {
  final CityModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends EditBuildingState {
  final String error;
  GetCityErrorState(this.error);
}

//**************************** */
class GetOrganizationsLoadingState extends EditBuildingState {}

class GetOrganizationsSuccessState extends EditBuildingState {
  final OrganizationModel organizationModel;

  GetOrganizationsSuccessState(this.organizationModel);
}

class GetOrganizationsErrorState extends EditBuildingState {
  final String error;
  GetOrganizationsErrorState(this.error);
}

//**************************** */

class GetBuildingDetailsLoadingState extends EditBuildingState {}

class GetBuildingDetailsSuccessState extends EditBuildingState {
  final BuildingDetailsInEditModel buildingDetailsInEditModel;

  GetBuildingDetailsSuccessState(this.buildingDetailsInEditModel);
}

class GetBuildingDetailsErrorState extends EditBuildingState {
  final String error;
  GetBuildingDetailsErrorState(this.error);
}
//**************************** */

class AllManagersLoadingState extends EditBuildingState {}

class AllManagersSuccessState extends EditBuildingState {
  final AllManagersModel allManagersModel;

  AllManagersSuccessState(this.allManagersModel);
}

class AllManagersErrorState extends EditBuildingState {
  final String error;
  AllManagersErrorState(this.error);
}
//**************************** */

class AllSupervisorsLoadingState extends EditBuildingState {}

class AllSupervisorsSuccessState extends EditBuildingState {
  final AllSupervisorsModel allSupervisorsModel;

  AllSupervisorsSuccessState(this.allSupervisorsModel);
}

class AllSupervisorsErrorState extends EditBuildingState {
  final String error;
  AllSupervisorsErrorState(this.error);
}

//**************************** */

class AllCleanersLoadingState extends EditBuildingState {}

class AllCleanersSuccessState extends EditBuildingState {
  final AllCleanersModel allCleanersModel;

  AllCleanersSuccessState(this.allCleanersModel);
}

class AllCleanersErrorState extends EditBuildingState {
  final String error;
  AllCleanersErrorState(this.error);
}

//**************************** */

class ShiftLoadingState extends EditBuildingState {}

class ShiftSuccessState extends EditBuildingState {
  final ShiftModel shiftModel;
  ShiftSuccessState(this.shiftModel);
}

class ShiftErrorState extends EditBuildingState {
  final String error;
  ShiftErrorState(this.error);
}
//********************************* */
class BuildingManagersDetailsLoadingState extends EditBuildingState {}

class BuildingManagersDetailsSuccessState extends EditBuildingState {
  final BuildingManagersDetailsModel buildingManagersDetailsModel;

  BuildingManagersDetailsSuccessState(this.buildingManagersDetailsModel);
}

class BuildingManagersDetailsErrorState extends EditBuildingState {
  final String error;
  BuildingManagersDetailsErrorState(this.error);
}

//********************************* */
class BuildingShiftsDetailsLoadingState extends EditBuildingState {}

class BuildingShiftsDetailsSuccessState extends EditBuildingState {
  final BuildingShiftsDetailsModel buildingShiftsDetailsModel;

  BuildingShiftsDetailsSuccessState(this.buildingShiftsDetailsModel);
}

class BuildingShiftsDetailsErrorState extends EditBuildingState {
  final String error;
  BuildingShiftsDetailsErrorState(this.error);
}
//******************************** */