import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_city/data/model/city_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_city/data/model/edit_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_city/logic/edit_city_state.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/city_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_list_model.dart';

class EditCityCubit extends Cubit<EditCityState> {
  EditCityCubit() : super(EditCityInitialState());

  static EditCityCubit get(context) => BlocProvider.of(context);
  TextEditingController nationalityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController areaIdController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  final allmanagersController = MultiSelectController<Users>();
  final allSupervisorsController = MultiSelectController<Users>();
  final allCleanersController = MultiSelectController<Users>();
  final formKey = GlobalKey<FormState>();

  EditCityModel? editCityModel;
  editCity(int? id, List<int>? selectedManagersIds,
      List<int>? selectedSupervisorsIds, List<int>? selectedCleanersIds) async {
    emit(EditCityLoadingState());
    try {
      final managersIds = selectedManagersIds?.isEmpty ?? true
          ? cityUsersDetailsModel?.data?.users
              ?.where((user) => user.role == 'Manager')
              .map((user) => user.id!)
              .toList()
          : selectedManagersIds;
      final supervisorsIds = selectedSupervisorsIds?.isEmpty ?? true
          ? cityUsersDetailsModel?.data?.users
              ?.where((user) => user.role == 'Supervisor')
              .map((user) => user.id!)
          : selectedSupervisorsIds;
      final cleanersIds = selectedCleanersIds?.isEmpty ?? true
          ? cityUsersDetailsModel?.data?.users
              ?.where((user) => user.role == 'Cleaner')
              .map((user) => user.id!)
              .toList()
          : selectedCleanersIds;
      final response =
          await DioHelper.putData(url: ApiConstants.cityEditUrl, data: {
        "id": id,
        "name": cityController.text.isEmpty
            ? cityDetailsInEditModel!.data!.name
            : cityController.text,
        "areaId": areaController.text.isEmpty
            ? cityDetailsInEditModel!.data!.areaId
            : areaIdController.text,
        "userIds": [...?managersIds, ...?supervisorsIds, ...?cleanersIds]
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

  CityUsersDetailsModel? cityUsersDetailsModel;
  getCityManagersDetails(int cityId) {
    emit(CityManagersDetailsLoadingState());
    DioHelper.getData(url: 'cities/with-user/$cityId').then((value) {
      cityUsersDetailsModel = CityUsersDetailsModel.fromJson(value!.data);
      emit(CityManagersDetailsSuccessState(cityUsersDetailsModel!));
    }).catchError((error) {
      emit(CityManagersDetailsErrorState(error.toString()));
    });
  }

  NationalityListModel? nationalityModel;
  getNationality() {
    emit(GetNationalityLoadingState());
    DioHelper.getData(
        url: ApiConstants.countriesUrl,
        query: {'userUsedOnly': false, 'areaUsedOnly': true}).then((value) {
      nationalityModel = NationalityListModel.fromJson(value!.data);
      emit(GetNationalitySuccessState(nationalityModel!));
    }).catchError((error) {
      emit(GetNationalityErrorState(error.toString()));
    });
  }

  AreaListModel? areasModel;
  getAreas(String countryName) {
    emit(GetAreaLoadingState());
    DioHelper.getData(url: "areas/pagination", query: {'country': countryName})
        .then((value) {
      areasModel = AreaListModel.fromJson(value!.data);
      emit(GetAreaSuccessState(areasModel!));
    }).catchError((error) {
      emit(GetAreaErrorState(error.toString()));
    });
  }

  CityListModel? cityyModel;
  getCityy(int areaId) {
    emit(GetCityLoadingState());
    DioHelper.getData(url: "cities/pagination", query: {'area': areaId})
        .then((value) {
      cityyModel = CityListModel.fromJson(value!.data);
      emit(GetCitySuccessState(cityyModel!));
    }).catchError((error) {
      emit(GetCityErrorState(error.toString()));
    });
  }
}
