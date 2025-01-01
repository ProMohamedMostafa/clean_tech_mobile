import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_organization/data/model/edit_organization_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_organization/data/model/organization_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_organization/logic/edit_organization_state.dart';

class EditOrganizationCubit extends Cubit<EditOrganizationState> {
  EditOrganizationCubit() : super(EditOrganizationInitialState());

  static EditOrganizationCubit get(context) => BlocProvider.of(context);
  TextEditingController nationalityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController managerNameController = TextEditingController();
  TextEditingController shiftsNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  EditOrganizationModel? editOrganizationModel;
  
  editOrganization(int? id, cityId, areaId) async {
    emit(EditOrganizationLoadingState());
    try {
      final response =
          await DioHelper.putData(url: ApiConstants.organizationEditUrl, data: {
        "id": id,
        "name": organizationController.text.isEmpty
            ? organizationDetailsInEditModel!.data!.name
            : organizationController.text,
        "cityId": cityController.text.isEmpty
            ? organizationDetailsInEditModel!.data!.cityId
            : cityId,
        "areaId": areaController.text.isEmpty
            ? organizationDetailsInEditModel!.data!.areaId
            : areaId,
        "countryName": nationalityController.text.isEmpty
            ? organizationDetailsInEditModel!.data!.countryName
            : nationalityController.text,
        "managerIds": null,
        "shiftsIds": null,
      });
      editOrganizationModel = EditOrganizationModel.fromJson(response!.data);
      emit(EditOrganizationSuccessState(editOrganizationModel!));
    } catch (error) {
      emit(EditOrganizationErrorState(error.toString()));
    }
  }

  OrganizationDetailsInEditModel? organizationDetailsInEditModel;
  getOrganizationDetailsInEdit(int id) {
    emit(GetOrganizationDetailsLoadingState());
    DioHelper.getData(url: 'organizations/$id').then((value) {
      organizationDetailsInEditModel =
          OrganizationDetailsInEditModel.fromJson(value!.data);
      emit(GetOrganizationDetailsSuccessState(organizationDetailsInEditModel!));
    }).catchError((error) {
      emit(GetOrganizationDetailsErrorState(error.toString()));
    });
  }

  OrganizationNationalityModel? nationalityModel;
  getNationality() {
    emit(GetOrganizationNationalityLoadingState());
    DioHelper.getData(url: ApiConstants.countriesUrl).then((value) {
      nationalityModel = OrganizationNationalityModel.fromJson(value!.data);
      emit(GetOrganizationNationalitySuccessState(nationalityModel!));
    }).catchError((error) {
      emit(GetOrganizationNationalityErrorState(error.toString()));
    });
  }

  AreaModel? areaModel;
  getArea(String countryName) {
    emit(GetOrganizationAreaLoadingState());
    DioHelper.getData(url: "areas/country/$countryName").then((value) {
      areaModel = AreaModel.fromJson(value!.data);
      emit(GetOrganizationAreaSuccessState(areaModel!));
    }).catchError((error) {
      emit(GetOrganizationAreaErrorState(error.toString()));
    });
  }

  CityModel? cityModel;
  getCity(int areaId) {
    emit(GetOrganizationCityLoadingState());
    DioHelper.getData(url: "cities/area/$areaId").then((value) {
      cityModel = CityModel.fromJson(value!.data);
      emit(GetOrganizationCitySuccessState(cityModel!));
    }).catchError((error) {
      emit(GetOrganizationCityErrorState(error.toString()));
    });
  }

  OrganizationModel? organizationModel;
  getOrganization(int cityId) {
    emit(GetOrganizationOrganizationsLoadingState());
    DioHelper.getData(url: "organizations/city/$cityId").then((value) {
      organizationModel = OrganizationModel.fromJson(value!.data);
      emit(GetOrganizationOrganizationsSuccessState(organizationModel!));
    }).catchError((error) {
      emit(GetOrganizationOrganizationsErrorState(error.toString()));
    });
  }

  // BuildingModel? buildingModel;
  // getBuilding(int id) {
  //   emit(GetOrganizationBuildingLoadingState());
  //   DioHelper.getData(url: 'buildings/organization/$id').then((value) {
  //     buildingModel = BuildingModel.fromJson(value!.data);
  //     emit(GetOrganizationBuildingSuccessState(buildingModel!));
  //   }).catchError((error) {
  //     emit(GetOrganizationBuildingErrorState(error.toString()));
  //   });
  // }

  // FloorModel? floorModel;
  // getFloor(int id) {
  //   emit(GetOrganizationFloorLoadingState());
  //   DioHelper.getData(url: 'floors/building/$id').then((value) {
  //     floorModel = FloorModel.fromJson(value!.data);
  //     emit(GetOrganizationFloorSuccessState(floorModel!));
  //   }).catchError((error) {
  //     emit(GetOrganizationFloorErrorState(error.toString()));
  //   });
  // }

  // PointsModel? pointsModel;
  // getPoints(int id) {
  //   emit(GetOrganizationPointsLoadingState());
  //   DioHelper.getData(url: 'points/floor/$id').then((value) {
  //     pointsModel = PointsModel.fromJson(value!.data);
  //     emit(GetOrganizationPointsSuccessState(pointsModel!));
  //   }).catchError((error) {
  //     emit(GetOrganizationPointsErrorState(error.toString()));
  //   });
  // }
}
