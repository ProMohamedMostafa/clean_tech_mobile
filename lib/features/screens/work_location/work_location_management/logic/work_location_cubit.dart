import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/points_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/all_tasks_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/area_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/area_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/building_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/building_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/building_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/city_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/city_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/floor_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/floor_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/floor_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/organization_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/area_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/deleted_point_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_states.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/organization_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/organization_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/point_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/point_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/point_shifts_details_model.dart';

class WorkLocationCubit extends Cubit<WorkLocationState> {
  WorkLocationCubit() : super(OrganizationsInitialState());

  static WorkLocationCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  AreaListModel? areaModel;
  getArea({String? country}) {
    emit(AreaLoadingState());
    DioHelper.getData(url: ApiConstants.areaUrl, query: {
      "search": searchController.text,
      "country": countryController.text
    }).then((value) {
      areaModel = AreaListModel.fromJson(value!.data);
      emit(AreaSuccessState(areaModel!));
    }).catchError((error) {
      emit(AreaErrorState(error.toString()));
    });
  }

  CityListModel? cityModel;
  getCity({String? country, int? areaId}) {
    emit(CityLoadingState());
    DioHelper.getData(url: ApiConstants.cityUrl, query: {
      "search": searchController.text,
      "country": countryController.text,
      "area": areaId
    }).then((value) {
      cityModel = CityListModel.fromJson(value!.data);
      emit(CitySuccessState(cityModel!));
    }).catchError((error) {
      emit(CityErrorState(error.toString()));
    });
  }

  OrganizationListModel? organizationModel;
  getOrganization({int? areaId, int? cityId}) {
    emit(OrganizationLoadingState());
    DioHelper.getData(url: ApiConstants.organizationUrl, query: {
      "search": searchController.text,
      "area": areaId,
      "city": cityId,
    }).then((value) {
      organizationModel = OrganizationListModel.fromJson(value!.data);
      emit(OrganizationSuccessState(organizationModel!));
    }).catchError((error) {
      emit(OrganizationErrorState(error.toString()));
    });
  }

  BuildingListModel? buildingModel;
  getBuilding({int? cityId, int? organizationId}) {
    emit(BuildingLoadingState());
    DioHelper.getData(url: ApiConstants.buildingUrl, query: {
      "search": searchController.text,
      "city": cityId,
      "organization": organizationId,
    }).then((value) {
      buildingModel = BuildingListModel.fromJson(value!.data);
      emit(BuildingSuccessState(buildingModel!));
    }).catchError((error) {
      emit(BuildingErrorState(error.toString()));
    });
  }

  FloorListModel? floorModel;
  getFloor({int? organizationId, int? buildingId}) {
    emit(FloorLoadingState());
    DioHelper.getData(url: ApiConstants.floorUrl, query: {
      "search": searchController.text,
      "organization": organizationId,
      "building": buildingId,
    }).then((value) {
      floorModel = FloorListModel.fromJson(value!.data);
      emit(FloorSuccessState(floorModel!));
    }).catchError((error) {
      emit(FloorErrorState(error.toString()));
    });
  }

  PointListModel? pointModel;
  getPoint({int? buildingId, int? floorId}) {
    emit(PointLoadingState());
    DioHelper.getData(url: ApiConstants.pointUrl, query: {
      "search": searchController.text,
      "building": buildingId,
      "floor": floorId,
    }).then((value) {
      pointModel = PointListModel.fromJson(value!.data);
      emit(PointSuccessState(pointModel!));
    }).catchError((error) {
      emit(PointErrorState(error.toString()));
    });
  }

  AreaDetailsModel? areaDetailsModel;
  getAreaDetails(int areaId) {
    emit(AreaDetailsLoadingState());
    DioHelper.getData(url: 'areas/$areaId').then((value) {
      areaDetailsModel = AreaDetailsModel.fromJson(value!.data);
      emit(AreaDetailsSuccessState(areaDetailsModel!));
    }).catchError((error) {
      emit(AreaDetailsErrorState(error.toString()));
    });
  }

  AreaManagersDetailsModel? areaManagersDetailsModel;
  getAreaManagersDetails(int areaId) {
    emit(AreaManagersDetailsLoadingState());
    DioHelper.getData(url: 'area/manager/$areaId').then((value) {
      areaManagersDetailsModel = AreaManagersDetailsModel.fromJson(value!.data);
      emit(AreaManagersDetailsSuccessState(areaManagersDetailsModel!));
    }).catchError((error) {
      emit(AreaManagersDetailsErrorState(error.toString()));
    });
  }

  CityDetailsModel? cityDetailsModel;
  getCityDetails(int cityId) {
    emit(CityDetailsLoadingState());
    DioHelper.getData(url: 'cities/$cityId').then((value) {
      cityDetailsModel = CityDetailsModel.fromJson(value!.data);
      emit(CityDetailsSuccessState(cityDetailsModel!));
    }).catchError((error) {
      emit(CityDetailsErrorState(error.toString()));
    });
  }

  CityManagersDetailsModel? cityManagersDetailsModel;
  getCityManagersDetails(int cityId) {
    emit(CityManagersDetailsLoadingState());
    DioHelper.getData(url: 'city/manager/$cityId').then((value) {
      cityManagersDetailsModel = CityManagersDetailsModel.fromJson(value!.data);
      emit(CityManagersDetailsSuccessState(cityManagersDetailsModel!));
    }).catchError((error) {
      emit(CityManagersDetailsErrorState(error.toString()));
    });
  }

  OrganizationDetailsModel? organizationDetailsModel;
  getOrganizationDetails(int organizationId) {
    emit(OrganizationDetailsLoadingState());
    DioHelper.getData(url: 'organizations/$organizationId').then((value) {
      organizationDetailsModel = OrganizationDetailsModel.fromJson(value!.data);
      emit(OrganizationDetailsSuccessState(organizationDetailsModel!));
    }).catchError((error) {
      emit(OrganizationDetailsErrorState(error.toString()));
    });
  }

  OrganizationManagersDetailsModel? organizationManagersDetailsModel;
  getOrganizationManagersDetails(int organizationId) {
    emit(OrganizationManagersDetailsLoadingState());
    DioHelper.getData(url: 'organization/manager/$organizationId')
        .then((value) {
      organizationManagersDetailsModel =
          OrganizationManagersDetailsModel.fromJson(value!.data);
      emit(OrganizationManagersDetailsSuccessState(
          organizationManagersDetailsModel!));
    }).catchError((error) {
      emit(OrganizationManagersDetailsErrorState(error.toString()));
    });
  }

  OrganizationShiftsDetailsModel? organizationShiftsDetailsModel;
  getOrganizationShiftsDetails(int organizationId) {
    emit(OrganizationShiftsDetailsLoadingState());
    DioHelper.getData(url: 'organization/shift/$organizationId').then((value) {
      organizationShiftsDetailsModel =
          OrganizationShiftsDetailsModel.fromJson(value!.data);
      emit(OrganizationShiftsDetailsSuccessState(
          organizationShiftsDetailsModel!));
    }).catchError((error) {
      emit(OrganizationShiftsDetailsErrorState(error.toString()));
    });
  }

  BuildingDetailsModel? buildingDetailsModel;
  getBuildingDetails(int buildingId) {
    emit(BuildingDetailsLoadingState());
    DioHelper.getData(url: 'buildings/$buildingId').then((value) {
      buildingDetailsModel = BuildingDetailsModel.fromJson(value!.data);
      emit(BuildingDetailsSuccessState(buildingDetailsModel!));
    }).catchError((error) {
      emit(BuildingDetailsErrorState(error.toString()));
    });
  }

  BuildingManagersDetailsModel? buildingManagersDetailsModel;
  getBuildingManagersDetails(int buildingId) {
    emit(BuildingManagersDetailsLoadingState());
    DioHelper.getData(url: 'building/manager/$buildingId').then((value) {
      buildingManagersDetailsModel =
          BuildingManagersDetailsModel.fromJson(value!.data);
      emit(BuildingManagersDetailsSuccessState(buildingManagersDetailsModel!));
    }).catchError((error) {
      emit(BuildingManagersDetailsErrorState(error.toString()));
    });
  }

  BuildingShiftsDetailsModel? buildingShiftsDetailsModel;
  getBuildingShiftsDetails(int buildingId) {
    emit(BuildingShiftsDetailsLoadingState());
    DioHelper.getData(url: 'building/shift/$buildingId').then((value) {
      buildingShiftsDetailsModel =
          BuildingShiftsDetailsModel.fromJson(value!.data);
      emit(BuildingShiftsDetailsSuccessState(buildingShiftsDetailsModel!));
    }).catchError((error) {
      emit(BuildingShiftsDetailsErrorState(error.toString()));
    });
  }

  FloorDetailsModel? floorDetailsModel;
  getFloorDetails(int floorId) {
    emit(FloorDetailsLoadingState());
    DioHelper.getData(url: 'floors/$floorId').then((value) {
      floorDetailsModel = FloorDetailsModel.fromJson(value!.data);
      emit(FloorDetailsSuccessState(floorDetailsModel!));
    }).catchError((error) {
      emit(FloorDetailsErrorState(error.toString()));
    });
  }

  FloorManagersDetailsModel? floorManagersDetailsModel;
  getFloorManagersDetails(int floorId) {
    emit(FloorManagersDetailsLoadingState());
    DioHelper.getData(url: 'floor/manager/$floorId').then((value) {
      floorManagersDetailsModel =
          FloorManagersDetailsModel.fromJson(value!.data);
      emit(FloorManagersDetailsSuccessState(floorManagersDetailsModel!));
    }).catchError((error) {
      emit(FloorManagersDetailsErrorState(error.toString()));
    });
  }

  FloorShiftsDetailsModel? floorShiftsDetailsModel;
  getFloorShiftsDetails(int floorId) {
    emit(FloorShiftsDetailsLoadingState());
    DioHelper.getData(url: 'floor/shift/$floorId').then((value) {
      floorShiftsDetailsModel = FloorShiftsDetailsModel.fromJson(value!.data);
      emit(FloorShiftsDetailsSuccessState(floorShiftsDetailsModel!));
    }).catchError((error) {
      emit(FloorShiftsDetailsErrorState(error.toString()));
    });
  }

  PointDetailsModel? pointDetailsModel;
  getPointDetails(int pointId) {
    emit(PointDetailsLoadingState());
    DioHelper.getData(url: 'points/$pointId').then((value) {
      pointDetailsModel = PointDetailsModel.fromJson(value!.data);
      emit(PointDetailsSuccessState(pointDetailsModel!));
    }).catchError((error) {
      emit(PointDetailsErrorState(error.toString()));
    });
  }

  PointManagersDetailsModel? pointManagersDetailsModel;
  getPointManagersDetails(int pointId) {
    emit(PointManagersDetailsLoadingState());
    DioHelper.getData(url: 'point/manager/$pointId').then((value) {
      pointManagersDetailsModel =
          PointManagersDetailsModel.fromJson(value!.data);
      emit(PointManagersDetailsSuccessState(pointManagersDetailsModel!));
    }).catchError((error) {
      emit(PointManagersDetailsErrorState(error.toString()));
    });
  }

  PointShiftsDetailsModel? pointShiftsDetailsModel;
  getPointShiftsDetails(int pointId) {
    emit(PointShiftsDetailsLoadingState());
    DioHelper.getData(url: 'point/shift/$pointId').then((value) {
      pointShiftsDetailsModel = PointShiftsDetailsModel.fromJson(value!.data);
      emit(PointShiftsDetailsSuccessState(pointShiftsDetailsModel!));
    }).catchError((error) {
      emit(PointShiftsDetailsErrorState(error.toString()));
    });
  }

  deleteArea(int id) {
    emit(AreaDeleteLoadingState());
    DioHelper.postData(url: 'areas/delete/$id', data: {'id': id}).then((value) {
      final message = value?.data['message'] ?? "Deleted successfully";
      emit(AreaDeleteSuccessState(message!));
    }).catchError((error) {
      emit(AreaDeleteErrorState(error.toString()));
    });
  }

  deleteCity(int id) {
    emit(CityDeleteLoadingState());
    DioHelper.postData(url: 'cities/delete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "Deleted successfully";
      emit(CityDeleteSuccessState(message!));
    }).catchError((error) {
      emit(CityDeleteErrorState(error.toString()));
    });
  }

  deleteOrganization(int id) {
    emit(OrganizationDeleteLoadingState());
    DioHelper.postData(url: 'organizations/delete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "Deleted successfully";
      emit(OrganizationDeleteSuccessState(message!));
    }).catchError((error) {
      emit(OrganizationDeleteErrorState(error.toString()));
    });
  }

  deleteBuilding(int id) {
    emit(BuildingDeleteLoadingState());
    DioHelper.postData(url: 'buildings/delete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "Deleted successfully";
      emit(BuildingDeleteSuccessState(message!));
    }).catchError((error) {
      emit(BuildingDeleteErrorState(error.toString()));
    });
  }

  deleteFloor(int id) {
    emit(FloorDeleteLoadingState());
    DioHelper.postData(url: 'floors/delete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "Deleted successfully";
      emit(FloorDeleteSuccessState(message!));
    }).catchError((error) {
      emit(FloorDeleteErrorState(error.toString()));
    });
  }

  deletePoint(int id) {
    emit(PointDeleteLoadingState());
    DioHelper.postData(url: 'points/delete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "Deleted successfully";
      emit(PointDeleteSuccessState(message!));
    }).catchError((error) {
      emit(PointDeleteErrorState(error.toString()));
    });
  }

  DeletedAreaList? deletedAreaList;
  getAllDeletedArea() {
    emit(DeletedAreaLoadingState());
    DioHelper.getData(url: ApiConstants.allDeletedAreaList).then((value) {
      deletedAreaList = DeletedAreaList.fromJson(value!.data);
      emit(DeletedAreaSuccessState(deletedAreaList!));
    }).catchError((error) {
      emit(DeletedAreaErrorState(error.toString()));
    });
  }

  DeletedCityList? deletedCityList;
  getAllDeletedCity() {
    emit(DeletedCityLoadingState());
    DioHelper.getData(url: ApiConstants.allDeletedCityList).then((value) {
      deletedCityList = DeletedCityList.fromJson(value!.data);
      emit(DeletedCitySuccessState(deletedCityList!));
    }).catchError((error) {
      emit(DeletedCityErrorState(error.toString()));
    });
  }

  DeletedOrganizationList? deletedOrganizationList;
  getAllDeletedOrganization() {
    emit(DeletedOrganizationLoadingState());
    DioHelper.getData(url: ApiConstants.allDeletedOrganizationList)
        .then((value) {
      deletedOrganizationList = DeletedOrganizationList.fromJson(value!.data);
      emit(DeletedOrganizationSuccessState(deletedOrganizationList!));
    }).catchError((error) {
      emit(DeletedOrganizationErrorState(error.toString()));
    });
  }

  DeletedBuildingList? deletedBuildingList;
  getAllDeletedBuilding() {
    emit(DeletedBuildingLoadingState());
    DioHelper.getData(url: ApiConstants.allDeletedBuildingList).then((value) {
      deletedBuildingList = DeletedBuildingList.fromJson(value!.data);
      emit(DeletedBuildingSuccessState(deletedBuildingList!));
    }).catchError((error) {
      emit(DeletedBuildingErrorState(error.toString()));
    });
  }

  DeletedFloorList? deletedFloorList;
  getAllDeletedFloor() {
    emit(DeletedFloorLoadingState());
    DioHelper.getData(url: ApiConstants.allDeletedFloorList).then((value) {
      deletedFloorList = DeletedFloorList.fromJson(value!.data);
      emit(DeletedFloorSuccessState(deletedFloorList!));
    }).catchError((error) {
      emit(DeletedFloorErrorState(error.toString()));
    });
  }

  DeletedPointList? deletedPointList;
  getAllDeletedPoint() {
    emit(DeletedPointLoadingState());
    DioHelper.getData(url: ApiConstants.allDeletedPointList).then((value) {
      deletedPointList = DeletedPointList.fromJson(value!.data);
      emit(DeletedPointSuccessState(deletedPointList!));
    }).catchError((error) {
      emit(DeletedPointErrorState(error.toString()));
    });
  }

  ///************************* */

  restoreDeletedArea(int id) {
    emit(DeleteRestoreAreaLoadingState());
    DioHelper.postData(url: 'areas/restore/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(DeleteRestoreAreaSuccessState(message));
    }).catchError((error) {
      emit(DeleteRestoreAreaErrorState(error.toString()));
    });
  }

  restoreDeletedCity(int id) {
    emit(DeleteRestoreCityLoadingState());
    DioHelper.postData(url: 'cities/restore/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(DeleteRestoreCitySuccessState(message));
    }).catchError((error) {
      emit(DeleteRestoreCityErrorState(error.toString()));
    });
  }

  restoreDeletedOrganization(int id) {
    emit(DeleteRestoreOrganizationLoadingState());
    DioHelper.postData(url: 'organizations/restore/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(DeleteRestoreOrganizationSuccessState(message));
    }).catchError((error) {
      emit(DeleteRestoreOrganizationErrorState(error.toString()));
    });
  }

  restoreDeletedBuilding(int id) {
    emit(DeleteRestoreBuildingLoadingState());
    DioHelper.postData(url: 'buildings/restore/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(DeleteRestoreBuildingSuccessState(message));
    }).catchError((error) {
      emit(DeleteRestoreBuildingErrorState(error.toString()));
    });
  }

  restoreDeletedFloor(int id) {
    emit(DeleteRestoreFloorLoadingState());
    DioHelper.postData(url: 'floors/restore/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(DeleteRestoreFloorSuccessState(message));
    }).catchError((error) {
      emit(DeleteRestoreFloorErrorState(error.toString()));
    });
  }

  restoreDeletedPoint(int id) {
    emit(DeleteRestorePointLoadingState());
    DioHelper.postData(url: 'points/restore/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(DeleteRestorePointSuccessState(message));
    }).catchError((error) {
      emit(DeleteRestorePointErrorState(error.toString()));
    });
  }

  ///************************* */

  forcedDeletedArea(int id) {
    emit(DeleteForceAreaLoadingState());
    DioHelper.deleteData(url: 'areas/forcedelete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "forced deleted successfully";
      emit(DeleteForceAreaSuccessState(message));
    }).catchError((error) {
      emit(DeleteForceAreaErrorState(error.toString()));
    });
  }

  forcedDeletedCity(int id) {
    emit(DeleteForceCityLoadingState());
    DioHelper.deleteData(url: 'cities/forcedelete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "forced deleted successfully";
      emit(DeleteForceCitySuccessState(message));
    }).catchError((error) {
      emit(DeleteForceCityErrorState(error.toString()));
    });
  }

  forcedDeletedOrganization(int id) {
    emit(DeleteForceOrganizationLoadingState());
    DioHelper.deleteData(url: 'organizations/forcedelete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "forced deleted successfully";
      emit(DeleteForceOrganizationSuccessState(message));
    }).catchError((error) {
      emit(DeleteForceOrganizationErrorState(error.toString()));
    });
  }

  forcedDeletedBuilding(int id) {
    emit(DeleteForceBuildingLoadingState());
    DioHelper.deleteData(url: 'buildings/forcedelete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "forced deleted successfully";
      emit(DeleteForceBuildingSuccessState(message));
    }).catchError((error) {
      emit(DeleteForceBuildingErrorState(error.toString()));
    });
  }

  forcedDeletedFloor(int id) {
    emit(DeleteForceFloorLoadingState());
    DioHelper.deleteData(url: 'floors/forcedelete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "forced deleted successfully";
      emit(DeleteForceFloorSuccessState(message));
    }).catchError((error) {
      emit(DeleteForceFloorErrorState(error.toString()));
    });
  }

  forcedDeletedPoint(int id) {
    emit(DeleteForcePointLoadingState());
    DioHelper.deleteData(url: 'points/forcedelete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "forced deleted successfully";
      emit(DeleteForcePointSuccessState(message));
    }).catchError((error) {
      emit(DeleteForcePointErrorState(error.toString()));
    });
  }

//********************* */

  NationalityModel? nationalityModel;
  getNationality() {
    emit(GetNationalityLoadingState());
    DioHelper.getData(url: ApiConstants.countriesUrl).then((value) {
      nationalityModel = NationalityModel.fromJson(value!.data);
      emit(GetNationalitySuccessState(nationalityModel!));
    }).catchError((error) {
      emit(GetNationalityErrorState(error.toString()));
    });
  }

  AreaModel? areasModel;
  getAreas(String countryName) {
    emit(GetAreaLoadingState());
    DioHelper.getData(url: "areas/country/$countryName").then((value) {
      areasModel = AreaModel.fromJson(value!.data);
      emit(GetAreaSuccessState(areasModel!));
    }).catchError((error) {
      emit(GetAreaErrorState(error.toString()));
    });
  }

  CityModel? cityyModel;
  getCityy(int areaId) {
    emit(GetCityLoadingState());
    DioHelper.getData(url: "cities/area/$areaId").then((value) {
      cityyModel = CityModel.fromJson(value!.data);
      emit(GetCitySuccessState(cityyModel!));
    }).catchError((error) {
      emit(GetCityErrorState(error.toString()));
    });
  }

  OrganizationModel? organizationsModel;
  getOrganizations(int cityId) {
    emit(GetOrganizationLoadingState());
    DioHelper.getData(url: "organizations/city/$cityId").then((value) {
      organizationsModel = OrganizationModel.fromJson(value!.data);
      emit(GetOrganizationSuccessState(organizationsModel!));
    }).catchError((error) {
      emit(GetOrganizationErrorState(error.toString()));
    });
  }

  BuildingModel? buildingsModel;
  getBuildings(int id) {
    emit(GetBuildingLoadingState());
    DioHelper.getData(url: 'buildings/organization/$id').then((value) {
      buildingsModel = BuildingModel.fromJson(value!.data);
      emit(GetBuildingSuccessState(buildingsModel!));
    }).catchError((error) {
      emit(GetBuildingErrorState(error.toString()));
    });
  }

  FloorModel? floorsModel;
  getFloors(int id) {
    emit(GetFloorLoadingState());
    DioHelper.getData(url: 'floors/building/$id').then((value) {
      floorsModel = FloorModel.fromJson(value!.data);
      emit(GetFloorSuccessState(floorsModel!));
    }).catchError((error) {
      emit(GetFloorErrorState(error.toString()));
    });
  }

  PointsModel? pointsModel;
  getPoints(int id) {
    emit(GetPointsLoadingState());
    DioHelper.getData(url: 'points/floor/$id').then((value) {
      pointsModel = PointsModel.fromJson(value!.data);
      emit(GetPointsSuccessState(pointsModel!));
    }).catchError((error) {
      emit(GetPointsErrorState(error.toString()));
    });
  }

//******************************** */
  AreaTreeModel? areaTreeModel;
  getAreatree(int id) {
    emit(AreaTreeLoadingState());
    DioHelper.getData(url: 'areas/tree/$id').then((value) {
      areaTreeModel = AreaTreeModel.fromJson(value!.data);
      emit(AreaTreeSuccessState(areaTreeModel!));
    }).catchError((error) {
      emit(AreaTreeErrorState(error.toString()));
    });
  }

  CityTreeModel? cityTreeModel;
  getCitytree(int id) {
    emit(CityTreeLoadingState());
    DioHelper.getData(url: 'cities/tree/$id').then((value) {
      cityTreeModel = CityTreeModel.fromJson(value!.data);
      emit(CityTreeSuccessState(cityTreeModel!));
    }).catchError((error) {
      emit(CityTreeErrorState(error.toString()));
    });
  }

  OrganizationTreeModel? organizationTreeModel;
  getOrganizationtree(int id) {
    emit(OrganizationTreeLoadingState());
    DioHelper.getData(url: 'organizations/tree/$id').then((value) {
      organizationTreeModel = OrganizationTreeModel.fromJson(value!.data);
      emit(OrganizationTreeSuccessState(organizationTreeModel!));
    }).catchError((error) {
      emit(OrganizationTreeErrorState(error.toString()));
    });
  }

  BuildingTreeModel? buildingTreeModel;
  getBuildingtree(int id) {
    emit(BuildingTreeLoadingState());
    DioHelper.getData(url: 'buildings/tree/$id').then((value) {
      buildingTreeModel = BuildingTreeModel.fromJson(value!.data);
      emit(BuildingTreeSuccessState(buildingTreeModel!));
    }).catchError((error) {
      emit(BuildingTreeErrorState(error.toString()));
    });
  }

  FloorTreeModel? floorTreeModel;
  getFloortree(int id) {
    emit(FloorTreeLoadingState());
    DioHelper.getData(url: 'floors/tree/$id').then((value) {
      floorTreeModel = FloorTreeModel.fromJson(value!.data);
      emit(FloorTreeSuccessState(floorTreeModel!));
    }).catchError((error) {
      emit(FloorTreeErrorState(error.toString()));
    });
  }

//********************** */
  AllTasksModel? allareaTasksModel;
  getareaTasks(
    int? areaId,
  ) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'area': areaId,
    }).then((value) {
      allareaTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allareaTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

  AllTasksModel? allcityTasksModel;
  getcityTasks(int? cityId) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'city': cityId,
    }).then((value) {
      allcityTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allcityTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

  AllTasksModel? allorganizationTasksModel;
  getorganizationTasks(int? organizationId) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'organization': organizationId,
    }).then((value) {
      allorganizationTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allorganizationTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

  AllTasksModel? allbuildingTasksModel;
  getbuildingTasks(int? buildingId) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'building': buildingId,
    }).then((value) {
      allbuildingTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allbuildingTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

  AllTasksModel? allfloorTasksModel;
  getfloorTasks(int? floorId) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'floor': floorId,
    }).then((value) {
      allfloorTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allfloorTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

  AllTasksModel? allPointTasksModel;
  getPointTasks(int? pointId) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'point': pointId,
    }).then((value) {
      allPointTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allPointTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

//*********************** */

  AttendanceHistoryModel? attendanceHistoryAreaModel;
  getAttendanceHistoryArea(int id) {
    emit(AttendanceHistoryAreaLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'areaId': id,
    }).then((value) {
      attendanceHistoryAreaModel = AttendanceHistoryModel.fromJson(value!.data);
      emit(AttendanceHistoryAreaSuccessState(attendanceHistoryAreaModel!));
    }).catchError((error) {
      emit(AttendanceHistoryAreaErrorState(error.toString()));
    });
  }

  AttendanceHistoryModel? attendanceHistoryCityModel;
  getAttendanceHistoryCity(int id) {
    emit(AttendanceHistoryCityLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'cityId': id,
    }).then((value) {
      attendanceHistoryCityModel = AttendanceHistoryModel.fromJson(value!.data);
      emit(AttendanceHistoryCitySuccessState(attendanceHistoryCityModel!));
    }).catchError((error) {
      emit(AttendanceHistoryCityErrorState(error.toString()));
    });
  }

  AttendanceHistoryModel? attendanceHistoryOrganizationModel;
  getAttendanceHistoryOrganization(int id) {
    emit(AttendanceHistoryOrganizationLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'buildingId': id,
    }).then((value) {
      attendanceHistoryOrganizationModel =
          AttendanceHistoryModel.fromJson(value!.data);
      emit(AttendanceHistoryOrganizationSuccessState(
          attendanceHistoryOrganizationModel!));
    }).catchError((error) {
      emit(AttendanceHistoryOrganizationErrorState(error.toString()));
    });
  }

  AttendanceHistoryModel? attendanceHistoryBuildingModel;
  getAttendanceHistoryBuilding(int id) {
    emit(AttendanceHistoryBuildingLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'buildingId': id,
    }).then((value) {
      attendanceHistoryBuildingModel =
          AttendanceHistoryModel.fromJson(value!.data);
      emit(AttendanceHistoryBuildingSuccessState(
          attendanceHistoryBuildingModel!));
    }).catchError((error) {
      emit(AttendanceHistoryBuildingErrorState(error.toString()));
    });
  }

  AttendanceHistoryModel? attendanceHistoryFloorModel;
  getAttendanceHistoryFloor(int id) {
    emit(AttendanceHistoryFloorLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'floorId': id,
    }).then((value) {
      attendanceHistoryFloorModel =
          AttendanceHistoryModel.fromJson(value!.data);
      emit(AttendanceHistoryFloorSuccessState(attendanceHistoryFloorModel!));
    }).catchError((error) {
      emit(AttendanceHistoryFloorErrorState(error.toString()));
    });
  }

  AttendanceHistoryModel? attendanceHistoryPointModel;
  getAttendanceHistoryPoint(int id) {
    emit(AttendanceHistoryPointLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'pointId': id,
    }).then((value) {
      attendanceHistoryPointModel =
          AttendanceHistoryModel.fromJson(value!.data);
      emit(AttendanceHistoryPointSuccessState(attendanceHistoryPointModel!));
    }).catchError((error) {
      emit(AttendanceHistoryPointErrorState(error.toString()));
    });
  }

//*********************************** */

  AttendanceLeavesModel? attendanceLeavesAreaModel;
  getAllLeavesArea(int id) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'area': id,
    }).then((value) {
      attendanceLeavesAreaModel = AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesAreaModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }

  AttendanceLeavesModel? attendanceLeavesCityModel;
  getAllLeavesCity(int id) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'city': id,
    }).then((value) {
      attendanceLeavesCityModel = AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesCityModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }

  AttendanceLeavesModel? attendanceLeavesOrganizationModel;
  getAllLeavesOrganization(int id) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'organization': id,
    }).then((value) {
      attendanceLeavesOrganizationModel =
          AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesOrganizationModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }

  AttendanceLeavesModel? attendanceLeavesBuildingModel;
  getAllLeavesBuilding(int id) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'building': id,
    }).then((value) {
      attendanceLeavesBuildingModel =
          AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesBuildingModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }

  AttendanceLeavesModel? attendanceLeavesFloorModel;
  getAllLeavesFloor(int id) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'floor': id,
    }).then((value) {
      attendanceLeavesFloorModel = AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesFloorModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }

  AttendanceLeavesModel? attendanceLeavesPointModel;
  getAllLeavesPoint(int id) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'point': id,
    }).then((value) {
      attendanceLeavesPointModel = AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesPointModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }
}
