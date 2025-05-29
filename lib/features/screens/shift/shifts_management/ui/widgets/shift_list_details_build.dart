import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/logic/shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/ui/widgets/list_item_build.dart';

class ShiftListDetailsBuild extends StatelessWidget {
  const ShiftListDetailsBuild({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShiftCubit>();
    final shiftsData = cubit.selectedIndex == 0
        ? cubit.allShiftsModel?.data?.shifts
        : cubit.allShiftsDeletedModel?.data;

    if (shiftsData == null || shiftsData.isEmpty) {
      return Center(
        child: Text(
          "There's no data",
          style: TextStyles.font13Blackmedium,
        ),
      );
    } else {
      return ListView.separated(
        controller: cubit.selectedIndex == 0 ? cubit.scrollController : null,
        shrinkWrap: true,
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
              ListShiftItemBuild(index: index),
            ],
          );
        },
      );
    }
  }
}
