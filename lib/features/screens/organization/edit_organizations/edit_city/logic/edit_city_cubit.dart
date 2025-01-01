import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/data/model/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_city/data/model/city_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_city/data/model/edit_details_model.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_city/logic/edit_city_state.dart';


class EditCityCubit extends Cubit<EditCityState> {
  EditCityCubit() : super(EditCityInitialState());

  static EditCityCubit get(context) => BlocProvider.of(context);
  TextEditingController nationalityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController managerNameController = TextEditingController();
  TextEditingController shiftsNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  EditCityModel? editCityModel;
  editCity(int? id, areaId) async {
    emit(EditCityLoadingState());
    try {
      final response =
          await DioHelper.putData(url: ApiConstants.cityEditUrl, data: {
        "id": id,
        "name": cityController.text.isEmpty
            ? cityDetailsInEditModel!.data!.name
            : cityController.text,
        "countryName": nationalityController.text.isEmpty
            ? cityDetailsInEditModel!.data!.countryName
            : nationalityController.text,
        "areaId": areaController.text.isEmpty
            ? cityDetailsInEditModel!.data!.areaId
            : areaId,
        "managerIds": null,
        "shiftsIds": null,
      });
      editCityModel = EditCityModel.fromJson(response!.data);
      emit(EditCitySuccessState(editCityModel!));
    } catch (error) {
      emit(EditCityErrorState(error.toString()));
    }
  }

  CityDetailsInEditModel? cityDetailsInEditModel;
  getCityDetailsInEdit(int id) {
    emit(GetCityDetailsLoadingState());
    DioHelper.getData(url: 'cities/$id').then((value) {
      cityDetailsInEditModel = CityDetailsInEditModel.fromJson(value!.data);
      emit(GetCityDetailsSuccessState(cityDetailsInEditModel!));
    }).catchError((error) {
      emit(GetCityDetailsErrorState(error.toString()));
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
    emit(GetOrganizationCityLoadingState());
    DioHelper.getData(url: "cities/area/$areaId").then((value) {
      cityModel = CityModel.fromJson(value!.data);
      emit(GetOrganizationCitySuccessState(cityModel!));
    }).catchError((error) {
      emit(GetOrganizationCityErrorState(error.toString()));
    });
  }

}
