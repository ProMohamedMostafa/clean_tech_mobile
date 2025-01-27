import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_cleaners_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_managers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_supervisors_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_organization/data/model/edit_organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_organization/data/model/organization_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_organization/logic/edit_organization_state.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_organization_details/data/model/organization_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_organization_details/data/model/organization_shifts_details_model.dart';

class EditOrganizationCubit extends Cubit<EditOrganizationState> {
  EditOrganizationCubit() : super(EditOrganizationInitialState());

  static EditOrganizationCubit get(context) => BlocProvider.of(context);
  TextEditingController nationalityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController cityIdController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  final allmanagersController = MultiSelectController<ManagersData>();
  final allSupervisorsController = MultiSelectController<SupervisorsData>();
  final allCleanersController = MultiSelectController<CleanersData>();
  final shiftController = MultiSelectController<ShiftDetails>();

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
          ? organizationManagersDetailsModel?.data?.managers
              ?.map((m) => m.id)
              .toList()
          : selectedManagersIds;
      final supervisorsIds = selectedSupervisorsIds?.isEmpty ?? true
          ? organizationManagersDetailsModel?.data?.supervisors
              ?.map((s) => s.id)
              .toList()
          : selectedSupervisorsIds;
      final cleanersIds = selectedCleanersIds?.isEmpty ?? true
          ? organizationManagersDetailsModel?.data?.cleaners
              ?.map((c) => c.id)
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
        "managersIds": [...?managersIds, ...?supervisorsIds, ...?cleanersIds],
        "shiftsIds":
            shiftController ?? organizationShiftsDetailsModel!.data!.shifts,
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

  AllManagersModel? allManagersModel;
  getManagers() {
    emit(AllManagersLoadingState());
    DioHelper.getData(url: 'users/manager/1').then((value) {
      allManagersModel = AllManagersModel.fromJson(value!.data);
      emit(AllManagersSuccessState(allManagersModel!));
    }).catchError((error) {
      emit(AllManagersErrorState(error.toString()));
    });
  }

  AllSupervisorsModel? allSupervisorsModel;
  getSupervisors() {
    emit(AllSupervisorsLoadingState());
    DioHelper.getData(url: 'users/manager/2').then((value) {
      allSupervisorsModel = AllSupervisorsModel.fromJson(value!.data);
      emit(AllSupervisorsSuccessState(allSupervisorsModel!));
    }).catchError((error) {
      emit(AllSupervisorsErrorState(error.toString()));
    });
  }

  AllCleanersModel? allCleanersModel;
  getCleaners() {
    emit(AllCleanersLoadingState());
    DioHelper.getData(url: 'users/manager/3').then((value) {
      allCleanersModel = AllCleanersModel.fromJson(value!.data);
      emit(AllCleanersSuccessState(allCleanersModel!));
    }).catchError((error) {
      emit(AllCleanersErrorState(error.toString()));
    });
  }

  OrganizationManagersDetailsModel? organizationManagersDetailsModel;
  getOrganizationManagersDetails(int organizationId) {
    emit(OrganizationManagersDetailsLoadingState());
    DioHelper.getData(url: 'organization/manager/$organizationId')
        .then((value) {
      organizationManagersDetailsModel =
          OrganizationManagersDetailsModel.fromJson(value!.data);
      emit(OrganizationManagersDetailsSuccessState(
          organizationManagersDetailsModel!));
    }).catchError((error) {
      emit(OrganizationManagersDetailsErrorState(error.toString()));
    });
  }

  OrganizationShiftsDetailsModel? organizationShiftsDetailsModel;
  getOrganizationShiftsDetails(int organizationId) {
    emit(OrganizationShiftsDetailsLoadingState());
    DioHelper.getData(url: 'organization/shift/$organizationId').then((value) {
      organizationShiftsDetailsModel =
          OrganizationShiftsDetailsModel.fromJson(value!.data);
      emit(OrganizationShiftsDetailsSuccessState(
          organizationShiftsDetailsModel!));
    }).catchError((error) {
      emit(OrganizationShiftsDetailsErrorState(error.toString()));
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
