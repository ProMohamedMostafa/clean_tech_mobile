import 'package:bloc/bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/data/models/all_tasks_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/area_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/building_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/city_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/floor_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/organization_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/point_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/section_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/area_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_area_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/delete_section_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/section_tree_model.dart';

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

//******************************** */
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

//********************** */
  AllTasksModel? allareaTasksModel;
  getareaTasks(
    int? areaId,
  ) {
    emit(GetAllTasksLoadingState());
    DioHelper.getData(url: "tasks/pagination", query: {
      'area': areaId,
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
      'city': cityId,
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
      'organization': organizationId,
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
      'building': buildingId,
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
      'floor': floorId,
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
      'section': sectionId,
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
      'point': pointId,
    }).then((value) {
      allPointTasksModel = AllTasksModel.fromJson(value!.data);
      emit(GetAllTasksSuccessState(allPointTasksModel!));
    }).catchError((error) {
      emit(GetAllTasksErrorState(error.toString()));
    });
  }

//*********************** */

  AttendanceHistoryModel? attendanceHistoryAreaModel;
  getAttendanceHistoryArea(int id) {
    emit(AttendanceHistoryAreaLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'areaId': id,
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
      'cityId': id,
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
      'buildingId': id,
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
      'floorId': id,
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
      'pointId': id,
    }).then((value) {
      attendanceHistoryPointModel =
          AttendanceHistoryModel.fromJson(value!.data);
      emit(AttendanceHistoryPointSuccessState(attendanceHistoryPointModel!));
    }).catchError((error) {
      emit(AttendanceHistoryPointErrorState(error.toString()));
    });
  }

//*********************************** */

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

//**************************** */
  DeleteAreaModel? deleteAreaModel;
  deleteArea(int id) {
    emit(AreaDeleteLoadingState());
    DioHelper.postData(url: 'areas/delete/$id', data: {'id': id}).then((value) {
      deleteAreaModel = DeleteAreaModel.fromJson(value!.data);
      emit(AreaDeleteSuccessState(deleteAreaModel!));
    }).catchError((error) {
      emit(AreaDeleteErrorState(error.toString()));
    });
  }

  DeleteCityModel? deleteCityModel;
  deleteCity(int id) {
    emit(CityDeleteLoadingState());
    DioHelper.postData(url: 'cities/delete/$id', data: {'id': id})
        .then((value) {
      deleteCityModel = DeleteCityModel.fromJson(value!.data);
      emit(CityDeleteSuccessState(deleteCityModel!));
    }).catchError((error) {
      emit(CityDeleteErrorState(error.toString()));
    });
  }

  DeleteOrganizationModel? deleteOrganizationModel;
  deleteOrganization(int id) {
    emit(OrganizationDeleteLoadingState());
    DioHelper.postData(url: 'organizations/delete/$id', data: {'id': id})
        .then((value) {
      deleteOrganizationModel = DeleteOrganizationModel.fromJson(value!.data);
      emit(OrganizationDeleteSuccessState(deleteOrganizationModel!));
    }).catchError((error) {
      emit(OrganizationDeleteErrorState(error.toString()));
    });
  }

  DeleteBuildingModel? deleteBuildingModel;
  deleteBuilding(int id) {
    emit(BuildingDeleteLoadingState());
    DioHelper.postData(url: 'buildings/delete/$id', data: {'id': id})
        .then((value) {
      deleteBuildingModel = DeleteBuildingModel.fromJson(value!.data);
      emit(BuildingDeleteSuccessState(deleteBuildingModel!));
    }).catchError((error) {
      emit(BuildingDeleteErrorState(error.toString()));
    });
  }

  DeleteFloorModel? deleteFloorModel;
  deleteFloor(int id) {
    emit(FloorDeleteLoadingState());
    DioHelper.postData(url: 'floors/delete/$id', data: {'id': id})
        .then((value) {
      deleteFloorModel = DeleteFloorModel.fromJson(value!.data);
      emit(FloorDeleteSuccessState(deleteFloorModel!));
    }).catchError((error) {
      emit(FloorDeleteErrorState(error.toString()));
    });
  }

  DeleteSectionModel? deleteSectionModel;
  deleteSection(int id) {
    emit(SectionDeleteLoadingState());
    DioHelper.postData(url: 'sections/delete/$id', data: {'id': id})
        .then((value) {
      deleteSectionModel = DeleteSectionModel.fromJson(value!.data);

      emit(SectionDeleteSuccessState(deleteSectionModel!));
    }).catchError((error) {
      emit(SectionDeleteErrorState(error.toString()));
    });
  }

  DeletePointModel? deletePointModel;
  deletePoint(int id) {
    emit(PointDeleteLoadingState());
    DioHelper.postData(url: 'points/delete/$id', data: {'id': id})
        .then((value) {
      deletePointModel = DeletePointModel.fromJson(value!.data);
      emit(PointDeleteSuccessState(deletePointModel!));
    }).catchError((error) {
      emit(PointDeleteErrorState(error.toString()));
    });
  }
//****************************** */
}
