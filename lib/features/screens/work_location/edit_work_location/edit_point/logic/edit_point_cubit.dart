import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/nationality_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_point/data/model/edit_point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_point/logic/edit_point_state.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/point_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/area_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';

class EditPointCubit extends Cubit<EditPointState> {
  EditPointCubit() : super(EditPointInitialState());

  static EditPointCubit get(context) => BlocProvider.of(context);
  TextEditingController nationalityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController floorIdController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController sectionIdController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController pointNumberController = TextEditingController();
  TextEditingController pointDescriptionController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  final allmanagersController = MultiSelectController<Users>();
  final allSupervisorsController = MultiSelectController<Users>();
  final allCleanersController = MultiSelectController<Users>();
  final formKey = GlobalKey<FormState>();

  PointEditModel? editPointModel;
  editPoint(
    int? id,
    List<int>? selectedManagersIds,
    List<int>? selectedSupervisorsIds,
    List<int>? selectedCleanersIds,
    double? capacity,
    int? unit,
  ) async {
    emit(EditPointLoadingState());
    try {
      final managersIds = selectedManagersIds?.isEmpty ?? true
          ? pointUsersDetailsModel?.data?.users!
              .where((user) => user.role == 'Manager')
              .map((user) => user.id!)
              .toList()
          : selectedManagersIds;
      final supervisorsIds = selectedSupervisorsIds?.isEmpty ?? true
          ? pointUsersDetailsModel?.data?.users!
              .where((user) => user.role == 'Supervisor')
              .map((user) => user.id!)
              .toList()
          : selectedSupervisorsIds;
      final cleanersIds = selectedCleanersIds?.isEmpty ?? true
          ? pointUsersDetailsModel?.data?.users!
              .where((user) => user.role == 'Cleaner')
              .map((user) => user.id!)
              .toList()
          : selectedCleanersIds;
      final response =
          await DioHelper.putData(url: ApiConstants.pointEditUrl, data: {
        "id": id,
        "name": pointController.text.isEmpty
            ? pointUsersDetailsModel!.data!.name
            : pointController.text,
        "number": pointNumberController.text.isEmpty
            ? pointUsersDetailsModel!.data!.number
            : pointNumberController.text,
        "description": pointDescriptionController.text.isEmpty
            ? pointUsersDetailsModel!.data!.description
            : pointDescriptionController.text,
        "isCountable": capacity ?? pointUsersDetailsModel!.data!.isCountable,
        "capacity": capacity ?? pointUsersDetailsModel!.data!.capacity,
        "unit": unit ?? pointUsersDetailsModel!.data!.unit,
        "sectionId": sectionController.text.isEmpty
            ? pointUsersDetailsModel!.data!.sectionId
            : sectionIdController.text,
        "userIds": [...?managersIds, ...?supervisorsIds, ...?cleanersIds],
      });
      editPointModel = PointEditModel.fromJson(response!.data);
      emit(EditPointSuccessState(editPointModel!));
    } catch (error) {
      emit(EditPointErrorState(error.toString()));
    }
  }

  PointUsersDetailsModel? pointUsersDetailsModel;
  getPointManagersDetails(int pointId) {
    emit(PointManagersDetailsLoadingState());
    DioHelper.getData(url: 'points/with-user/$pointId').then((value) {
      pointUsersDetailsModel = PointUsersDetailsModel.fromJson(value!.data);
      emit(PointManagersDetailsSuccessState(pointUsersDetailsModel!));
    }).catchError((error) {
      emit(PointManagersDetailsErrorState(error.toString()));
    });
  }

  NationalityModel? nationalityModel;
  getNationality() {
    emit(GetNationalityLoadingState());
    DioHelper.getData(
        url: ApiConstants.countriesUrl,
        query: {'userUsedOnly': false, 'areaUsedOnly': true}).then((value) {
      nationalityModel = NationalityModel.fromJson(value!.data);
      emit(GetNationalitySuccessState(nationalityModel!));
    }).catchError((error) {
      emit(GetNationalityErrorState(error.toString()));
    });
  }

  AreaListModel? areasModel;
  getAreas(String countryName) {
    emit(GetAreaLoadingState());
    DioHelper.getData(url: "areas/pagination", query: {'country': countryName})
        .then((value) {
      areasModel = AreaListModel.fromJson(value!.data);
      emit(GetAreaSuccessState(areasModel!));
    }).catchError((error) {
      emit(GetAreaErrorState(error.toString()));
    });
  }

  CityListModel? cityyModel;
  getCityy(int areaId) {
    emit(GetCityLoadingState());
    DioHelper.getData(url: "cities/pagination", query: {'area': areaId})
        .then((value) {
      cityyModel = CityListModel.fromJson(value!.data);
      emit(GetCitySuccessState(cityyModel!));
    }).catchError((error) {
      emit(GetCityErrorState(error.toString()));
    });
  }

  OrganizationListModel? organizationsModel;
  getOrganizations(int cityId) {
    emit(GetOrganizationLoadingState());
    DioHelper.getData(url: "organizations/pagination", query: {'city': cityId})
        .then((value) {
      organizationsModel = OrganizationListModel.fromJson(value!.data);
      emit(GetOrganizationSuccessState(organizationsModel!));
    }).catchError((error) {
      emit(GetOrganizationErrorState(error.toString()));
    });
  }

  BuildingListModel? buildingsModel;
  getBuildings(int organizationId) {
    emit(GetBuildingLoadingState());
    DioHelper.getData(
        url: 'buildings/pagination',
        query: {'organization': organizationId}).then((value) {
      buildingsModel = BuildingListModel.fromJson(value!.data);
      emit(GetBuildingSuccessState(buildingsModel!));
    }).catchError((error) {
      emit(GetBuildingErrorState(error.toString()));
    });
  }

  FloorListModel? floorsModel;
  getFloors(int buildingId) {
    emit(GetFloorLoadingState());
    DioHelper.getData(url: 'floors/pagination', query: {'building': buildingId})
        .then((value) {
      floorsModel = FloorListModel.fromJson(value!.data);
      emit(GetFloorSuccessState(floorsModel!));
    }).catchError((error) {
      emit(GetFloorErrorState(error.toString()));
    });
  }
}
