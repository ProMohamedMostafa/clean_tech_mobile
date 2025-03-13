import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_organization/data/model/edit_organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_organization/data/model/organization_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/organization_users_shifts_details_model.dart';

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

class GetAreaLoadingState extends EditOrganizationState {}

class GetAreaSuccessState extends EditOrganizationState {
  final AreaListModel areaModel;

  GetAreaSuccessState(this.areaModel);
}

class GetAreaErrorState extends EditOrganizationState {
  final String error;
  GetAreaErrorState(this.error);
}
//**************************** */

class GetCityLoadingState extends EditOrganizationState {}

class GetCitySuccessState extends EditOrganizationState {
  final CityListModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends EditOrganizationState {
  final String error;
  GetCityErrorState(this.error);
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

class OrganizationManagersDetailsLoadingState extends EditOrganizationState {}

class OrganizationManagersDetailsSuccessState extends EditOrganizationState {
  final OrganizationUsersShiftsDetailsModel organizationManagersDetailsModel;

  OrganizationManagersDetailsSuccessState(
      this.organizationManagersDetailsModel);
}

class OrganizationManagersDetailsErrorState extends EditOrganizationState {
  final String error;
  OrganizationManagersDetailsErrorState(this.error);
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
