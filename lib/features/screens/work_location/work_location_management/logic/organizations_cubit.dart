import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
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
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/organizations_states.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_organization_details/data/model/organization_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_organization_details/data/model/organization_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_point_details/data/model/point_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_point_details/data/model/point_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_point_details/data/model/point_shifts_details_model.dart';

class OrganizationsCubit extends Cubit<OrganizationsState> {
  OrganizationsCubit() : super(OrganizationsInitialState());

  static OrganizationsCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  AreaListModel? areaModel;
  getArea() {
    emit(AreaLoadingState());
    DioHelper.getData(
        url: ApiConstants.areaUrl,
        query: {"search": searchController.text}).then((value) {
      areaModel = AreaListModel.fromJson(value!.data);
      emit(AreaSuccessState(areaModel!));
    }).catchError((error) {
      emit(AreaErrorState(error.toString()));
    });
  }

  CityListModel? cityModel;
  getCity() {
    emit(CityLoadingState());
    DioHelper.getData(
        url: ApiConstants.cityUrl,
        query: {"search": searchController.text}).then((value) {
      cityModel = CityListModel.fromJson(value!.data);
      emit(CitySuccessState(cityModel!));
    }).catchError((error) {
      emit(CityErrorState(error.toString()));
    });
  }

  OrganizationListModel? organizationModel;
  getOrganization() {
    emit(OrganizationLoadingState());
    DioHelper.getData(
        url: ApiConstants.organizationUrl,
        query: {"search": searchController.text}).then((value) {
      organizationModel = OrganizationListModel.fromJson(value!.data);
      emit(OrganizationSuccessState(organizationModel!));
    }).catchError((error) {
      emit(OrganizationErrorState(error.toString()));
    });
  }

  BuildingListModel? buildingModel;
  getBuilding() {
    emit(BuildingLoadingState());
    DioHelper.getData(
        url: ApiConstants.buildingUrl,
        query: {"search": searchController.text}).then((value) {
      buildingModel = BuildingListModel.fromJson(value!.data);
      emit(BuildingSuccessState(buildingModel!));
    }).catchError((error) {
      emit(BuildingErrorState(error.toString()));
    });
  }

  FloorListModel? floorModel;
  getFloor() {
    emit(FloorLoadingState());
    DioHelper.getData(
        url: ApiConstants.floorUrl,
        query: {"search": searchController.text}).then((value) {
      floorModel = FloorListModel.fromJson(value!.data);
      emit(FloorSuccessState(floorModel!));
    }).catchError((error) {
      emit(FloorErrorState(error.toString()));
    });
  }

  PointListModel? pointModel;
  getPoint() {
    emit(PointLoadingState());
    DioHelper.getData(
        url: ApiConstants.pointUrl,
        query: {"search": searchController.text}).then((value) {
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
}
