import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/all_shifts_deleted_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/all_shifts_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/logic/shift_state.dart';

class ShiftCubit extends Cubit<ShiftState> {
  ShiftCubit() : super(ShiftInitialState());

  static ShiftCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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

  AllShiftsModel? allShiftsModel;
  getAllShifts() {
    emit(ShiftLoadingState());
    DioHelper.getData(url: ApiConstants.allShiftsUrl).then((value) {
      allShiftsModel = AllShiftsModel.fromJson(value!.data);
      allShiftsModel;
      emit(ShiftSuccessState(allShiftsModel!));
    }).catchError((error) {
      emit(ShiftErrorState(error.toString()));
    });
  }

  shiftDelete(int id) {
    emit(ShiftDeleteLoadingState());
    DioHelper.postData(url: 'shifts/delete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(ShiftDeleteSuccessState(message!));
    }).catchError((error) {
      emit(ShiftDeleteErrorState(error.toString()));
    });
  }

  AllShiftsDeletedModel? allShiftsDeletedModel;
  getAllDeletedShifts() {
    emit(AllShiftDeleteLoadingState());
    DioHelper.getData(url: ApiConstants.allShiftsDeletedUrl).then((value) {
      allShiftsDeletedModel = AllShiftsDeletedModel.fromJson(value!.data);
      emit(AllShiftDeleteSuccessState(allShiftsDeletedModel!));
    }).catchError((error) {
      emit(AllShiftDeleteErrorState(error.toString()));
    });
  }

  restoreDeletedShift(int id) {
    emit(RestoreShiftLoadingState());
    DioHelper.postData(url: 'shifts/restore/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(RestoreShiftSuccessState(message));
    }).catchError((error) {
      emit(RestoreShiftErrorState(error.toString()));
    });
  }

  forcedDeletedShift(int id) {
    emit(ForceDeleteShiftLoadingState());
    DioHelper.deleteData(url: 'shifts/forcedelete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "deleted successfully";
      emit(ForceDeleteShiftSuccessState(message));
    }).catchError((error) {
      emit(ForceDeleteShiftErrorState(error.toString()));
    });
  }
}
