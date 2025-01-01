import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_city/data/model/city_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_city/data/model/edit_details_model.dart';

abstract class EditCityState {}

class EditCityInitialState extends EditCityState {}

class EditCityLoadingState extends EditCityState {}

class EditCitySuccessState extends EditCityState {
  final EditCityModel editCityModel;
  EditCitySuccessState(this.editCityModel);
}

class EditCityErrorState extends EditCityState {
  final String error;
  EditCityErrorState(this.error);
}

//******************************** */

class GetNationalityLoadingState extends EditCityState {}

class GetNationalitySuccessState extends EditCityState {
  final OrganizationNationalityModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends EditCityState {
  final String error;
  GetNationalityErrorState(this.error);
}
//**************************** */

class GetAreaLoadingState extends EditCityState {}

class GetAreaSuccessState extends EditCityState {
  final AreaModel areaModel;

  GetAreaSuccessState(this.areaModel);
}

class GetAreaErrorState extends EditCityState {
  final String error;
  GetAreaErrorState(this.error);
}

//**************************** */

class GetCityDetailsLoadingState extends EditCityState {}

class GetCityDetailsSuccessState extends EditCityState {
  final CityDetailsInEditModel cityDetailsInEditModel;

  GetCityDetailsSuccessState(this.cityDetailsInEditModel);
}

class GetCityDetailsErrorState extends EditCityState {
  final String error;
  GetCityDetailsErrorState(this.error);
}
//**************************** */

class GetOrganizationCityLoadingState extends EditCityState {}

class GetOrganizationCitySuccessState extends EditCityState {
  final CityModel cityModel;

  GetOrganizationCitySuccessState(this.cityModel);
}

class GetOrganizationCityErrorState extends EditCityState {
  final String error;
  GetOrganizationCityErrorState(this.error);
}