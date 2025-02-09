import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/delete_user_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/deleted_list_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_task_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_work_location_details.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_state.dart';

import '../../../integrations/data/models/building_model.dart';
import '../../../integrations/data/models/floor_model.dart';
import '../../../integrations/data/models/nationality_model.dart';
import '../../../integrations/data/models/points_model.dart';
import '../../../integrations/data/models/role_model.dart';
import '../../../integrations/data/models/users_model.dart';

class UserManagementCubit extends Cubit<UserManagementState> {
  UserManagementCubit() : super(UserManagementInitialState());

  static UserManagementCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
  getUserTaskDetails(int? id) {
    emit(UserTaskDetailsLoadingState());
    DioHelper.getData(url: 'tasks/pagination', query: {'assignTo': id})
        .then((value) {
      userTaskDetailsModel = UserTaskDetailsModel.fromJson(value!.data);
      emit(UserTaskDetailsSuccessState(userTaskDetailsModel!));
    }).catchError((error) {
      emit(UserTaskDetailsErrorState(error.toString()));
    });
  }

  UsersModel? usersModel;
  getAllUsersInUserManage({
    int? areaId,
    int? cityId,
    int? organizationId,
    int? buildingId,
    int? floorId,
    int? pointId,
  }) {
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
      'search': searchController.text
    }).then((value) {
      usersModel = UsersModel.fromJson(value!.data);
      emit(AllUsersSuccessState(usersModel!));
    }).catchError((error) {
      emit(AllUsersErrorState(error.toString()));
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

  DeletedListModel? deletedListModel;
  getAllDeletedUser() {
    emit(DeletedUsersLoadingState());
    DioHelper.getData(url: ApiConstants.deleteUserListUrl).then((value) {
      deletedListModel = DeletedListModel.fromJson(value!.data);
      emit(DeletedUsersSuccessState(deletedListModel!));
    }).catchError((error) {
      emit(DeletedUsersErrorState(error.toString()));
    });
  }

  restoreDeletedUser(int id) {
    emit(RestoreUsersLoadingState());
    DioHelper.postData(url: 'users/restore/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(RestoreUsersSuccessState(message));
    }).catchError((error) {
      emit(RestoreUsersErrorState(error.toString()));
    });
  }

  forcedDeletedUser(int id) {
    emit(ForceDeleteUsersLoadingState());
    DioHelper.deleteData(url: 'users/forcedelete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(ForceDeleteUsersSuccessState(message));
    }).catchError((error) {
      emit(ForceDeleteUsersErrorState(error.toString()));
    });
  }

  NationalityModel? nationalityModel;
  getNationality() {
    emit(GetNationalityLoadingState());
    DioHelper.getData(url: 'countries/used/user').then((value) {
      nationalityModel = NationalityModel.fromJson(value!.data);
      emit(GetNationalitySuccessState(nationalityModel!));
    }).catchError((error) {
      emit(GetNationalityErrorState(error.toString()));
    });
  }

  AreaModel? areaModel;
  getArea(String countryName) {
    emit(GetAreaLoadingState());
    DioHelper.getData(url: "areas/country/$countryName").then((value) {
      areaModel = AreaModel.fromJson(value!.data);
      emit(GetAreaSuccessState(areaModel!));
    }).catchError((error) {
      emit(GetAreaErrorState(error.toString()));
    });
  }

  CityModel? cityModel;
  getCity(int areaId) {
    emit(GetCityLoadingState());
    DioHelper.getData(url: "cities/area/$areaId").then((value) {
      cityModel = CityModel.fromJson(value!.data);
      emit(GetCitySuccessState(cityModel!));
    }).catchError((error) {
      emit(GetCityErrorState(error.toString()));
    });
  }

  OrganizationModel? organizationModel;
  getOrganization(int cityId) {
    emit(GetOrganizationLoadingState());
    DioHelper.getData(url: "organizations/city/$cityId").then((value) {
      organizationModel = OrganizationModel.fromJson(value!.data);
      emit(GetOrganizationSuccessState(organizationModel!));
    }).catchError((error) {
      emit(GetOrganizationErrorState(error.toString()));
    });
  }

  BuildingModel? buildingModel;
  getBuilding(int id) {
    emit(GetBuildingLoadingState());
    DioHelper.getData(url: 'buildings/organization/$id').then((value) {
      buildingModel = BuildingModel.fromJson(value!.data);
      emit(GetBuildingSuccessState(buildingModel!));
    }).catchError((error) {
      emit(GetBuildingErrorState(error.toString()));
    });
  }

  FloorModel? floorModel;
  getFloor(int id) {
    emit(GetFloorLoadingState());
    DioHelper.getData(url: 'floors/building/$id').then((value) {
      floorModel = FloorModel.fromJson(value!.data);
      emit(GetFloorSuccessState(floorModel!));
    }).catchError((error) {
      emit(GetFloorErrorState(error.toString()));
    });
  }

  PointsModel? pointsModel;
  getPoints(int id) {
    emit(GetPointsLoadingState());
    DioHelper.getData(url: 'points/floor/$id').then((value) {
      pointsModel = PointsModel.fromJson(value!.data);
      emit(GetPointsSuccessState(pointsModel!));
    }).catchError((error) {
      emit(GetPointsErrorState(error.toString()));
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

  AttendanceHistoryModel? attendanceHistoryModel;
  getAllHistory(int id) {
    emit(HistoryLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'search': searchController.text,
      'role': roleController.text,
      'userId': id,
      // 'status': statusIdController.text,
      // 'startDate': startDateController.text,
      // 'endDate': endDateController.text
    }).then((value) {
      attendanceHistoryModel = AttendanceHistoryModel.fromJson(value!.data);
      emit(HistorySuccessState(attendanceHistoryModel!));
    }).catchError((error) {
      emit(HistoryErrorState(error.toString()));
    });
  }

  AttendanceLeavesModel? attendanceLeavesModel;
  getAllLeaves(int id) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'search': searchController.text,
      'assignTo': id,
    }).then((value) {
      attendanceLeavesModel = AttendanceLeavesModel.fromJson(value!.data);
      emit(LeavesSuccessState(attendanceLeavesModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }
}
