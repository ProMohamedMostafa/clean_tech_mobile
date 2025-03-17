import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/profile/logic/profile_state.dart';
import 'package:smart_cleaning_application/features/screens/settings/data/model/profile_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/all_shifts_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_status_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_task_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_work_location_details.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/point_model.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController typeIdController = TextEditingController();
  TextEditingController createdByController = TextEditingController();
  TextEditingController assignToController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController providerController = TextEditingController();
  TextEditingController shiftController = TextEditingController();

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

  UserStatusModel? userStatusProfileModel;
  getUserProfileStatus() {
    emit(UserStatusLoadingState());
    DioHelper.getData(url: 'attendance/status').then((value) {
      userStatusProfileModel = UserStatusModel.fromJson(value!.data);
      emit(UserStatusSuccessState(userStatusProfileModel!));
    }).catchError((error) {
      emit(UserStatusErrorState(error.toString()));
    });
  }

  UserWorkLocationDetailsModel? userWorkLocationDetailsModel;
  getUserWorkLocationDetails(int? id) {
    emit(UserWorkLocationDetailsLoadingState());
    DioHelper.getData(url: 'users/level/$id').then((value) {
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
      'startDate': startTimeController.text,
      'endDate': endDateController.text,
      'startTime': startTimeController.text,
      'endTime': endTimeController.text,
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

  AllAreaModel? allAreaModel;
  getAllArea() {
    emit(GetAllAreaLoadingState());
    DioHelper.getData(url: ApiConstants.areaUrl).then((value) {
      allAreaModel = AllAreaModel.fromJson(value!.data);
      emit(GetAllAreaSuccessState(allAreaModel!));
    }).catchError((error) {
      emit(GetAllAreaErrorState(error.toString()));
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
      'role': roleController.text,
      'shift': shiftId,
      'startDate': startDateController.text,
      'endDate': endDateController.text,
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
      'history': true,
      'role': roleController.text,
      'startDate': startDateController.text,
      'endDate': endDateController.text,
      'type': typeIdController.text,
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

  AllShiftsModel? allShiftsModel;
  getAllShifts({
    int? areaId,
    int? cityId,
    int? organizationId,
    int? buildingId,
    int? floorId,
    int? pointId,
    int? providerId,
  }) {
    emit(ShiftAllLoadingState());
    DioHelper.getData(url: ApiConstants.allShiftsUrl, query: {
      'area': areaId,
      'city': cityId,
      'organization': organizationId,
      'building': buildingId,
      'floor': floorId,
      'point': pointId,
      'startDate': startDateController.text,
      'endDate': endDateController.text,
      'startTime': startTimeController.text,
      'endTime': endTimeController.text,
      // 'provider': providerId
    }).then((value) {
      allShiftsModel = AllShiftsModel.fromJson(value!.data);
      emit(ShiftAllSuccessState(allShiftsModel!));
    }).catchError((error) {
      emit(ShiftAllErrorState(error.toString()));
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


  AreaListModel? areaModel;
  getArea(String countryName) {
    emit(GetAreaLoadingState());
    DioHelper.getData(url: "areas/pagination", query: {'country': countryName})
        .then((value) {
      areaModel = AreaListModel.fromJson(value!.data);
      emit(GetAreaSuccessState(areaModel!));
    }).catchError((error) {
      emit(GetAreaErrorState(error.toString()));
    });
  }

  CityListModel? cityModel;
  getCity(int areaId) {
    emit(GetCityLoadingState());
    DioHelper.getData(url: "cities/pagination", query: {'area': areaId})
        .then((value) {
      cityModel = CityListModel.fromJson(value!.data);
      emit(GetCitySuccessState(cityModel!));
    }).catchError((error) {
      emit(GetCityErrorState(error.toString()));
    });
  }

  OrganizationListModel? organizationModel;
  getOrganization(int cityId) {
    emit(GetOrganizationLoadingState());
    DioHelper.getData(url: "organizations/pagination", query: {'city': cityId})
        .then((value) {
      organizationModel = OrganizationListModel.fromJson(value!.data);
      emit(GetOrganizationSuccessState(organizationModel!));
    }).catchError((error) {
      emit(GetOrganizationErrorState(error.toString()));
    });
  }

  BuildingListModel? buildingModel;
  getBuilding(int organizationId) {
    emit(GetBuildingLoadingState());
    DioHelper.getData(
        url: 'buildings/pagination',
        query: {'organization': organizationId}).then((value) {
      buildingModel = BuildingListModel.fromJson(value!.data);
      emit(GetBuildingSuccessState(buildingModel!));
    }).catchError((error) {
      emit(GetBuildingErrorState(error.toString()));
    });
  }

  FloorListModel? floorModel;
  getFloor(int buildingId) {
    emit(GetFloorLoadingState());
    DioHelper.getData(url: 'floors/pagination', query: {'building': buildingId})
        .then((value) {
      floorModel = FloorListModel.fromJson(value!.data);
      emit(GetFloorSuccessState(floorModel!));
    }).catchError((error) {
      emit(GetFloorErrorState(error.toString()));
    });
  }

  PointListModel? pointModel;
  getPoint(int sectionId) {
    emit(GetPointsLoadingState());
    DioHelper.getData(url: 'points/pagination', query: {'section': sectionId})
        .then((value) {
      pointModel = PointListModel.fromJson(value!.data);
      emit(GetPointsSuccessState(pointModel!));
    }).catchError((error) {
      emit(GetPointsErrorState(error.toString()));
    });
  }


  ProvidersModel? providersModel;
  getProviders() {
    emit(AllProvidersLoadingState());
    DioHelper.getData(url: ApiConstants.allProvidersUrl).then((value) {
      providersModel = ProvidersModel.fromJson(value!.data);
      emit(AllProvidersSuccessState(providersModel!));
    }).catchError((error) {
      emit(AllProvidersErrorState(error.toString()));
    });
  }

  UsersModel? usersModel;
  getAllUsersInUserManage(
      {int? areaId,
      int? cityId,
      int? organizationId,
      int? buildingId,
      int? floorId,
      int? pointId,
      int? providerId}) {
    emit(AllUsersLoadingState());
    DioHelper.getData(url: "users/pagination", query: {
      'country': countryController.text,
      'area': areaId,
      'city': cityId,
      'organization': organizationId,
      'building': buildingId,
      'floor': floorId,
      'point': pointId,
      'role': roleController.text,
      'provider': providerId,
    }).then((value) {
      usersModel = UsersModel.fromJson(value!.data);
      emit(AllUsersSuccessState(usersModel!));
    }).catchError((error) {
      emit(AllUsersErrorState(error.toString()));
    });
  }
}
