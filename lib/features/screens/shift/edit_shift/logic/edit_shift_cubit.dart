import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_organization_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/edit_shift/data/model/edit_shift_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/edit_shift/logic/edit_shift_state.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/data/models/shift_building_details.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/data/models/shift_floor_details.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/data/models/shift_organization_details.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/data/models/shift_section_details.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/section_model.dart';

class EditShiftCubit extends Cubit<EditShiftState> {
  EditShiftCubit() : super(EditShiftInitialState());

  static EditShiftCubit get(context) => BlocProvider.of(context);

  TextEditingController shiftNameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController organizationIdController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController buildingIdController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController floorIdController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController sectionIdController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  EditShiftDetailsModel? editShiftDetailsModel;
  editShift(int? id) async {
    emit(EditShiftLoadingState());

    try {
      final response =
          await DioHelper.putData(url: ApiConstants.editShiftsUrl, data: {
        "id": id,
        "name": shiftNameController.text.isEmpty
            ? shiftDetailsModel!.data!.name
            : shiftNameController.text,
        "startDate": startDateController.text.isEmpty
            ? shiftDetailsModel!.data!.startDate
            : startDateController.text,
        "endDate": endDateController.text.isEmpty
            ? shiftDetailsModel!.data!.endDate
            : endDateController.text,
        "startTime": startTimeController.text.isEmpty
            ? shiftDetailsModel!.data!.startTime
            : startTimeController.text,
        "endTime": endTimeController.text.isEmpty
            ? shiftDetailsModel!.data!.endTime
            : endTimeController.text,
        "organizationIds": organizationController.text.isEmpty
            ? shiftOrganizationDetailsModel!.data!.map((e) => e.id).toList()
            : [int.parse(organizationIdController.text)],
        "buildingIds": buildingController.text.isEmpty
            ? shiftBuildingsDetailsModel!.data!.map((e) => e.id).toList()
            : [int.parse(buildingIdController.text)],
        "floorIds": floorController.text.isEmpty
            ? shiftFloorDetailsModel!.data!.map((e) => e.id).toList()
            : [int.parse(floorIdController.text)],
        "sectionIds": sectionController.text.isEmpty
            ? shiftSectionDetailsModel!.data!.map((e) => e.id).toList()
            : [int.parse(sectionIdController.text)],
      });
      editShiftDetailsModel = EditShiftDetailsModel.fromJson(response!.data);
      emit(EditShiftSuccessState(editShiftDetailsModel!));
    } catch (error) {
      emit(EditShiftErrorState(error.toString()));
    }
  }

  ShiftDetailsModel? shiftDetailsModel;
  getShiftDetails(int? id) {
    emit(ShiftDetailsLoadingState());
    DioHelper.getData(url: 'shifts/$id').then((value) {
      shiftDetailsModel = ShiftDetailsModel.fromJson(value!.data);
      emit(ShiftDetailsSuccessState(shiftDetailsModel!));
    }).catchError((error) {
      emit(ShiftDetailsErrorState(error.toString()));
    });
  }

  ShiftOrganizationDetailsModel? shiftOrganizationDetailsModel;
  getShiftOrganizationDetails(int? id) {
    emit(ShiftOrganizationDetailsLoadingState());
    DioHelper.getData(url: 'shift/organization/$id').then((value) {
      shiftOrganizationDetailsModel =
          ShiftOrganizationDetailsModel.fromJson(value!.data);
      emit(
          ShiftOrganizationDetailsSuccessState(shiftOrganizationDetailsModel!));
    }).catchError((error) {
      emit(ShiftOrganizationDetailsErrorState(error.toString()));
    });
  }

  ShiftBuildingsDetailsModel? shiftBuildingsDetailsModel;
  getShiftBuildingDetails(int? id) {
    emit(ShiftBuildingDetailsLoadingState());
    DioHelper.getData(url: 'shift/building/$id').then((value) {
      shiftBuildingsDetailsModel =
          ShiftBuildingsDetailsModel.fromJson(value!.data);
      emit(ShiftBuildingDetailsSuccessState(shiftBuildingsDetailsModel!));
    }).catchError((error) {
      emit(ShiftBuildingDetailsErrorState(error.toString()));
    });
  }

  ShiftFloorDetailsModel? shiftFloorDetailsModel;
  getShiftFloorDetails(int? id) {
    emit(ShiftFloorDetailsLoadingState());
    DioHelper.getData(url: 'shift/floor/$id').then((value) {
      shiftFloorDetailsModel = ShiftFloorDetailsModel.fromJson(value!.data);
      emit(ShiftFloorDetailsSuccessState(shiftFloorDetailsModel!));
    }).catchError((error) {
      emit(ShiftFloorDetailsErrorState(error.toString()));
    });
  }

  ShiftSectionDetailsModel? shiftSectionDetailsModel;
  getShiftSectionDetails(int? id) {
    emit(ShiftSectionDetailsLoadingState());
    DioHelper.getData(url: 'shift/section/$id').then((value) {
      shiftSectionDetailsModel = ShiftSectionDetailsModel.fromJson(value!.data);
      emit(ShiftSectionDetailsSuccessState(shiftSectionDetailsModel!));
    }).catchError((error) {
      emit(ShiftSectionDetailsErrorState(error.toString()));
    });
  }

  AllOrganizationModel? allOrganizationModel;
  getOrganization() {
    emit(OrganizationLoadingState());
    DioHelper.getData(url: ApiConstants.organizationUrl).then((value) {
      allOrganizationModel = AllOrganizationModel.fromJson(value!.data);
      emit(OrganizationSuccessState(allOrganizationModel!));
    }).catchError((error) {
      emit(OrganizationErrorState(error.toString()));
    });
  }

  BuildingListModel? buildingModel;
  getBuilding(int organizationId) {
    emit(GetBuildingLoadingState());
    DioHelper.getData(
        url: 'buildings/pagination',
        query: {'organization': organizationId}).then((value) {
      buildingModel = BuildingListModel.fromJson(value!.data);
      emit(GetBuildingSuccessState(buildingModel!));
    }).catchError((error) {
      emit(GetBuildingErrorState(error.toString()));
    });
  }

  FloorListModel? floorModel;
  getFloor(int buildingId) {
    emit(GetFloorLoadingState());
    DioHelper.getData(url: 'floors/pagination', query: {'building': buildingId})
        .then((value) {
      floorModel = FloorListModel.fromJson(value!.data);
      emit(GetFloorSuccessState(floorModel!));
    }).catchError((error) {
      emit(GetFloorErrorState(error.toString()));
    });
  }

  SectionListModel? sectionModel;
  getSection(int floorId) {
    emit(GetSectionLoadingState());
    DioHelper.getData(url: 'sections/pagination', query: {'floor': floorId})
        .then((value) {
      sectionModel = SectionListModel.fromJson(value!.data);
      emit(GetSectionSuccessState(sectionModel!));
    }).catchError((error) {
      emit(GetSectionErrorState(error.toString()));
    });
  }
}
