import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/logic/attendance_leaves_state.dart';
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
  final formKey = GlobalKey<FormState>();



  // AttendanceHistoryModel? attendanceHistoryModel;
  // getAllHistory() {
  //   emit(HistoryLoadingState());
  //   DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
  //     'search': searchController.text,
  //     'role': roleController.text,
  //     'shift': shiftIdController.text,
  //     'status': statusIdController.text,
  //     'startDate': startDateController.text,
  //     'endDate': endDateController.text
  //   }).then((value) {
  //     attendanceHistoryModel = AttendanceHistoryModel.fromJson(value!.data);
  //     emit(HistorySuccessState(attendanceHistoryModel!));
  //   }).catchError((error) {
  //     emit(HistoryErrorState(error.toString()));
  //   });
  // }

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

}
