import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/delete_user_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/deleted_list_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_status_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_task_details_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/user_work_location_details.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_state.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/section_model.dart';

import '../../../integrations/data/models/nationality_model.dart';
import '../../../integrations/data/models/role_model.dart';
import '../../../integrations/data/models/users_model.dart';

class UserManagementCubit extends Cubit<UserManagementState> {
  UserManagementCubit() : super(UserManagementInitialState());

  static UserManagementCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  TextEditingController createdByController = TextEditingController();
  TextEditingController assignToController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController shiftController = TextEditingController();
  TextEditingController shiftIdController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController roleIdController = TextEditingController();
  TextEditingController providerController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController typeIdController = TextEditingController();

  ScrollController scrollController = ScrollController();

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

  int currentPage = 1;
  UsersModel? usersModel;

  getAllUsersInUserManage({
    int? areaId,
    int? cityId,
    int? organizationId,
    int? buildingId,
    int? floorId,
    int? sectionId,
    int? pointId,
    int? providerId,
  }) {
    emit(AllUsersLoadingState());

    DioHelper.getData(url: "users/pagination", query: {
      'pageNumber': currentPage,
      'pageSize': 10,
      'country': countryController.text,
      'area': areaId,
      'city': cityId,
      'organization': organizationId,
      'building': buildingId,
      'floor': floorId,
      'section': sectionId,
      'point': pointId,
      'role': roleIdController.text,
      'search': searchController.text,
      'provider': providerId,
    }).then((value) {
      final newUsers = UsersModel.fromJson(value!.data);

      if (usersModel == null) {
        usersModel = newUsers;
      } else {
        usersModel?.data?.users?.addAll(newUsers.data?.users ?? []);
        usersModel?.data?.currentPage = newUsers.data?.currentPage;
        usersModel?.data?.totalPages = newUsers.data?.totalPages;
      }

      emit(AllUsersSuccessState(usersModel!));
    }).catchError((error) {
      emit(AllUsersErrorState(error.toString()));
    });
  }

  void initialize() {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getAllUsersInUserManage();
        }
      });
  }

  DeleteUserModel? deleteUserModel;
  List<User> deletedUsers = [];

  userDelete(int id) {
    emit(UserDeleteLoadingState());

    DioHelper.postData(url: 'users/delete/$id', data: {'id': id}).then((value) {
      deleteUserModel = DeleteUserModel.fromJson(value!.data);

      final deletedUser = usersModel?.data?.users?.firstWhere(
        (user) => user.id == id,
      );

      if (deletedUser != null) {
        // Remove from main list
        usersModel?.data?.users?.removeWhere((user) => user.id == id);

        // Add to deleted list
        deletedUsers.insert(0, deletedUser);

        //  Reload current page to refill to 10 users
        if (currentPage == 1) {
          usersModel = null;
          getAllUsersInUserManage();
        }
      }

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
      final responseMessage = value?.data['message'] ?? "Restored successfully";

      // Find and process the restored user
      final restoredData = deletedListModel?.data?.firstWhere(
        (data) => data.id == id,
      );

      if (restoredData != null) {
        // Remove from deleted list
        deletedListModel?.data?.removeWhere((data) => data.id == id);

        // Initialize users list if null
        usersModel?.data?.users ??= [];

        // Convert to User object
        final restoredUser = User.fromJson(restoredData.toJson());

        // Find the correct position to insert (sorted by ID)
        int insertIndex = usersModel!.data!.users!
            .indexWhere((user) => user.id! > restoredUser.id!);

        // If not found, add to end
        if (insertIndex == -1) insertIndex = usersModel!.data!.users!.length;

        // Insert at correct position
        usersModel?.data?.users?.insert(insertIndex, restoredUser);

        // Update pagination metadata
        usersModel?.data?.totalCount = (usersModel?.data?.totalCount ?? 0) + 1;
        usersModel?.data?.totalPages = ((usersModel?.data?.totalCount ?? 0) /
                (usersModel?.data?.pageSize ?? 10))
            .ceil();
      }

      emit(RestoreUsersSuccessState(responseMessage));
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
    DioHelper.getData(
        url: ApiConstants.countriesUrl,
        query: {'userUsedOnly': true, 'areaUsedOnly': true}).then((value) {
      nationalityModel = NationalityModel.fromJson(value!.data);
      emit(GetNationalitySuccessState(nationalityModel!));
    }).catchError((error) {
      emit(GetNationalityErrorState(error.toString()));
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

  SectionListModel? sectionModel;
  getSection(int floorId) {
    emit(GetSectionLoadingState());
    DioHelper.getData(url: 'sections/pagination', query: {'floor': floorId})
        .then((value) {
      sectionModel = SectionListModel.fromJson(value!.data);
      emit(GetSectionSuccessState(sectionModel!));
    }).catchError((error) {
      emit(GetSectionErrorState(error.toString()));
    });
  }

  PointListModel? pointModel;
  getPoint(int sectionId) {
    emit(GetPointLoadingState());
    DioHelper.getData(url: 'points/pagination', query: {'section': sectionId})
        .then((value) {
      pointModel = PointListModel.fromJson(value!.data);
      emit(GetPointSuccessState(pointModel!));
    }).catchError((error) {
      emit(GetPointErrorState(error.toString()));
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
      'history': false,
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
}
