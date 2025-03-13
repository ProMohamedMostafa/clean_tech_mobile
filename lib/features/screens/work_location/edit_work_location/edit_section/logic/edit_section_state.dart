import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_section/data/model/edit_section_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_section/data/model/section_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/section_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';

abstract class EditSectionState {}

class EditSectionInitialState extends EditSectionState {}

class EditSectionLoadingState extends EditSectionState {}

class EditSectionSuccessState extends EditSectionState {
  final SectionEditModel sectionEditModel;
  EditSectionSuccessState(this.sectionEditModel);
}

class EditSectionErrorState extends EditSectionState {
  final String error;
  EditSectionErrorState(this.error);
}

//******************************** */

class GetNationalityLoadingState extends EditSectionState {}

class GetNationalitySuccessState extends EditSectionState {
  final NationalityModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends EditSectionState {
  final String error;
  GetNationalityErrorState(this.error);
}
//**************************** */

class GetAreaLoadingState extends EditSectionState {}

class GetAreaSuccessState extends EditSectionState {
  final AreaListModel areaModel;

  GetAreaSuccessState(this.areaModel);
}

class GetAreaErrorState extends EditSectionState {
  final String error;
  GetAreaErrorState(this.error);
}

//**************************** */
class GetCityLoadingState extends EditSectionState {}

class GetCitySuccessState extends EditSectionState {
  final CityListModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends EditSectionState {
  final String error;
  GetCityErrorState(this.error);
}

//**************************** */
class GetOrganizationLoadingState extends EditSectionState {}

class GetOrganizationSuccessState extends EditSectionState {
  final OrganizationListModel organizationModel;

  GetOrganizationSuccessState(this.organizationModel);
}

class GetOrganizationErrorState extends EditSectionState {
  final String error;
  GetOrganizationErrorState(this.error);
}
//**************************** */

class GetBuildingLoadingState extends EditSectionState {}

class GetBuildingSuccessState extends EditSectionState {
  final BuildingListModel buildingModel;

  GetBuildingSuccessState(this.buildingModel);
}

class GetBuildingErrorState extends EditSectionState {
  final String error;
  GetBuildingErrorState(this.error);
}

//**************************** */

class GetFloorLoadingState extends EditSectionState {}

class GetFloorSuccessState extends EditSectionState {
  final FloorListModel buildingModel;

  GetFloorSuccessState(this.buildingModel);
}

class GetFloorErrorState extends EditSectionState {
  final String error;
  GetFloorErrorState(this.error);
}

//**************************** */

class GetSectionDetailsLoadingState extends EditSectionState {}

class GetSectionDetailsSuccessState extends EditSectionState {
  final SectionDetailsInEditModel sectionDetailsInEditModel;

  GetSectionDetailsSuccessState(this.sectionDetailsInEditModel);
}

class GetSectionDetailsErrorState extends EditSectionState {
  final String error;
  GetSectionDetailsErrorState(this.error);
}
//**************************** */

class ShiftLoadingState extends EditSectionState {}

class ShiftSuccessState extends EditSectionState {
  final ShiftModel shiftModel;
  ShiftSuccessState(this.shiftModel);
}

class ShiftErrorState extends EditSectionState {
  final String error;
  ShiftErrorState(this.error);
}

//********************************* */
class SectionUsersDetailsLoadingState extends EditSectionState {}

class SectionUsersDetailsSuccessState extends EditSectionState {
  final SectionUsersShiftsDetailsModel sectionUsersDetailsModel;

  SectionUsersDetailsSuccessState(this.sectionUsersDetailsModel);
}

class SectionUsersDetailsErrorState extends EditSectionState {
  final String error;
  SectionUsersDetailsErrorState(this.error);
}

