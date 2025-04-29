import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/delete_user_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/data/models/user_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/data/models/user_shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/data/models/user_status_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/data/models/user_task_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/data/models/user_work_location_details.dart';
part 'user_details_state.dart';

class UserDetailsCubit extends Cubit<UserDetailsState> {
  UserDetailsCubit() : super(UserDetailsInitial());

  TextEditingController createdByController = TextEditingController();
  TextEditingController assignToController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController shiftController = TextEditingController();
  TextEditingController shiftIdController = TextEditingController();
  TextEditingController priorityController = TextEditingController();

  FilterDialogDataModel? filterModel;

  UserDetailsModel? userDetailsModel;
  getUserDetails(int? id) {
    emit(UserDetailsLoadingState());
    DioHelper.getData(url: 'users/$id').then((value) {
      userDetailsModel = UserDetailsModel.fromJson(value!.data);
      emit(UserDetailsSuccessState(userDetailsModel!));
    }).catchError((error) {
      emit(UserDetailsErrorState(error.toString()));
    });
  }

  UserStatusModel? userStatusModel;
  getUserStatus(int? id) {
    emit(UserStatusLoadingState());
    DioHelper.getData(url: 'attendance/status', query: {'userId': id})
        .then((value) {
      userStatusModel = UserStatusModel.fromJson(value!.data);
      emit(UserStatusSuccessState(userStatusModel!));
    }).catchError((error) {
      emit(UserStatusErrorState(error.toString()));
    });
  }

  UserWorkLocationDetailsModel? userWorkLocationDetailsModel;
  getUserWorkLocationDetails(int? id) {
    emit(UserWorkLocationDetailsLoadingState());
    DioHelper.getData(url: 'users/with-work-location/$id').then((value) {
      userWorkLocationDetailsModel =
          UserWorkLocationDetailsModel.fromJson(value!.data);
      emit(UserWorkLocationDetailsSuccessState(userWorkLocationDetailsModel!));
    }).catchError((error) {
      emit(UserWorkLocationDetailsErrorState(error.toString()));
    });
  }

  UserShiftDetailsModel? userShiftDetailsModel;
  getUserShiftDetails(int? id) {
    emit(UserShiftDetailsLoadingState());
    DioHelper.getData(url: 'user/shift/$id').then((value) {
      userShiftDetailsModel = UserShiftDetailsModel.fromJson(value!.data);
      emit(UserShiftDetailsSuccessState(userShiftDetailsModel!));
    }).catchError((error) {
      emit(UserShiftDetailsErrorState(error.toString()));
    });
  }

  UserTaskDetailsModel? userTaskDetailsModel;
  getUserTaskDetails(
    int? id, {
    int? createdBy,
    int? status,
    int? priority,
    int? areaId,
    int? cityId,
    int? organizationId,
    int? buildingId,
    int? floorId,
    int? pointId,
    int? providerId,
  }) {
    emit(UserTaskDetailsLoadingState());
    DioHelper.getData(url: 'tasks/pagination', query: {
      'assignTo': id,
      'startDate': filterModel?.startDate,
      'endDate': filterModel?.endDate,
      'startTime': filterModel?.startTime,
      'endTime': filterModel?.endTime,
      'created': createdBy,
      'status': status,
      'priority': priority,
      'area': areaId,
      'city': cityId,
      'organization': organizationId,
      'building': buildingId,
      'floor': floorId,
      'point': pointId,
    }).then((value) {
      userTaskDetailsModel = UserTaskDetailsModel.fromJson(value!.data);
      emit(UserTaskDetailsSuccessState(userTaskDetailsModel!));
    }).catchError((error) {
      emit(UserTaskDetailsErrorState(error.toString()));
    });
  }

  AttendanceHistoryModel? attendanceHistoryModel;
  getAllHistory(
    int? id, {
    int? status,
    int? areaId,
    int? cityId,
    int? organizationId,
    int? buildingId,
    int? floorId,
    int? pointId,
    int? providerId,
    int? shiftId,
  }) {
    emit(HistoryLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'userId': id,
      'history': false,
      'role': filterModel?.roleId,
      'shift': shiftId,
      'startDate': filterModel?.startDate,
      'endDate': filterModel?.endDate,
      'status': status,
      'areaId': areaId,
      'cityId': cityId,
      'organizationId': organizationId,
      'buildingId': buildingId,
      'floorId': floorId,
      'pointId': pointId,
      'providerId': providerId
    }).then((value) {
      attendanceHistoryModel = AttendanceHistoryModel.fromJson(value!.data);
      emit(HistorySuccessState(attendanceHistoryModel!));
    }).catchError((error) {
      emit(HistoryErrorState(error.toString()));
    });
  }

  AttendanceLeavesModel? attendanceLeavesModel;
  getAllLeaves(
    int? id, {
    int? areaId,
    int? cityId,
    int? organizationId,
    int? buildingId,
    int? floorId,
    int? pointId,
    int? providerId,
  }) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'assignTo': id,
      'history': false,
      'role': filterModel?.roleId,
      'startDate': filterModel?.startDate,
      'endDate': filterModel?.endDate,
      'type': filterModel?.typeId,
      'area': areaId,
      'city': cityId,
      'organization': organizationId,
      'building': buildingId,
      'floor': floorId,
      'point': pointId,
      'provider': providerId
    }).then((value) {
      attendanceLeavesModel = AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }

  AreaListModel? areaListModel;
  getAllArea() {
    emit(GetAllAreaLoadingState());
    DioHelper.getData(url: ApiConstants.areaUrl).then((value) {
      areaListModel = AreaListModel.fromJson(value!.data);
      emit(GetAllAreaSuccessState(areaListModel!));
    }).catchError((error) {
      emit(GetAllAreaErrorState(error.toString()));
    });
  }

  ShiftModel? shiftModel;
  getShifts() {
    emit(ShiftLoadingState());
    DioHelper.getData(url: ApiConstants.allShiftsUrl).then((value) {
      shiftModel = ShiftModel.fromJson(value!.data);
      emit(ShiftSuccessState(shiftModel!));
    }).catchError((error) {
      emit(ShiftErrorState(error.toString()));
    });
  }

  DeleteUserModel? deleteUserModel;
  userDelete(int id) {
    emit(UserDeleteLoadingState());
    DioHelper.postData(url: 'users/delete/$id', data: {'id': id}).then((value) {
      deleteUserModel = DeleteUserModel.fromJson(value!.data);
      emit(UserDeleteSuccessState(deleteUserModel!));
    }).catchError((error) {
      emit(UserDeleteErrorState(error.toString()));
    });
  }
}
