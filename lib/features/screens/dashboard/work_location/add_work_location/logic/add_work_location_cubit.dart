import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/nationality_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/sensor/sensor_managment/data/model/sensor_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/add_work_location/logic/add_work_location_state.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/point_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/section_list_model.dart';

class AddWorkLocationCubit extends Cubit<AddWorkLocationState> {
  AddWorkLocationCubit() : super(AddWorkLocationInitialState());

  static AddWorkLocationCubit get(context) => BlocProvider.of(context);

  TextEditingController nationalityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController areaIdController = TextEditingController();
  TextEditingController addAreaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController cityIdController = TextEditingController();
  TextEditingController addCityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController organizationIdController = TextEditingController();
  TextEditingController addOrganizationController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController buildingIdController = TextEditingController();
  TextEditingController addBuildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController floorIdController = TextEditingController();
  TextEditingController addFloorController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController sectionIdController = TextEditingController();
  TextEditingController addSectionController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController pointIdController = TextEditingController();
  TextEditingController addPointController = TextEditingController();
  TextEditingController buildingNumberController = TextEditingController();
  TextEditingController buildingDiscriptionController = TextEditingController();
  TextEditingController floorNumberController = TextEditingController();
  TextEditingController floorDiscriptionController = TextEditingController();
  TextEditingController sectionNumberController = TextEditingController();
  TextEditingController sectionDiscriptionController = TextEditingController();
  TextEditingController pointNumberController = TextEditingController();
  TextEditingController pointDiscriptionController = TextEditingController();
  TextEditingController sensorController = TextEditingController();
  TextEditingController sensorIdController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController capacityIdController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController unitIdController = TextEditingController();
  final allManagersController = MultiSelectController<UserItem>();
  final allSupervisorsController = MultiSelectController<UserItem>();
  final allCleanersController = MultiSelectController<UserItem>();
  final allShiftsController = MultiSelectController<ShiftItem>();
  final formKey = GlobalKey<FormState>();

  List<int> selectedManagersIds = [];
  List<int> selectedSupervisorsIds = [];
  List<int> selectedCleanersIds = [];
  List<int> selectedShiftsIds = [];
  bool? isCountable = true;

  NationalityListModel? nationalityListModel;
  List<NationalityDataModel> nationalityData = [
    NationalityDataModel(name: 'No nationalities')
  ];
  getNationality({bool? userUsedOnly, bool? areaUsedOnly}) {
    emit(GetNationalityLoadingState());
    DioHelper.getData(
            url: ApiConstants.countriesUrl,
            query: {'userUsedOnly': userUsedOnly, 'areaUsedOnly': areaUsedOnly})
        .then((value) {
      nationalityListModel = NationalityListModel.fromJson(value!.data);
      nationalityData = nationalityListModel?.data ??
          [NationalityDataModel(name: 'No nationalities')];
      emit(GetNationalitySuccessState(nationalityListModel!));
    }).catchError((error) {
      emit(GetNationalityErrorState(error.toString()));
    });
  }

  AreaListModel? areaListModel;
  List<AreaItem> areaItem = [AreaItem(name: 'No Areas')];
  getArea() {
    emit(GetAreaLoadingState());
    DioHelper.getData(
        url: "areas/pagination",
        query: {'Country': nationalityController.text}).then((value) {
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
      emit(GetCityLoadingState());
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

  ShiftModel? shiftModel;
  List<ShiftItem> shiftItem = [ShiftItem(name: 'No shifts')];
  getShifts() {
    emit(ShiftLoadingState());
    DioHelper.getData(url: 'shifts/pagination').then((value) {
      shiftModel = ShiftModel.fromJson(value!.data);
      shiftItem = shiftModel?.data?.data ?? [ShiftItem(name: 'No shifts')];
      emit(ShiftSuccessState(shiftModel!));
    }).catchError((error) {
      emit(ShiftErrorState(error.toString()));
    });
  }

  SensorModel? sensorModel;
  List<SensorItem> sensorItem = [SensorItem(name: 'No sensors')];
  getSensorsData() {
    emit(SensorLoading());
    DioHelper.getData(url: "devices", query: {'IsAsign': false}).then((value) {
      sensorModel = SensorModel.fromJson(value!.data);
      sensorItem = sensorModel?.data?.data ?? [SensorItem(name: 'No sensors')];
      emit(SensorSuccess(sensorModel!));
    }).catchError((error) {
      emit(SensorError(error.toString()));
    });
  }

  createArea() {
    emit(CreateAreaLoadingState());
    DioHelper.postData(url: ApiConstants.createAreaUrl, data: {
      "name": addAreaController.text,
      "countryName": nationalityController.text,
      "userIds": [
        ...selectedManagersIds,
        ...selectedSupervisorsIds,
        ...selectedCleanersIds
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

  createCity() {
    emit(CreateCityLoadingState());
    DioHelper.postData(url: ApiConstants.createCityUrl, data: {
      "name": addCityController.text,
      "areaId": areaIdController.text,
      "userIds": [
        ...selectedManagersIds,
        ...selectedSupervisorsIds,
        ...selectedCleanersIds
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

  createOrganization() {
    emit(CreateOrganizationLoadingState());
    DioHelper.postData(url: ApiConstants.createOrganizationUrl, data: {
      "name": addOrganizationController.text,
      "cityId": cityIdController.text,
      "userIds": [
        ...selectedManagersIds,
        ...selectedSupervisorsIds,
        ...selectedCleanersIds
      ],
      "shiftIds": [...selectedShiftsIds]
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

  createBuilding() {
    emit(CreateBuildingLoadingState());
    DioHelper.postData(url: ApiConstants.createBuildingUrl, data: {
      "name": addBuildingController.text,
      "number": buildingNumberController.text,
      "description": buildingDiscriptionController.text,
      "organizationId": organizationIdController.text,
      "userIds": [
        ...selectedManagersIds,
        ...selectedSupervisorsIds,
        ...selectedCleanersIds
      ],
      "shiftIds": [...selectedShiftsIds]
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

  createFloor() {
    emit(CreateFloorLoadingState());
    DioHelper.postData(url: ApiConstants.createFloorUrl, data: {
      "name": addFloorController.text,
      "number": floorNumberController.text,
      "description": floorDiscriptionController.text,
      "buildingId": buildingIdController.text,
      "userIds": [
        ...selectedManagersIds,
        ...selectedSupervisorsIds,
        ...selectedCleanersIds
      ],
      "shiftIds": [...selectedShiftsIds]
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

  createSection() {
    emit(CreateSectionLoadingState());
    DioHelper.postData(url: ApiConstants.createSectionUrl, data: {
      "name": addSectionController.text,
      "number": sectionNumberController.text,
      "description": sectionDiscriptionController.text,
      "floorId": floorIdController.text,
      "userIds": [
        ...selectedManagersIds,
        ...selectedSupervisorsIds,
        ...selectedCleanersIds
      ],
      "shiftIds": [...selectedShiftsIds]
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

  createPoint() {
    emit(CreatePointLoadingState());

    DioHelper.postData(url: ApiConstants.createPointUrl, data: {
      "name": addPointController.text,
      "number": pointNumberController.text,
      "description": pointDiscriptionController.text,
      "isCountable": isCountable,
      "capacity": double.tryParse(capacityIdController.text),
      "unit": int.tryParse(unitIdController.text),
      "sectionId": sectionIdController.text,
      "deviceId": int.tryParse(sensorIdController.text),
      "userIds": [
        ...selectedManagersIds,
        ...selectedSupervisorsIds,
        ...selectedCleanersIds
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

  void changeIsCountable(bool value) {
    isCountable = value;
    emit(IsCountableChanged()); 
  }
}
