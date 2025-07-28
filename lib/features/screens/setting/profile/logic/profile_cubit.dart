import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_history_management/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_leaves_management/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/setting/profile/logic/profile_state.dart';
import 'package:smart_cleaning_application/features/screens/setting/settings/data/model/profile_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/task_management/data/models/all_tasks_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_details/data/models/user_shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_details/data/models/user_work_location_details.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  FilterDialogDataModel? taskFilterModel;
  FilterDialogDataModel? attendanceFilterModel;
  FilterDialogDataModel? leavesFilterModel;

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

  ScrollController scrollController = ScrollController();
  int currentPage = 1;
  AllTasksModel? userTaskDetailsModel;
  getUserTaskDetails() {
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
      'AssignTo': uId,
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

  initialize() {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getUserTaskDetails();
        }
      });
    getUserTaskDetails();
  }

  AttendanceHistoryModel? attendanceHistoryModel;
  getAllHistory() {
    emit(HistoryLoadingState());
    final String? formattedStartDate = attendanceFilterModel?.startDate != null
        ? DateFormat('yyyy-MM-dd').format(attendanceFilterModel!.startDate!)
        : null;

    final String? formattedEndDate = attendanceFilterModel?.endDate != null
        ? DateFormat('yyyy-MM-dd').format(attendanceFilterModel!.endDate!)
        : null;
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'UserId': uId,
      'History': true,
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
  getAllLeaves() {
    emit(LeavesLoadingState());
    final String? formattedStartDate = leavesFilterModel?.startDate != null
        ? DateFormat('yyyy-MM-dd').format(leavesFilterModel!.startDate!)
        : null;

    final String? formattedEndDate = leavesFilterModel?.endDate != null
        ? DateFormat('yyyy-MM-dd').format(leavesFilterModel!.endDate!)
        : null;
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'UserId': uId,
      'History': true,
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

  Future<void> refreshShifts() async {
    userShiftDetailsModel = null;
    emit(UserShiftDetailsLoadingState());
    await getUserShiftDetails();
  }

  Future<void> refreshWorkLocations() async {
    userWorkLocationDetailsModel = null;
    emit(UserWorkLocationDetailsLoadingState());
    await getUserWorkLocationDetails();
  }
}
