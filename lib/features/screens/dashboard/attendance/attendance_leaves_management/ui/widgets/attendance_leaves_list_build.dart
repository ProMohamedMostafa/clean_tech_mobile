import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_leaves_management/logic/attendance_leaves_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_leaves_management/ui/widgets/attendance_leaves_list_item_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class LeavesListBuild extends StatelessWidget {
  const LeavesListBuild({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AttendanceLeavesCubit>();
    final selectedLeaves = cubit.selectedIndex == 0
        ? cubit.allLeaves?.data?.leaves
        : cubit.selectedIndex == 1
            ? cubit.pendingLeaves?.data?.leaves
            : cubit.selectedIndex == 2
                ? cubit.rejectedLeaves?.data?.leaves
                : cubit.approvedLeaves?.data?.leaves;

    if (selectedLeaves == null || selectedLeaves.isEmpty) {
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
        scrollDirection: Axis.vertical,
        itemCount: selectedLeaves.length,
        separatorBuilder: (context, index) {
          return verticalSpace(10);
        },
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [LeavesListItemBuild(index: index)],
          );
        },
      );
    }
  }
}
