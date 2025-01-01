import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_area_details/data/model/area_details_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_building_details/data/model/building_details_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_city_details/data/model/city_details_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_floor_details/data/model/floor_details_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_organization_details/data/model/organization_details_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/data/model/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/data/model/point_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/logic/organizations_states.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_point_details/data/model/point_details_model.dart';

class OrganizationsCubit extends Cubit<OrganizationsState> {
  OrganizationsCubit() : super(OrganizationsInitialState());

  static OrganizationsCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  AreaListModel? areaModel;
  getArea() {
    emit(AreaLoadingState());
    DioHelper.getData(url: ApiConstants.areaUrl).then((value) {
      areaModel = AreaListModel.fromJson(value!.data);
      emit(AreaSuccessState(areaModel!));
    }).catchError((error) {
      emit(AreaErrorState(error.toString()));
    });
  }

  CityListModel? cityModel;
  getCity() {
    emit(CityLoadingState());
    DioHelper.getData(url: ApiConstants.cityUrl).then((value) {
      cityModel = CityListModel.fromJson(value!.data);
      emit(CitySuccessState(cityModel!));
    }).catchError((error) {
      emit(CityErrorState(error.toString()));
    });
  }

  OrganizationListModel? organizationModel;
  getOrganization() {
    emit(OrganizationLoadingState());
    DioHelper.getData(url: ApiConstants.organizationUrl).then((value) {
      organizationModel = OrganizationListModel.fromJson(value!.data);
      emit(OrganizationSuccessState(organizationModel!));
    }).catchError((error) {
      emit(OrganizationErrorState(error.toString()));
    });
  }

  BuildingListModel? buildingModel;
  getBuilding() {
    emit(BuildingLoadingState());
    DioHelper.getData(url: ApiConstants.buildingUrl).then((value) {
      buildingModel = BuildingListModel.fromJson(value!.data);
      emit(BuildingSuccessState(buildingModel!));
    }).catchError((error) {
      emit(BuildingErrorState(error.toString()));
    });
  }

  FloorListModel? floorModel;
  getFloor() {
    emit(FloorLoadingState());
    DioHelper.getData(url: ApiConstants.floorUrl).then((value) {
      floorModel = FloorListModel.fromJson(value!.data);
      emit(FloorSuccessState(floorModel!));
    }).catchError((error) {
      emit(FloorErrorState(error.toString()));
    });
  }

  PointListModel? pointModel;
  getPoint() {
    emit(PointLoadingState());
    DioHelper.getData(url: ApiConstants.pointUrl).then((value) {
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
}
