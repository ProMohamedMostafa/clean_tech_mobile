import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_area_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/city_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/points_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/all_shifts_deleted_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/all_shifts_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/data/model/shift_level_details_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/logic/shift_state.dart';

class ShiftCubit extends Cubit<ShiftState> {
  ShiftCubit() : super(ShiftInitialState());

  static ShiftCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
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
  TextEditingController pointController = TextEditingController();
  TextEditingController pointIdController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ShiftDetailsModel? shiftDetailsModel;
  getShiftDetails(int? id) {
    emit(ShiftDetailsLoadingState());
    DioHelper.getData(url: 'shifts/$id').then((value) {
      shiftDetailsModel = ShiftDetailsModel.fromJson(value!.data);
      emit(ShiftDetailsSuccessState(shiftDetailsModel!));
    }).catchError((error) {
      emit(ShiftDetailsErrorState(error.toString()));
    });
  }

  ShiftLevelDetailsModel? shiftLevelDetailsModel;
  getShiftLevelDetails(int? id) {
    emit(ShiftLevelDetailsLoadingState());
    DioHelper.getData(url: 'level/$id').then((value) {
      shiftLevelDetailsModel = ShiftLevelDetailsModel.fromJson(value!.data);
      emit(ShiftLevelDetailsSuccessState(shiftLevelDetailsModel!));
    }).catchError((error) {
      emit(ShiftLevelDetailsErrorState(error.toString()));
    });
  }

  AllShiftsModel? allShiftsModel;
  getAllShifts({
    int? areaId,
    int? cityId,
    int? organizationId,
    int? buildingId,
    int? floorId,
    int? pointId,
  }) {
    emit(ShiftLoadingState());
    DioHelper.getData(url: ApiConstants.allShiftsUrl, query: {
      'search': searchController.text,
      'area': areaIdController.text,
      'city': cityIdController.text,
      'organization': organizationIdController.text,
      'building': buildingIdController.text,
      'floor': floorIdController.text,
      'point': pointIdController.text,
      'startDate': startDateController.text,
      'endDate': endDateController.text
    }).then((value) {
      allShiftsModel = AllShiftsModel.fromJson(value!.data);
      emit(ShiftSuccessState(allShiftsModel!));
    }).catchError((error) {
      emit(ShiftErrorState(error.toString()));
    });
  }

  shiftDelete(int id) {
    emit(ShiftDeleteLoadingState());
    DioHelper.postData(url: 'shifts/delete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(ShiftDeleteSuccessState(message!));
    }).catchError((error) {
      emit(ShiftDeleteErrorState(error.toString()));
    });
  }

  AllShiftsDeletedModel? allShiftsDeletedModel;
  getAllDeletedShifts() {
    emit(AllShiftDeleteLoadingState());
    DioHelper.getData(url: ApiConstants.allShiftsDeletedUrl).then((value) {
      allShiftsDeletedModel = AllShiftsDeletedModel.fromJson(value!.data);
      emit(AllShiftDeleteSuccessState(allShiftsDeletedModel!));
    }).catchError((error) {
      emit(AllShiftDeleteErrorState(error.toString()));
    });
  }

  restoreDeletedShift(int id) {
    emit(RestoreShiftLoadingState());
    DioHelper.postData(url: 'shifts/restore/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(RestoreShiftSuccessState(message));
    }).catchError((error) {
      emit(RestoreShiftErrorState(error.toString()));
    });
  }

  forcedDeletedShift(int id) {
    emit(ForceDeleteShiftLoadingState());
    DioHelper.deleteData(url: 'shifts/forcedelete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "deleted successfully";
      emit(ForceDeleteShiftSuccessState(message));
    }).catchError((error) {
      emit(ForceDeleteShiftErrorState(error.toString()));
    });
  }

  AllAreaModel? allAreaModel;
  getArea(String countryName) {
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
}
