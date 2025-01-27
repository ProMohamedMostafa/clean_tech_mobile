import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_cleaners_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_managers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_supervisors_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_building/data/model/building_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_building/data/model/edit_building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_building/logic/edit_building_state.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_building_details/data/model/building_managers_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view_building_details/data/model/building_shifts_details_model.dart';

class EditBuildingCubit extends Cubit<EditBuildingState> {
  EditBuildingCubit() : super(EditBuildingInitialState());

  static EditBuildingCubit get(context) => BlocProvider.of(context);
  TextEditingController nationalityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController organizationIdController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController buildingNumberController = TextEditingController();
  TextEditingController buildingDescriptionController = TextEditingController();
  final allmanagersController = MultiSelectController<ManagersData>();
  final allSupervisorsController = MultiSelectController<SupervisorsData>();
  final allCleanersController = MultiSelectController<CleanersData>();
  final shiftController = MultiSelectController<ShiftDetails>();
  final formKey = GlobalKey<FormState>();

  BuildingEditModel? editBuildingModel;
  editBuilding(
      int? id,
      List<int>? selectedManagersIds,
      List<int>? selectedSupervisorsIds,
      List<int>? selectedCleanersIds,
      List<int>? shiftController) async {
    emit(EditBuildingLoadingState());
    try {
      final managersIds = selectedManagersIds?.isEmpty ?? true
          ? buildingManagersDetailsModel?.data?.managers
              ?.map((m) => m.id)
              .toList()
          : selectedManagersIds;
      final supervisorsIds = selectedSupervisorsIds?.isEmpty ?? true
          ? buildingManagersDetailsModel?.data?.supervisors
              ?.map((s) => s.id)
              .toList()
          : selectedSupervisorsIds;
      final cleanersIds = selectedCleanersIds?.isEmpty ?? true
          ? buildingManagersDetailsModel?.data?.cleaners
              ?.map((c) => c.id)
              .toList()
          : selectedCleanersIds;
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
            : organizationIdController.text,
        "managersIds": [...?managersIds, ...?supervisorsIds, ...?cleanersIds],
        "shiftsIds":
            shiftController ?? buildingShiftsDetailsModel!.data!.shifts,
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

  BuildingManagersDetailsModel? buildingManagersDetailsModel;
  getBuildingManagersDetails(int buildingId) {
    emit(BuildingManagersDetailsLoadingState());
    DioHelper.getData(url: 'building/manager/$buildingId').then((value) {
      buildingManagersDetailsModel =
          BuildingManagersDetailsModel.fromJson(value!.data);
      emit(BuildingManagersDetailsSuccessState(buildingManagersDetailsModel!));
    }).catchError((error) {
      emit(BuildingManagersDetailsErrorState(error.toString()));
    });
  }

  BuildingShiftsDetailsModel? buildingShiftsDetailsModel;
  getBuildingShiftsDetails(int buildingId) {
    emit(BuildingShiftsDetailsLoadingState());
    DioHelper.getData(url: 'building/shift/$buildingId').then((value) {
      buildingShiftsDetailsModel =
          BuildingShiftsDetailsModel.fromJson(value!.data);
      emit(BuildingShiftsDetailsSuccessState(buildingShiftsDetailsModel!));
    }).catchError((error) {
      emit(BuildingShiftsDetailsErrorState(error.toString()));
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
}
