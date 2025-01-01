import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/floor_organization_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/points_model.dart';

import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_point/data/model/edit_point_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_point/data/model/point_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_point/logic/edit_point_state.dart';

class EditPointCubit extends Cubit<EditPointState> {
  EditPointCubit() : super(EditPointInitialState());

  static EditPointCubit get(context) => BlocProvider.of(context);
  TextEditingController nationalityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController pointNumberController = TextEditingController();
  TextEditingController pointDescriptionController = TextEditingController();
  TextEditingController managerNameController = TextEditingController();
  TextEditingController shiftsNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  PointEditModel? editPointModel;
  editPoint(
      int? id, cityId, areaId, organizationId, buildingId, floorId) async {
    emit(EditPointLoadingState());
    try {
      final response =
          await DioHelper.putData(url: ApiConstants.pointEditUrl, data: {
        "id": id,
        "name": pointController.text.isEmpty
            ? pointDetailsInEditModel!.data!.name
            : pointController.text,
        "number": pointNumberController.text.isEmpty
            ? pointDetailsInEditModel!.data!.number
            : pointNumberController.text,
        "description": pointDescriptionController.text.isEmpty
            ? pointDetailsInEditModel!.data!.description
            : pointDescriptionController.text,
        "floorId": floorController.text.isEmpty
            ? pointDetailsInEditModel!.data!.floorId
            : floorId,
        "buildingId": buildingController.text.isEmpty
            ? pointDetailsInEditModel!.data!.buildingId
            : buildingId,
        "organizationId": organizationController.text.isEmpty
            ? pointDetailsInEditModel!.data!.organizationId
            : organizationId,
        "cityId": cityController.text.isEmpty
            ? pointDetailsInEditModel!.data!.cityId
            : cityId,
        "areaId": areaController.text.isEmpty
            ? pointDetailsInEditModel!.data!.areaId
            : areaId,
        "countryName": nationalityController.text.isEmpty
            ? pointDetailsInEditModel!.data!.countryName
            : nationalityController.text,
        "managerIds": null,
        "shiftsIds": null,
      });
      editPointModel = PointEditModel.fromJson(response!.data);
      emit(EditPointSuccessState(editPointModel!));
    } catch (error) {
      emit(EditPointErrorState(error.toString()));
    }
  }

  PointDetailsInEditModel? pointDetailsInEditModel;
  getPointDetailsInEdit(int id) {
    emit(GetPointDetailsLoadingState());
    DioHelper.getData(url: 'points/$id').then((value) {
      pointDetailsInEditModel = PointDetailsInEditModel.fromJson(value!.data);
      emit(GetPointDetailsSuccessState(pointDetailsInEditModel!));
    }).catchError((error) {
      emit(GetPointDetailsErrorState(error.toString()));
    });
  }

  OrganizationNationalityModel? nationalityModel;
  getNationality() {
    emit(GetNationalityLoadingState());
    DioHelper.getData(url: ApiConstants.countriesUrl).then((value) {
      nationalityModel = OrganizationNationalityModel.fromJson(value!.data);
      emit(GetNationalitySuccessState(nationalityModel!));
    }).catchError((error) {
      emit(GetNationalityErrorState(error.toString()));
    });
  }

  AreaModel? areaModel;
  getArea(String countryName) {
    emit(GetAreaLoadingState());
    DioHelper.getData(url: "areas/country/$countryName").then((value) {
      areaModel = AreaModel.fromJson(value!.data);
      emit(GetAreaSuccessState(areaModel!));
    }).catchError((error) {
      emit(GetAreaErrorState(error.toString()));
    });
  }

  CityModel? cityModel;
  getCity(int areaId) {
    emit(GetCityLoadingState());
    DioHelper.getData(url: "cities/area/$areaId").then((value) {
      cityModel = CityModel.fromJson(value!.data);
      emit(GetCitySuccessState(cityModel!));
    }).catchError((error) {
      emit(GetCityErrorState(error.toString()));
    });
  }

  OrganizationModel? organizationModel;
  getOrganization(int cityId) {
    emit(GetOrganizationsLoadingState());
    DioHelper.getData(url: "organizations/city/$cityId").then((value) {
      organizationModel = OrganizationModel.fromJson(value!.data);
      emit(GetOrganizationsSuccessState(organizationModel!));
    }).catchError((error) {
      emit(GetOrganizationsErrorState(error.toString()));
    });
  }

  BuildingModel? buildingModel;
  getBuilding(int buildingId) {
    emit(GetBuildingLoadingState());
    DioHelper.getData(url: 'buildings/organization/$buildingId').then((value) {
      buildingModel = BuildingModel.fromJson(value!.data);
      emit(GetBuildingSuccessState(buildingModel!));
    }).catchError((error) {
      emit(GetBuildingErrorState(error.toString()));
    });
  }

  FloorModel? floorModel;
  getFloor(int floorId) {
    emit(GetFloorLoadingState());
    DioHelper.getData(url: 'floors/building/$floorId').then((value) {
      floorModel = FloorModel.fromJson(value!.data);
      emit(GetFloorSuccessState(floorModel!));
    }).catchError((error) {
      emit(GetFloorErrorState(error.toString()));
    });
  }

  PointsModel? pointsModel;
  getPoints(int pointId) {
    emit(GetPointLoadingState());
    DioHelper.getData(url: 'points/floor/$pointId').then((value) {
      pointsModel = PointsModel.fromJson(value!.data);
      emit(GetPointSuccessState(pointsModel!));
    }).catchError((error) {
      emit(GetPointErrorState(error.toString()));
    });
  }
}
