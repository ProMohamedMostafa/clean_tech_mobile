import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/assign/data/assign_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_user_model.dart';
import 'package:smart_cleaning_application/features/screens/assign/logic/assign_state.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';
import '../../integrations/data/models/building_model.dart';
import '../../integrations/data/models/city_model.dart';
import '../../integrations/data/models/floor_model.dart';
import '../../integrations/data/models/points_model.dart';

class AssignCubit extends Cubit<AssignStates> {
  AssignCubit() : super(AssignInitialState());

  static AssignCubit get(context) => BlocProvider.of(context);

  TextEditingController locationController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  final userController = MultiSelectController<DataRoleUser>();
  final shiftController = MultiSelectController<ShiftDetails>();
  final formKey = GlobalKey<FormState>();

  AssignModel? assignModel;
  assignArea(int? locationId, List<int>? selectedUsersIds) {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignAreaUrl, data: {
      "areaId": locationId,
      "managersIds": selectedUsersIds,
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
      "managersIds": selectedUsersIds,
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
      "managersIds": selectedUsersIds,
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
      "managersIds": selectedUsersIds,
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
      "managersIds": selectedUsersIds,
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
      "managersIds": selectedUsersIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignShift(List<int>? selectedShiftsIds, List<int>? selectedUsersIds) {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignShiftUrl, data: {
      "shiftsIds": selectedShiftsIds,
      "usersIds": selectedUsersIds,
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
      "organizationsIds": [locationId],
      "shiftsIds": selectedShiftsIds,
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
      "buildingsIds": [locationId],
      "shiftsIds": selectedShiftsIds,
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
      "floorsIds": [locationId],
      "shiftsIds": selectedShiftsIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
    });
  }

  assignPointShift(int? locationId, List<int>? selectedShiftsIds) {
    emit(AssignLoadingState());
    DioHelper.postData(url: ApiConstants.assignPointShiftUrl, data: {
      "pointsIds": [locationId],
      "shiftsIds": selectedShiftsIds,
    }).then((value) {
      assignModel = AssignModel.fromJson(value!.data);
      emit(AssignSuccessState(assignModel!));
    }).catchError((error) {
      emit(AssignErrorState(error.toString()));
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

  RoleUserModel? roleUserModel;
  getRoleUser(int id) {
    emit(RoleUserLoadingState());
    roleUserModel = null;
    DioHelper.getData(url: 'users/role/$id').then((value) {
      roleUserModel = RoleUserModel.fromJson(value!.data);
      emit(RoleUserSuccessState(roleUserModel!));
    }).catchError((error) {
      emit(RoleUserErrorState(error.toString()));
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
    emit(GetPointLoadingState());
    DioHelper.getData(url: 'points/floor/$id').then((value) {
      pointsModel = PointsModel.fromJson(value!.data);
      emit(GetPointSuccessState(pointsModel!));
    }).catchError((error) {
      emit(GetPointErrorState(error.toString()));
    });
  }

  OrganizationListModel? organizationListModel;
  getAllOrganization() {
    emit(OrganizationAllLoadingState());
    DioHelper.getData(url: ApiConstants.organizationUrl).then((value) {
      organizationListModel = OrganizationListModel.fromJson(value!.data);
      emit(OrganizationAllSuccessState(organizationListModel!));
    }).catchError((error) {
      emit(OrganizationAllErrorState(error.toString()));
    });
  }
}
