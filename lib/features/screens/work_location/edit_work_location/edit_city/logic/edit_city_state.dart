import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_cleaners_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_managers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_supervisors_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_city/data/model/city_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_city/data/model/edit_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_city_details/data/model/city_managers_details_model.dart';

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
  final NationalityModel nationalitymodel;

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

//**************************** */

class AllManagersLoadingState extends EditCityState {}

class AllManagersSuccessState extends EditCityState {
  final AllManagersModel allManagersModel;

  AllManagersSuccessState(this.allManagersModel);
}

class AllManagersErrorState extends EditCityState {
  final String error;
  AllManagersErrorState(this.error);
}
//**************************** */

class AllSupervisorsLoadingState extends EditCityState {}

class AllSupervisorsSuccessState extends EditCityState {
  final AllSupervisorsModel allSupervisorsModel;

  AllSupervisorsSuccessState(this.allSupervisorsModel);
}

class AllSupervisorsErrorState extends EditCityState {
  final String error;
  AllSupervisorsErrorState(this.error);
}

//**************************** */

class AllCleanersLoadingState extends EditCityState {}

class AllCleanersSuccessState extends EditCityState {
  final AllCleanersModel allCleanersModel;

  AllCleanersSuccessState(this.allCleanersModel);
}

class AllCleanersErrorState extends EditCityState {
  final String error;
  AllCleanersErrorState(this.error);
}

//********************************* */
class CityManagersDetailsLoadingState extends EditCityState {}

class CityManagersDetailsSuccessState extends EditCityState {
  final CityManagersDetailsModel cityManagersDetailsModel;

  CityManagersDetailsSuccessState(this.cityManagersDetailsModel);
}

class CityManagersDetailsErrorState extends EditCityState {
  final String error;
  CityManagersDetailsErrorState(this.error);
}
