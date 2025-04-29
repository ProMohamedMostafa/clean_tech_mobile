import 'package:bloc/bloc.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/data/models/shift_building_details.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/data/models/shift_floor_details.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/data/models/shift_organization_details.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/data/models/shift_section_details.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/delete_shift_model.dart'
    show DeleteShiftModel;
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/shift_details_model.dart';

part 'shift_details_state.dart';

class ShiftDetailsCubit extends Cubit<ShiftDetailsState> {
  ShiftDetailsCubit() : super(ShiftDetailsInitial());

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

  DeleteShiftModel? deleteShiftModel;
  shiftDelete(int id) {
    emit(ShiftDeleteLoadingState());
    DioHelper.postData(url: 'shifts/delete/$id', data: {'id': id})
        .then((value) {
      deleteShiftModel = DeleteShiftModel.fromJson(value!.data);
      emit(ShiftDeleteSuccessState(deleteShiftModel!));
    }).catchError((error) {
      emit(ShiftDeleteErrorState(error.toString()));
    });
  }
}
