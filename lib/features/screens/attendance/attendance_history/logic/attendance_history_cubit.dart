import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/logic/attendance_history_state.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';

class AttendanceHistoryCubit extends Cubit<AttendanceHistoryState> {
  AttendanceHistoryCubit() : super(AttendanceHistoryInitialState());

  static AttendanceHistoryCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController statusIdController = TextEditingController();
  TextEditingController shiftController = TextEditingController();
  TextEditingController shiftIdController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  AttendanceHistoryModel? attendanceHistoryModel;
  getAllHistory() {
    emit(HistoryLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'search': searchController.text,
      'role': roleController.text,
      'shift': shiftIdController.text,
      'status': statusIdController.text,
      'startDate': startDateController.text,
      'endDate': endDateController.text
    }).then((value) {
      attendanceHistoryModel = AttendanceHistoryModel.fromJson(value!.data);
      emit(HistorySuccessState(attendanceHistoryModel!));
    }).catchError((error) {
      emit(HistoryErrorState(error.toString()));
    });
  }

  RoleModel? roleModel;
  getRole() {
    emit(RoleLoadingState());
    DioHelper.getData(url: ApiConstants.rolesUrl).then((value) {
      roleModel = RoleModel.fromJson(value!.data);
      emit(RoleSuccessState(roleModel!));
    }).catchError((error) {
      emit(RoleErrorState(error.toString()));
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
