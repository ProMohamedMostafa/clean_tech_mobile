
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/points_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_cleaners_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_managers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_supervisors_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_point/data/model/edit_point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_point/data/model/point_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/point_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/point_shifts_details_model.dart';

abstract class EditPointState {}

class EditPointInitialState extends EditPointState {}

class EditPointLoadingState extends EditPointState {}

class EditPointSuccessState extends EditPointState {
  final PointEditModel pointEditModel;
  EditPointSuccessState(this.pointEditModel);
}

class EditPointErrorState extends EditPointState {
  final String error;
  EditPointErrorState(this.error);
}

//******************************** */

class GetNationalityLoadingState extends EditPointState {}

class GetNationalitySuccessState extends EditPointState {
  final NationalityModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends EditPointState {
  final String error;
  GetNationalityErrorState(this.error);
}
//**************************** */

class GetAreaLoadingState extends EditPointState {}

class GetAreaSuccessState extends EditPointState {
  final AreaModel areaModel;

  GetAreaSuccessState(this.areaModel);
}

class GetAreaErrorState extends EditPointState {
  final String error;
  GetAreaErrorState(this.error);
}

//**************************** */
class GetCityLoadingState extends EditPointState {}

class GetCitySuccessState extends EditPointState {
  final CityModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends EditPointState {
  final String error;
  GetCityErrorState(this.error);
}

//**************************** */
class GetOrganizationsLoadingState extends EditPointState {}

class GetOrganizationsSuccessState extends EditPointState {
  final OrganizationModel organizationModel;

  GetOrganizationsSuccessState(this.organizationModel);
}

class GetOrganizationsErrorState extends EditPointState {
  final String error;
  GetOrganizationsErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends EditPointState {}

class GetBuildingSuccessState extends EditPointState {
  final BuildingModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends EditPointState {
  final String error;
  GetBuildingErrorState(this.error);
}

//**************************** */
class GetFloorLoadingState extends EditPointState {}

class GetFloorSuccessState extends EditPointState {
  final FloorModel floorModel;

  GetFloorSuccessState(this.floorModel);
}

class GetFloorErrorState extends EditPointState {
  final String error;
  GetFloorErrorState(this.error);
}
//**************************** */

class GetPointLoadingState extends EditPointState {}

class GetPointSuccessState extends EditPointState {
  final PointsModel pointModel;

  GetPointSuccessState(this.pointModel);
}

class GetPointErrorState extends EditPointState {
  final String error;
  GetPointErrorState(this.error);
}
//**************************** */

class AllManagersLoadingState extends EditPointState {}

class AllManagersSuccessState extends EditPointState {
  final AllManagersModel allManagersModel;

  AllManagersSuccessState(this.allManagersModel);
}

class AllManagersErrorState extends EditPointState {
  final String error;
  AllManagersErrorState(this.error);
}
//**************************** */

class AllSupervisorsLoadingState extends EditPointState {}

class AllSupervisorsSuccessState extends EditPointState {
  final AllSupervisorsModel allSupervisorsModel;

  AllSupervisorsSuccessState(this.allSupervisorsModel);
}

class AllSupervisorsErrorState extends EditPointState {
  final String error;
  AllSupervisorsErrorState(this.error);
}

//**************************** */

class AllCleanersLoadingState extends EditPointState {}

class AllCleanersSuccessState extends EditPointState {
  final AllCleanersModel allCleanersModel;

  AllCleanersSuccessState(this.allCleanersModel);
}

class AllCleanersErrorState extends EditPointState {
  final String error;
  AllCleanersErrorState(this.error);
}

//**************************** */

class ShiftLoadingState extends EditPointState {}

class ShiftSuccessState extends EditPointState {
  final ShiftModel shiftModel;
  ShiftSuccessState(this.shiftModel);
}

class ShiftErrorState extends EditPointState {
  final String error;
  ShiftErrorState(this.error);
}
class GetPointDetailsLoadingState extends EditPointState {}

class GetPointDetailsSuccessState extends EditPointState {
  final PointDetailsInEditModel pointDetailsInEditModel;

  GetPointDetailsSuccessState(this.pointDetailsInEditModel);
}

class GetPointDetailsErrorState extends EditPointState {
  final String error;
  GetPointDetailsErrorState(this.error);
}
//********************************* */
class PointManagersDetailsLoadingState extends EditPointState {}

class PointManagersDetailsSuccessState extends EditPointState {
  final PointManagersDetailsModel pointManagersDetailsModel;

  PointManagersDetailsSuccessState(this.pointManagersDetailsModel);
}

class PointManagersDetailsErrorState extends EditPointState {
  final String error;
  PointManagersDetailsErrorState(this.error);
}

//********************************* */
class PointShiftsDetailsLoadingState extends EditPointState {}

class PointShiftsDetailsSuccessState extends EditPointState {
  final PointShiftsDetailsModel pointShiftsDetailsModel;

  PointShiftsDetailsSuccessState(this.pointShiftsDetailsModel);
}

class PointShiftsDetailsErrorState extends EditPointState {
  final String error;
  PointShiftsDetailsErrorState(this.error);
}