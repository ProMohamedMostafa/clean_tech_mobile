import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/points_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/edit_shift/data/model/edit_shift_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/edit_shift/logic/edit_shift_state.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';

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
  TextEditingController pointController = TextEditingController();
  TextEditingController pointIdController = TextEditingController();
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

  OrganizationListModel? organizationModel;
  getOrganization() {
    emit(OrganizationLoadingState());
    DioHelper.getData(url: ApiConstants.organizationUrl).then((value) {
      organizationModel = OrganizationListModel.fromJson(value!.data);
      emit(OrganizationSuccessState(organizationModel!));
    }).catchError((error) {
      emit(OrganizationErrorState(error.toString()));
    });
  }

  BuildingModel? buildingModel;
  getBuilding(int buildingId) {
    emit(GetBuildingLoadingState());
    DioHelper.getData(url: 'buildings/organization/$buildingId').then((value) {
      buildingModel = BuildingModel.fromJson(value!.data);
      emit(GetBuildingSuccessState(buildingModel!));
    }).catchError((error) {
      emit(GetBuildingErrorState(error.toString()));
    });
  }

  FloorModel? floorModel;
  getFloor(int floorId) {
    emit(GetFloorLoadingState());
    DioHelper.getData(url: 'floors/building/$floorId').then((value) {
      floorModel = FloorModel.fromJson(value!.data);
      emit(GetFloorSuccessState(floorModel!));
    }).catchError((error) {
      emit(GetFloorErrorState(error.toString()));
    });
  }

  PointsModel? pointModel;
  getPoints(int pointId) {
    emit(GetPointLoadingState());
    DioHelper.getData(url: 'points/floor/$pointId').then((value) {
      pointModel = PointsModel.fromJson(value!.data);
      emit(GetPointSuccessState(pointModel!));
    }).catchError((error) {
      emit(GetPointErrorState(error.toString()));
    });
  }
}
