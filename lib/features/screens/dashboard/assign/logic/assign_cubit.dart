import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/assign/data/assign_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/assign/data/user_shift_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/assign/logic/assign_state.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/role_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/point_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/section_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/data/models/area_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/data/models/building_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/data/models/city_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/data/models/floor_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/data/models/organization_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/data/models/point_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/data/models/section_users_shifts_details_model.dart';

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
  final allShiftsController = MultiSelectController<ShiftItem>();
  final allManagersController = MultiSelectController<UserItem>();
  final allSupervisorsController = MultiSelectController<UserItem>();
  final allCleanersController = MultiSelectController<UserItem>();

  int? selectedLocation;
  int index = 0;

  List<int> selectedManagersIds = [];
  List<int> selectedSupervisorsIds = [];
  List<int> selectedCleanersIds = [];
  List<int> selectedShiftsIds = [];

  AssignModel? assignModel;
  assignArea() {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignAreaUrl, data: {
      "areaId": areaIdController.text,
      "userIds": [
        ...selectedManagersIds,
        ...selectedSupervisorsIds,
        ...selectedCleanersIds
      ],
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
      "userIds": [
        ...selectedManagersIds,
        ...selectedSupervisorsIds,
        ...selectedCleanersIds
      ],
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
      "userIds": [
        ...selectedManagersIds,
        ...selectedSupervisorsIds,
        ...selectedCleanersIds
      ],
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
      "userIds": [
        ...selectedManagersIds,
        ...selectedSupervisorsIds,
        ...selectedCleanersIds
      ],
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
      "userIds": [
        ...selectedManagersIds,
        ...selectedSupervisorsIds,
        ...selectedCleanersIds
      ],
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
      "userIds": [
        ...selectedManagersIds,
        ...selectedSupervisorsIds,
        ...selectedCleanersIds
      ],
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
      "userIds": [
        ...selectedManagersIds,
        ...selectedSupervisorsIds,
        ...selectedCleanersIds
      ],
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

  ShiftModel? shiftModel;
  List<ShiftItem> shiftData = [ShiftItem(name: 'No shifts available')];
  getShifts() {
    emit(ShiftLoadingState());
    DioHelper.getData(url: ApiConstants.allShiftsUrl).then((value) {
      shiftModel = ShiftModel.fromJson(value!.data);
      shiftData =
          shiftModel?.data?.data ?? [ShiftItem(name: 'No shifts available')];
      emit(ShiftSuccessState(shiftModel!));
    }).catchError((error) {
      emit(ShiftErrorState(error.toString()));
    });
  }

  UserShiftModel? userShiftModel;
  void getUsers({int? roleId}) {
    emit(UserShiftLoadingState());
    DioHelper.getData(url: "user-with-shift/$roleId").then((value) {
      userShiftModel = UserShiftModel.fromJson(value!.data);

      emit(UserShiftSuccessState(userShiftModel!));
    }).catchError((error) {
      emit(UserShiftErrorState(error.toString()));
    });
  }

  UsersModel? usersModel;
  List<UserItem> userItem = [UserItem(userName: 'No users available')];
  getAllUsers() {
    emit(AllUsersLoadingState());
    DioHelper.getData(url: "users/pagination").then((value) {
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

  fetchAppropriateOrganizations(int index) {
    if (index == 0) {
      getShifts();
      getRole();
    } else if (index == 1) {
      getAllOrganization();
      getShifts();
    } else if (index == 2) {
      getArea();
      getAllUsers();
    }
  }

  List<String> get levelOrder {
    if (index == 1) {
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

  void initializeControllers(int selectedUserId) {
    if (userShiftModel != null && shiftModel != null) {
      final shifts = shiftModel!.data!.data!
          .map((shift) => DropdownItem(
                label: shift.name!,
                value: ShiftItem(
                  id: shift.id,
                  name: shift.name,
                  startDate: shift.startDate,
                  endDate: shift.endDate,
                  startTime: shift.startTime,
                  endTime: shift.endTime,
                ),
              ))
          .toList();

      allShiftsController.setItems(shifts);

      final selectedUser =
          userShiftModel!.data?.firstWhere((user) => user.id == selectedUserId);

      selectedShiftsIds = selectedUser?.shifts
              ?.where((shift) => shift.id != null)
              .map((shift) => shift.id!)
              .toList() ??
          [];

      allShiftsController
          .selectWhere((item) => selectedShiftsIds.contains(item.value.id));
    }
  }

  void initializeOrganizationControllers() {
    if (organizationUsersShiftsDetailsModel != null && shiftModel != null) {
      final shifts = shiftModel!.data!.data!
          .map((shift) => DropdownItem(
                label: shift.name ?? '',
                value: ShiftItem(
                  id: shift.id,
                  name: shift.name,
                  startDate: shift.startDate,
                  endDate: shift.endDate,
                  startTime: shift.startTime,
                  endTime: shift.endTime,
                ),
              ))
          .toList();

      allShiftsController.setItems(shifts);

      final assignedShifts = organizationUsersShiftsDetailsModel!.data?.shifts;

      selectedShiftsIds = assignedShifts
              ?.where((shift) => shift.id != null)
              .map((shift) => shift.id!)
              .toList() ??
          [];

      allShiftsController.selectWhere(
        (item) => selectedShiftsIds.contains(item.value.id),
      );
    }
  }

  void initializeBuildingControllers() {
    if (buildingUsersShiftsDetailsModel != null && shiftModel != null) {
      final shifts = shiftModel!.data!.data!
          .map((shift) => DropdownItem(
                label: shift.name ?? '',
                value: ShiftItem(
                  id: shift.id,
                  name: shift.name,
                  startDate: shift.startDate,
                  endDate: shift.endDate,
                  startTime: shift.startTime,
                  endTime: shift.endTime,
                ),
              ))
          .toList();

      allShiftsController.setItems(shifts);

      final assignedShifts = buildingUsersShiftsDetailsModel!.data?.shifts;

      selectedShiftsIds = assignedShifts
              ?.where((shift) => shift.id != null)
              .map((shift) => shift.id!)
              .toList() ??
          [];

      allShiftsController.selectWhere(
        (item) => selectedShiftsIds.contains(item.value.id),
      );
    }
  }

  void initializeFloorControllers() {
    if (floorUsersShiftsDetailsModel != null && shiftModel != null) {
      final shifts = shiftModel!.data!.data!
          .map((shift) => DropdownItem(
                label: shift.name ?? '',
                value: ShiftItem(
                  id: shift.id,
                  name: shift.name,
                  startDate: shift.startDate,
                  endDate: shift.endDate,
                  startTime: shift.startTime,
                  endTime: shift.endTime,
                ),
              ))
          .toList();

      allShiftsController.setItems(shifts);

      final assignedShifts = floorUsersShiftsDetailsModel!.data?.shifts;

      selectedShiftsIds = assignedShifts
              ?.where((shift) => shift.id != null)
              .map((shift) => shift.id!)
              .toList() ??
          [];

      allShiftsController.selectWhere(
        (item) => selectedShiftsIds.contains(item.value.id),
      );
    }
  }

  void initializeSectionControllers() {
    if (sectionUsersShiftsDetailsModel != null && shiftModel != null) {
      final shifts = shiftModel!.data!.data!
          .map((shift) => DropdownItem(
                label: shift.name ?? '',
                value: ShiftItem(
                  id: shift.id,
                  name: shift.name,
                  startDate: shift.startDate,
                  endDate: shift.endDate,
                  startTime: shift.startTime,
                  endTime: shift.endTime,
                ),
              ))
          .toList();

      allShiftsController.setItems(shifts);

      final assignedShifts = sectionUsersShiftsDetailsModel!.data?.shifts;

      selectedShiftsIds = assignedShifts
              ?.where((shift) => shift.id != null)
              .map((shift) => shift.id!)
              .toList() ??
          [];

      allShiftsController.selectWhere(
        (item) => selectedShiftsIds.contains(item.value.id),
      );
    }
  }

  AreaUsersDetailsModel? areaUsersDetailsModel;
  getAreaUsersDetails(int areaId) {
    emit(AreaUsersDetailsLoadingState());
    DioHelper.getData(url: 'areas/with-user/$areaId').then((value) {
      areaUsersDetailsModel = AreaUsersDetailsModel.fromJson(value!.data);
      initializeAreaControllers();
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
      initializeCityControllers();
      emit(CityUsersDetailsSuccessState(cityUsersDetailsModel!));
    }).catchError((error) {
      emit(CityUsersDetailsErrorState(error.toString()));
    });
  }

  OrganizationUsersShiftsDetailsModel? organizationUsersShiftsDetailsModel;
  getOrganizationManagersDetails(int organizationId) {
    emit(OrganizationEmployeesDetailsLoadingState());
    DioHelper.getData(url: 'organizations/with-user-shift/$organizationId')
        .then((value) {
      organizationUsersShiftsDetailsModel =
          OrganizationUsersShiftsDetailsModel.fromJson(value!.data);

      initializeOrganizationControllers();

      emit(OrganizationEmployeesDetailsSuccessState(
          organizationUsersShiftsDetailsModel!));
    }).catchError((error) {
      emit(OrganizationEmployeesDetailsErrorState(error.toString()));
    });
  }

  BuildingUsersShiftsDetailsModel? buildingUsersShiftsDetailsModel;
  getBuildingManagersDetails(int buildingId) {
    emit(BuildingEmployeesDetailsLoadingState());
    DioHelper.getData(url: 'buildings/with-user-shift/$buildingId')
        .then((value) {
      buildingUsersShiftsDetailsModel =
          BuildingUsersShiftsDetailsModel.fromJson(value!.data);

      initializeBuildingControllers();
      emit(BuildingEmployeesDetailsSuccessState(
          buildingUsersShiftsDetailsModel!));
    }).catchError((error) {
      emit(BuildingEmployeesDetailsErrorState(error.toString()));
    });
  }

  FloorUsersShiftsDetailsModel? floorUsersShiftsDetailsModel;
  getFloorManagersDetails(int floorId) {
    emit(FloorEmployeesDetailsLoadingState());
    DioHelper.getData(url: 'floors/with-user-shift/$floorId').then((value) {
      floorUsersShiftsDetailsModel =
          FloorUsersShiftsDetailsModel.fromJson(value!.data);
      initializeFloorControllers();
      emit(FloorEmployeesDetailsSuccessState(floorUsersShiftsDetailsModel!));
    }).catchError((error) {
      emit(FloorEmployeesDetailsErrorState(error.toString()));
    });
  }

  SectionUsersShiftsDetailsModel? sectionUsersShiftsDetailsModel;
  getSectionManagersDetails(int sectionId) {
    emit(SectionEmployeesDetailsLoadingState());
    DioHelper.getData(url: 'sections/with-user-shift/$sectionId').then((value) {
      sectionUsersShiftsDetailsModel =
          SectionUsersShiftsDetailsModel.fromJson(value!.data);

      initializeSectionControllers();
      emit(
          SectionEmployeesDetailsSuccessState(sectionUsersShiftsDetailsModel!));
    }).catchError((error) {
      emit(SectionEmployeesDetailsErrorState(error.toString()));
    });
  }

  PointUsersDetailsModel? pointUsersDetailsModel;
  getPointUsersDetails(int pointId) {
    emit(PointUsersDetailsLoadingState());
    DioHelper.getData(url: 'points/with-user/$pointId').then((value) {
      pointUsersDetailsModel = PointUsersDetailsModel.fromJson(value!.data);
      initializePointControllers();
      emit(PointUsersDetailsSuccessState(pointUsersDetailsModel!));
    }).catchError((error) {
      emit(PointUsersDetailsErrorState(error.toString()));
    });
  }

  void clearAllControllers() {
    areaController.clear();
    areaIdController.clear();
    cityController.clear();
    cityIdController.clear();
    organizationController.clear();
    organizationIdController.clear();
    buildingController.clear();
    buildingIdController.clear();
    floorController.clear();
    floorIdController.clear();
    sectionController.clear();
    sectionIdController.clear();
    pointController.clear();
    pointIdController.clear();
    roleController.clear();
    roleIdController.clear();
    userController.clear();
    userIdController.clear();

    [...selectedManagersIds, ...selectedSupervisorsIds, ...selectedCleanersIds]
        .clear();
    selectedShiftsIds.clear();

    allManagersController.clearAll();
    allSupervisorsController.clearAll();
    allCleanersController.clearAll();
    allShiftsController.clearAll();

    emit(ControllersClearedState());
  }

  void initializeAreaControllers() {
    if (areaUsersDetailsModel != null && usersModel != null) {
      // Initialize managers
      final managers = usersModel!.data!.users!
          .where((user) => user.role == 'Manager')
          .map((manager) => DropdownItem(
                label: manager.userName!,
                value: UserItem(id: manager.id, userName: manager.userName),
              ))
          .toList();

      allManagersController.setItems(managers);
      selectedManagersIds = areaUsersDetailsModel!.data!.users!
          .where((user) => user.role == 'Manager')
          .map((user) => user.id!)
          .toList();
      allManagersController
          .selectWhere((item) => selectedManagersIds.contains(item.value.id));

      // Initialize supervisors
      final supervisors = usersModel!.data!.users!
          .where((user) => user.role == 'Supervisor')
          .map((supervisor) => DropdownItem(
                label: supervisor.userName!,
                value:
                    UserItem(id: supervisor.id, userName: supervisor.userName),
              ))
          .toList();

      allSupervisorsController.setItems(supervisors);
      selectedSupervisorsIds = areaUsersDetailsModel!.data!.users!
          .where((user) => user.role == 'Supervisor')
          .map((user) => user.id!)
          .toList();
      allSupervisorsController.selectWhere(
          (item) => selectedSupervisorsIds.contains(item.value.id));

      // Initialize cleaners
      final cleaners = usersModel!.data!.users!
          .where((user) => user.role == 'Cleaner')
          .map((cleaner) => DropdownItem(
                label: cleaner.userName!,
                value: UserItem(id: cleaner.id, userName: cleaner.userName),
              ))
          .toList();

      allCleanersController.setItems(cleaners);
      selectedCleanersIds = areaUsersDetailsModel!.data!.users!
          .where((user) => user.role == 'Cleaner')
          .map((user) => user.id!)
          .toList();
      allCleanersController
          .selectWhere((item) => selectedCleanersIds.contains(item.value.id));
    }
  }

  void initializeCityControllers() {
    if (cityUsersDetailsModel != null && usersModel != null) {
      // Initialize managers
      final managers = usersModel!.data!.users!
          .where((user) => user.role == 'Manager')
          .map((manager) => DropdownItem(
                label: manager.userName!,
                value: UserItem(id: manager.id, userName: manager.userName),
              ))
          .toList();

      allManagersController.setItems(managers);
      selectedManagersIds = cityUsersDetailsModel!.data!.users!
          .where((user) => user.role == 'Manager')
          .map((user) => user.id!)
          .toList();
      allManagersController
          .selectWhere((item) => selectedManagersIds.contains(item.value.id));

      // Initialize supervisors
      final supervisors = usersModel!.data!.users!
          .where((user) => user.role == 'Supervisor')
          .map((supervisor) => DropdownItem(
                label: supervisor.userName!,
                value:
                    UserItem(id: supervisor.id, userName: supervisor.userName),
              ))
          .toList();

      allSupervisorsController.setItems(supervisors);
      selectedSupervisorsIds = cityUsersDetailsModel!.data!.users!
          .where((user) => user.role == 'Supervisor')
          .map((user) => user.id!)
          .toList();
      allSupervisorsController.selectWhere(
          (item) => selectedSupervisorsIds.contains(item.value.id));

      // Initialize cleaners
      final cleaners = usersModel!.data!.users!
          .where((user) => user.role == 'Cleaner')
          .map((cleaner) => DropdownItem(
                label: cleaner.userName!,
                value: UserItem(id: cleaner.id, userName: cleaner.userName),
              ))
          .toList();

      allCleanersController.setItems(cleaners);
      selectedCleanersIds = cityUsersDetailsModel!.data!.users!
          .where((user) => user.role == 'Cleaner')
          .map((user) => user.id!)
          .toList();
      allCleanersController
          .selectWhere((item) => selectedCleanersIds.contains(item.value.id));
    }
  }

 void initializePointControllers() {
    if (pointUsersDetailsModel != null && usersModel != null) {
      // Initialize managers
      final managers = usersModel!.data!.users!
          .where((user) => user.role == 'Manager')
          .map((manager) => DropdownItem(
                label: manager.userName!,
                value: UserItem(id: manager.id, userName: manager.userName),
              ))
          .toList();

      allManagersController.setItems(managers);
      selectedManagersIds = pointUsersDetailsModel!.data!.users!
          .where((user) => user.role == 'Manager')
          .map((user) => user.id!)
          .toList();
      allManagersController
          .selectWhere((item) => selectedManagersIds.contains(item.value.id));

      // Initialize supervisors
      final supervisors = usersModel!.data!.users!
          .where((user) => user.role == 'Supervisor')
          .map((supervisor) => DropdownItem(
                label: supervisor.userName!,
                value:
                    UserItem(id: supervisor.id, userName: supervisor.userName),
              ))
          .toList();

      allSupervisorsController.setItems(supervisors);
      selectedSupervisorsIds = pointUsersDetailsModel!.data!.users!
          .where((user) => user.role == 'Supervisor')
          .map((user) => user.id!)
          .toList();
      allSupervisorsController.selectWhere(
          (item) => selectedSupervisorsIds.contains(item.value.id));

      // Initialize cleaners
      final cleaners = usersModel!.data!.users!
          .where((user) => user.role == 'Cleaner')
          .map((cleaner) => DropdownItem(
                label: cleaner.userName!,
                value: UserItem(id: cleaner.id, userName: cleaner.userName),
              ))
          .toList();

      allCleanersController.setItems(cleaners);
      selectedCleanersIds = pointUsersDetailsModel!.data!.users!
          .where((user) => user.role == 'Cleaner')
          .map((user) => user.id!)
          .toList();
      allCleanersController
          .selectWhere((item) => selectedCleanersIds.contains(item.value.id));
    }
  }
}
