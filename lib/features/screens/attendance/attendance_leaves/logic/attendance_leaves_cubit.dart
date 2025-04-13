import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/logic/attendance_leaves_state.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_edit/data/models/leaves_details_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/data/model/providers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/section_model.dart';

class AttendanceLeavesCubit extends Cubit<AttendanceLeavesState> {
  AttendanceLeavesCubit() : super(AttendanceLeavesInitialState());

  static AttendanceLeavesCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController typeIdController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController providerController = TextEditingController();
  ScrollController scrollController = ScrollController();
  int currentPage = 1;

  AttendanceLeavesModel? attendanceLeavesModel;
  getAllLeaves({
    int? areaId,
    int? cityId,
    int? organizationId,
    int? buildingId,
    int? floorId,
    int? sectionId,
    int? pointId,
    int? providerId,
    int? userId,
  }) {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'pageNumber': currentPage,
      'pageSize': 10,
      'Search': searchController.text,
      'History': false,
      'UserId': userId,
      'RoleId': roleController.text,
      'StartDate': startDateController.text,
      'EndDate': endDateController.text,
      'Type': typeIdController.text,
      'AreaId': areaId,
      'CityId': cityId,
      'OrganizationId': organizationId,
      'BuildingId': buildingId,
      'FloorId': floorId,
      'SectionId': sectionId,
      'PointId': pointId,
      'ProviderId': providerId
    }).then((value) {
       final newLeaves = AttendanceLeavesModel.fromJson(value!.data);

      if (attendanceLeavesModel == null) {
        attendanceLeavesModel = newLeaves;
      } else {
        attendanceLeavesModel?.data?.leaves?.addAll(newLeaves.data?.leaves ?? []);
        attendanceLeavesModel?.data?.currentPage = newLeaves.data?.currentPage;
        attendanceLeavesModel?.data?.totalPages = newLeaves.data?.totalPages;
      }
      emit(LeavesSuccessState(attendanceLeavesModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
  }
  void initialize() {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getAllLeaves();
        }
      });
  }
  UsersModel? usersModel;
  getAllUsers() {
    emit(AllUsersLoadingState());
    DioHelper.getData(url: "users/pagination").then((value) {
      usersModel = UsersModel.fromJson(value!.data);
      emit(AllUsersSuccessState(usersModel!));
    }).catchError((error) {
      emit(AllUsersErrorState(error.toString()));
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

  AllAreaModel? allAreaModel;
  getAllArea() {
    emit(GetAreaLoadingState());
    DioHelper.getData(url: ApiConstants.areaUrl).then((value) {
      allAreaModel = AllAreaModel.fromJson(value!.data);
      emit(GetAreaSuccessState(allAreaModel!));
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

  leavesDelete(int id) {
    emit(LeavesDeleteLoadingState());
    DioHelper.deleteData(url: 'leaves/delete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(LeavesDeleteSuccessState(message!));
    }).catchError((error) {
      emit(LeavesDeleteErrorState(error.toString()));
    });
  }

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
}
