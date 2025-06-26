import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_management/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_management/logic/attendance_leaves_state.dart';

class AttendanceLeavesCubit extends Cubit<AttendanceLeavesState> {
  AttendanceLeavesCubit() : super(AttendanceLeavesInitialState());

  static AttendanceLeavesCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  int selectedIndex = 0;
  int currentPage = 1;
  FilterDialogDataModel? filterModel;
  AttendanceLeavesModel? allLeaves;
  AttendanceLeavesModel? pendingLeaves;
  AttendanceLeavesModel? rejectedLeaves;
  AttendanceLeavesModel? approvedLeaves;

  Future<void> getAllLeaves({int? status}) async {
    emit(LeavesLoadingState());

    try {
      final response =
          await DioHelper.getData(url: ApiConstants.leavesUrl, query: {
        'PageNumber': 1,
        'PageSize': 15,
        'Search': searchController.text,
        'History': (role == 'Cleaner') ? true : false,
        'UserId': filterModel?.userId,
        'RoleId': filterModel?.roleId,
        'StartDate': filterModel?.startDate,
        'EndDate': filterModel?.endDate,
        'Type': filterModel?.typeId,
        'Status': status,
        'AreaId': filterModel?.areaId,
        'CityId': filterModel?.cityId,
        'OrganizationId': filterModel?.organizationId,
        'BuildingId': filterModel?.buildingId,
        'FloorId': filterModel?.floorId,
        'SectionId': filterModel?.sectionId,
        'PointId': filterModel?.pointId,
        'ProviderId': filterModel?.providerId
      });

      final model = AttendanceLeavesModel.fromJson(response!.data);
      if (status == null) {
        allLeaves = model;
      } else if (status == 0) {
        pendingLeaves = model;
      } else if (status == 1) {
        approvedLeaves = model;
      } else if (status == 2) {
        rejectedLeaves = model;
      }

      emit(LeavesSuccessState(allLeaves ?? model));
    } catch (e) {
      emit(LeavesErrorState(e.toString()));
    }
  }

  void initialize() {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getAllLeaves();
        }
      });

    fetchAllLeaveCounts();
  }

  void fetchAllLeaveCounts() async {
    emit(LeavesLoadingState());
    try {
      await getAllLeaves(status: null);
      await getAllLeaves(status: 0);
      await getAllLeaves(status: 2);
      await getAllLeaves(status: 1);
      emit(LeavesSuccessState(allLeaves!));
    } catch (e) {
      emit(LeavesErrorState(e.toString()));
    }
  }

  void changeTap(int index) {
    selectedIndex = index;
    currentPage = 1;

    int? status;
    if (index == 1) {
      // Pending
      status = 0;
      if (pendingLeaves != null) {
        emit(LeavesSuccessState(pendingLeaves!));
        return;
      }
    } else if (index == 2) {
      // Rejected
      status = 2;
      if (rejectedLeaves != null) {
        emit(LeavesSuccessState(rejectedLeaves!));
        return;
      }
    } else if (index == 3) {
      // Approved
      status = 1;
      if (approvedLeaves != null) {
        emit(LeavesSuccessState(approvedLeaves!));
        return;
      }
    } else {
      // All
      status = null;
      if (allLeaves != null) {
        emit(LeavesSuccessState(allLeaves!));
        return;
      }
    }

    // Load if not already available
    getAllLeaves(status: status);
  }

  leavesDelete(int id) {
    emit(LeavesDeleteLoadingState());
    DioHelper.deleteData(url: 'leaves/delete/$id').then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(LeavesDeleteSuccessState(message!));
    }).catchError((error) {
      emit(LeavesDeleteErrorState(error.toString()));
    });
  }
}
