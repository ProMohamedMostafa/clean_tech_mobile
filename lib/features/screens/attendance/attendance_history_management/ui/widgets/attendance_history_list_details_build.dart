import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history_management/logic/attendance_history_cubit.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history_management/ui/widgets/attendance_list_item_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AttendanceHistoryListBuild extends StatelessWidget {
  const AttendanceHistoryListBuild({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AttendanceHistoryCubit>();
    final attendanceData = cubit.attendanceHistoryModel?.data!.data;
    if (attendanceData == null || attendanceData.isEmpty) {
      return Center(
        child: Text(
          S.of(context).noData,
          style: TextStyles.font13Blackmedium,
        ),
      );
    } else {
      return ListView.separated(
        controller: cubit.scrollController,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: attendanceData.length,
        separatorBuilder: (context, index) {
          return verticalSpace(10);
        },
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [HistoryListItem(index: index)],
          );
        },
      );
    }
  }
}
