import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_history_management/data/models/attendance_history_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_history_management/logic/attendance_history_state.dart';

class AttendanceHistoryCubit extends Cubit<AttendanceHistoryState> {
  AttendanceHistoryCubit() : super(AttendanceHistoryInitialState());

  static AttendanceHistoryCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  int selectedIndex = 0;
  int currentPage = 1;

  FilterDialogDataModel? filterModel;
  AttendanceHistoryModel? attendanceHistoryModel;
  getAllHistory({int? status}) {
    emit(HistoryLoadingState());
    final startDate = filterModel?.startDate;
    final endDate = filterModel?.endDate;
    DioHelper.getData(url: ApiConstants.hisotryUrl, query: {
      'PageNumber': currentPage,
      'PageSize': 15,
      'Search': searchController.text,
      'UserId': filterModel?.userId,
      'History': role == 'Cleaner' ? true : false,
      'RoleId': filterModel?.roleId,
      'Shift': filterModel?.shiftId,
      'StartDate': startDate != null
          ? DateFormat('yyyy-MM-dd', 'en').format(startDate)
          : null,
      'EndDate': endDate != null
          ? DateFormat('yyyy-MM-dd', 'en').format(endDate)
          : null,
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

  // Format a duration string like "01:30" into "1 hr 30 min"
  String formatDuration(String? duration) {
    if (duration == null || duration.isEmpty || !duration.contains(':')) {
      return '   ';
    }

    final durationParts = duration.split(':');
    if (durationParts.length < 2) return '   ';

    final hours = int.tryParse(durationParts[0]) ?? 0;
    final minutes = int.tryParse(durationParts[1]) ?? 0;

    if (hours > 0) {
      return '$hours hr ${minutes > 0 ? '$minutes min' : ''}';
    } else {
      return '$minutes min';
    }
  }

  // Convert status string to its corresponding color
  Color getStatusColor(String status) {
    const List<String> statuses = ["Absent", "Late", "Present"];
    const List<Color> statusColors = [
      Colors.red,
      Colors.orange,
      Colors.green,
    ];

    final index = statuses.indexOf(status);
    if (index != -1) {
      return statusColors[index];
    }
    return Colors.black;
  }
}
