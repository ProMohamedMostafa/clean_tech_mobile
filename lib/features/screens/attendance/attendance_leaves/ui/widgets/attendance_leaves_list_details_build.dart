import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/logic/attendance_leaves_cubit.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/ui/widgets/list_item_build.dart';

Widget attendanceLeavesListDetailsBuild(
    BuildContext context) {
  
final attendanceData =
      context.read<AttendanceLeavesCubit>().attendanceLeavesModel?.data!.leaves;

  if (attendanceData == null || attendanceData.isEmpty) {
    return Center(
      child: Text(
        "There's no data",
        style: TextStyles.font13Blackmedium,
      ),
    );
  } else {
    return ListView.separated(
         controller: context.read<AttendanceLeavesCubit>().scrollController,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: attendanceData.length,
      separatorBuilder: (context, index) {
        return verticalSpace(10);
      },
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildCardItem(context,index),
          ],
        );
      },
    );
  }
}
