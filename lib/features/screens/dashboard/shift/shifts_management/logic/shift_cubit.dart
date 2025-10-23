import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/shifts_management/data/model/all_shifts_deleted_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/shifts_management/data/model/delete_shift_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/shifts_management/logic/shift_state.dart';

class ShiftCubit extends Cubit<ShiftState> {
  ShiftCubit() : super(ShiftInitialState());

  static ShiftCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  int selectedIndex = 0;
  int currentPage = 1;
  FilterDialogDataModel? filterModel;
  ShiftModel? allShiftsModel;
  getAllShifts({String? isActive}) {
    emit(AllShiftLoadingState());
    DioHelper.getData(url: ApiConstants.allShiftsUrl, query: {
      'PageNumber': currentPage,
      'PageSize': 15,
      'Search': searchController.text,
      'StartDate': filterModel?.startDate,
      'EndDate': filterModel?.endDate,
      'StartTime': filterModel?.startTime,
      'EndTime': filterModel?.endTime,
      'AreaId': filterModel?.areaId,
      'CityId': filterModel?.cityId,
      'OrganizationId': filterModel?.organizationId,
      'BuildingId': filterModel?.buildingId,
      'FloorId': filterModel?.floorId,
      'SectionId': filterModel?.sectionId,
      'IsActive': isActive ?? filterModel?.isActive,
    }).then((value) {
      final newShifts = ShiftModel.fromJson(value!.data);

      if (currentPage == 1 || allShiftsModel == null) {
        allShiftsModel = newShifts;
      } else {
        allShiftsModel?.data?.data?.addAll(newShifts.data?.data ?? []);
        allShiftsModel?.data?.currentPage = newShifts.data?.currentPage;
        allShiftsModel?.data?.totalPages = newShifts.data?.totalPages;
      }

      emit(AllShiftSuccessState(allShiftsModel!));
    }).catchError((error) {
      emit(AllShiftErrorState(error.toString()));
    });
  }

  void initialize({String? isActive}) {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getAllShifts(isActive: isActive);
        }
      });
    getAllShifts(isActive: isActive);
    if (role == "Admin") {
      getAllDeletedShifts();
    }
  }

  void changeTap(int index) {
    selectedIndex = index;

    if (index == 0) {
      if (allShiftsModel == null) {
        currentPage = 1;
        allShiftsModel = null;
        getAllShifts();
      } else {
        emit(AllShiftSuccessState(allShiftsModel!));
      }
    } else {
      if (allShiftsDeletedModel == null) {
        getAllDeletedShifts();
      } else {
        emit(AllShiftDeleteSuccessState(allShiftsDeletedModel!));
      }
    }
  }

  Future<void> refreshShifts() async {
    currentPage = 1;
    allShiftsModel = null;
    allShiftsDeletedModel = null;
    emit(AllShiftLoadingState());
    emit(AllShiftDeleteLoadingState());
    await getAllShifts();
    await getAllDeletedShifts();
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

  List<ShiftItem> deletedShifts = [];
  DeleteShiftModel? deleteShiftModel;
  shiftDelete(int id) {
    emit(ShiftDeleteLoadingState());
    DioHelper.postData(url: 'shifts/delete/$id').then((value) {
      deleteShiftModel = DeleteShiftModel.fromJson(value!.data);

      final deletedShift = allShiftsModel?.data?.data?.firstWhere(
        (shift) => shift.id == id,
      );

      if (deletedShift != null) {
        // Remove from main list
        allShiftsModel?.data?.data?.removeWhere((shift) => shift.id == id);

        // Add to deleted list
        deletedShifts.insert(0, deletedShift);

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

  restoreDeletedShift(int id) {
    emit(RestoreShiftLoadingState());
    DioHelper.postData(url: 'shifts/restore/$id').then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      final restoredData = allShiftsDeletedModel?.data?.firstWhere(
        (data) => data.id == id,
      );

      if (restoredData != null) {
        // Remove from deleted list
        allShiftsDeletedModel?.data?.removeWhere((data) => data.id == id);

        // Initialize users list if null
        allShiftsModel?.data?.data ??= [];

        // Convert to User object
        final restoredUser = ShiftItem.fromJson(restoredData.toJson());

        // Find the correct position to insert (sorted by ID)
        int insertIndex = allShiftsModel!.data!.data!
            .indexWhere((user) => user.id! > restoredUser.id!);

        // If not found, add to end
        if (insertIndex == -1) {
          insertIndex = allShiftsModel!.data!.data!.length;
        }

        // Insert at correct position
        allShiftsModel?.data?.data?.insert(insertIndex, restoredUser);

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
    DioHelper.deleteData(url: 'shifts/forcedelete/$id').then((value) {
      final message = value?.data['message'] ?? "deleted successfully";
      emit(ForceDeleteShiftSuccessState(message));
    }).catchError((error) {
      emit(ForceDeleteShiftErrorState(error.toString()));
    });
  }
}
