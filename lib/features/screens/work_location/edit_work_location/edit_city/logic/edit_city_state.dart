import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_city/data/model/city_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_city/data/model/edit_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/city_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_model.dart';

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
  final AreaListModel areaModel;

  GetAreaSuccessState(this.areaModel);
}

class GetAreaErrorState extends EditCityState {
  final String error;
  GetAreaErrorState(this.error);
}
//**************************** */
class GetCityLoadingState extends EditCityState {}

class GetCitySuccessState extends EditCityState {
  final CityListModel cityModel;

  GetCitySuccessState(this.cityModel);
}

class GetCityErrorState extends EditCityState {
  final String error;
  GetCityErrorState(this.error);
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

//********************************* */
class CityManagersDetailsLoadingState extends EditCityState {}

class CityManagersDetailsSuccessState extends EditCityState {
  final CityUsersDetailsModel cityUsersDetailsModel;

  CityManagersDetailsSuccessState(this.cityUsersDetailsModel);
}

class CityManagersDetailsErrorState extends EditCityState {
  final String error;
  CityManagersDetailsErrorState(this.error);
}
