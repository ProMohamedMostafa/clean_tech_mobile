import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_floor/data/model/edit_floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_floor/data/model/floor_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_floor/logic/edit_floor_state.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/floor_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_list_model.dart';

class EditFloorCubit extends Cubit<EditFloorState> {
  EditFloorCubit() : super(EditFloorInitialState());

  static EditFloorCubit get(context) => BlocProvider.of(context);
  TextEditingController nationalityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController buildingIdController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController floorNumberController = TextEditingController();
  TextEditingController floorDescriptionController = TextEditingController();
  final allmanagersController = MultiSelectController<Users>();
  final allSupervisorsController = MultiSelectController<Users>();
  final allCleanersController = MultiSelectController<Users>();
  final shiftController = MultiSelectController<ShiftItem>();
  final formKey = GlobalKey<FormState>();

  FloorEditModel? editFloorModel;
  editFloor(
      int? id,
      List<int>? selectedManagersIds,
      List<int>? selectedSupervisorsIds,
      List<int>? selectedCleanersIds,
      List<int>? shiftController) async {
    emit(EditFloorLoadingState());

    final managersIds = selectedManagersIds?.isEmpty ?? true
        ? floorUsersShiftsDetailsModel?.data?.users!
            .where((user) => user.role == 'Manager')
            .map((user) => user.id!)
            .toList()
        : selectedManagersIds;
    final supervisorsIds = selectedSupervisorsIds?.isEmpty ?? true
        ? floorUsersShiftsDetailsModel?.data?.users!
            .where((user) => user.role == 'Supervisor')
            .map((user) => user.id!)
            .toList()
        : selectedSupervisorsIds;
    final cleanersIds = selectedCleanersIds?.isEmpty ?? true
        ? floorUsersShiftsDetailsModel?.data?.users!
            .where((user) => user.role == 'Cleaner')
            .map((user) => user.id!)
            .toList()
        : selectedCleanersIds;
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
            : buildingIdController.text,
        "userIds": [...?managersIds, ...?supervisorsIds, ...?cleanersIds],
        "shiftIds":
            shiftController ?? floorUsersShiftsDetailsModel!.data!.shifts,
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

  FloorUsersShiftsDetailsModel? floorUsersShiftsDetailsModel;
  getFloorManagersDetails(int floorId) {
    emit(FloorManagersDetailsLoadingState());
    DioHelper.getData(url: 'floors/with-user-shift/$floorId').then((value) {
      floorUsersShiftsDetailsModel =
          FloorUsersShiftsDetailsModel.fromJson(value!.data);
      emit(FloorManagersDetailsSuccessState(floorUsersShiftsDetailsModel!));
    }).catchError((error) {
      emit(FloorManagersDetailsErrorState(error.toString()));
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

  BuildingListModel? buildingsModel;
  getBuildings(int organizationId) {
    emit(GetBuildingLoadingState());
    DioHelper.getData(
        url: 'buildings/pagination',
        query: {'organization': organizationId}).then((value) {
      buildingsModel = BuildingListModel.fromJson(value!.data);
      emit(GetBuildingSuccessState(buildingsModel!));
    }).catchError((error) {
      emit(GetBuildingErrorState(error.toString()));
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
