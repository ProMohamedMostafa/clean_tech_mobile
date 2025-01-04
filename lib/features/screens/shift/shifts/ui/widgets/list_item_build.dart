import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/logic/shift_cubit.dart';

Widget listItemBuild(BuildContext context, selectedIndex, index) {
  return InkWell(
    onTap: () {
      context.pushNamed(Routes.shiftDetailsScreen,
          arguments:
              context.read<ShiftCubit>().allShiftsModel!.data![index].id);
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          selectedIndex == 0
              ? context.read<ShiftCubit>().allShiftsModel!.data![index].name!
              : context
                  .read<ShiftCubit>()
                  .allShiftsDeletedModel!
                  .data![index]
                  .name!,
          style: TextStyles.font14BlackSemiBold,
        ),
        horizontalSpace(27),
        Text(
          selectedIndex == 0
              ? context
                  .read<ShiftCubit>()
                  .allShiftsModel!
                  .data![index]
                  .startTime!
              : context
                  .read<ShiftCubit>()
                  .allShiftsDeletedModel!
                  .data![index]
                  .startTime!,
          style: TextStyles.font11BlackMedium,
        ),
        horizontalSpace(30),
        Text(
          selectedIndex == 0
              ? context
                  .read<ShiftCubit>()
                  .allShiftsModel!
                  .data![index]
                  .startDate!
              : context
                  .read<ShiftCubit>()
                  .allShiftsDeletedModel!
                  .data![index]
                  .startDate!,
          style: TextStyles.font11BlackMedium,
        ),
        horizontalSpace(20),
        Spacer(),
        InkWell(
            onTap: () {
              selectedIndex == 0
                  ? context.pushNamed(
                      Routes.editShiftScreen,
                      arguments: context
                          .read<ShiftCubit>()
                          .allShiftsModel!
                          .data![index]
                          .id,
                    )
                  : showCustomDialog(
                      context, "Are you Sure to restore this shift ?", () {
                      context.read<ShiftCubit>().restoreDeletedShift(
                            context
                                .read<ShiftCubit>()
                                .allShiftsDeletedModel!
                                .data![index]
                                .id!,
                          );
                      context.pop();
                    });
            },
            child: Icon(
              selectedIndex == 0
                  ? Icons.mode_edit_outlined
                  : Icons.replay_outlined,
              color: AppColor.thirdColor,
            )),
        horizontalSpace(10),
        InkWell(
            onTap: () {
              selectedIndex == 0
                  ? showCustomDialog(
                      context, "Are you Sure to delete this shift ?", () {
                      context.read<ShiftCubit>().shiftDelete(context
                          .read<ShiftCubit>()
                          .allShiftsModel!
                          .data![index]
                          .id!);
                      context.pop();
                    })
                  : showCustomDialog(context, "Forced Delete this shift", () {
                      context.read<ShiftCubit>().forcedDeletedShift(context
                          .read<ShiftCubit>()
                          .allShiftsDeletedModel!
                          .data![index]
                          .id!);
                      context.pop();
                    });
            },
            child: Icon(
              IconBroken.delete,
              color: AppColor.thirdColor,
            )),
      ],
    ),
  );
}
