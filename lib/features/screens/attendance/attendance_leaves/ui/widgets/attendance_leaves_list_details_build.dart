import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/ui/widgets/list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/logic/task_management_cubit.dart';

Widget attendanceLeavesListDetailsBuild(
    BuildContext context) {
  

  // if (tasksData == null || tasksData.isEmpty) {
  //   return Center(
  //     child: Text(
  //       "There's no data",
  //       style: TextStyles.font13Blackmedium,
  //     ),
  //   );
  // } else {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: 1,
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
// }
