import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/all_area_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/data/models/shift_building_details.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/data/models/shift_floor_details.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/data/models/shift_organization_details.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/data/models/shift_section_details.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/all_shifts_deleted_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/all_shifts_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/delete_shift_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/shift_details_model.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/logic/shift_state.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/point_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/section_model.dart';

class ShiftCubit extends Cubit<ShiftState> {
  ShiftCubit() : super(ShiftInitialState());

  static ShiftCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController providerController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();

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

  ShiftOrganizationDetailsModel? shiftOrganizationDetailsModel;
  getShiftOrganizationDetails(int? id) {
    emit(ShiftOrganizationDetailsLoadingState());
    DioHelper.getData(url: 'shift/organization/$id').then((value) {
      shiftOrganizationDetailsModel =
          ShiftOrganizationDetailsModel.fromJson(value!.data);
      emit(
          ShiftOrganizationDetailsSuccessState(shiftOrganizationDetailsModel!));
    }).catchError((error) {
      emit(ShiftOrganizationDetailsErrorState(error.toString()));
    });
  }

  ShiftBuildingsDetailsModel? shiftBuildingsDetailsModel;
  getShiftBuildingDetails(int? id) {
    emit(ShiftBuildingDetailsLoadingState());
    DioHelper.getData(url: 'shift/building/$id').then((value) {
      shiftBuildingsDetailsModel =
          ShiftBuildingsDetailsModel.fromJson(value!.data);
      emit(ShiftBuildingDetailsSuccessState(shiftBuildingsDetailsModel!));
    }).catchError((error) {
      emit(ShiftBuildingDetailsErrorState(error.toString()));
    });
  }

  ShiftFloorDetailsModel? shiftFloorDetailsModel;
  getShiftFloorDetails(int? id) {
    emit(ShiftFloorDetailsLoadingState());
    DioHelper.getData(url: 'shift/floor/$id').then((value) {
      shiftFloorDetailsModel = ShiftFloorDetailsModel.fromJson(value!.data);
      emit(ShiftFloorDetailsSuccessState(shiftFloorDetailsModel!));
    }).catchError((error) {
      emit(ShiftFloorDetailsErrorState(error.toString()));
    });
  }

  ShiftSectionDetailsModel? shiftSectionDetailsModel;
  getShiftSectionDetails(int? id) {
    emit(ShiftSectionDetailsLoadingState());
    DioHelper.getData(url: 'shift/section/$id').then((value) {
      shiftSectionDetailsModel = ShiftSectionDetailsModel.fromJson(value!.data);
      emit(ShiftSectionDetailsSuccessState(shiftSectionDetailsModel!));
    }).catchError((error) {
      emit(ShiftSectionDetailsErrorState(error.toString()));
    });
  }

  int currentPage = 1;

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
    DioHelper.getData(url: ApiConstants.allShiftsUrl, query: {
      'pageNumber': currentPage,
      'pageSize': 10,
      'search': searchController.text,
      'area': areaId,
      'city': cityId,
      'organization': organizationId,
      'building': buildingId,
      'floor': floorId,
      'section': sectionId,
      'startDate': startDateController.text,
      'endDate': endDateController.text,
      'startTime': startTimeController.text,
      'endTime': endTimeController.text,
    }).then((value) {
      final newShifts = AllShiftsModel.fromJson(value!.data);

      if (allShiftsModel == null) {
        allShiftsModel = newShifts;
      } else {
        allShiftsModel?.data?.shifts?.addAll(newShifts.data?.shifts ?? []);
        allShiftsModel?.data?.currentPage = newShifts.data?.currentPage;
        allShiftsModel?.data?.totalPages = newShifts.data?.totalPages;
      }
      emit(ShiftSuccessState(allShiftsModel!));
    }).catchError((error) {
      emit(ShiftErrorState(error.toString()));
    });
  }

  void initialize() {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getAllShifts();
        }
      });
  }

  List<Shift> deletedShifts = [];
  DeleteShiftModel? deleteShiftModel;
  shiftDelete(int id) {
    emit(ShiftDeleteLoadingState());
    DioHelper.postData(url: 'shifts/delete/$id', data: {'id': id})
        .then((value) {
      deleteShiftModel = DeleteShiftModel.fromJson(value!.data);

      final deletedShift = allShiftsModel?.data?.shifts?.firstWhere(
        (shift) => shift.id == id,
      );

      if (deletedShift != null) {
        // Remove from main list
        allShiftsModel?.data?.shifts?.removeWhere((shift) => shift.id == id);

        // Add to deleted list
        deletedShifts.insert(0, deletedShift);

        //  Reload current page to refill to 10 users
        if (currentPage == 1) {
          allShiftsModel = null;
          getAllShifts();
        }
      }
      emit(ShiftDeleteSuccessState(deleteShiftModel!));
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
      // Find and process the restored user
      final restoredData = allShiftsDeletedModel?.data?.firstWhere(
        (data) => data.id == id,
      );

      if (restoredData != null) {
        // Remove from deleted list
        allShiftsDeletedModel?.data?.removeWhere((data) => data.id == id);

        // Initialize users list if null
        allShiftsModel?.data?.shifts ??= [];

        // Convert to User object
        final restoredUser = Shift.fromJson(restoredData.toJson());

        // Find the correct position to insert (sorted by ID)
        int insertIndex = allShiftsModel!.data!.shifts!
            .indexWhere((user) => user.id! > restoredUser.id!);

        // If not found, add to end
        if (insertIndex == -1)
          insertIndex = allShiftsModel!.data!.shifts!.length;

        // Insert at correct position
        allShiftsModel?.data?.shifts?.insert(insertIndex, restoredUser);

        // Update pagination metadata
        allShiftsModel?.data?.totalCount =
            (allShiftsModel?.data?.totalCount ?? 0) + 1;
        allShiftsModel?.data?.totalPages =
            ((allShiftsModel?.data?.totalCount ?? 0) /
                    (allShiftsModel?.data?.pageSize ?? 10))
                .ceil();
      }
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
}
