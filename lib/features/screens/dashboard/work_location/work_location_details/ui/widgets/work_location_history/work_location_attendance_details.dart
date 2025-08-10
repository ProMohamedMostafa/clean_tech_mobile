import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/logic/cubit/work_location_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/ui/widgets/work_location_history/work_location_attendance_list_item_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class WorkLocationAttendanceDetails extends StatelessWidget {
  final int selectedIndex;
  const WorkLocationAttendanceDetails({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          verticalSpace(10),
          _buildAttendanceList(context, selectedIndex),
        ],
      ),
    );
  }

  Widget _buildAttendanceList(BuildContext context, int selectedIndex) {
    final cubit = context.read<WorkLocationDetailsCubit>();
    final attendanceData = selectedIndex == 0
        ? cubit.attendanceHistoryAreaModel?.data?.data
        : selectedIndex == 1
            ? cubit.attendanceHistoryCityModel?.data?.data
            : selectedIndex == 2
                ? cubit.attendanceHistoryOrganizationModel?.data?.data
                : selectedIndex == 3
                    ? cubit.attendanceHistoryBuildingModel?.data?.data
                    : selectedIndex == 4
                        ? cubit.attendanceHistoryFloorModel?.data?.data
                        : selectedIndex == 5
                            ? cubit.attendanceHistorySectionModel?.data?.data
                            : cubit.attendanceHistoryPointModel?.data?.data;

    if (attendanceData == null || attendanceData.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Text(
            S.of(context).noData,
            style: TextStyles.font13Blackmedium,
          ),
        ),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: attendanceData.length,
      separatorBuilder: (context, index) => verticalSpace(10),
      itemBuilder: (context, index) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          WorkLocationAttendanceListItemBuild(
              selectedIndex: selectedIndex, index: index),
        ],
      ),
    );
  }
}
