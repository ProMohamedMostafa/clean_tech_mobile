import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/all_shifts_deleted_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/all_shifts_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/shift_buildings_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/shift_floors_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/shift_organizations_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/shift_points_model.dart';
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

  // ShiftUsersModel? shiftUsersModel;
  // getShiftUsersDetails(int? id) {
  //   emit(ShiftUsersDetailsLoadingState());
  //   DioHelper.getData(url: 'user/shift/$id').then((value) {
  //     shiftUsersModel = ShiftUsersModel.fromJson(value!.data);
  //     emit(ShiftUsersDetailsSuccessState(shiftUsersModel!));
  //   }).catchError((error) {
  //     emit(ShiftUsersDetailsErrorState(error.toString()));
  //   });
  // }
  ShiftOrganizationsModel? shiftOrganizationsModel;
  getShiftOrganizations(int? id) {
    emit(ShiftOrganizationsLoadingState());
    DioHelper.getData(url: 'shift/point/$id').then((value) {
      shiftOrganizationsModel = ShiftOrganizationsModel.fromJson(value!.data);
      emit(ShiftOrganizationsSuccessState(shiftOrganizationsModel!));
    }).catchError((error) {
      emit(ShiftOrganizationsErrorState(error.toString()));
    });
  }

  ShiftBuildingsModel? shiftBuildingsModel;
  getShiftBuildings(int? id) {
    emit(ShiftBuildingsLoadingState());
    DioHelper.getData(url: 'shift/point/$id').then((value) {
      shiftBuildingsModel = ShiftBuildingsModel.fromJson(value!.data);
      emit(ShiftBuildingsSuccessState(shiftBuildingsModel!));
    }).catchError((error) {
      emit(ShiftBuildingsErrorState(error.toString()));
    });
  }

  ShiftFloorsModel? shiftFloorsModel;
  getShiftFloors(int? id) {
    emit(ShiftFloorsLoadingState());
    DioHelper.getData(url: 'shift/point/$id').then((value) {
      shiftFloorsModel = ShiftFloorsModel.fromJson(value!.data);
      emit(ShiftFloorsSuccessState(shiftFloorsModel!));
    }).catchError((error) {
      emit(ShiftFloorsErrorState(error.toString()));
    });
  }

  ShiftPointsModel? shiftPointsModel;
  getShiftPoints(int? id) {
    emit(ShiftPointsLoadingState());
    DioHelper.getData(url: 'shift/point/$id').then((value) {
      shiftPointsModel = ShiftPointsModel.fromJson(value!.data);
      emit(ShiftPointsSuccessState(shiftPointsModel!));
    }).catchError((error) {
      emit(ShiftPointsErrorState(error.toString()));
    });
  }

  AllShiftsModel? allShiftsModel;
  getAllShifts() {
    emit(ShiftLoadingState());
    DioHelper.getData(
        url: ApiConstants.allShiftsUrl,
        query: {'search': searchController.text}).then((value) {
      allShiftsModel = AllShiftsModel.fromJson(value!.data);
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
