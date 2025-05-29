import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/profile/logic/profile_state.dart';
import 'package:smart_cleaning_application/features/screens/settings/data/model/profile_model.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/data/models/all_tasks_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/data/models/user_shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/data/models/user_work_location_details.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  FilterDialogDataModel? filterModel;

  ProfileModel? profileModel;
  getUserProfileDetails() {
    emit(UserProfileDetailsLoadingState());
    DioHelper.getData(url: 'auth/profile').then((value) {
      profileModel = ProfileModel.fromJson(value!.data);
      emit(UserProfileDetailsSuccessState(profileModel!));
    }).catchError((error) {
      emit(UserProfileDetailsErrorState(error.toString()));
    });
  }

  UserWorkLocationDetailsModel? userWorkLocationDetailsModel;
  getUserWorkLocationDetails() {
    emit(UserWorkLocationDetailsLoadingState());
    DioHelper.getData(url: 'users/with-work-location/$uId').then((value) {
      userWorkLocationDetailsModel =
          UserWorkLocationDetailsModel.fromJson(value!.data);
      emit(UserWorkLocationDetailsSuccessState(userWorkLocationDetailsModel!));
    }).catchError((error) {
      emit(UserWorkLocationDetailsErrorState(error.toString()));
    });
  }

  UserShiftDetailsModel? userShiftDetailsModel;
  getUserShiftDetails() {
    emit(UserShiftDetailsLoadingState());
    DioHelper.getData(url: 'user/shift/$uId').then((value) {
      userShiftDetailsModel = UserShiftDetailsModel.fromJson(value!.data);
      emit(UserShiftDetailsSuccessState(userShiftDetailsModel!));
    }).catchError((error) {
      emit(UserShiftDetailsErrorState(error.toString()));
    });
  }

  AllTasksModel? userTaskDetailsModel;
  getUserTaskDetails() {
    emit(UserTaskDetailsLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'Status': filterModel?.taskStatusId,
      'Priority': filterModel?.priorityId,
      'CreatedBy': filterModel?.createdBy,
      'AssignTo': uId,
      'AreaId': filterModel?.areaId,
      'CityId': filterModel?.cityId,
      'OrganizationId': filterModel?.organizationId,
      'BuildingId': filterModel?.buildingId,
      'FloorId': filterModel?.floorId,
      'SectionId': filterModel?.sectionId,
      'PointId': filterModel?.pointId,
      'ProviderId': filterModel?.providerId,
      'StartDate': filterModel?.startDate != null
          ? DateFormat('yyyy-MM-dd').format(filterModel!.startDate!)
          : null,
      'EndDate': filterModel?.endDate,
      'StartTime': filterModel?.startTime,
      'EndTime': filterModel?.endTime,
    }).then((value) {
      userTaskDetailsModel = AllTasksModel.fromJson(value!.data);
      emit(UserTaskDetailsSuccessState(userTaskDetailsModel!));
    }).catchError((error) {
      emit(UserTaskDetailsErrorState(error.toString()));
    });
  }

  AttendanceHistoryModel? attendanceHistoryModel;
  getAllHistory() {
    emit(HistoryLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'UserId': uId,
      'History': false,
      'RoleId': filterModel?.roleId,
      'Shift': filterModel?.shiftId,
      'StartDate': filterModel?.startDate,
      'EndDate': filterModel?.endDate,
      'Status': filterModel?.statusId,
      'AreaId': filterModel?.areaId,
      'CityId': filterModel?.cityId,
      'OrganizationId': filterModel?.organizationId,
      'BuildingId': filterModel?.buildingId,
      'FloorId': filterModel?.floorId,
      'SectionId': filterModel?.sectionId,
      'PointId': filterModel?.pointId,
      'ProviderId': filterModel?.providerId
    }).then((value) {
      attendanceHistoryModel = AttendanceHistoryModel.fromJson(value!.data);
      emit(HistorySuccessState(attendanceHistoryModel!));
    }).catchError((error) {
      emit(HistoryErrorState(error.toString()));
    });
  }

  AttendanceLeavesModel? attendanceLeavesModel;
  getAllLeaves() {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'History': false,
      'UserId': uId,
      'RoleId': filterModel?.roleId,
      'StartDate': filterModel?.startDate,
      'EndDate': filterModel?.endDate,
      'Type': filterModel?.typeId,
      'AreaId': filterModel?.areaId,
      'CityId': filterModel?.cityId,
      'OrganizationId': filterModel?.organizationId,
      'BuildingId': filterModel?.buildingId,
      'FloorId': filterModel?.floorId,
      'SectionId': filterModel?.sectionId,
      'PointId': filterModel?.pointId,
      'ProviderId': filterModel?.providerId,
    }).then((value) {
      attendanceLeavesModel = AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }

  static const List<String> statusList = ["Absent", "Late", "Present"];
  static const List<Color> statusColors = [
    Colors.red,
    Colors.orange,
    Colors.green,
  ];

  // Priority related constants
  static const List<String> priorityList = ["High", "Medium", "Low"];
  static const List<Color> priorityColors = [
    Colors.red,
    Colors.orange,
    Colors.green,
  ];

  // Format duration string
  String formatDuration(String? duration) {
    if (duration == null || duration.isEmpty) return "    ";
    final parts = duration.split(':');
    if (parts.length != 3) return "Invalid Format";

    try {
      final hours = int.tryParse(parts[0]) ?? 0;
      final minutes = int.tryParse(parts[1]) ?? 0;
      if (hours > 0) return '$hours hr';
      if (minutes > 0) return '$minutes min';
      return '${(double.tryParse(parts[2])?.floor() ?? 0)} sec';
    } catch (e) {
      return "Invalid Data";
    }
  }

  // Format time string
  String formatTime(String? time) {
    if (time == null || time.isEmpty) return " ";
    try {
      return DateFormat('HH:mm').format(DateTime.parse(time));
    } catch (e) {
      return "Invalid Time";
    }
  }

  // Get status color based on status string
  Color getStatusColor(String status) {
    if (statusList.contains(status)) {
      return statusColors[statusList.indexOf(status)];
    }
    return Colors.black;
  }

  // Get priority color based on priority string
  Color getPriorityColor(String priority) {
    if (priorityList.contains(priority)) {
      return priorityColors[priorityList.indexOf(priority)];
    }
    return Colors.black;
  }
}
