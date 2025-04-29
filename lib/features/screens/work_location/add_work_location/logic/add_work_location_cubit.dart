import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/logic/add_work_location_state.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/point_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/section_list_model.dart';

class AddWorkLocationCubit extends Cubit<AddWorkLocationState> {
  AddWorkLocationCubit() : super(AddWorkLocationInitialState());

  static AddWorkLocationCubit get(context) => BlocProvider.of(context);

  TextEditingController capacityController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController addAreaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addCityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController addOrganizationController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController addBuildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController addFloorController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController addSectionController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController addPointController = TextEditingController();
  TextEditingController managerNameController = TextEditingController();
  TextEditingController buildingNumberController = TextEditingController();
  TextEditingController buildingDiscriptionController = TextEditingController();
  TextEditingController floorNumberController = TextEditingController();
  TextEditingController floorDiscriptionController = TextEditingController();
  TextEditingController sectionNumberController = TextEditingController();
  TextEditingController sectionDiscriptionController = TextEditingController();
  TextEditingController pointNumberController = TextEditingController();
  TextEditingController pointDiscriptionController = TextEditingController();
  final allmanagersController = MultiSelectController<UserItem>();
  final allSupervisorsController = MultiSelectController<UserItem>();
  final allCleanersController = MultiSelectController<UserItem>();
  final shiftController = MultiSelectController<ShiftItem>();

  final formKey = GlobalKey<FormState>();
  final formAddKey = GlobalKey<FormState>();

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

  NationalityListModel? nationalityModel;
  getNationality({bool? userUsedOnly, bool? areaUsedOnly}) {
    emit(GetNationalityLoadingState());
    DioHelper.getData(
            url: ApiConstants.countriesUrl,
            query: {'userUsedOnly': userUsedOnly, 'areaUsedOnly': areaUsedOnly})
        .then((value) {
      nationalityModel = NationalityListModel.fromJson(value!.data);
      emit(GetNationalitySuccessState(nationalityModel!));
    }).catchError((error) {
      emit(GetNationalityErrorState(error.toString()));
    });
  }

  AreaListModel? areaModel;
  getArea(String countryName) {
    emit(GetAreaLoadingState());
    DioHelper.getData(url: "areas/pagination", query: {'Country': countryName})
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
    DioHelper.getData(url: "cities/pagination", query: {'Area': areaId})
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
    DioHelper.getData(url: "organizations/pagination", query: {'City': cityId})
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
        query: {'OrganizationId': organizationId}).then((value) {
      buildingModel = BuildingListModel.fromJson(value!.data);
      emit(GetBuildingSuccessState(buildingModel!));
    }).catchError((error) {
      emit(GetBuildingErrorState(error.toString()));
    });
  }

  FloorListModel? floorModel;
  getFloor(int buildingId) {
    emit(GetFloorLoadingState());
    DioHelper.getData(
        url: 'floors/pagination',
        query: {'BuildingId': buildingId}).then((value) {
      floorModel = FloorListModel.fromJson(value!.data);
      emit(GetFloorSuccessState(floorModel!));
    }).catchError((error) {
      emit(GetFloorErrorState(error.toString()));
    });
  }

  SectionListModel? sectionModel;
  getSection(int floorId) {
    emit(GetSectionLoadingState());
    DioHelper.getData(url: 'sections/pagination', query: {'FloorId': floorId})
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
    DioHelper.getData(url: 'points/pagination', query: {'SectionId': sectionId})
        .then((value) {
      pointModel = PointListModel.fromJson(value!.data);
      emit(GetPointSuccessState(pointModel!));
    }).catchError((error) {
      emit(GetPointErrorState(error.toString()));
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

  createArea(String countryName, List<int>? selectedManagersIds,
      List<int>? selectedSupervisorsIds, List<int>? selectedCleanersIds) {
    emit(CreateAreaLoadingState());
    DioHelper.postData(url: ApiConstants.createAreaUrl, data: {
      "name": addAreaController.text,
      "countryName": countryName,
      "userIds": [
        ...?selectedManagersIds,
        ...?selectedSupervisorsIds,
        ...?selectedCleanersIds
      ]
    }).then((value) {
      final message = value?.data['message'] ?? "Created successfully";
      emit(CreateAreaSuccessState(message));
      nationalityController.clear();
      addAreaController.clear();
    }).catchError((error) {
      emit(CreateAreaErrorState(error.toString()));
    });
  }

  createCity(int areaId, List<int>? selectedManagersIds,
      List<int>? selectedSupervisorsIds, List<int>? selectedCleanersIds) {
    emit(CreateCityLoadingState());
    DioHelper.postData(url: ApiConstants.createCityUrl, data: {
      "name": addCityController.text,
      "areaId": areaId,
      "userIds": [
        ...?selectedManagersIds,
        ...?selectedSupervisorsIds,
        ...?selectedCleanersIds
      ]
    }).then((value) {
      final message = value?.data['message'] ?? "Created successfully";
      emit(CreateCitySuccessState(message));
      nationalityController.clear();
      addCityController.clear();
      areaController.clear();
    }).catchError((error) {
      emit(CreateCityErrorState(error.toString()));
    });
  }

  createOrganization(
      int cityId,
      List<int>? selectedManagersIds,
      List<int>? selectedSupervisorsIds,
      List<int>? selectedCleanersIds,
      List<int>? selectedShiftsIds) {
    emit(CreateOrganizationLoadingState());
    DioHelper.postData(url: ApiConstants.createOrganizationUrl, data: {
      "name": addOrganizationController.text,
      "cityId": cityId,
      "userIds": [
        ...?selectedManagersIds,
        ...?selectedSupervisorsIds,
        ...?selectedCleanersIds
      ],
      "shiftIds": selectedShiftsIds
    }).then((value) {
      final message = value?.data['message'] ?? "Created successfully";
      emit(CreateOrganizationSuccessState(message));
      nationalityController.clear();
      areaController.clear();
      cityController.clear();
      addOrganizationController.clear();
    }).catchError((error) {
      emit(CreateOrganizationErrorState(error.toString()));
    });
  }

  createBuilding(
      int organizationId,
      List<int>? selectedManagersIds,
      List<int>? selectedSupervisorsIds,
      List<int>? selectedCleanersIds,
      List<int>? selectedShiftsIds) {
    emit(CreateBuildingLoadingState());
    DioHelper.postData(url: ApiConstants.createBuildingUrl, data: {
      "name": addBuildingController.text,
      "number": buildingNumberController.text,
      "description": buildingDiscriptionController.text,
      "organizationId": organizationId,
      "userIds": [
        ...?selectedManagersIds,
        ...?selectedSupervisorsIds,
        ...?selectedCleanersIds
      ],
      "shiftIds": selectedShiftsIds
    }).then((value) {
      final message = value?.data['message'] ?? "Created successfully";
      emit(CreateBuildingSuccessState(message));
      nationalityController.clear();
      areaController.clear();
      cityController.clear();
      organizationController.clear();
      buildingNumberController.clear();
      buildingDiscriptionController.clear();
      addBuildingController.clear();
    }).catchError((error) {
      emit(CreateBuildingErrorState(error.toString()));
    });
  }

  createFloor(
      int buildingId,
      List<int>? selectedManagersIds,
      List<int>? selectedSupervisorsIds,
      List<int>? selectedCleanersIds,
      List<int>? selectedShiftsIds) {
    emit(CreateFloorLoadingState());
    DioHelper.postData(url: ApiConstants.createFloorUrl, data: {
      "name": addFloorController.text,
      "number": floorNumberController.text,
      "description": floorDiscriptionController.text,
      "buildingId": buildingId,
      "userIds": [
        ...?selectedManagersIds,
        ...?selectedSupervisorsIds,
        ...?selectedCleanersIds
      ],
      "shiftIds": selectedShiftsIds
    }).then((value) {
      final message = value?.data['message'] ?? "Created successfully";
      emit(CreateFloorSuccessState(message));
      nationalityController.clear();
      areaController.clear();
      cityController.clear();
      organizationController.clear();
      buildingController.clear();
      floorNumberController.clear();
      floorDiscriptionController.clear();
      addFloorController.clear();
    }).catchError((error) {
      emit(CreateFloorErrorState(error.toString()));
    });
  }

  createSection(
      int buildingId,
      List<int>? selectedManagersIds,
      List<int>? selectedSupervisorsIds,
      List<int>? selectedCleanersIds,
      List<int>? selectedShiftsIds) {
    emit(CreateSectionLoadingState());
    DioHelper.postData(url: ApiConstants.createSectionUrl, data: {
      "name": addSectionController.text,
      "number": sectionNumberController.text,
      "description": sectionDiscriptionController.text,
      "floorId": buildingId,
      "userIds": [
        ...?selectedManagersIds,
        ...?selectedSupervisorsIds,
        ...?selectedCleanersIds
      ],
      "shiftIds": selectedShiftsIds
    }).then((value) {
      final message = value?.data['message'] ?? "Created successfully";
      emit(CreateSectionSuccessState(message));
      nationalityController.clear();
      areaController.clear();
      cityController.clear();
      organizationController.clear();
      buildingController.clear();
      floorController.clear();
      sectionNumberController.clear();
      sectionDiscriptionController.clear();
      addSectionController.clear();
    }).catchError((error) {
      emit(CreateSectionErrorState(error.toString()));
    });
  }

  createPoint(
    int sectionId,
    List<int>? selectedManagersIds,
    List<int>? selectedSupervisorsIds,
    List<int>? selectedCleanersIds,
    bool? isCountable,
    double? capacity,
    int? unit,
  ) {
    emit(CreatePointLoadingState());
    DioHelper.postData(url: ApiConstants.createPointUrl, data: {
      "name": addPointController.text,
      "number": pointNumberController.text,
      "description": pointDiscriptionController.text,
      "isCountable": isCountable,
      "capacity": capacity,
      "unit": unit,
      "sectionId": sectionId,
      "userIds": [
        ...?selectedManagersIds,
        ...?selectedSupervisorsIds,
        ...?selectedCleanersIds
      ],
    }).then((value) {
      final message = value?.data['message'] ?? "Created successfully";
      emit(CreatePointSuccessState(message));
      nationalityController.clear();
      areaController.clear();
      cityController.clear();
      organizationController.clear();
      buildingController.clear();
      floorController.clear();
      sectionController.clear();
      pointNumberController.clear();
      pointDiscriptionController.clear();
      addPointController.clear();
    }).catchError((error) {
      emit(CreatePointErrorState(error.toString()));
    });
  }
}
