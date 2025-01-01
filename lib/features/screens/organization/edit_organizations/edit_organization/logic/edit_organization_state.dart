import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_organization/data/model/edit_organization_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_organization/data/model/organization_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/data/model/organization_model.dart';

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

class GetOrganizationNationalityLoadingState extends EditOrganizationState {}

class GetOrganizationNationalitySuccessState extends EditOrganizationState {
  final OrganizationNationalityModel nationalitymodel;

  GetOrganizationNationalitySuccessState(this.nationalitymodel);
}

class GetOrganizationNationalityErrorState extends EditOrganizationState {
  final String error;
  GetOrganizationNationalityErrorState(this.error);
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
//**************************** */

class GetOrganizationOrganizationsLoadingState extends EditOrganizationState {}

class GetOrganizationOrganizationsSuccessState extends EditOrganizationState {
  final OrganizationModel organizationModel;

  GetOrganizationOrganizationsSuccessState(this.organizationModel);
}

class GetOrganizationOrganizationsErrorState extends EditOrganizationState {
  final String error;
  GetOrganizationOrganizationsErrorState(this.error);
}
// //**************************** */

// class GetOrganizationBuildingLoadingState extends EditOrganizationState {}

// class GetOrganizationBuildingSuccessState extends EditOrganizationState {
//   final BuildingModel buildingModel;

//   GetOrganizationBuildingSuccessState(this.buildingModel);
// }

// class GetOrganizationBuildingErrorState extends EditOrganizationState {
//   final String error;
//   GetOrganizationBuildingErrorState(this.error);
// }
// //**************************** */

// class GetOrganizationFloorLoadingState extends EditOrganizationState {}

// class GetOrganizationFloorSuccessState extends EditOrganizationState {
//   final FloorModel floorModel;

//   GetOrganizationFloorSuccessState(this.floorModel);
// }

// class GetOrganizationFloorErrorState extends EditOrganizationState {
//   final String error;
//   GetOrganizationFloorErrorState(this.error);
// }
// //**************************** */

// class GetOrganizationPointsLoadingState extends EditOrganizationState {}

// class GetOrganizationPointsSuccessState extends EditOrganizationState {
//   final PointsModel pointsModel;

//   GetOrganizationPointsSuccessState(this.pointsModel);
// }

// class GetOrganizationPointsErrorState extends EditOrganizationState {
//   final String error;
//   GetOrganizationPointsErrorState(this.error);
// }
// //**************************** */

class GetOrganizationDetailsLoadingState extends EditOrganizationState {}

class GetOrganizationDetailsSuccessState extends EditOrganizationState {
  final OrganizationDetailsInEditModel organizationDetailsInEditModel;

  GetOrganizationDetailsSuccessState(this.organizationDetailsInEditModel);
}

class GetOrganizationDetailsErrorState extends EditOrganizationState {
  final String error;
  GetOrganizationDetailsErrorState(this.error);
}