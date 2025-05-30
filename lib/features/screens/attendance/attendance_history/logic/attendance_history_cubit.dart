import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/logic/attendance_history_state.dart';

class AttendanceHistoryCubit extends Cubit<AttendanceHistoryState> {
  AttendanceHistoryCubit() : super(AttendanceHistoryInitialState());

  static AttendanceHistoryCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();
  int selectedIndex = 0;
  int currentPage = 1;

  FilterDialogDataModel? filterModel;
  AttendanceHistoryModel? attendanceHistoryModel;
  getAllHistory({int? status}) {
    emit(HistoryLoadingState());
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'PageNumber': currentPage,
      'PageSize': 15,
      'Search': searchController.text,
      'UserId': filterModel?.userId,
      'History': false,
      'RoleId': filterModel?.roleId,
      'Shift': filterModel?.shiftId,
      'StartDate': filterModel?.startDate,
      'EndDate': filterModel?.endDate,
      'Status': status ?? filterModel?.statusId,
      'AreaId': filterModel?.areaId,
      'CityId': filterModel?.cityId,
      'OrganizationId': filterModel?.organizationId,
      'BuildingId': filterModel?.buildingId,
      'FloorId': filterModel?.floorId,
      'SectionId': filterModel?.sectionId,
      'PointId': filterModel?.pointId,
      'ProviderId': filterModel?.providerId
    }).then((value) {
      final newHistory = AttendanceHistoryModel.fromJson(value!.data);

      if (currentPage == 1 || attendanceHistoryModel == null) {
        attendanceHistoryModel = newHistory;
      } else {
        attendanceHistoryModel?.data?.data?.addAll(newHistory.data?.data ?? []);
        attendanceHistoryModel?.data?.currentPage =
            newHistory.data?.currentPage;
        attendanceHistoryModel?.data?.totalPages = newHistory.data?.totalPages;
      }
      emit(HistorySuccessState(attendanceHistoryModel!));
    }).catchError((error) {
      emit(HistoryErrorState(error.toString()));
    });
  }

  void initialize(int? status) {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getAllHistory(status: status);
        }
      });
    getAllHistory(status: status);
  }
}
