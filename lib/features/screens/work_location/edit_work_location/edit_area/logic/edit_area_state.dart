import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_area/data/model/area_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_area/data/model/edit_area_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/area_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/area_model.dart';

abstract class EditAreaState {}

class EditAreaInitialState extends EditAreaState {}

class EditAreaLoadingState extends EditAreaState {}

class EditAreaSuccessState extends EditAreaState {
  final EditAreaModel editAreaModel;
  EditAreaSuccessState(this.editAreaModel);
}

class EditAreaErrorState extends EditAreaState {
  final String error;
  EditAreaErrorState(this.error);
}

//******************************** */

class GetNationalityLoadingState extends EditAreaState {}

class GetNationalitySuccessState extends EditAreaState {
  final NationalityModel nationalitymodel;

  GetNationalitySuccessState(this.nationalitymodel);
}

class GetNationalityErrorState extends EditAreaState {
  final String error;
  GetNationalityErrorState(this.error);
}
//**************************** */

class GetAreaLoadingState extends EditAreaState {}

class GetAreaSuccessState extends EditAreaState {
  final AreaListModel areaModel;

  GetAreaSuccessState(this.areaModel);
}

class GetAreaErrorState extends EditAreaState {
  final String error;
  GetAreaErrorState(this.error);
}

//**************************** */

class GetAreaDetailsLoadingState extends EditAreaState {}

class GetAreaDetailsSuccessState extends EditAreaState {
  final AreaDetailsInEditModel areaDetailsInEditModel;

  GetAreaDetailsSuccessState(this.areaDetailsInEditModel);
}

class GetAreaDetailsErrorState extends EditAreaState {
  final String error;
  GetAreaDetailsErrorState(this.error);
}
//******************************** */

class AreaManagersDetailsLoadingState extends EditAreaState {}

class AreaManagersDetailsSuccessState extends EditAreaState {
  final AreaUsersDetailsModel areaUsersDetailsModel;

  AreaManagersDetailsSuccessState(this.areaUsersDetailsModel);
}

class AreaManagersDetailsErrorState extends EditAreaState {
  final String error;
  AreaManagersDetailsErrorState(this.error);
}
