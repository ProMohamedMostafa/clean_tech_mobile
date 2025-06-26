import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/area_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/section_list_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/sensor/sensor_managment/data/model/sensor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/data/models/area_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/data/models/building_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/data/models/city_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/data/models/floor_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/data/models/organization_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/data/models/point_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/data/models/section_users_shifts_details_model.dart';

part 'edit_work_location_state.dart';

class EditWorkLocationCubit extends Cubit<EditWorkLocationState> {
  EditWorkLocationCubit() : super(EditWorkLocationInitial());

  TextEditingController nationalityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController areaIdController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController cityIdController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController organizationIdController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController buildingIdController = TextEditingController();
  TextEditingController buildingNumberController = TextEditingController();
  TextEditingController buildingDescriptionController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController floorIdController = TextEditingController();
  TextEditingController floorNumberController = TextEditingController();
  TextEditingController floorDescriptionController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController sectionIdController = TextEditingController();
  TextEditingController sectionNumberController = TextEditingController();
  TextEditingController sectionDescriptionController = TextEditingController();
  TextEditingController sensorController = TextEditingController();
  TextEditingController sensorIdController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController pointNumberController = TextEditingController();
  TextEditingController pointDescriptionController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController unitIdController = TextEditingController();
  final allmanagersController = MultiSelectController<UserItem>();
  final allSupervisorsController = MultiSelectController<UserItem>();
  final allCleanersController = MultiSelectController<UserItem>();
  final shiftController = MultiSelectController<ShiftItem>();
  final formKey = GlobalKey<FormState>();

  List<int>? selectedManagersIds = [];
  List<int>? selectedSupervisorsIds = [];
  List<int>? selectedCleanersIds = [];
  List<int>? selectedShiftsIds = [];

  bool? isCountable;
  editArea(int? id) async {
    emit(EditWorkLocationLoadingState());
    try {
      final managersIds = selectedManagersIds!.isEmpty
          ? areaUsersDetailsModel?.data?.users
              ?.where((user) => user.role == 'Manager')
              .map((user) => user.id!)
              .toList()
          : selectedManagersIds;
      final supervisorsIds = selectedSupervisorsIds!.isEmpty
          ? areaUsersDetailsModel?.data?.users
              ?.where((user) => user.role == 'Supervisor')
              .map((user) => user.id!)
              .toList()
          : selectedSupervisorsIds;
      final cleanersIds = selectedCleanersIds!.isEmpty
          ? areaUsersDetailsModel?.data?.users
              ?.where((user) => user.role == 'Cleaner')
              .map((user) => user.id!)
              .toList()
          : selectedCleanersIds;
      final response =
          await DioHelper.putData(url: ApiConstants.areaEditUrl, data: {
        "id": id,
        "name": areaController.text.isEmpty
            ? areaUsersDetailsModel!.data!.name
            : areaController.text,
        "countryName": nationalityController.text.isEmpty
            ? areaUsersDetailsModel!.data!.countryName
            : nationalityController.text,
        "userIds": [...?managersIds, ...?supervisorsIds, ...?cleanersIds]
      });
      final message = response?.data['message'] ?? "Edit successfully";
      emit(EditWorkLocationSuccessState(message));
    } catch (error) {
      emit(EditWorkLocationErrorState(error.toString()));
    }
  }

  editCity(int? id) async {
    emit(EditWorkLocationLoadingState());
    try {
      final managersIds = selectedManagersIds!.isEmpty
          ? cityUsersDetailsModel?.data?.users
              ?.where((user) => user.role == 'Manager')
              .map((user) => user.id!)
              .toList()
          : selectedManagersIds;
      final supervisorsIds = selectedSupervisorsIds!.isEmpty
          ? cityUsersDetailsModel?.data?.users
              ?.where((user) => user.role == 'Supervisor')
              .map((user) => user.id!)
          : selectedSupervisorsIds;
      final cleanersIds = selectedCleanersIds!.isEmpty
          ? cityUsersDetailsModel?.data?.users
              ?.where((user) => user.role == 'Cleaner')
              .map((user) => user.id!)
              .toList()
          : selectedCleanersIds;
      final response =
          await DioHelper.putData(url: ApiConstants.cityEditUrl, data: {
        "id": id,
        "name": cityController.text.isEmpty
            ? cityUsersDetailsModel!.data!.name
            : cityController.text,
        "areaId": areaController.text.isEmpty
            ? cityUsersDetailsModel!.data!.areaId
            : areaIdController.text,
        "userIds": [...?managersIds, ...?supervisorsIds, ...?cleanersIds]
      });
      final message = response?.data['message'] ?? "Edit successfully";
      emit(EditWorkLocationSuccessState(message));
    } catch (error) {
      emit(EditWorkLocationErrorState(error.toString()));
    }
  }

  editOrganization(int? id) async {
    emit(EditWorkLocationLoadingState());
    try {
      final managersIds = selectedManagersIds!.isEmpty
          ? organizationUsersShiftsDetailsModel?.data?.users!
              .where((user) => user.role == 'Manager')
              .map((user) => user.id!)
              .toList()
          : selectedManagersIds;
      final supervisorsIds = selectedSupervisorsIds!.isEmpty
          ? organizationUsersShiftsDetailsModel?.data?.users!
              .where((user) => user.role == 'Supervisor')
              .map((user) => user.id!)
              .toList()
          : selectedSupervisorsIds;
      final cleanersIds = selectedCleanersIds!.isEmpty
          ? organizationUsersShiftsDetailsModel?.data?.users!
              .where((user) => user.role == 'Cleaner')
              .map((user) => user.id!)
              .toList()
          : selectedCleanersIds;
      final shiftsIds = selectedShiftsIds!.isEmpty
          ? organizationUsersShiftsDetailsModel?.data?.users!
              .where((user) => user.role == 'Cleaner')
              .map((user) => user.id!)
              .toList()
          : selectedShiftsIds;
      final response =
          await DioHelper.putData(url: ApiConstants.organizationEditUrl, data: {
        "id": id,
        "name": organizationController.text.isEmpty
            ? organizationUsersShiftsDetailsModel!.data!.name
            : organizationController.text,
        "cityId": cityController.text.isEmpty
            ? organizationUsersShiftsDetailsModel!.data!.cityId
            : cityIdController.text,
        "userIds": [...?managersIds, ...?supervisorsIds, ...?cleanersIds],
        "shiftIds": [...?shiftsIds],
      });
      final message = response?.data['message'] ?? "Edit successfully";
      emit(EditWorkLocationSuccessState(message));
    } catch (error) {
      emit(EditWorkLocationErrorState(error.toString()));
    }
  }

  editBuilding(int? id) async {
    emit(EditWorkLocationLoadingState());
    try {
      final managersIds = selectedManagersIds!.isEmpty
          ? buildingUsersShiftsDetailsModel?.data?.users!
              .where((user) => user.role == 'Manager')
              .map((user) => user.id!)
              .toList()
          : selectedManagersIds;
      final supervisorsIds = selectedSupervisorsIds!.isEmpty
          ? buildingUsersShiftsDetailsModel?.data?.users!
              .where((user) => user.role == 'Manager')
              .map((user) => user.id!)
              .toList()
          : selectedSupervisorsIds;
      final cleanersIds = selectedCleanersIds!.isEmpty
          ? buildingUsersShiftsDetailsModel?.data?.users!
              .where((user) => user.role == 'Manager')
              .map((user) => user.id!)
              .toList()
          : selectedCleanersIds;
      final shiftsIds = selectedShiftsIds!.isEmpty
          ? buildingUsersShiftsDetailsModel?.data?.users!
              .where((user) => user.role == 'Cleaner')
              .map((user) => user.id!)
              .toList()
          : selectedShiftsIds;
      final response =
          await DioHelper.putData(url: ApiConstants.buildingEditUrl, data: {
        "id": id,
        "name": buildingController.text.isEmpty
            ? buildingUsersShiftsDetailsModel!.data!.name
            : buildingController.text,
        "number": buildingNumberController.text.isEmpty
            ? buildingUsersShiftsDetailsModel!.data!.number
            : buildingNumberController.text,
        "description": buildingDescriptionController.text.isEmpty
            ? buildingUsersShiftsDetailsModel!.data!.description
            : buildingDescriptionController.text,
        "organizationId": organizationController.text.isEmpty
            ? buildingUsersShiftsDetailsModel!.data!.organizationId
            : organizationIdController.text,
        "userIds": [...?managersIds, ...?supervisorsIds, ...?cleanersIds],
        "shiftIds": [...?shiftsIds],
      });
      final message = response?.data['message'] ?? "Edit successfully";
      emit(EditWorkLocationSuccessState(message));
    } catch (error) {
      emit(EditWorkLocationErrorState(error.toString()));
    }
  }

  editFloor(int? id) async {
    emit(EditWorkLocationLoadingState());

    final managersIds = selectedManagersIds!.isEmpty
        ? floorUsersShiftsDetailsModel?.data?.users!
            .where((user) => user.role == 'Manager')
            .map((user) => user.id!)
            .toList()
        : selectedManagersIds;
    final supervisorsIds = selectedSupervisorsIds!.isEmpty
        ? floorUsersShiftsDetailsModel?.data?.users!
            .where((user) => user.role == 'Supervisor')
            .map((user) => user.id!)
            .toList()
        : selectedSupervisorsIds;
    final cleanersIds = selectedCleanersIds!.isEmpty
        ? floorUsersShiftsDetailsModel?.data?.users!
            .where((user) => user.role == 'Cleaner')
            .map((user) => user.id!)
            .toList()
        : selectedCleanersIds;
    final shiftsIds = selectedShiftsIds!.isEmpty
        ? floorUsersShiftsDetailsModel?.data?.users!
            .where((user) => user.role == 'Cleaner')
            .map((user) => user.id!)
            .toList()
        : selectedShiftsIds;
    try {
      final response =
          await DioHelper.putData(url: ApiConstants.floorEditUrl, data: {
        "id": id,
        "name": floorController.text.isEmpty
            ? floorUsersShiftsDetailsModel!.data!.name
            : floorController.text,
        "number": floorNumberController.text.isEmpty
            ? floorUsersShiftsDetailsModel!.data!.number
            : floorNumberController.text,
        "description": floorDescriptionController.text.isEmpty
            ? floorUsersShiftsDetailsModel!.data!.description
            : floorDescriptionController.text,
        "buildingId": buildingController.text.isEmpty
            ? floorUsersShiftsDetailsModel!.data!.buildingId
            : buildingIdController.text,
        "userIds": [...?managersIds, ...?supervisorsIds, ...?cleanersIds],
        "shiftIds": [...?shiftsIds],
      });
      final message = response?.data['message'] ?? "Edit successfully";
      emit(EditWorkLocationSuccessState(message));
    } catch (error) {
      emit(EditWorkLocationErrorState(error.toString()));
    }
  }

  editSection(int? id) async {
    emit(EditWorkLocationLoadingState());

    final managersIds = selectedManagersIds!.isEmpty
        ? sectionUsersShiftsDetailsModel?.data?.users!
            .where((user) => user.role == 'Manager')
            .map((user) => user.id!)
            .toList()
        : selectedManagersIds;
    final supervisorsIds = selectedSupervisorsIds!.isEmpty
        ? sectionUsersShiftsDetailsModel?.data?.users!
            .where((user) => user.role == 'Supervisor')
            .map((user) => user.id!)
            .toList()
        : selectedSupervisorsIds;
    final cleanersIds = selectedCleanersIds!.isEmpty
        ? sectionUsersShiftsDetailsModel?.data?.users!
            .where((user) => user.role == 'Cleaner')
            .map((user) => user.id!)
            .toList()
        : selectedCleanersIds;
    final shiftsIds = selectedShiftsIds!.isEmpty
        ? sectionUsersShiftsDetailsModel?.data?.users!
            .where((user) => user.role == 'Cleaner')
            .map((user) => user.id!)
            .toList()
        : selectedShiftsIds;
    try {
      final response =
          await DioHelper.putData(url: ApiConstants.sectionEditUrl, data: {
        "id": id,
        "name": sectionController.text.isEmpty
            ? sectionUsersShiftsDetailsModel!.data!.name
            : sectionController.text,
        "number": sectionNumberController.text.isEmpty
            ? sectionUsersShiftsDetailsModel!.data!.number
            : sectionNumberController.text,
        "description": sectionDescriptionController.text.isEmpty
            ? sectionUsersShiftsDetailsModel!.data!.description
            : sectionDescriptionController.text,
        "floorId": floorController.text.isEmpty
            ? sectionUsersShiftsDetailsModel!.data!.buildingId
            : floorIdController.text,
        "userIds": [...?managersIds, ...?supervisorsIds, ...?cleanersIds],
        "shiftIds": [...?shiftsIds]
      });
      final message = response?.data['message'] ?? "Edit successfully";
      emit(EditWorkLocationSuccessState(message));
    } catch (error) {
      emit(EditWorkLocationErrorState(error.toString()));
    }
  }

  editPoint(int? id) async {
    emit(EditWorkLocationLoadingState());
    try {
      final managersIds = selectedManagersIds!.isEmpty
          ? pointUsersDetailsModel?.data?.users!
              .where((user) => user.role == 'Manager')
              .map((user) => user.id!)
              .toList()
          : selectedManagersIds;

      final supervisorsIds = selectedSupervisorsIds!.isEmpty
          ? pointUsersDetailsModel?.data?.users!
              .where((user) => user.role == 'Supervisor')
              .map((user) => user.id!)
              .toList()
          : selectedSupervisorsIds;

      final cleanersIds = selectedCleanersIds!.isEmpty
          ? pointUsersDetailsModel?.data?.users!
              .where((user) => user.role == 'Cleaner')
              .map((user) => user.id!)
              .toList()
          : selectedCleanersIds;

      // Get current values from the model if not provided
      final currentPoint = pointUsersDetailsModel!.data!;
      final isCountableValue = isCountable ?? currentPoint.isCountable;

      // Handle capacity - use existing value if not changed and isCountable is true
      final capacityValue = isCountableValue!
          ? (capacityController.text.isNotEmpty
              ? double.tryParse(capacityController.text)
              : currentPoint.capacity)
          : null;

      // Handle unit - use existing value if not changed and isCountable is true
      final unitValue = isCountableValue
          ? (unitController.text.isNotEmpty
              ? int.tryParse(unitIdController.text)
              : currentPoint.unitId)
          : null;

      final response = await DioHelper.putData(
        url: ApiConstants.pointEditUrl,
        data: {
          "id": id,
          "name": pointController.text.isEmpty
              ? currentPoint.name
              : pointController.text,
          "number": pointNumberController.text.isEmpty
              ? currentPoint.number
              : pointNumberController.text,
          "description": pointDescriptionController.text.isEmpty
              ? currentPoint.description
              : pointDescriptionController.text,
          "isCountable": isCountableValue,
          "capacity": capacityValue,
          "unit": unitValue,
          "sectionId": sectionController.text.isEmpty
              ? currentPoint.sectionId
              : sectionIdController.text,
          "deviceId": sensorController.text.isEmpty
              ? currentPoint.deviceId
              : sensorIdController.text,
          "userIds": [...?managersIds, ...?supervisorsIds, ...?cleanersIds],
        },
      );

      final message = response?.data['message'] ?? "Edit successfully";
      emit(EditWorkLocationSuccessState(message));
    } catch (error) {
      emit(EditWorkLocationErrorState(error.toString()));
    }
  }

//*********************************************************************************************** */
  AreaUsersDetailsModel? areaUsersDetailsModel;
  getAreaManagersDetails(int areaId) {
    emit(AreaEmployeesDetailsLoadingState());
    DioHelper.getData(url: 'areas/with-user/$areaId').then((value) {
      areaUsersDetailsModel = AreaUsersDetailsModel.fromJson(value!.data);
      emit(AreaEmployeesDetailsSuccessState(areaUsersDetailsModel!));
    }).catchError((error) {
      emit(AreaEmployeesDetailsErrorState(error.toString()));
    });
  }

  CityUsersDetailsModel? cityUsersDetailsModel;
  getCityManagersDetails(int cityId) {
    emit(CityEmployeesDetailsLoadingState());
    DioHelper.getData(url: 'cities/with-user/$cityId').then((value) {
      cityUsersDetailsModel = CityUsersDetailsModel.fromJson(value!.data);
      emit(CityEmployeesDetailsSuccessState(cityUsersDetailsModel!));
    }).catchError((error) {
      emit(CityEmployeesDetailsErrorState(error.toString()));
    });
  }

  OrganizationUsersShiftsDetailsModel? organizationUsersShiftsDetailsModel;
  getOrganizationManagersDetails(int organizationId) {
    emit(OrganizationEmployeesDetailsLoadingState());
    DioHelper.getData(url: 'organizations/with-user-shift/$organizationId')
        .then((value) {
      organizationUsersShiftsDetailsModel =
          OrganizationUsersShiftsDetailsModel.fromJson(value!.data);
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
      emit(
          SectionEmployeesDetailsSuccessState(sectionUsersShiftsDetailsModel!));
    }).catchError((error) {
      emit(SectionEmployeesDetailsErrorState(error.toString()));
    });
  }

  PointUsersDetailsModel? pointUsersDetailsModel;
  getPointManagersDetails(int pointId) {
    emit(PointEmployeesDetailsLoadingState());
    DioHelper.getData(url: 'points/with-user/$pointId').then((value) {
      pointUsersDetailsModel = PointUsersDetailsModel.fromJson(value!.data);
      emit(PointEmployeesDetailsSuccessState(pointUsersDetailsModel!));
    }).catchError((error) {
      emit(PointEmployeesDetailsErrorState(error.toString()));
    });
  }

//****************************************************************************************** */
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

  void changeIsCountable(bool value) {
    isCountable = value;
    emit(IsCountableChanged());
  }
}
