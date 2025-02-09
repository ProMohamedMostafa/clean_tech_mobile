import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/logic/shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/ui/widgets/list_item_build.dart';

Widget shiftListDetailsBuild(BuildContext context, int selectedIndex) {
  final shiftsData = selectedIndex == 0
      ? context.read<ShiftCubit>().allShiftsModel?.data?.shifts
      : context.read<ShiftCubit>().allShiftsDeletedModel?.data;

  if (shiftsData == null || shiftsData.isEmpty) {
    return Center(
      child: Text(
        "There's no data",
        style: TextStyles.font13Blackmedium,
      ),
    );
  } else {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: shiftsData.length,
      separatorBuilder: (context, index) {
        return verticalSpace(10);
      },
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            listItemBuild(context, selectedIndex, index),
          ],
        );
      },
    );
  }
}
