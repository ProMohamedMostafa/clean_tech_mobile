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
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_floor/data/model/edit_floor_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_floor/data/model/floor_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_floor/logic/edit_floor_state.dart';

class EditFloorCubit extends Cubit<EditFloorState> {
  EditFloorCubit() : super(EditFloorInitialState());

  static EditFloorCubit get(context) => BlocProvider.of(context);
  TextEditingController nationalityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController floorNumberController = TextEditingController();
  TextEditingController floorDescriptionController = TextEditingController();
  TextEditingController managerNameController = TextEditingController();
  TextEditingController shiftsNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  FloorEditModel? editFloorModel;
  editFloor(int? id, cityId, areaId, organizationId, buildingId) async {
    emit(EditFloorLoadingState());
    try {
      final response =
          await DioHelper.putData(url: ApiConstants.floorEditUrl, data: {
        "id": id,
        "name": floorController.text.isEmpty
            ? floorDetailsInEditModel!.data!.name
            : floorController.text,
        "number": floorNumberController.text.isEmpty
            ? floorDetailsInEditModel!.data!.number
            : floorNumberController.text,
        "description": floorDescriptionController.text.isEmpty
            ? floorDetailsInEditModel!.data!.description
            : floorDescriptionController.text,
        "buildingId": buildingController.text.isEmpty
            ? floorDetailsInEditModel!.data!.buildingId
            : buildingId,
        "organizationId": organizationController.text.isEmpty
            ? floorDetailsInEditModel!.data!.organizationId
            : organizationId,
        "cityId": cityController.text.isEmpty
            ? floorDetailsInEditModel!.data!.cityId
            : cityId,
        "areaId": areaController.text.isEmpty
            ? floorDetailsInEditModel!.data!.areaId
            : areaId,
        "countryName": nationalityController.text.isEmpty
            ? floorDetailsInEditModel!.data!.countryName
            : nationalityController.text,
        "managerIds": null,
        "shiftsIds": null,
      });
      editFloorModel = FloorEditModel.fromJson(response!.data);
      emit(EditFloorSuccessState(editFloorModel!));
    } catch (error) {
      emit(EditFloorErrorState(error.toString()));
    }
  }

  FloorDetailsInEditModel? floorDetailsInEditModel;
  getFloorDetailsInEdit(int id) {
    emit(GetFloorDetailsLoadingState());
    DioHelper.getData(url: 'floors/$id').then((value) {
      floorDetailsInEditModel = FloorDetailsInEditModel.fromJson(value!.data);
      emit(GetFloorDetailsSuccessState(floorDetailsInEditModel!));
    }).catchError((error) {
      emit(GetFloorDetailsErrorState(error.toString()));
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
  getFloor(int id) {
    emit(GetFloorLoadingState());
    DioHelper.getData(url: 'floors/building/$id').then((value) {
      floorModel = FloorModel.fromJson(value!.data);
      emit(GetFloorSuccessState(floorModel!));
    }).catchError((error) {
      emit(GetFloorErrorState(error.toString()));
    });
  }
}
