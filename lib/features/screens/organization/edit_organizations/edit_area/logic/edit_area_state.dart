import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_area/data/model/area_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_area/data/model/edit_area_model.dart';

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
  final OrganizationNationalityModel nationalitymodel;

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
