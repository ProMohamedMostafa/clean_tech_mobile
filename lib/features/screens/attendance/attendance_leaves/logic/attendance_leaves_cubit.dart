import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/logic/attendance_leaves_state.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_edit/data/models/leaves_details_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';

class AttendanceLeavesCubit extends Cubit<AttendanceLeavesState> {
  AttendanceLeavesCubit() : super(AttendanceLeavesInitialState());

  static AttendanceLeavesCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController typeIdController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  AttendanceLeavesModel? attendanceLeavesModel;
  getAllLeaves() {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'search': searchController.text,
      'role': roleController.text,
      'type': typeIdController.text,
      'startDate': startDateController.text,
      'endDate': endDateController.text
    }).then((value) {
      attendanceLeavesModel = AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
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

  leavesDelete(int id) {
    emit(LeavesDeleteLoadingState());
    DioHelper.deleteData(url: 'leaves/delete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(LeavesDeleteSuccessState(message!));
    }).catchError((error) {
      emit(LeavesDeleteErrorState(error.toString()));
    });
  }

LeavesDetailsModel? leavesDetailsModel;
  getLeavesDetails(int? id) {
    emit(LeavesDetailsLoadingState());
    DioHelper.getData(url: "leaves/$id").then((value) {
      leavesDetailsModel = LeavesDetailsModel.fromJson(value!.data);
      emit(LeavesDetailsSuccessState(leavesDetailsModel!));
    }).catchError((error) {
      emit(LeavesDetailsErrorState(error.toString()));
    });
  }

  

}
