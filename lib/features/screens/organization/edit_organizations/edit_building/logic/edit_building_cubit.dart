import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_building/data/model/building_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_building/data/model/edit_building_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_building/logic/edit_building_state.dart';

class EditBuildingCubit extends Cubit<EditBuildingState> {
  EditBuildingCubit() : super(EditBuildingInitialState());

  static EditBuildingCubit get(context) => BlocProvider.of(context);
  TextEditingController nationalityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController buildingNumberController = TextEditingController();
  TextEditingController buildingDescriptionController = TextEditingController();
  TextEditingController managerNameController = TextEditingController();
  TextEditingController shiftsNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  BuildingEditModel? editBuildingModel;
  editBuilding(int? id, cityId, areaId, organizationId) async {
    emit(EditBuildingLoadingState());
    try {
      final response =
          await DioHelper.putData(url: ApiConstants.buildingEditUrl, data: {
        "id": id,
        "name": buildingController.text.isEmpty
            ? buildingDetailsInEditModel!.data!.name
            : buildingController.text,
        "number": buildingNumberController.text.isEmpty
            ? buildingDetailsInEditModel!.data!.number
            : buildingNumberController.text,
        "description": buildingDescriptionController.text.isEmpty
            ? buildingDetailsInEditModel!.data!.description
            : buildingDescriptionController.text,
        "organizationId": organizationController.text.isEmpty
            ? buildingDetailsInEditModel!.data!.organizationId
            : organizationId,
        "cityId": cityController.text.isEmpty
            ? buildingDetailsInEditModel!.data!.cityId
            : cityId,
        "areaId": areaController.text.isEmpty
            ? buildingDetailsInEditModel!.data!.areaId
            : areaId,
        "countryName": nationalityController.text.isEmpty
            ? buildingDetailsInEditModel!.data!.countryName
            : nationalityController.text,
        "managerIds": null,
        "shiftsIds": null,
      });
      editBuildingModel = BuildingEditModel.fromJson(response!.data);
      emit(EditBuildingSuccessState(editBuildingModel!));
    } catch (error) {
      emit(EditBuildingErrorState(error.toString()));
    }
  }

  BuildingDetailsInEditModel? buildingDetailsInEditModel;
  getBuildingDetailsInEdit(int id) {
    emit(GetBuildingDetailsLoadingState());
    DioHelper.getData(url: 'buildings/$id').then((value) {
      buildingDetailsInEditModel =
          BuildingDetailsInEditModel.fromJson(value!.data);
      emit(GetBuildingDetailsSuccessState(buildingDetailsInEditModel!));
    }).catchError((error) {
      emit(GetBuildingDetailsErrorState(error.toString()));
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
  getBuilding(int id) {
    emit(GetBuildingLoadingState());
    DioHelper.getData(url: 'buildings/organization/$id').then((value) {
      buildingModel = BuildingModel.fromJson(value!.data);
      emit(GetBuildingSuccessState(buildingModel!));
    }).catchError((error) {
      emit(GetBuildingErrorState(error.toString()));
    });
  }
}
