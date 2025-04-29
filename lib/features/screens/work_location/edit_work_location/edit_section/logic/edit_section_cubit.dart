import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_section/data/model/edit_section_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_section/data/model/section_details_in_edit_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_section/logic/edit_section_state.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_list_model.dart';

import '../../../view_work_location/data/models/section_users_shifts_details_model.dart';

class EditSectionCubit extends Cubit<EditSectionState> {
  EditSectionCubit() : super(EditSectionInitialState());

  static EditSectionCubit get(context) => BlocProvider.of(context);
  TextEditingController nationalityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController buildingIdController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController floorIdController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController sectionNumberController = TextEditingController();
  TextEditingController sectionDescriptionController = TextEditingController();
  final allmanagersController = MultiSelectController<Users>();
  final allSupervisorsController = MultiSelectController<Users>();
  final allCleanersController = MultiSelectController<Users>();
  final shiftController = MultiSelectController<ShiftItem>();
  final formKey = GlobalKey<FormState>();

  SectionEditModel? editSectionModel;
  editSection(
      int? id,
      List<int>? selectedManagersIds,
      List<int>? selectedSupervisorsIds,
      List<int>? selectedCleanersIds,
      List<int>? shiftController) async {
    emit(EditSectionLoadingState());

    final managersIds = selectedManagersIds?.isEmpty ?? true
        ? sectionUsersShiftsDetailsModel?.data?.users!
            .where((user) => user.role == 'Manager')
            .map((user) => user.id!)
            .toList()
        : selectedManagersIds;
    final supervisorsIds = selectedSupervisorsIds?.isEmpty ?? true
        ? sectionUsersShiftsDetailsModel?.data?.users!
            .where((user) => user.role == 'Supervisor')
            .map((user) => user.id!)
            .toList()
        : selectedSupervisorsIds;
    final cleanersIds = selectedCleanersIds?.isEmpty ?? true
        ? sectionUsersShiftsDetailsModel?.data?.users!
            .where((user) => user.role == 'Cleaner')
            .map((user) => user.id!)
            .toList()
        : selectedCleanersIds;

    try {
      final response =
          await DioHelper.putData(url: ApiConstants.sectionEditUrl, data: {
        "id": id,
        "name": sectionController.text.isEmpty
            ? sectionDetailsInEditModel!.data!.name
            : sectionController.text,
        "number": sectionNumberController.text.isEmpty
            ? sectionDetailsInEditModel!.data!.number
            : sectionNumberController.text,
        "description": sectionDescriptionController.text.isEmpty
            ? sectionDetailsInEditModel!.data!.description
            : sectionDescriptionController.text,
        "floorId": floorController.text.isEmpty
            ? sectionDetailsInEditModel!.data!.buildingId
            : floorIdController.text,
        "userIds": [...?managersIds, ...?supervisorsIds, ...?cleanersIds],
        "shiftIds":
            shiftController ?? sectionUsersShiftsDetailsModel!.data!.shifts,
      });
      editSectionModel = SectionEditModel.fromJson(response!.data);
      emit(EditSectionSuccessState(editSectionModel!));
    } catch (error) {
      emit(EditSectionErrorState(error.toString()));
    }
  }

  SectionDetailsInEditModel? sectionDetailsInEditModel;
  getSectionDetailsInEdit(int id) {
    emit(GetSectionDetailsLoadingState());
    DioHelper.getData(url: 'sections/$id').then((value) {
      sectionDetailsInEditModel =
          SectionDetailsInEditModel.fromJson(value!.data);
      emit(GetSectionDetailsSuccessState(sectionDetailsInEditModel!));
    }).catchError((error) {
      emit(GetSectionDetailsErrorState(error.toString()));
    });
  }

  SectionUsersShiftsDetailsModel? sectionUsersShiftsDetailsModel;
  getSectionManagersDetails(int sectionId) {
    emit(SectionUsersDetailsLoadingState());
    DioHelper.getData(url: 'sections/with-user-shift/$sectionId').then((value) {
      sectionUsersShiftsDetailsModel =
          SectionUsersShiftsDetailsModel.fromJson(value!.data);
      emit(SectionUsersDetailsSuccessState(sectionUsersShiftsDetailsModel!));
    }).catchError((error) {
      emit(SectionUsersDetailsErrorState(error.toString()));
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

  FloorListModel? floorsModel;
  getFloors(int buildingId) {
    emit(GetFloorLoadingState());
    DioHelper.getData(url: 'floors/pagination', query: {'building': buildingId})
        .then((value) {
      floorsModel = FloorListModel.fromJson(value!.data);
      emit(GetFloorSuccessState(floorsModel!));
    }).catchError((error) {
      emit(GetFloorErrorState(error.toString()));
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
