import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_list_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_area/data/model/area_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_area/data/model/edit_area_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_area/logic/edit_area_state.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/area_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_list_model.dart';

class EditAreaCubit extends Cubit<EditAreaState> {
  EditAreaCubit() : super(EditAreaInitialState());

  static EditAreaCubit get(context) => BlocProvider.of(context);
  TextEditingController nationalityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  final allmanagersController = MultiSelectController<Users>();
  final allSupervisorsController = MultiSelectController<Users>();
  final allCleanersController = MultiSelectController<Users>();
  final formKey = GlobalKey<FormState>();

  EditAreaModel? editAreaModel;
  editArea(int? id, List<int>? selectedManagersIds,
      List<int>? selectedSupervisorsIds, List<int>? selectedCleanersIds) async {
    emit(EditAreaLoadingState());
    try {
      final managersIds = selectedManagersIds?.isEmpty ?? true
          ? areaUsersDetailsModel?.data?.users
              ?.where((user) => user.role == 'Manager')
              .map((user) => user.id!)
              .toList()
          : selectedManagersIds;
      final supervisorsIds = selectedSupervisorsIds?.isEmpty ?? true
          ? areaUsersDetailsModel?.data?.users
              ?.where((user) => user.role == 'Supervisor')
              .map((user) => user.id!)
              .toList()
          : selectedSupervisorsIds;
      final cleanersIds = selectedCleanersIds?.isEmpty ?? true
          ? areaUsersDetailsModel?.data?.users
              ?.where((user) => user.role == 'Cleaner')
              .map((user) => user.id!)
              .toList()
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
        "userIds": [...?managersIds, ...?supervisorsIds, ...?cleanersIds]
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

  AreaUsersDetailsModel? areaUsersDetailsModel;
  getAreaManagersDetails(int areaId) {
    emit(AreaManagersDetailsLoadingState());
    DioHelper.getData(url: 'areas/with-user/$areaId').then((value) {
      areaUsersDetailsModel = AreaUsersDetailsModel.fromJson(value!.data);
      emit(AreaManagersDetailsSuccessState(areaUsersDetailsModel!));
    }).catchError((error) {
      emit(AreaManagersDetailsErrorState(error.toString()));
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
}
