import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/data/models/attendance_leaves_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/logic/attendance_leaves_state.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_edit/data/models/leaves_details_model.dart';

class AttendanceLeavesCubit extends Cubit<AttendanceLeavesState> {
  AttendanceLeavesCubit() : super(AttendanceLeavesInitialState());

  static AttendanceLeavesCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();

  ScrollController scrollController = ScrollController();

  int currentPage = 1;
  FilterDialogDataModel? filterModel;
  AttendanceLeavesModel? attendanceLeavesModel;
  getAllLeaves() {
    emit(LeavesLoadingState());
    DioHelper.getData(url: ApiConstants.leavesUrl, query: {
      'PageNumber': currentPage,
      'PageSize': 15,
      'Search': searchController.text,
      'History': false,
      'UserId': filterModel?.userId,
      'RoleId': filterModel?.roleId,
      'StartDate': filterModel?.startDate,
      'EndDate': filterModel?.endDate,
      'Type': filterModel?.typeId,
      'AreaId': filterModel?.areaId,
      'CityId': filterModel?.cityId,
      'OrganizationId': filterModel?.organizationId,
      'BuildingId': filterModel?.buildingId,
      'FloorId': filterModel?.floorId,
      'SectionId': filterModel?.sectionId,
      'PointId': filterModel?.pointId,
      'ProviderId': filterModel?.providerId
    }).then((value) {
      final newLeaves = AttendanceLeavesModel.fromJson(value!.data);

      if (currentPage == 1 || attendanceLeavesModel == null) {
        attendanceLeavesModel = newLeaves;
      } else {
        attendanceLeavesModel?.data?.leaves
            ?.addAll(newLeaves.data?.leaves ?? []);
        attendanceLeavesModel?.data?.currentPage = newLeaves.data?.currentPage;
        attendanceLeavesModel?.data?.totalPages = newLeaves.data?.totalPages;
      }
      emit(LeavesSuccessState(attendanceLeavesModel!));
    }).catchError((error) {
      emit(LeavesErrorState(error.toString()));
    });
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
    getAllLeaves();
  }

  leavesDelete(int id) {
    emit(LeavesDeleteLoadingState());
    DioHelper.deleteData(url: 'leaves/delete/$id', data: {'id': id})
        .then((value) {
      final message = value?.data['message'] ?? "restored successfully";
      emit(LeavesDeleteSuccessState(message!));
    }).catchError((error) {
      emit(LeavesDeleteErrorState(error.toString()));
    });
  }

  LeavesDetailsModel? leavesDetailsModel;
  getLeavesDetails(int? id) {
    emit(LeavesDetailsLoadingState());
    DioHelper.getData(url: "leaves/$id").then((value) {
      leavesDetailsModel = LeavesDetailsModel.fromJson(value!.data);
      emit(LeavesDetailsSuccessState(leavesDetailsModel!));
    }).catchError((error) {
      emit(LeavesDetailsErrorState(error.toString()));
    });
  }
}
