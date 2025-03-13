import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/points_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_cleaners_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_managers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_supervisors_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/logic/add_work_location_state.dart';

class AddWorkLocationCubit extends Cubit<AddWorkLocationState> {
  AddWorkLocationCubit() : super(AddWorkLocationInitialState());

  static AddWorkLocationCubit get(context) => BlocProvider.of(context);

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
  final allmanagersController = MultiSelectController<ManagersData>();
  final allSupervisorsController = MultiSelectController<SupervisorsData>();
  final allCleanersController = MultiSelectController<CleanersData>();
  final shiftController = MultiSelectController<ShiftDetails>();

  final formKey = GlobalKey<FormState>();
  final formAddKey = GlobalKey<FormState>();

  NationalityModel? nationalityModel;
  getNationality() {
    emit(GetNationalityLoadingState());
    DioHelper.getData(url: ApiConstants.countriesUrl).then((value) {
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
  getBuilding(int organizationId) {
    emit(GetBuildingLoadingState());
    DioHelper.getData(url: 'buildings/organization/$organizationId')
        .then((value) {
      buildingModel = BuildingModel.fromJson(value!.data);
      emit(GetBuildingSuccessState(buildingModel!));
    }).catchError((error) {
      emit(GetBuildingErrorState(error.toString()));
    });
  }

  FloorModel? floorModel;
  getFloor(int buildingId) {
    emit(GetFloorLoadingState());
    DioHelper.getData(url: 'floors/building/$buildingId').then((value) {
      floorModel = FloorModel.fromJson(value!.data);
      emit(GetFloorSuccessState(floorModel!));
    }).catchError((error) {
      emit(GetFloorErrorState(error.toString()));
    });
  }

  PointsModel? pointsModel;
  getPoints(int pointId) {
    emit(GetPointLoadingState());
    DioHelper.getData(url: 'points/floor/$pointId').then((value) {
      pointsModel = PointsModel.fromJson(value!.data);
      emit(GetPointSuccessState(pointsModel!));
    }).catchError((error) {
      emit(GetPointErrorState(error.toString()));
    });
  }

  AllManagersModel? allManagersModel;
  getManagers() {
    emit(AllManagersLoadingState());
    DioHelper.getData(url: 'users/role/2').then((value) {
      allManagersModel = AllManagersModel.fromJson(value!.data);
      emit(AllManagersSuccessState(allManagersModel!));
    }).catchError((error) {
      emit(AllManagersErrorState(error.toString()));
    });
  }

  AllSupervisorsModel? allSupervisorsModel;
  getSupervisors() {
    emit(AllSupervisorsLoadingState());
    DioHelper.getData(url: 'users/role/3').then((value) {
      allSupervisorsModel = AllSupervisorsModel.fromJson(value!.data);
      emit(AllSupervisorsSuccessState(allSupervisorsModel!));
    }).catchError((error) {
      emit(AllSupervisorsErrorState(error.toString()));
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

  AllCleanersModel? allCleanersModel;
  getCleaners() {
    emit(AllCleanersLoadingState());
    DioHelper.getData(url: 'users/role/4').then((value) {
      allCleanersModel = AllCleanersModel.fromJson(value!.data);
      emit(AllCleanersSuccessState(allCleanersModel!));
    }).catchError((error) {
      emit(AllCleanersErrorState(error.toString()));
    });
  }

  createArea(String countryName, List<int>? selectedManagersIds,
      List<int>? selectedSupervisorsIds, List<int>? selectedCleanersIds) {
    emit(CreateAreaLoadingState());
    DioHelper.postData(url: ApiConstants.createAreaUrl, data: {
      "name": addAreaController.text,
      "countryName": countryName,
      "managersIds": [
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
      "managersIds": [
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
      "managersIds": [
        ...?selectedManagersIds,
        ...?selectedSupervisorsIds,
        ...?selectedCleanersIds
      ],
      "shiftsIds": selectedShiftsIds
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
      "managersIds": [
        ...?selectedManagersIds,
        ...?selectedSupervisorsIds,
        ...?selectedCleanersIds
      ],
      "shiftsIds": selectedShiftsIds
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
      "managersIds": [
        ...?selectedManagersIds,
        ...?selectedSupervisorsIds,
        ...?selectedCleanersIds
      ],
      "shiftsIds": selectedShiftsIds
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

  createpoint(
      int floorId,
      List<int>? selectedManagersIds,
      List<int>? selectedSupervisorsIds,
      List<int>? selectedCleanersIds,
      List<int>? selectedShiftsIds) {
    emit(CreatePointLoadingState());
    DioHelper.postData(url: ApiConstants.createPointUrl, data: {
      "name": addPointController.text,
      "number": pointNumberController.text,
      "description": pointDiscriptionController.text,
      "floorId": floorId,
      "managersIds": [
        ...?selectedManagersIds,
        ...?selectedSupervisorsIds,
        ...?selectedCleanersIds
      ],
      "shiftsIds": selectedShiftsIds
    }).then((value) {
      final message = value?.data['message'] ?? "Created successfully";
      emit(CreatePointSuccessState(message));
      nationalityController.clear();
      areaController.clear();
      cityController.clear();
      organizationController.clear();
      buildingController.clear();
      floorController.clear();
      pointNumberController.clear();
      pointDiscriptionController.clear();
      addPointController.clear();
    }).catchError((error) {
      emit(CreatePointErrorState(error.toString()));
    });
  }
}
