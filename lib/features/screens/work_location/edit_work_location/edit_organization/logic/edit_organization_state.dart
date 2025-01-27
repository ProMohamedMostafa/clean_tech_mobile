import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_cleaners_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_managers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_supervisors_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_organization/data/model/edit_organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_organization/data/model/organization_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_organization_details/data/model/organization_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_organization_details/data/model/organization_shifts_details_model.dart';

abstract class EditOrganizationState {}

class EditOrganizationInitialState extends EditOrganizationState {}

class EditOrganizationLoadingState extends EditOrganizationState {}

class EditOrganizationSuccessState extends EditOrganizationState {
  final EditOrganizationModel editOrganizationModel;
  EditOrganizationSuccessState(this.editOrganizationModel);
}

class EditOrganizationErrorState extends EditOrganizationState {
  final String error;
  EditOrganizationErrorState(this.error);
}

//******************************** */

class EditOrganizationDetailsLoadingState extends EditOrganizationState {}

class EditOrganizationDetailsSuccessState extends EditOrganizationState {
  final OrganizationListModel organizationModel;

  EditOrganizationDetailsSuccessState(this.organizationModel);
}

class EditOrganizationDetailsErrorState extends EditOrganizationState {
  final String error;
  EditOrganizationDetailsErrorState(this.error);
}

//**************************** */
class GetNationalityLoadingState extends EditOrganizationState {}

class GetNationalitySuccessState extends EditOrganizationState {
  final NationalityModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends EditOrganizationState {
  final String error;
  GetNationalityErrorState(this.error);
}

//**************************** */

class GetOrganizationAreaLoadingState extends EditOrganizationState {}

class GetOrganizationAreaSuccessState extends EditOrganizationState {
  final AreaModel areaModel;

  GetOrganizationAreaSuccessState(this.areaModel);
}

class GetOrganizationAreaErrorState extends EditOrganizationState {
  final String error;
  GetOrganizationAreaErrorState(this.error);
}
//**************************** */

class GetOrganizationCityLoadingState extends EditOrganizationState {}

class GetOrganizationCitySuccessState extends EditOrganizationState {
  final CityModel cityModel;

  GetOrganizationCitySuccessState(this.cityModel);
}

class GetOrganizationCityErrorState extends EditOrganizationState {
  final String error;
  GetOrganizationCityErrorState(this.error);
}

//***************************** */

class GetOrganizationDetailsLoadingState extends EditOrganizationState {}

class GetOrganizationDetailsSuccessState extends EditOrganizationState {
  final OrganizationDetailsInEditModel organizationDetailsInEditModel;

  GetOrganizationDetailsSuccessState(this.organizationDetailsInEditModel);
}

class GetOrganizationDetailsErrorState extends EditOrganizationState {
  final String error;
  GetOrganizationDetailsErrorState(this.error);
}

//**************************** */


class AllManagersLoadingState extends EditOrganizationState {}

class AllManagersSuccessState extends EditOrganizationState {
  final AllManagersModel allManagersModel;

  AllManagersSuccessState(this.allManagersModel);
}

class AllManagersErrorState extends EditOrganizationState {
  final String error;
  AllManagersErrorState(this.error);
}
//**************************** */

class AllSupervisorsLoadingState extends EditOrganizationState {}

class AllSupervisorsSuccessState extends EditOrganizationState {
  final AllSupervisorsModel allSupervisorsModel;

  AllSupervisorsSuccessState(this.allSupervisorsModel);
}

class AllSupervisorsErrorState extends EditOrganizationState {
  final String error;
  AllSupervisorsErrorState(this.error);
}

//**************************** */

class AllCleanersLoadingState extends EditOrganizationState {}

class AllCleanersSuccessState extends EditOrganizationState {
  final AllCleanersModel allCleanersModel;

  AllCleanersSuccessState(this.allCleanersModel);
}

class AllCleanersErrorState extends EditOrganizationState {
  final String error;
  AllCleanersErrorState(this.error);
}


 //********************************* */

class OrganizationManagersDetailsLoadingState extends EditOrganizationState {}

class OrganizationManagersDetailsSuccessState extends EditOrganizationState {
  final OrganizationManagersDetailsModel organizationManagersDetailsModel;

  OrganizationManagersDetailsSuccessState(
      this.organizationManagersDetailsModel);
}

class OrganizationManagersDetailsErrorState extends EditOrganizationState {
  final String error;
  OrganizationManagersDetailsErrorState(this.error);
}

//********************************* */
class OrganizationShiftsDetailsLoadingState extends EditOrganizationState {}

class OrganizationShiftsDetailsSuccessState extends EditOrganizationState {
  final OrganizationShiftsDetailsModel organizationShiftsDetailsModel;

  OrganizationShiftsDetailsSuccessState(this.organizationShiftsDetailsModel);
}

class OrganizationShiftsDetailsErrorState extends EditOrganizationState {
  final String error;
  OrganizationShiftsDetailsErrorState(this.error);
}

//**************************** */

class ShiftLoadingState extends EditOrganizationState {}

class ShiftSuccessState extends EditOrganizationState {
  final ShiftModel shiftModel;
  ShiftSuccessState(this.shiftModel);
}

class ShiftErrorState extends EditOrganizationState {
  final String error;
  ShiftErrorState(this.error);
}