import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_area_details/data/model/area_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_area_details/data/model/area_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_building_details/data/model/building_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_building_details/data/model/building_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_building_details/data/model/building_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_city_details/data/model/city_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_city_details/data/model/city_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_floor_details/data/model/floor_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_floor_details/data/model/floor_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_floor_details/data/model/floor_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_organization_details/data/model/organization_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_organization_details/data/model/organization_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_organization_details/data/model/organization_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_point_details/data/model/point_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_point_details/data/model/point_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_point_details/data/model/point_shifts_details_model.dart';

import '../../../integrations/data/models/city_model.dart';

abstract class OrganizationsState {}

class OrganizationsInitialState extends OrganizationsState {}

class OrganizationsLoadingState extends OrganizationsState {}

class OrganizationsSuccessState extends OrganizationsState {}

class OrganizationsErrorState extends OrganizationsState {
  final String error;
  OrganizationsErrorState(this.error);
}

//******************************** */

class AreaLoadingState extends OrganizationsState {}

class AreaSuccessState extends OrganizationsState {
  final AreaListModel areaModel;

  AreaSuccessState(this.areaModel);
}

class AreaErrorState extends OrganizationsState {
  final String error;
  AreaErrorState(this.error);
}
//******************************** */

class CityLoadingState extends OrganizationsState {}

class CitySuccessState extends OrganizationsState {
  final CityListModel cityModel;

  CitySuccessState(this.cityModel);
}

class CityErrorState extends OrganizationsState {
  final String error;
  CityErrorState(this.error);
}
//******************************** */

class OrganizationLoadingState extends OrganizationsState {}

class OrganizationSuccessState extends OrganizationsState {
  final OrganizationListModel organizationModel;

  OrganizationSuccessState(this.organizationModel);
}

class OrganizationErrorState extends OrganizationsState {
  final String error;
  OrganizationErrorState(this.error);
}
//******************************** */

class BuildingLoadingState extends OrganizationsState {}

class BuildingSuccessState extends OrganizationsState {
  final BuildingListModel buildingModel;

  BuildingSuccessState(this.buildingModel);
}

class BuildingErrorState extends OrganizationsState {
  final String error;
  BuildingErrorState(this.error);
}
//******************************** */

class FloorLoadingState extends OrganizationsState {}

class FloorSuccessState extends OrganizationsState {
  final FloorListModel floorModel;

  FloorSuccessState(this.floorModel);
}

class FloorErrorState extends OrganizationsState {
  final String error;
  FloorErrorState(this.error);
}

//******************************** */

class PointLoadingState extends OrganizationsState {}

class PointSuccessState extends OrganizationsState {
  final PointListModel pointModel;

  PointSuccessState(this.pointModel);
}

class PointErrorState extends OrganizationsState {
  final String error;
  PointErrorState(this.error);
}
//******************************** */

class GetCityLoadingState extends OrganizationsState {}

class GetCitySuccessState extends OrganizationsState {
  final CityModel cityDetailsModel;

  GetCitySuccessState(this.cityDetailsModel);
}

class GetCityErrorState extends OrganizationsState {
  final String error;
  GetCityErrorState(this.error);
}

//******************************** */

class AreaDetailsLoadingState extends OrganizationsState {}

class AreaDetailsSuccessState extends OrganizationsState {
  final AreaDetailsModel areaDetailsModel;

  AreaDetailsSuccessState(this.areaDetailsModel);
}

class AreaDetailsErrorState extends OrganizationsState {
  final String error;
  AreaDetailsErrorState(this.error);
}
//******************************** */

class AreaManagersDetailsLoadingState extends OrganizationsState {}

class AreaManagersDetailsSuccessState extends OrganizationsState {
  final AreaManagersDetailsModel areaManagersDetailsModel;

  AreaManagersDetailsSuccessState(this.areaManagersDetailsModel);
}

class AreaManagersDetailsErrorState extends OrganizationsState {
  final String error;
  AreaManagersDetailsErrorState(this.error);
}
//******************************** */

class OrganizationDetailsLoadingState extends OrganizationsState {}

class OrganizationDetailsSuccessState extends OrganizationsState {
  final OrganizationDetailsModel organizationDetailsModel;

  OrganizationDetailsSuccessState(this.organizationDetailsModel);
}

class OrganizationDetailsErrorState extends OrganizationsState {
  final String error;
  OrganizationDetailsErrorState(this.error);
} 
//********************************* */

class OrganizationManagersDetailsLoadingState extends OrganizationsState {}

class OrganizationManagersDetailsSuccessState extends OrganizationsState {
  final OrganizationManagersDetailsModel organizationManagersDetailsModel;

  OrganizationManagersDetailsSuccessState(
      this.organizationManagersDetailsModel);
}

class OrganizationManagersDetailsErrorState extends OrganizationsState {
  final String error;
  OrganizationManagersDetailsErrorState(this.error);
}

//********************************* */
class OrganizationShiftsDetailsLoadingState extends OrganizationsState {}

class OrganizationShiftsDetailsSuccessState extends OrganizationsState {
  final OrganizationShiftsDetailsModel organizationShiftsDetailsModel;

  OrganizationShiftsDetailsSuccessState(this.organizationShiftsDetailsModel);
}

class OrganizationShiftsDetailsErrorState extends OrganizationsState {
  final String error;
  OrganizationShiftsDetailsErrorState(this.error);
}

//******************************** */

class CityDetailsLoadingState extends OrganizationsState {}

class CityDetailsSuccessState extends OrganizationsState {
  final CityDetailsModel cityDetailsModel;

  CityDetailsSuccessState(this.cityDetailsModel);
}

class CityDetailsErrorState extends OrganizationsState {
  final String error;
  CityDetailsErrorState(this.error);
}

//********************************* */
class CityManagersDetailsLoadingState extends OrganizationsState {}

class CityManagersDetailsSuccessState extends OrganizationsState {
  final CityManagersDetailsModel cityManagersDetailsModel;

  CityManagersDetailsSuccessState(this.cityManagersDetailsModel);
}

class CityManagersDetailsErrorState extends OrganizationsState {
  final String error;
  CityManagersDetailsErrorState(this.error);
}

//******************************** */

class BuildingDetailsLoadingState extends OrganizationsState {}

class BuildingDetailsSuccessState extends OrganizationsState {
  final BuildingDetailsModel buildingDetailsModel;

  BuildingDetailsSuccessState(this.buildingDetailsModel);
}

class BuildingDetailsErrorState extends OrganizationsState {
  final String error;
  BuildingDetailsErrorState(this.error);
}

//********************************* */
class BuildingManagersDetailsLoadingState extends OrganizationsState {}

class BuildingManagersDetailsSuccessState extends OrganizationsState {
  final BuildingManagersDetailsModel buildingManagersDetailsModel;

  BuildingManagersDetailsSuccessState(this.buildingManagersDetailsModel);
}

class BuildingManagersDetailsErrorState extends OrganizationsState {
  final String error;
  BuildingManagersDetailsErrorState(this.error);
}

//********************************* */
class BuildingShiftsDetailsLoadingState extends OrganizationsState {}

class BuildingShiftsDetailsSuccessState extends OrganizationsState {
  final BuildingShiftsDetailsModel buildingShiftsDetailsModel;

  BuildingShiftsDetailsSuccessState(this.buildingShiftsDetailsModel);
}

class BuildingShiftsDetailsErrorState extends OrganizationsState {
  final String error;
  BuildingShiftsDetailsErrorState(this.error);
}
//******************************** */

class FloorDetailsLoadingState extends OrganizationsState {}

class FloorDetailsSuccessState extends OrganizationsState {
  final FloorDetailsModel floorDetailsModel;

  FloorDetailsSuccessState(this.floorDetailsModel);
}

class FloorDetailsErrorState extends OrganizationsState {
  final String error;
  FloorDetailsErrorState(this.error);
}

//********************************* */
class FloorManagersDetailsLoadingState extends OrganizationsState {}

class FloorManagersDetailsSuccessState extends OrganizationsState {
  final FloorManagersDetailsModel floorManagersDetailsModel;

  FloorManagersDetailsSuccessState(this.floorManagersDetailsModel);
}

class FloorManagersDetailsErrorState extends OrganizationsState {
  final String error;
  FloorManagersDetailsErrorState(this.error);
}

//********************************* */
class FloorShiftsDetailsLoadingState extends OrganizationsState {}

class FloorShiftsDetailsSuccessState extends OrganizationsState {
  final FloorShiftsDetailsModel floorShiftsDetailsModel;

  FloorShiftsDetailsSuccessState(this.floorShiftsDetailsModel);
}

class FloorShiftsDetailsErrorState extends OrganizationsState {
  final String error;
  FloorShiftsDetailsErrorState(this.error);
}
//******************************** */

class PointDetailsLoadingState extends OrganizationsState {}

class PointDetailsSuccessState extends OrganizationsState {
  final PointDetailsModel pointDetailsModel;

  PointDetailsSuccessState(this.pointDetailsModel);
}

class PointDetailsErrorState extends OrganizationsState {
  final String error;
  PointDetailsErrorState(this.error);
}

//********************************* */
class PointManagersDetailsLoadingState extends OrganizationsState {}

class PointManagersDetailsSuccessState extends OrganizationsState {
  final PointManagersDetailsModel pointManagersDetailsModel;

  PointManagersDetailsSuccessState(this.pointManagersDetailsModel);
}

class PointManagersDetailsErrorState extends OrganizationsState {
  final String error;
  PointManagersDetailsErrorState(this.error);
}

//********************************* */
class PointShiftsDetailsLoadingState extends OrganizationsState {}

class PointShiftsDetailsSuccessState extends OrganizationsState {
  final PointShiftsDetailsModel pointShiftsDetailsModel;

  PointShiftsDetailsSuccessState(this.pointShiftsDetailsModel);
}

class PointShiftsDetailsErrorState extends OrganizationsState {
  final String error;
  PointShiftsDetailsErrorState(this.error);
}
//******************************** */

class AreaDeleteLoadingState extends OrganizationsState {}

class AreaDeleteSuccessState extends OrganizationsState {
  final String message;

  AreaDeleteSuccessState(this.message);
}

class AreaDeleteErrorState extends OrganizationsState {
  final String error;
  AreaDeleteErrorState(this.error);
}

//******************************** */
class CityDeleteLoadingState extends OrganizationsState {}

class CityDeleteSuccessState extends OrganizationsState {
  final String message;

  CityDeleteSuccessState(this.message);
}

class CityDeleteErrorState extends OrganizationsState {
  final String error;
  CityDeleteErrorState(this.error);
}

//******************************** */
class OrganizationDeleteLoadingState extends OrganizationsState {}

class OrganizationDeleteSuccessState extends OrganizationsState {
  final String message;

  OrganizationDeleteSuccessState(this.message);
}

class OrganizationDeleteErrorState extends OrganizationsState {
  final String error;
  OrganizationDeleteErrorState(this.error);
}

//******************************** */
class BuildingDeleteLoadingState extends OrganizationsState {}

class BuildingDeleteSuccessState extends OrganizationsState {
  final String message;

  BuildingDeleteSuccessState(this.message);
}

class BuildingDeleteErrorState extends OrganizationsState {
  final String error;
  BuildingDeleteErrorState(this.error);
}
//******************************** */

class FloorDeleteLoadingState extends OrganizationsState {}

class FloorDeleteSuccessState extends OrganizationsState {
  final String message;

  FloorDeleteSuccessState(this.message);
}

class FloorDeleteErrorState extends OrganizationsState {
  final String error;
  FloorDeleteErrorState(this.error);
}
//******************************** */

class PointDeleteLoadingState extends OrganizationsState {}

class PointDeleteSuccessState extends OrganizationsState {
  final String message;

  PointDeleteSuccessState(this.message);
}

class PointDeleteErrorState extends OrganizationsState {
  final String error;
  PointDeleteErrorState(this.error);
}
