import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_organization/data/model/edit_organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_organization/data/model/organization_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_organization/logic/edit_organization_state.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/organization_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_list_model.dart';

class EditOrganizationCubit extends Cubit<EditOrganizationState> {
  EditOrganizationCubit() : super(EditOrganizationInitialState());

  static EditOrganizationCubit get(context) => BlocProvider.of(context);
  TextEditingController nationalityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController cityIdController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  final allmanagersController = MultiSelectController<Users>();
  final allSupervisorsController = MultiSelectController<Users>();
  final allCleanersController = MultiSelectController<Users>();
  final shiftController = MultiSelectController<ShiftItem>();

  final formKey = GlobalKey<FormState>();

  EditOrganizationModel? editOrganizationModel;

  editOrganization(
      int? id,
      List<int>? selectedManagersIds,
      List<int>? selectedSupervisorsIds,
      List<int>? selectedCleanersIds,
      List<int>? shiftController) async {
    emit(EditOrganizationLoadingState());
    try {
      final managersIds = selectedManagersIds?.isEmpty ?? true
          ? organizationUsersShiftsDetailsModel?.data?.users!
              .where((user) => user.role == 'Manager')
              .map((user) => user.id!)
              .toList()
          : selectedManagersIds;
      final supervisorsIds = selectedSupervisorsIds?.isEmpty ?? true
          ? organizationUsersShiftsDetailsModel?.data?.users!
              .where((user) => user.role == 'Supervisor')
              .map((user) => user.id!)
              .toList()
          : selectedSupervisorsIds;
      final cleanersIds = selectedCleanersIds?.isEmpty ?? true
          ? organizationUsersShiftsDetailsModel?.data?.users!
              .where((user) => user.role == 'Cleaner')
              .map((user) => user.id!)
              .toList()
          : selectedCleanersIds;
      final response =
          await DioHelper.putData(url: ApiConstants.organizationEditUrl, data: {
        "id": id,
        "name": organizationController.text.isEmpty
            ? organizationDetailsInEditModel!.data!.name
            : organizationController.text,
        "cityId": cityController.text.isEmpty
            ? organizationDetailsInEditModel!.data!.cityId
            : cityIdController.text,
        "userIds": [...?managersIds, ...?supervisorsIds, ...?cleanersIds],
        "shiftIds": shiftController ??
            organizationUsersShiftsDetailsModel!.data!.shifts,
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

  OrganizationUsersShiftsDetailsModel? organizationUsersShiftsDetailsModel;
  getOrganizationManagersDetails(int organizationId) {
    emit(OrganizationManagersDetailsLoadingState());
    DioHelper.getData(url: 'organizations/with-user-shift/$organizationId')
        .then((value) {
      organizationUsersShiftsDetailsModel =
          OrganizationUsersShiftsDetailsModel.fromJson(value!.data);
      emit(OrganizationManagersDetailsSuccessState(
          organizationUsersShiftsDetailsModel!));
    }).catchError((error) {
      emit(OrganizationManagersDetailsErrorState(error.toString()));
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

  ShiftModel? shiftModel;
  getShifts() {
    emit(ShiftLoadingState());
    DioHelper.getData(url: 'shifts/pagination').then((value) {
      shiftModel = ShiftModel.fromJson(value!.data);
      emit(ShiftSuccessState(shiftModel!));
    }).catchError((error) {
      emit(ShiftErrorState(error.toString()));
    });
  }
}
