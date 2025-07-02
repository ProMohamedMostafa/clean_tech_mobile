import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/assign/data/assign_model.dart';
import 'package:smart_cleaning_application/features/screens/assign/logic/assign_state.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/all_shifts_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/point_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/section_list_model.dart';

class AssignCubit extends Cubit<AssignStates> {
  AssignCubit() : super(AssignInitialState());

  static AssignCubit get(context) => BlocProvider.of(context);

  TextEditingController areaController = TextEditingController();
  TextEditingController areaIdController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController cityIdController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController organizationIdController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController buildingIdController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController floorIdController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController sectionIdController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController pointIdController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController roleIdController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController levelController = TextEditingController();

  final usersController = MultiSelectController<UserItem>();
  final shiftsController = MultiSelectController<ShiftData>();
  final formKey = GlobalKey<FormState>();

  int selecteIndex = 0;
  int selecteSecendIndex = 0;
  int? selectedLocation;

  List<int> selectedUsersIds = [];
  List<int> selectedShiftsIds = [];

  AssignModel? assignModel;
  assignArea() {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignAreaUrl, data: {
      "areaId": areaIdController.text,
      "userIds": selectedUsersIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      clearAllControllers();

      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignCity() {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignCityUrl, data: {
      "cityId": cityIdController.text,
      "userIds": selectedUsersIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      clearAllControllers();

      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignOrganization() {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignOrganizationUrl, data: {
      "organizationId": organizationIdController.text,
      "userIds": selectedUsersIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      clearAllControllers();

      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignBuilding() {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignBuildingUrl, data: {
      "buildingId": buildingIdController.text,
      "userIds": selectedUsersIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      clearAllControllers();

      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignFloor() {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignFloorUrl, data: {
      "floorId": floorIdController.text,
      "userIds": selectedUsersIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      clearAllControllers();

      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignSection() {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignSectionUrl, data: {
      "sectionId": sectionIdController.text,
      "userIds": selectedUsersIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      clearAllControllers();

      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignPoint() {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignPointUrl, data: {
      "pointId": pointIdController.text,
      "userIds": selectedUsersIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      clearAllControllers();

      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignOrganizationShift() {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignOrganizationShiftUrl, data: {
      "organizationId": organizationIdController.text,
      "shiftIds": selectedShiftsIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      clearAllControllers();

      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignBuildingShift() {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignBuildingShiftUrl, data: {
      "buildingId": buildingIdController.text,
      "shiftIds": selectedShiftsIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      clearAllControllers();

      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignFloorShift() {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignFloorShiftUrl, data: {
      "floorId": floorIdController.text,
      "shiftIds": selectedShiftsIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      clearAllControllers();

      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignSectionShift() {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignSectionShiftUrl, data: {
      "sectionId": sectionIdController.text,
      "shiftIds": selectedShiftsIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      clearAllControllers();

      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignUserShift() {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignShiftUrl, data: {
      "userId": userIdController.text,
      "shiftIds": selectedShiftsIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      clearAllControllers();

      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  AreaListModel? areaListModel;
  List<AreaItem> areaItem = [AreaItem(name: 'No Areas')];
  getArea() {
    emit(GetAreaLoadingState());
    DioHelper.getData(url: "areas/pagination").then((value) {
      areaListModel = AreaListModel.fromJson(value!.data);
      areaItem = areaListModel?.data?.data ?? [AreaItem(name: 'No Areas')];
      emit(GetAreaSuccessState(areaListModel!));
    }).catchError((error) {
      emit(GetAreaErrorState(error.toString()));
    });
  }

  CityListModel? cityModel;
  List<CityItem> cityItem = [CityItem(name: 'No Cities')];
  getCity() {
    emit(GetCityLoadingState());
    DioHelper.getData(
        url: "cities/pagination",
        query: {'Area': areaIdController.text}).then((value) {
      cityModel = CityListModel.fromJson(value!.data);
      cityItem = cityModel?.data?.data ?? [CityItem(name: 'No Cities')];
      emit(GetCitySuccessState(cityModel!));
    }).catchError((error) {
      emit(GetCityErrorState(error.toString()));
    });
  }

  OrganizationListModel? organizationModel;
  List<OrganizationItem> organizationItem = [
    OrganizationItem(name: 'No organizations')
  ];
  getOrganization() {
    emit(GetOrganizationLoadingState());
    DioHelper.getData(
        url: "organizations/pagination",
        query: {'City': cityIdController.text}).then((value) {
      organizationModel = OrganizationListModel.fromJson(value!.data);
      organizationItem = organizationModel?.data?.data ??
          [OrganizationItem(name: 'No organizations')];
      emit(GetOrganizationSuccessState(organizationModel!));
    }).catchError((error) {
      emit(GetOrganizationErrorState(error.toString()));
    });
  }

  BuildingListModel? buildingModel;
  List<BuildingItem> buildingItem = [BuildingItem(name: 'No building')];
  getBuilding() {
    emit(GetBuildingLoadingState());
    DioHelper.getData(
        url: 'buildings/pagination',
        query: {'OrganizationId': organizationIdController.text}).then((value) {
      buildingModel = BuildingListModel.fromJson(value!.data);
      buildingItem =
          buildingModel?.data?.data ?? [BuildingItem(name: 'No building')];
      emit(GetBuildingSuccessState(buildingModel!));
    }).catchError((error) {
      emit(GetBuildingErrorState(error.toString()));
    });
  }

  FloorListModel? floorModel;
  List<FloorItem> floorItem = [FloorItem(name: 'No floors')];
  getFloor() {
    emit(GetFloorLoadingState());
    DioHelper.getData(
        url: 'floors/pagination',
        query: {'BuildingId': buildingIdController.text}).then((value) {
      floorModel = FloorListModel.fromJson(value!.data);
      floorItem = floorModel?.data?.data ?? [FloorItem(name: 'No floors')];
      emit(GetFloorSuccessState(floorModel!));
    }).catchError((error) {
      emit(GetFloorErrorState(error.toString()));
    });
  }

  SectionListModel? sectionModel;
  List<SectionItem> sectionItem = [SectionItem(name: 'No sections')];
  getSection() {
    emit(GetSectionLoadingState());
    DioHelper.getData(
        url: 'sections/pagination',
        query: {'FloorId': floorIdController.text}).then((value) {
      sectionModel = SectionListModel.fromJson(value!.data);
      sectionItem =
          sectionModel?.data?.data ?? [SectionItem(name: 'No sections')];
      emit(GetSectionSuccessState(sectionModel!));
    }).catchError((error) {
      emit(GetSectionErrorState(error.toString()));
    });
  }

  PointListModel? pointModel;
  List<PointItem> pointItem = [PointItem(name: 'No points')];
  getPoint() {
    emit(GetPointLoadingState());
    DioHelper.getData(
        url: 'points/pagination',
        query: {'SectionId': sectionIdController.text}).then((value) {
      pointModel = PointListModel.fromJson(value!.data);
      pointItem = pointModel?.data?.data ?? [PointItem(name: 'No points')];
      emit(GetPointSuccessState(pointModel!));
    }).catchError((error) {
      emit(GetPointErrorState(error.toString()));
    });
  }

  RoleModel? roleModel;
  List<RoleDataItem> roleDataItem = [RoleDataItem(name: 'No roles available')];
  getRole() {
    emit(RoleLoadingState());

    DioHelper.getData(url: ApiConstants.rolesUrl).then((value) {
      roleModel = RoleModel.fromJson(value!.data);
      roleDataItem =
          roleModel?.data ?? [RoleDataItem(name: 'No roles available')];
      emit(RoleSuccessState(roleModel!));
    }).catchError((error) {
      emit(RoleErrorState(error.toString()));
    });
  }

  AllShiftsModel? shiftsModel;
  List<ShiftData> shiftData = [ShiftData(name: 'No shifts available')];
  getShifts() {
    emit(ShiftLoadingState());
    DioHelper.getData(url: ApiConstants.allShiftsUrl).then((value) {
      shiftsModel = AllShiftsModel.fromJson(value!.data);
      shiftData =
          shiftsModel?.data?.shifts ?? [ShiftData(name: 'No shifts available')];
      emit(ShiftSuccessState(shiftsModel!));
    }).catchError((error) {
      emit(ShiftErrorState(error.toString()));
    });
  }

  UsersModel? usersModel;
  List<UserItem> userItem = [UserItem(userName: 'No users available')];
  getUsers({int? roleId}) {
    emit(AllUsersLoadingState());
    DioHelper.getData(url: "users/pagination", query: {'RoleId': roleId})
        .then((value) {
      usersModel = UsersModel.fromJson(value!.data);
      userItem =
          usersModel?.data?.users ?? [UserItem(userName: 'No users available')];
      emit(AllUsersSuccessState(usersModel!));
    }).catchError((error) {
      emit(AllUsersErrorState(error.toString()));
    });
  }

  getAllOrganization() {
    emit(AllOrganizationLoadingState());
    DioHelper.getData(url: ApiConstants.organizationUrl).then((value) {
      organizationModel = OrganizationListModel.fromJson(value!.data);
      organizationItem = organizationModel?.data?.data ??
          [OrganizationItem(name: 'No organizations')];
      emit(AllOrganizationSuccessState(organizationModel!));
    }).catchError((error) {
      emit(AllOrganizationErrorState(error.toString()));
    });
  }

  fetchAppropriateOrganizations() {
    if ((selecteIndex == 1 && selecteSecendIndex == 1) ||
        (selecteIndex == 2 && selecteSecendIndex == 1)) {
      getAllOrganization();
    } else if ((selecteIndex == 0 && selecteSecendIndex == 1) ||
        (selecteIndex == 2 && selecteSecendIndex == 0)) {
      getArea();
      getOrganization();
    }
  }

  void clearAllControllers() {
    // Clear all text controllers
    areaController.clear();
    cityController.clear();
    organizationController.clear();
    buildingController.clear();
    floorController.clear();
    sectionController.clear();
    pointController.clear();
    roleController.clear();
    userController.clear();
    levelController.clear();

    // Clear all ID controllers
    areaIdController.clear();
    cityIdController.clear();
    organizationIdController.clear();
    buildingIdController.clear();
    floorIdController.clear();
    sectionIdController.clear();
    pointIdController.clear();
    roleIdController.clear();
    userIdController.clear();

    // Clear multi-select controllers
    usersController.clearAll();
    shiftsController.clearAll();

    // Clear selected IDs
    selectedUsersIds.clear();
    selectedShiftsIds.clear();

    // Reset location selection
    selectedLocation = 0;
    selectedLevel = '';

    // Reset models to force fresh data fetch
    areaListModel = null;
    cityModel = null;
    organizationModel = null;
    buildingModel = null;
    floorModel = null;
    sectionModel = null;
    pointModel = null;
    usersModel = null;

    emit(AssignClearState());
  }

  List<String> get levelOrder {
    if ((selecteIndex == 1 && selecteSecendIndex == 1) ||
        (selecteIndex == 2 && selecteSecendIndex == 1)) {
      return [
        'Organization',
        'Building',
        'Floor',
        'Section',
      ];
    } else {
      return [
        'Area',
        'City',
        'Organization',
        'Building',
        'Floor',
        'Section',
        'Point',
      ];
    }
  }

  String selectedLevel = '';
  void setSelectedLevel(String level) {
    selectedLevel = level;
    selectedLocation = levelOrder.indexOf(level);
    emit(LevelChanged());
  }

  bool shouldShow(String level) {
    if (!levelOrder.contains(level)) return false;

    final selectedIndex = levelOrder.indexOf(selectedLevel);
    final levelIndex = levelOrder.indexOf(level);
    return selectedIndex >= levelIndex;
  }

  String getFirstLabel(int selecteIndex) {
    if (selecteIndex == 0) return 'Shift';
    if (selecteIndex == 1) return 'User';
    return 'User';
  }

  String getSecondLabel(int selecteIndex) {
    if (selecteIndex == 0 || selecteIndex == 1) return 'Location';
    return 'Shift';
  }
}
