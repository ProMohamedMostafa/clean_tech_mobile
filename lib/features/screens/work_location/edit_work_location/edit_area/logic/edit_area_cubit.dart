import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_cleaners_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_managers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_supervisors_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_area/data/model/area_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_area/data/model/edit_area_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_area/logic/edit_area_state.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/area_managers_details_model.dart';

class EditAreaCubit extends Cubit<EditAreaState> {
  EditAreaCubit() : super(EditAreaInitialState());

  static EditAreaCubit get(context) => BlocProvider.of(context);
  TextEditingController nationalityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  final allmanagersController = MultiSelectController<ManagersData>();
  final allSupervisorsController = MultiSelectController<SupervisorsData>();
  final allCleanersController = MultiSelectController<CleanersData>();
  final formKey = GlobalKey<FormState>();

  EditAreaModel? editAreaModel;
  editArea(int? id, List<int>? selectedManagersIds,
      List<int>? selectedSupervisorsIds, List<int>? selectedCleanersIds) async {
    emit(EditAreaLoadingState());
    try {
      final managersIds = selectedManagersIds?.isEmpty ?? true
          ? areaManagersDetailsModel?.data?.managers?.map((m) => m.id).toList()
          : selectedManagersIds;
      final supervisorsIds = selectedSupervisorsIds?.isEmpty ?? true
          ? areaManagersDetailsModel?.data?.supervisors
              ?.map((s) => s.id)
              .toList()
          : selectedSupervisorsIds;
      final cleanersIds = selectedCleanersIds?.isEmpty ?? true
          ? areaManagersDetailsModel?.data?.cleaners?.map((c) => c.id).toList()
          : selectedCleanersIds;
      final response =
          await DioHelper.putData(url: ApiConstants.areaEditUrl, data: {
        "id": id,
        "name": areaController.text.isEmpty
            ? areaDetailsInEditModel!.data!.name
            : areaController.text,
        "countryName": nationalityController.text.isEmpty
            ? areaDetailsInEditModel!.data!.countryName
            : nationalityController.text,
        "managersIds": [...?managersIds, ...?supervisorsIds, ...?cleanersIds]
      });
      editAreaModel = EditAreaModel.fromJson(response!.data);
      emit(EditAreaSuccessState(editAreaModel!));
    } catch (error) {
      emit(EditAreaErrorState(error.toString()));
    }
  }

  AreaDetailsInEditModel? areaDetailsInEditModel;
  getAreaDetailsInEdit(int id) {
    emit(GetAreaDetailsLoadingState());
    DioHelper.getData(url: 'areas/$id').then((value) {
      areaDetailsInEditModel = AreaDetailsInEditModel.fromJson(value!.data);
      emit(GetAreaDetailsSuccessState(areaDetailsInEditModel!));
    }).catchError((error) {
      emit(GetAreaDetailsErrorState(error.toString()));
    });
  }

  NationalityModel? nationalityModel;
  getNationality() {
    emit(GetAreaNationalityLoadingState());
    DioHelper.getData(url: ApiConstants.countriesUrl).then((value) {
      nationalityModel = NationalityModel.fromJson(value!.data);
      emit(GetAreaNationalitySuccessState(nationalityModel!));
    }).catchError((error) {
      emit(GetAreaNationalityErrorState(error.toString()));
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
}
