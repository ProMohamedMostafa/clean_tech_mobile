import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_cleaners_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_managers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_supervisors_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_area/data/model/area_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_area/data/model/edit_area_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_area_details/data/model/area_managers_details_model.dart';

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

class GetAreaNationalityLoadingState extends EditAreaState {}

class GetAreaNationalitySuccessState extends EditAreaState {
  final NationalityModel nationalitymodel;

  GetAreaNationalitySuccessState(this.nationalitymodel);
}

class GetAreaNationalityErrorState extends EditAreaState {
  final String error;
  GetAreaNationalityErrorState(this.error);
}
//**************************** */

class GetAreaLoadingState extends EditAreaState {}

class GetAreaSuccessState extends EditAreaState {
  final AreaModel areaModel;

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
//**************************** */

class AllManagersLoadingState extends EditAreaState {}

class AllManagersSuccessState extends EditAreaState {
  final AllManagersModel allManagersModel;

  AllManagersSuccessState(this.allManagersModel);
}

class AllManagersErrorState extends EditAreaState {
  final String error;
  AllManagersErrorState(this.error);
}
//**************************** */

class AllSupervisorsLoadingState extends EditAreaState {}

class AllSupervisorsSuccessState extends EditAreaState {
  final AllSupervisorsModel allSupervisorsModel;

  AllSupervisorsSuccessState(this.allSupervisorsModel);
}

class AllSupervisorsErrorState extends EditAreaState {
  final String error;
  AllSupervisorsErrorState(this.error);
}

//**************************** */

class AllCleanersLoadingState extends EditAreaState {}

class AllCleanersSuccessState extends EditAreaState {
  final AllCleanersModel allCleanersModel;

  AllCleanersSuccessState(this.allCleanersModel);
}

class AllCleanersErrorState extends EditAreaState {
  final String error;
  AllCleanersErrorState(this.error);
}
//******************************** */

class AreaManagersDetailsLoadingState extends EditAreaState {}

class AreaManagersDetailsSuccessState extends EditAreaState {
  final AreaManagersDetailsModel areaManagersDetailsModel;

  AreaManagersDetailsSuccessState(this.areaManagersDetailsModel);
}

class AreaManagersDetailsErrorState extends EditAreaState {
  final String error;
  AreaManagersDetailsErrorState(this.error);
}