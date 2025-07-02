import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attedance_leaves_details/data/model/leaves_details_model.dart';
part 'leaves_details_state.dart';

class LeavesDetailsCubit extends Cubit<LeavesDetailsState> {
  LeavesDetailsCubit() : super(LeavesDetailsInitial());
  TextEditingController rejectionReasonController = TextEditingController();

  bool descTextShowFlag = false;

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

  leavesDelete(int id) {
    emit(LeavesDeleteLoadingState());
    DioHelper.deleteData(url: 'leaves/delete/$id').then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(LeavesDeleteSuccessState(message!));
    }).catchError((error) {
      emit(LeavesDeleteErrorState(error.toString()));
    });
  }

  approveLeaveRequest(int id, bool isApproved) {
    emit(LeavesApproveLoadingState());
    DioHelper.putData(url: 'leaves/approve-or-reject', data: {
      'id': id,
      'isApproved': isApproved,
      'rejectionReason': rejectionReasonController.text
    }).then((value) {
      final message = value?.data['message'] ?? "Operation successfully";
      emit(LeavesApproveSuccessState(message!));
    }).catchError((error) {
      emit(LeavesApproveErrorState(error.toString()));
    });
  }

  void toggleDescText() {
    descTextShowFlag = !descTextShowFlag;
    emit(DescToggleState());
  }

  Future<void> refresLeaves({int? id}) async {
    leavesDetailsModel = null;
    emit(LeavesDetailsLoadingState());
    await getLeavesDetails(id);
  }
}
