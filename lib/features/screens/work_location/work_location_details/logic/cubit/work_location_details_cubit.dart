import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history_management/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_management/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/data/models/all_tasks_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/data/models/area_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/data/models/building_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/data/models/city_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/data/models/floor_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/data/models/organization_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/data/models/point_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/data/models/section_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/data/models/area_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/data/models/building_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/data/models/city_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_area_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_section_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/data/models/floor_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/data/models/organization_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/data/models/section_tree_model.dart';

part 'work_location_details_state.dart';

class WorkLocationDetailsCubit extends Cubit<WorkLocationDetailsState> {
  WorkLocationDetailsCubit() : super(WorkLocationDetailsInitial());

  AreaUsersDetailsModel? areaUsersDetailsModel;
  getAreaUsersDetails(int areaId) {
    emit(AreaUsersDetailsLoadingState());
    DioHelper.getData(url: 'areas/with-user/$areaId').then((value) {
      areaUsersDetailsModel = AreaUsersDetailsModel.fromJson(value!.data);
      emit(AreaUsersDetailsSuccessState(areaUsersDetailsModel!));
    }).catchError((error) {
      emit(AreaUsersDetailsErrorState(error.toString()));
    });
  }

  CityUsersDetailsModel? cityUsersDetailsModel;
  getCityUsersDetails(int cityId) {
    emit(CityUsersDetailsLoadingState());
    DioHelper.getData(url: 'cities/with-user/$cityId').then((value) {
      cityUsersDetailsModel = CityUsersDetailsModel.fromJson(value!.data);
      emit(CityUsersDetailsSuccessState(cityUsersDetailsModel!));
    }).catchError((error) {
      emit(CityUsersDetailsErrorState(error.toString()));
    });
  }

  OrganizationUsersShiftsDetailsModel? organizationUsersShiftDetailsModel;
  getOrganizationUsersDetails(int organizationId) {
    emit(OrganizationUsersDetailsLoadingState());
    DioHelper.getData(url: 'organizations/with-user-shift/$organizationId')
        .then((value) {
      organizationUsersShiftDetailsModel =
          OrganizationUsersShiftsDetailsModel.fromJson(value!.data);
      emit(OrganizationUsersDetailsSuccessState(
          organizationUsersShiftDetailsModel!));
    }).catchError((error) {
      emit(OrganizationUsersDetailsErrorState(error.toString()));
    });
  }

  BuildingUsersShiftsDetailsModel? buildingUsersShiftDetailsModel;
  getBuildingUsersDetails(int buildingId) {
    emit(BuildingUsersDetailsLoadingState());
    DioHelper.getData(url: 'buildings/with-user-shift/$buildingId')
        .then((value) {
      buildingUsersShiftDetailsModel =
          BuildingUsersShiftsDetailsModel.fromJson(value!.data);
      emit(BuildingUsersDetailsSuccessState(buildingUsersShiftDetailsModel!));
    }).catchError((error) {
      emit(BuildingUsersDetailsErrorState(error.toString()));
    });
  }

  FloorUsersShiftsDetailsModel? floorUsersShiftDetailsModel;
  getFloorUsersDetails(int floorId) {
    emit(FloorUsersDetailsLoadingState());
    DioHelper.getData(url: 'floors/with-user-shift/$floorId').then((value) {
      floorUsersShiftDetailsModel =
          FloorUsersShiftsDetailsModel.fromJson(value!.data);
      emit(FloorUsersDetailsSuccessState(floorUsersShiftDetailsModel!));
    }).catchError((error) {
      emit(FloorUsersDetailsErrorState(error.toString()));
    });
  }

  SectionUsersShiftsDetailsModel? sectionUsersShiftDetailsModel;
  getSectionUsersDetails(int sectionId) {
    emit(SectionUserDetailsLoadingState());
    DioHelper.getData(url: 'sections/with-user-shift/$sectionId').then((value) {
      sectionUsersShiftDetailsModel =
          SectionUsersShiftsDetailsModel.fromJson(value!.data);
      emit(SectionUserDetailsSuccessState(sectionUsersShiftDetailsModel!));
    }).catchError((error) {
      emit(SectionUserDetailsErrorState(error.toString()));
    });
  }

  PointUsersDetailsModel? pointUsersDetailsModel;
  getPointUsersDetails(int pointId) {
    emit(PointUsersDetailsLoadingState());
    DioHelper.getData(url: 'points/with-user/$pointId').then((value) {
      pointUsersDetailsModel = PointUsersDetailsModel.fromJson(value!.data);
      emit(PointUsersDetailsSuccessState(pointUsersDetailsModel!));
    }).catchError((error) {
      emit(PointUsersDetailsErrorState(error.toString()));
    });
  }

//*********************************************************************************** */
  AreaTreeModel? areaTreeModel;
  getAreatree(int id) {
    emit(AreaTreeLoadingState());
    DioHelper.getData(url: 'areas/tree/$id').then((value) {
      areaTreeModel = AreaTreeModel.fromJson(value!.data);
      emit(AreaTreeSuccessState(areaTreeModel!));
    }).catchError((error) {
      emit(AreaTreeErrorState(error.toString()));
    });
  }

  CityTreeModel? cityTreeModel;
  getCitytree(int id) {
    emit(CityTreeLoadingState());
    DioHelper.getData(url: 'cities/tree/$id').then((value) {
      cityTreeModel = CityTreeModel.fromJson(value!.data);
      emit(CityTreeSuccessState(cityTreeModel!));
    }).catchError((error) {
      emit(CityTreeErrorState(error.toString()));
    });
  }

  OrganizationTreeModel? organizationTreeModel;
  getOrganizationtree(int id) {
    emit(OrganizationTreeLoadingState());
    DioHelper.getData(url: 'organizations/tree/$id').then((value) {
      organizationTreeModel = OrganizationTreeModel.fromJson(value!.data);
      emit(OrganizationTreeSuccessState(organizationTreeModel!));
    }).catchError((error) {
      emit(OrganizationTreeErrorState(error.toString()));
    });
  }

  BuildingTreeModel? buildingTreeModel;
  getBuildingtree(int id) {
    emit(BuildingTreeLoadingState());
    DioHelper.getData(url: 'buildings/tree/$id').then((value) {
      buildingTreeModel = BuildingTreeModel.fromJson(value!.data);
      emit(BuildingTreeSuccessState(buildingTreeModel!));
    }).catchError((error) {
      emit(BuildingTreeErrorState(error.toString()));
    });
  }

  FloorTreeModel? floorTreeModel;
  getFloortree(int id) {
    emit(FloorTreeLoadingState());
    DioHelper.getData(url: 'floors/tree/$id').then((value) {
      floorTreeModel = FloorTreeModel.fromJson(value!.data);
      emit(FloorTreeSuccessState(floorTreeModel!));
    }).catchError((error) {
      emit(FloorTreeErrorState(error.toString()));
    });
  }

  SectionTreeModel? sectionTreeModel;
  getSectiontree(int id) {
    emit(SectionTreeLoadingState());
    DioHelper.getData(url: 'sections/tree/$id').then((value) {
      sectionTreeModel = SectionTreeModel.fromJson(value!.data);
      emit(SectionTreeSuccessState(sectionTreeModel!));
    }).catchError((error) {
      emit(SectionTreeErrorState(error.toString()));
    });
  }

//*********************************************************************************** */
  AllTasksModel? allareaTasksModel;
  getAreaTasks(
    int? areaId,
  ) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'AreaId': areaId,
    }).then((value) {
      allareaTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allareaTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

  AllTasksModel? allcityTasksModel;
  getCityTasks(int? cityId) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'CityId': cityId,
    }).then((value) {
      allcityTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allcityTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

  AllTasksModel? allorganizationTasksModel;
  getorganizationTasks(int? organizationId) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'OrganizationId': organizationId,
    }).then((value) {
      allorganizationTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allorganizationTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

  AllTasksModel? allbuildingTasksModel;
  getbuildingTasks(int? buildingId) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'BuildingId': buildingId,
    }).then((value) {
      allbuildingTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allbuildingTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

  AllTasksModel? allfloorTasksModel;
  getfloorTasks(int? floorId) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'FloorId': floorId,
    }).then((value) {
      allfloorTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allfloorTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

  AllTasksModel? allSectionTasksModel;
  getSectionTasks(int? sectionId) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'SectionId': sectionId,
    }).then((value) {
      allSectionTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allSectionTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

  AllTasksModel? allPointTasksModel;
  getPointTasks(int? pointId) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'PointId': pointId,
    }).then((value) {
      allPointTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allPointTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

//*********************************************************************************** */

  AttendanceHistoryModel? attendanceHistoryAreaModel;
  getAttendanceHistoryArea(int id) {
    emit(AttendanceHistoryAreaLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'AreaId': id,
    }).then((value) {
      attendanceHistoryAreaModel = AttendanceHistoryModel.fromJson(value!.data);
      emit(AttendanceHistoryAreaSuccessState(attendanceHistoryAreaModel!));
    }).catchError((error) {
      emit(AttendanceHistoryAreaErrorState(error.toString()));
    });
  }

  AttendanceHistoryModel? attendanceHistoryCityModel;
  getAttendanceHistoryCity(int id) {
    emit(AttendanceHistoryCityLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'CityId': id,
    }).then((value) {
      attendanceHistoryCityModel = AttendanceHistoryModel.fromJson(value!.data);
      emit(AttendanceHistoryCitySuccessState(attendanceHistoryCityModel!));
    }).catchError((error) {
      emit(AttendanceHistoryCityErrorState(error.toString()));
    });
  }

  AttendanceHistoryModel? attendanceHistoryOrganizationModel;
  getAttendanceHistoryOrganization(int id) {
    emit(AttendanceHistoryOrganizationLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'OrganizationId': id,
    }).then((value) {
      attendanceHistoryOrganizationModel =
          AttendanceHistoryModel.fromJson(value!.data);
      emit(AttendanceHistoryOrganizationSuccessState(
          attendanceHistoryOrganizationModel!));
    }).catchError((error) {
      emit(AttendanceHistoryOrganizationErrorState(error.toString()));
    });
  }

  AttendanceHistoryModel? attendanceHistoryBuildingModel;
  getAttendanceHistoryBuilding(int id) {
    emit(AttendanceHistoryBuildingLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'BuildingId': id,
    }).then((value) {
      attendanceHistoryBuildingModel =
          AttendanceHistoryModel.fromJson(value!.data);
      emit(AttendanceHistoryBuildingSuccessState(
          attendanceHistoryBuildingModel!));
    }).catchError((error) {
      emit(AttendanceHistoryBuildingErrorState(error.toString()));
    });
  }

  AttendanceHistoryModel? attendanceHistoryFloorModel;
  getAttendanceHistoryFloor(int id) {
    emit(AttendanceHistoryFloorLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'FloorId': id,
    }).then((value) {
      attendanceHistoryFloorModel =
          AttendanceHistoryModel.fromJson(value!.data);
      emit(AttendanceHistoryFloorSuccessState(attendanceHistoryFloorModel!));
    }).catchError((error) {
      emit(AttendanceHistoryFloorErrorState(error.toString()));
    });
  }

  AttendanceHistoryModel? attendanceHistorySectionModel;
  getAttendanceHistorySection(int id) {
    emit(AttendanceHistorySectionLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'SectionId': id,
    }).then((value) {
      attendanceHistorySectionModel =
          AttendanceHistoryModel.fromJson(value!.data);
      emit(
          AttendanceHistorySectionSuccessState(attendanceHistorySectionModel!));
    }).catchError((error) {
      emit(AttendanceHistorySectionErrorState(error.toString()));
    });
  }

  AttendanceHistoryModel? attendanceHistoryPointModel;
  getAttendanceHistoryPoint(int id) {
    emit(AttendanceHistoryPointLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'PointId': id,
    }).then((value) {
      attendanceHistoryPointModel =
          AttendanceHistoryModel.fromJson(value!.data);
      emit(AttendanceHistoryPointSuccessState(attendanceHistoryPointModel!));
    }).catchError((error) {
      emit(AttendanceHistoryPointErrorState(error.toString()));
    });
  }

//*********************************************************************************** */

  AttendanceLeavesModel? attendanceLeavesAreaModel;
  getAllLeavesArea(int id) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'AreaId': id,
    }).then((value) {
      attendanceLeavesAreaModel = AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesAreaModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }

  AttendanceLeavesModel? attendanceLeavesCityModel;
  getAllLeavesCity(int id) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'CityId': id,
    }).then((value) {
      attendanceLeavesCityModel = AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesCityModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }

  AttendanceLeavesModel? attendanceLeavesOrganizationModel;
  getAllLeavesOrganization(int id) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'OrganizationId': id,
    }).then((value) {
      attendanceLeavesOrganizationModel =
          AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesOrganizationModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }

  AttendanceLeavesModel? attendanceLeavesBuildingModel;
  getAllLeavesBuilding(int id) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'BuildingId': id,
    }).then((value) {
      attendanceLeavesBuildingModel =
          AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesBuildingModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }

  AttendanceLeavesModel? attendanceLeavesFloorModel;
  getAllLeavesFloor(int id) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'FloorId': id,
    }).then((value) {
      attendanceLeavesFloorModel = AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesFloorModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }

  AttendanceLeavesModel? attendanceLeavesSectionModel;
  getAllLeavesSection(int id) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'SectionId': id,
    }).then((value) {
      attendanceLeavesSectionModel =
          AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesSectionModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }

  AttendanceLeavesModel? attendanceLeavesPointModel;
  getAllLeavesPoint(int id) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'PointId': id,
    }).then((value) {
      attendanceLeavesPointModel = AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesPointModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }

//*********************************************************************************** */
  DeleteAreaModel? deleteAreaModel;
  deleteArea(int id) {
    emit(AreaDeleteLoadingState());
    DioHelper.postData(url: 'areas/delete/$id').then((value) {
      deleteAreaModel = DeleteAreaModel.fromJson(value!.data);
      emit(AreaDeleteSuccessState(deleteAreaModel!));
    }).catchError((error) {
      emit(AreaDeleteErrorState(error.toString()));
    });
  }

  DeleteCityModel? deleteCityModel;
  deleteCity(int id) {
    emit(CityDeleteLoadingState());
    DioHelper.postData(url: 'cities/delete/$id').then((value) {
      deleteCityModel = DeleteCityModel.fromJson(value!.data);
      emit(CityDeleteSuccessState(deleteCityModel!));
    }).catchError((error) {
      emit(CityDeleteErrorState(error.toString()));
    });
  }

  DeleteOrganizationModel? deleteOrganizationModel;
  deleteOrganization(int id) {
    emit(OrganizationDeleteLoadingState());
    DioHelper.postData(url: 'organizations/delete/$id').then((value) {
      deleteOrganizationModel = DeleteOrganizationModel.fromJson(value!.data);
      emit(OrganizationDeleteSuccessState(deleteOrganizationModel!));
    }).catchError((error) {
      emit(OrganizationDeleteErrorState(error.toString()));
    });
  }

  DeleteBuildingModel? deleteBuildingModel;
  deleteBuilding(int id) {
    emit(BuildingDeleteLoadingState());
    DioHelper.postData(url: 'buildings/delete/$id').then((value) {
      deleteBuildingModel = DeleteBuildingModel.fromJson(value!.data);
      emit(BuildingDeleteSuccessState(deleteBuildingModel!));
    }).catchError((error) {
      emit(BuildingDeleteErrorState(error.toString()));
    });
  }

  DeleteFloorModel? deleteFloorModel;
  deleteFloor(int id) {
    emit(FloorDeleteLoadingState());
    DioHelper.postData(url: 'floors/delete/$id').then((value) {
      deleteFloorModel = DeleteFloorModel.fromJson(value!.data);
      emit(FloorDeleteSuccessState(deleteFloorModel!));
    }).catchError((error) {
      emit(FloorDeleteErrorState(error.toString()));
    });
  }

  DeleteSectionModel? deleteSectionModel;
  deleteSection(int id) {
    emit(SectionDeleteLoadingState());
    DioHelper.postData(url: 'sections/delete/$id').then((value) {
      deleteSectionModel = DeleteSectionModel.fromJson(value!.data);

      emit(SectionDeleteSuccessState(deleteSectionModel!));
    }).catchError((error) {
      emit(SectionDeleteErrorState(error.toString()));
    });
  }

  DeletePointModel? deletePointModel;
  deletePoint(int id) {
    emit(PointDeleteLoadingState());
    DioHelper.postData(url: 'points/delete/$id').then((value) {
      deletePointModel = DeletePointModel.fromJson(value!.data);
      emit(PointDeleteSuccessState(deletePointModel!));
    }).catchError((error) {
      emit(PointDeleteErrorState(error.toString()));
    });
  }

//*********************************************************************************** */

  FilterDialogDataModel? taskFilterModel;

  AllTasksModel? workLocationTaskDetailsModel;
  getWorklocationTaskDetails(int? id) {
    emit(UserTaskDetailsLoadingState());
    final String? formattedStartDate = taskFilterModel?.startDate != null
        ? DateFormat('yyyy-MM-dd').format(taskFilterModel!.startDate!)
        : null;

    final String? formattedEndDate = taskFilterModel?.endDate != null
        ? DateFormat('yyyy-MM-dd').format(taskFilterModel!.endDate!)
        : null;
    DioHelper.getData(url: "tasks/pagination", query: {
      'Status': taskFilterModel?.taskStatusId,
      'Priority': taskFilterModel?.priorityId,
      'CreatedBy': taskFilterModel?.createdBy,
      'AssignTo': taskFilterModel?.userId,
      'AreaId': id,
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
      workLocationTaskDetailsModel = AllTasksModel.fromJson(value!.data);
      emit(UserTaskDetailsSuccessState(workLocationTaskDetailsModel!));
    }).catchError((error) {
      emit(UserTaskDetailsErrorState(error.toString()));
    });
  }

  int selectedTreeIndex = 0;
  bool descTextShowFlag = false;

  void toggleDescText() {
    descTextShowFlag = !descTextShowFlag;
    emit(DescToggleState());
  }

  void changeSelectedTreeIndex(int index) {
    selectedTreeIndex = index;
    emit(ChangeTreeIndexState());
  }

  static const List<String> statusList = ["Absent", "Late", "Present"];
  static const List<Color> statusColors = [
    Colors.red,
    Colors.orange,
    Colors.green,
  ];
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

  Color getStatusColor(String status) {
    if (statusList.contains(status)) {
      return statusColors[statusList.indexOf(status)];
    }
    return Colors.black;
  }

  void initialize(int id, int selectedIndex) {
    if (selectedIndex == 0) {
      getAreaUsersDetails(id);
      getAreaTasks(id);

      getAttendanceHistoryArea(id);
      getAllLeavesArea(id);
      getAreatree(id);
    }
    if (selectedIndex == 1) {
      getCityUsersDetails(id);
      getCityTasks(id);
      getAttendanceHistoryCity(id);
      getAllLeavesCity(id);
      getCitytree(id);
    }
    if (selectedIndex == 2) {
      getOrganizationUsersDetails(id);
      getorganizationTasks(id);
      getAttendanceHistoryOrganization(id);
      getAllLeavesOrganization(id);
      getOrganizationtree(id);
    }
    if (selectedIndex == 3) {
      getBuildingUsersDetails(id);
      getbuildingTasks(id);
      getAttendanceHistoryBuilding(id);
      getAllLeavesBuilding(id);
      getBuildingtree(id);
    }
    if (selectedIndex == 4) {
      getFloorUsersDetails(id);
      getfloorTasks(id);
      getAttendanceHistoryFloor(id);
      getAllLeavesFloor(id);
      getFloortree(id);
    }
    if (selectedIndex == 5) {
      getSectionUsersDetails(id);
      getSectionTasks(id);
      getAttendanceHistorySection(id);
      getAllLeavesSection(id);
      getSectiontree(id);
    }
    if (selectedIndex == 6) {
      getPointUsersDetails(id);
      getPointTasks(id);
      getAttendanceHistoryPoint(id);
      getAllLeavesPoint(id);
    }
  }

// // Get counts for all levels below the current work location
//   List<Map<String, String>> getCounts(dynamic treeModel, int selectedIndex) {
//     if (treeModel == null) return [];

//     switch (selectedIndex) {
//       case 0: // Area
//         return getAreaCounts(treeModel as AreaTreeModel);
//       case 1: // City
//         return getCityCounts(treeModel as CityTreeModel);
//       case 2: // Organization
//         return getOrganizationCounts(treeModel as OrganizationTreeModel);
//       case 3: // Building
//         return getBuildingCounts(treeModel as BuildingTreeModel);
//       case 4: // Floor
//         return getFloorCounts(treeModel as FloorTreeModel);
//       case 5: // Section
//         return getSectionCounts(treeModel as SectionTreeModel);
//       default:
//         return [];
//     }
//   }

//   List<Map<String, String>> getAreaCounts(AreaTreeModel model) {
//     List<Map<String, String>> counts = [];
//     if (model.data == null) return counts;

//     final cities = model.data!.cities ?? [];
//     final organizations = cities.expand((c) => c.organizations ?? []).toList();
//     final buildings = organizations.expand((o) => o.buildings ?? []).toList();
//     final floors = buildings.expand((b) => b.floors ?? []).toList();
//     final sections = floors.expand((f) => f.sections ?? []).toList();
//     final points = sections.expand((s) => s.points ?? []).toList();

//     if (cities.isNotEmpty)
//       counts.add({"count": "${cities.length}", "title": "City"});
//     if (organizations.isNotEmpty)
//       counts.add({"count": "${organizations.length}", "title": "Organization"});
//     if (buildings.isNotEmpty)
//       counts.add({"count": "${buildings.length}", "title": "Building"});
//     if (floors.isNotEmpty)
//       counts.add({"count": "${floors.length}", "title": "Floor"});
//     if (sections.isNotEmpty)
//       counts.add({"count": "${sections.length}", "title": "Section"});
//     if (points.isNotEmpty)
//       counts.add({"count": "${points.length}", "title": "Point"});

//     return counts;
//   }

//   List<Map<String, String>> getCityCounts(CityTreeModel model) {
//     List<Map<String, String>> counts = [];
//     if (model.data == null) return counts;

//     final organizations = model.data!.organizations ?? [];
//     final buildings = organizations.expand((o) => o.buildings ?? []).toList();
//     final floors = buildings.expand((b) => b.floors ?? []).toList();
//     final sections = floors.expand((f) => f.sections ?? []).toList();
//     final points = sections.expand((s) => s.points ?? []).toList();

//     if (organizations.isNotEmpty)
//       counts.add({"count": "${organizations.length}", "title": "Organization"});
//     if (buildings.isNotEmpty)
//       counts.add({"count": "${buildings.length}", "title": "Building"});
//     if (floors.isNotEmpty)
//       counts.add({"count": "${floors.length}", "title": "Floor"});
//     if (sections.isNotEmpty)
//       counts.add({"count": "${sections.length}", "title": "Section"});
//     if (points.isNotEmpty)
//       counts.add({"count": "${points.length}", "title": "Point"});

//     return counts;
//   }

//   List<Map<String, String>> getOrganizationCounts(
//       OrganizationTreeModel model) {
//     List<Map<String, String>> counts = [];
//     if (model.data == null) return counts;

//     final buildings = model.data!.buildings ?? [];
//     final floors = buildings.expand((b) => b.floors ?? []).toList();
//     final sections = floors.expand((f) => f.sections ?? []).toList();
//     final points = sections.expand((s) => s.points ?? []).toList();

//     if (buildings.isNotEmpty)
//       counts.add({"count": "${buildings.length}", "title": "Building"});
//     if (floors.isNotEmpty)
//       counts.add({"count": "${floors.length}", "title": "Floor"});
//     if (sections.isNotEmpty)
//       counts.add({"count": "${sections.length}", "title": "Section"});
//     if (points.isNotEmpty)
//       counts.add({"count": "${points.length}", "title": "Point"});

//     return counts;
//   }

//   List<Map<String, String>> getBuildingCounts(BuildingTreeModel model) {
//     List<Map<String, String>> counts = [];
//     if (model.data == null) return counts;

//     final floors = model.data!.floors ?? [];
//     final sections = floors.expand((f) => f.sections ?? []).toList();
//     final points = sections.expand((s) => s.points ?? []).toList();

//     if (floors.isNotEmpty)
//       counts.add({"count": "${floors.length}", "title": "Floor"});
//     if (sections.isNotEmpty)
//       counts.add({"count": "${sections.length}", "title": "Section"});
//     if (points.isNotEmpty)
//       counts.add({"count": "${points.length}", "title": "Point"});

//     return counts;
//   }

//   List<Map<String, String>> getFloorCounts(FloorTreeModel model) {
//     List<Map<String, String>> counts = [];
//     if (model.data == null) return counts;

//     final sections = model.data!.sections ?? [];
//     final points = sections.expand((s) => s.points ?? []).toList();

//     if (sections.isNotEmpty)
//       counts.add({"count": "${sections.length}", "title": "Section"});
//     if (points.isNotEmpty)
//       counts.add({"count": "${points.length}", "title": "Point"});

//     return counts;
//   }

//   List<Map<String, String>> getSectionCounts(SectionTreeModel model) {
//     List<Map<String, String>> counts = [];
//     if (model.data == null) return counts;

//     final points = model.data!.points ?? [];
//     if (points.isNotEmpty)
//       counts.add({"count": "${points.length}", "title": "Point"});

//     return counts;
//   }

//   // Get filtered list for the selected tree level
//   List<dynamic> getFilteredList(
//       dynamic treeModel, int selectedIndex, int treeLevel) {
//     if (treeModel == null) return [];

//     switch (selectedIndex) {
//       case 0: // Area
//         return getAreaFilteredList(treeModel as AreaTreeModel, treeLevel);
//       case 1: // City
//         return getCityFilteredList(treeModel as CityTreeModel, treeLevel);
//       case 2: // Organization
//         return getOrganizationFilteredList(
//             treeModel as OrganizationTreeModel, treeLevel);
//       case 3: // Building
//         return getBuildingFilteredList(
//             treeModel as BuildingTreeModel, treeLevel);
//       case 4: // Floor
//         return getFloorFilteredList(treeModel as FloorTreeModel, treeLevel);
//       case 5: // Section
//         return getSectionFilteredList(
//             treeModel as SectionTreeModel, treeLevel);
//       default:
//         return [];
//     }
//   }

//   List<dynamic> getAreaFilteredList(AreaTreeModel model, int treeLevel) {
//     if (model.data == null) return [];

//     final cities = model.data!.cities ?? [];
//     final organizations = cities.expand((c) => c.organizations ?? []).toList();
//     final buildings = organizations.expand((o) => o.buildings ?? []).toList();
//     final floors = buildings.expand((b) => b.floors ?? []).toList();
//     final sections = floors.expand((f) => f.sections ?? []).toList();
//     final points = sections.expand((s) => s.points ?? []).toList();

//     switch (treeLevel) {
//       case 0:
//         return cities;
//       case 1:
//         return organizations;
//       case 2:
//         return buildings;
//       case 3:
//         return floors;
//       case 4:
//         return sections;
//       case 5:
//         return points;
//       default:
//         return [];
//     }
//   }

//   List<dynamic> getCityFilteredList(CityTreeModel model, int treeLevel) {
//     if (model.data == null) return [];

//     final organizations = model.data!.organizations ?? [];
//     final buildings = organizations.expand((o) => o.buildings ?? []).toList();
//     final floors = buildings.expand((b) => b.floors ?? []).toList();
//     final sections = floors.expand((f) => f.sections ?? []).toList();
//     final points = sections.expand((s) => s.points ?? []).toList();

//     switch (treeLevel) {
//       case 0:
//         return organizations;
//       case 1:
//         return buildings;
//       case 2:
//         return floors;
//       case 3:
//         return sections;
//       case 4:
//         return points;
//       default:
//         return [];
//     }
//   }

//   List<dynamic> getOrganizationFilteredList(
//       OrganizationTreeModel model, int treeLevel) {
//     if (model.data == null) return [];

//     final buildings = model.data!.buildings ?? [];
//     final floors = buildings.expand((b) => b.floors ?? []).toList();
//     final sections = floors.expand((f) => f.sections ?? []).toList();
//     final points = sections.expand((s) => s.points ?? []).toList();

//     switch (treeLevel) {
//       case 0:
//         return buildings;
//       case 1:
//         return floors;
//       case 2:
//         return sections;
//       case 3:
//         return points;
//       default:
//         return [];
//     }
//   }

//   List<dynamic> getBuildingFilteredList(
//       BuildingTreeModel model, int treeLevel) {
//     if (model.data == null) return [];

//     final floors = model.data!.floors ?? [];
//     final sections = floors.expand((f) => f.sections ?? []).toList();
//     final points = sections.expand((s) => s.points ?? []).toList();

//     switch (treeLevel) {
//       case 0:
//         return floors;
//       case 1:
//         return sections;
//       case 2:
//         return points;
//       default:
//         return [];
//     }
//   }

//   List<dynamic> getFloorFilteredList(FloorTreeModel model, int treeLevel) {
//     if (model.data == null) return [];

//     final sections = model.data!.sections ?? [];
//     final points = sections.expand((s) => s.points ?? []).toList();

//     switch (treeLevel) {
//       case 0:
//         return sections;
//       case 1:
//         return points;
//       default:
//         return [];
//     }
//   }

//   List<dynamic> getSectionFilteredList(SectionTreeModel model, int treeLevel) {
//     if (model.data == null) return [];

//     final points = model.data!.points ?? [];
//     return treeLevel == 0 ? points : [];
//   }

//   // bool descTextShowFlag = false;
//   // int selectedTreeIndex = 0;
//   //  if (widget.selectedIndex == 0) {
//   //     context.read<WorkLocationDetailsCubit>().getAreaUsersDetails(widget.id);
//   //     context.read<WorkLocationDetailsCubit>().getAreaTasks(widget.id);
//   //     context
//   //         .read<WorkLocationDetailsCubit>()
//   //         .getAttendanceHistoryArea(widget.id);
//   //     context.read<WorkLocationDetailsCubit>().getAllLeavesArea(widget.id);
//   //     context.read<WorkLocationDetailsCubit>().getAreatree(widget.id);
//   //   }
//   //   if (widget.selectedIndex == 1) {
//   //     context.read<WorkLocationDetailsCubit>().getCityUsersDetails(widget.id);
//   //     context.read<WorkLocationDetailsCubit>().getCityTasks(widget.id);
//   //     context
//   //         .read<WorkLocationDetailsCubit>()
//   //         .getAttendanceHistoryCity(widget.id);
//   //     context.read<WorkLocationDetailsCubit>().getAllLeavesCity(widget.id);
//   //     context.read<WorkLocationDetailsCubit>().getCitytree(widget.id);
//   //   }
//   //   if (widget.selectedIndex == 2) {
//   //     context
//   //         .read<WorkLocationDetailsCubit>()
//   //         .getOrganizationUsersDetails(widget.id);
//   //     context.read<WorkLocationDetailsCubit>().getorganizationTasks(widget.id);
//   //     context
//   //         .read<WorkLocationDetailsCubit>()
//   //         .getAttendanceHistoryOrganization(widget.id);
//   //     context
//   //         .read<WorkLocationDetailsCubit>()
//   //         .getAllLeavesOrganization(widget.id);
//   //     context.read<WorkLocationDetailsCubit>().getOrganizationtree(widget.id);
//   //   }
//   //   if (widget.selectedIndex == 3) {
//   //     context
//   //         .read<WorkLocationDetailsCubit>()
//   //         .getBuildingUsersDetails(widget.id);
//   //     context.read<WorkLocationDetailsCubit>().getbuildingTasks(widget.id);
//   //     context
//   //         .read<WorkLocationDetailsCubit>()
//   //         .getAttendanceHistoryBuilding(widget.id);
//   //     context.read<WorkLocationDetailsCubit>().getAllLeavesBuilding(widget.id);
//   //     context.read<WorkLocationDetailsCubit>().getBuildingtree(widget.id);
//   //   }
//   //   if (widget.selectedIndex == 4) {
//   //     context.read<WorkLocationDetailsCubit>().getFloorUsersDetails(widget.id);
//   //     context.read<WorkLocationDetailsCubit>().getfloorTasks(widget.id);
//   //     context
//   //         .read<WorkLocationDetailsCubit>()
//   //         .getAttendanceHistoryFloor(widget.id);
//   //     context.read<WorkLocationDetailsCubit>().getAllLeavesFloor(widget.id);
//   //     context.read<WorkLocationDetailsCubit>().getFloortree(widget.id);
//   //   }
//   //   if (widget.selectedIndex == 5) {
//   //     context
//   //         .read<WorkLocationDetailsCubit>()
//   //         .getSectionUsersDetails(widget.id);
//   //     context.read<WorkLocationDetailsCubit>().getSectionTasks(widget.id);
//   //     context
//   //         .read<WorkLocationDetailsCubit>()
//   //         .getAttendanceHistorySection(widget.id);
//   //     context.read<WorkLocationDetailsCubit>().getAllLeavesSection(widget.id);
//   //     context.read<WorkLocationDetailsCubit>().getSectiontree(widget.id);
//   //   }
//   //   if (widget.selectedIndex == 6) {
//   //     context.read<WorkLocationDetailsCubit>().getPointUsersDetails(widget.id);
//   //     context.read<WorkLocationDetailsCubit>().getPointTasks(widget.id);
//   //     context
//   //         .read<WorkLocationDetailsCubit>()
//   //         .getAttendanceHistoryPoint(widget.id);
//   //     context.read<WorkLocationDetailsCubit>().getAllLeavesPoint(widget.id);
//   //   }
}
