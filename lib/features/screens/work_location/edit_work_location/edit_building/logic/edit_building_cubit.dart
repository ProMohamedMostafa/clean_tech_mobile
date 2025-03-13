import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_building/data/model/building_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_building/data/model/edit_building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_building/logic/edit_building_state.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/building_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';

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
  final allmanagersController = MultiSelectController<Users>();
  final allSupervisorsController = MultiSelectController<Users>();
  final allCleanersController = MultiSelectController<Users>();
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
          ? buildingUsersShiftsDetailsModel?.data?.users!
           .where((user) => user.role == 'Manager')
            .map((user) => user.id!)
              .toList()
          : selectedManagersIds;
      final supervisorsIds = selectedSupervisorsIds?.isEmpty ?? true
          ? buildingUsersShiftsDetailsModel?.data?.users!
              .where((user) => user.role == 'Manager')
            .map((user) => user.id!)
              .toList()
          : selectedSupervisorsIds;
      final cleanersIds = selectedCleanersIds?.isEmpty ?? true
          ? buildingUsersShiftsDetailsModel?.data?.users!
            .where((user) => user.role == 'Manager')
            .map((user) => user.id!)
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
            shiftController ?? buildingUsersShiftsDetailsModel!.data!.shifts,
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

  BuildingUsersShiftsDetailsModel? buildingUsersShiftsDetailsModel;
  getBuildingManagersDetails(int buildingId) {
    emit(BuildingManagersDetailsLoadingState());
    DioHelper.getData(url: 'buildings/with-user-shift/$buildingId')
        .then((value) {
      buildingUsersShiftsDetailsModel =
          BuildingUsersShiftsDetailsModel.fromJson(value!.data);
      emit(BuildingManagersDetailsSuccessState(buildingUsersShiftsDetailsModel!));
    }).catchError((error) {
      emit(BuildingManagersDetailsErrorState(error.toString()));
    });
  }

  NationalityModel? nationalityModel;
  getNationality() {
    emit(GetNationalityLoadingState());
    DioHelper.getData(
        url: ApiConstants.countriesUrl,
        query: {'userUsedOnly': false, 'areaUsedOnly': true}).then((value) {
      nationalityModel = NationalityModel.fromJson(value!.data);
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

  OrganizationListModel? organizationsModel;
  getOrganizations(int cityId) {
    emit(GetOrganizationLoadingState());
    DioHelper.getData(url: "organizations/pagination", query: {'city': cityId})
        .then((value) {
      organizationsModel = OrganizationListModel.fromJson(value!.data);
      emit(GetOrganizationSuccessState(organizationsModel!));
    }).catchError((error) {
      emit(GetOrganizationErrorState(error.toString()));
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
