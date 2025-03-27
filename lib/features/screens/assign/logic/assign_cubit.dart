import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/assign/data/assign_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_area_model.dart';
import 'package:smart_cleaning_application/features/screens/assign/logic/assign_state.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_organization_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/all_shifts_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/section_model.dart';

class AssignCubit extends Cubit<AssignStates> {
  AssignCubit() : super(AssignInitialState());

  static AssignCubit get(context) => BlocProvider.of(context);

  TextEditingController locationController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController userController = TextEditingController();
  final usersController = MultiSelectController<User>();
  final shiftController = MultiSelectController<Shift>();
  final formKey = GlobalKey<FormState>();

  AssignModel? assignModel;
  assignArea(int? locationId, List<int>? selectedUsersIds) {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignAreaUrl, data: {
      "areaId": locationId,
      "userIds": selectedUsersIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignCity(int? locationId, List<int>? selectedUsersIds) {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignCityUrl, data: {
      "cityId": locationId,
      "userIds": selectedUsersIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignOrganization(int? locationId, List<int>? selectedUsersIds) {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignOrganizationUrl, data: {
      "organizationId": locationId,
      "userIds": selectedUsersIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignBuilding(int? locationId, List<int>? selectedUsersIds) {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignBuildingUrl, data: {
      "buildingId": locationId,
      "userIds": selectedUsersIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignFloor(int? locationId, List<int>? selectedUsersIds) {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignFloorUrl, data: {
      "floorId": locationId,
      "userIds": selectedUsersIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignSection(int? locationId, List<int>? selectedUsersIds) {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignSectionUrl, data: {
      "sectionId": locationId,
      "userIds": selectedUsersIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignPoint(int? locationId, List<int>? selectedUsersIds) {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignPointUrl, data: {
      "pointId": locationId,
      "userIds": selectedUsersIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignUserShift(List<int>? selectedShiftsIds, List<int>? selectedUsersIds ,{int? selectedUserId}) {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignShiftUrl, data: {
      "shiftIds": selectedShiftsIds,
      "userId": selectedUserId ?? selectedUsersIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignOrganizationShift(int? locationId, List<int>? selectedShiftsIds) {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignOrganizationShiftUrl, data: {
      "organizationId": [locationId],
      "shiftIds": selectedShiftsIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignBuildingShift(int? locationId, List<int>? selectedShiftsIds) {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignBuildingShiftUrl, data: {
      "buildingId": [locationId],
      "shiftIds": selectedShiftsIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignFloorShift(int? locationId, List<int>? selectedShiftsIds) {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignFloorShiftUrl, data: {
      "floorId": [locationId],
      "shiftIds": selectedShiftsIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignSectionShift(int? locationId, List<int>? selectedShiftsIds) {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignSectionShiftUrl, data: {
      "sectionId": [locationId],
      "shiftIds": selectedShiftsIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

 AllShiftsModel? allShiftsModel;
  getAllShifts({
    int? areaId,
    int? cityId,
    int? organizationId,
    int? buildingId,
    int? floorId,
    int? sectionId,
  }) {
    emit(ShiftLoadingState());
    DioHelper.getData(url: ApiConstants.allShiftsUrl,).then((value) {
      allShiftsModel = AllShiftsModel.fromJson(value!.data);
      emit(ShiftSuccessState(allShiftsModel!));
    }).catchError((error) {
      emit(ShiftErrorState(error.toString()));
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

  UsersModel? usersModel;
  getAllUsers(int id) {
    emit(AllUsersLoadingState());
    DioHelper.getData(url: "users/pagination", query: {'role': id})
        .then((value) {
      usersModel = UsersModel.fromJson(value!.data);
      emit(AllUsersSuccessState(usersModel!));
    }).catchError((error) {
      emit(AllUsersErrorState(error.toString()));
    });
  }

  AllAreaModel? allAreaModel;
  getArea() {
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

  AllOrganizationModel? allOrganizationModel;
  getAllOrganization() {
    emit(AllOrganizationLoadingState());
    DioHelper.getData(url: ApiConstants.organizationUrl).then((value) {
      allOrganizationModel = AllOrganizationModel.fromJson(value!.data);
      emit(AllOrganizationSuccessState(allOrganizationModel!));
    }).catchError((error) {
      emit(AllOrganizationErrorState(error.toString()));
    });
  }
}
