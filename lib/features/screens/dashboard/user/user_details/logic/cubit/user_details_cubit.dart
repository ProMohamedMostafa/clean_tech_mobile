import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_history_management/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_leaves_management/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/task_management/data/models/all_tasks_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_managment/data/model/delete_user_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_details/data/models/user_details_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_details/data/models/user_shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_details/data/models/user_work_location_details.dart';
part 'user_details_state.dart';

class UserDetailsCubit extends Cubit<UserDetailsState> {
  UserDetailsCubit() : super(UserDetailsInitial());


  FilterDialogDataModel? taskFilterModel;
  FilterDialogDataModel? attendanceFilterModel;
  FilterDialogDataModel? leavesFilterModel;

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

  ScrollController scrollController = ScrollController();
  int currentPage = 1;
  AllTasksModel? userTaskDetailsModel;
  getUserTaskDetails(int? id) {
    emit(UserTaskDetailsLoadingState());
    final String? formattedStartDate = taskFilterModel?.startDate != null
        ? DateFormat('yyyy-MM-dd').format(taskFilterModel!.startDate!)
        : null;

    final String? formattedEndDate = taskFilterModel?.endDate != null
        ? DateFormat('yyyy-MM-dd').format(taskFilterModel!.endDate!)
        : null;
    DioHelper.getData(url: "tasks/pagination", query: {
      'PageNumber': currentPage,
      'PageSize': 10,
      'Status': taskFilterModel?.taskStatusId,
      'Priority': taskFilterModel?.priorityId,
      'CreatedBy': taskFilterModel?.createdBy,
      'AssignTo': id,
      'AreaId': taskFilterModel?.areaId,
      'CityId': taskFilterModel?.cityId,
      'OrganizationId': taskFilterModel?.organizationId,
      'BuildingId': taskFilterModel?.buildingId,
      'FloorId': taskFilterModel?.floorId,
      'SectionId': taskFilterModel?.sectionId,
      'PointId': taskFilterModel?.pointId,
      if (formattedStartDate != null) 'StartDate': formattedStartDate,
      if (formattedEndDate != null) 'EndDate': formattedEndDate,
      'StartTime': taskFilterModel?.startTime,
      'EndTime': taskFilterModel?.endTime,
    }).then((value) {
      final newTask = AllTasksModel.fromJson(value!.data);

      if (currentPage == 1 || userTaskDetailsModel == null) {
        userTaskDetailsModel = newTask;
      } else {
        userTaskDetailsModel?.data?.data?.addAll(newTask.data?.data ?? []);
        userTaskDetailsModel?.data?.currentPage = newTask.data?.currentPage;
        userTaskDetailsModel?.data?.totalPages = newTask.data?.totalPages;
      }
      emit(UserTaskDetailsSuccessState(userTaskDetailsModel!));
    }).catchError((error) {
      emit(UserTaskDetailsErrorState(error.toString()));
    });
  }

  initialize(int? id) {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getUserTaskDetails(id);
        }
      });
    getUserTaskDetails(id);
  }

  AttendanceHistoryModel? attendanceHistoryModel;
  getAllHistory(int? id) {
    emit(HistoryLoadingState());
    final String? formattedStartDate = attendanceFilterModel?.startDate != null
        ? DateFormat('yyyy-MM-dd').format(attendanceFilterModel!.startDate!)
        : null;

    final String? formattedEndDate = attendanceFilterModel?.endDate != null
        ? DateFormat('yyyy-MM-dd').format(attendanceFilterModel!.endDate!)
        : null;
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'UserId': id,
      'History': false,
      'Shift': attendanceFilterModel?.shiftId,
      if (formattedStartDate != null) 'StartDate': formattedStartDate,
      if (formattedEndDate != null) 'EndDate': formattedEndDate,
      'Status': attendanceFilterModel?.statusId,
      'AreaId': attendanceFilterModel?.areaId,
      'CityId': attendanceFilterModel?.cityId,
      'OrganizationId': attendanceFilterModel?.organizationId,
      'BuildingId': attendanceFilterModel?.buildingId,
      'FloorId': attendanceFilterModel?.floorId,
      'SectionId': attendanceFilterModel?.sectionId,
      'PointId': attendanceFilterModel?.pointId,
    }).then((value) {
      attendanceHistoryModel = AttendanceHistoryModel.fromJson(value!.data);
      emit(HistorySuccessState(attendanceHistoryModel!));
    }).catchError((error) {
      emit(HistoryErrorState(error.toString()));
    });
  }

  AttendanceLeavesModel? attendanceLeavesModel;
  getAllLeaves(int? id) {
    emit(LeavesLoadingState());
    final String? formattedStartDate = leavesFilterModel?.startDate != null
        ? DateFormat('yyyy-MM-dd').format(leavesFilterModel!.startDate!)
        : null;

    final String? formattedEndDate = leavesFilterModel?.endDate != null
        ? DateFormat('yyyy-MM-dd').format(leavesFilterModel!.endDate!)
        : null;
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'History': false,
      'UserId': id,
      if (formattedStartDate != null) 'StartDate': formattedStartDate,
      if (formattedEndDate != null) 'EndDate': formattedEndDate,
      'Type': leavesFilterModel?.typeId,
      'AreaId': leavesFilterModel?.areaId,
      'CityId': leavesFilterModel?.cityId,
      'OrganizationId': leavesFilterModel?.organizationId,
      'BuildingId': leavesFilterModel?.buildingId,
      'FloorId': leavesFilterModel?.floorId,
      'SectionId': leavesFilterModel?.sectionId,
      'PointId': leavesFilterModel?.pointId,
    }).then((value) {
      attendanceLeavesModel = AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }

  DeleteUserModel? deleteUserModel;
  userDelete(int id) {
    emit(UserDeleteLoadingState());
    DioHelper.postData(url: 'users/delete/$id').then((value) {
      deleteUserModel = DeleteUserModel.fromJson(value!.data);
      emit(UserDeleteSuccessState(deleteUserModel!));
    }).catchError((error) {
      emit(UserDeleteErrorState(error.toString()));
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

  Future<void> refreshShifts({int? id}) async {
    userShiftDetailsModel = null;
    emit(UserShiftDetailsLoadingState());
    await getUserShiftDetails(id);
  }

  Future<void> refreshWorkLocations({int? id}) async {
    userWorkLocationDetailsModel = null;
    emit(UserWorkLocationDetailsLoadingState());
    await getUserWorkLocationDetails(id);
  }
}
