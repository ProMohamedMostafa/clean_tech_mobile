import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_cleaners_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_managers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_supervisors_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_city/data/model/city_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_city/data/model/edit_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_city/logic/edit_city_state.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/city_managers_details_model.dart';

class EditCityCubit extends Cubit<EditCityState> {
  EditCityCubit() : super(EditCityInitialState());

  static EditCityCubit get(context) => BlocProvider.of(context);
  TextEditingController nationalityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController areaIdController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  final allmanagersController = MultiSelectController<ManagersData>();
  final allSupervisorsController = MultiSelectController<SupervisorsData>();
  final allCleanersController = MultiSelectController<CleanersData>();
  final formKey = GlobalKey<FormState>();

  EditCityModel? editCityModel;
  editCity(int? id, List<int>? selectedManagersIds,
      List<int>? selectedSupervisorsIds, List<int>? selectedCleanersIds) async {
    emit(EditCityLoadingState());
    try {
      final managersIds = selectedManagersIds?.isEmpty ?? true
          ? cityManagersDetailsModel?.data?.managers?.map((m) => m.id).toList()
          : selectedManagersIds;
      final supervisorsIds = selectedSupervisorsIds?.isEmpty ?? true
          ? cityManagersDetailsModel?.data?.supervisors
              ?.map((s) => s.id)
              .toList()
          : selectedSupervisorsIds;
      final cleanersIds = selectedCleanersIds?.isEmpty ?? true
          ? cityManagersDetailsModel?.data?.cleaners?.map((c) => c.id).toList()
          : selectedCleanersIds;
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
            : areaIdController.text,
        "managersIds": [...?managersIds, ...?supervisorsIds, ...?cleanersIds]
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

  AllManagersModel? allManagersModel;
  getManagers() {
    emit(AllManagersLoadingState());
    DioHelper.getData(url: 'users/role/2').then((value) {
      allManagersModel = AllManagersModel.fromJson(value!.data);
      emit(AllManagersSuccessState(allManagersModel!));
    }).catchError((error) {
      emit(AllManagersErrorState(error.toString()));
    });
  }

  AllSupervisorsModel? allSupervisorsModel;
  getSupervisors() {
    emit(AllSupervisorsLoadingState());
    DioHelper.getData(url: 'users/role/3').then((value) {
      allSupervisorsModel = AllSupervisorsModel.fromJson(value!.data);
      emit(AllSupervisorsSuccessState(allSupervisorsModel!));
    }).catchError((error) {
      emit(AllSupervisorsErrorState(error.toString()));
    });
  }

  AllCleanersModel? allCleanersModel;
  getCleaners() {
    emit(AllCleanersLoadingState());
    DioHelper.getData(url: 'users/role/4').then((value) {
      allCleanersModel = AllCleanersModel.fromJson(value!.data);
      emit(AllCleanersSuccessState(allCleanersModel!));
    }).catchError((error) {
      emit(AllCleanersErrorState(error.toString()));
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
}
