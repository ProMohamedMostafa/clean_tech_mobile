import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/logic/shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_cubit.dart';

Widget listShiftItemBuild(BuildContext context, index) {
  return InkWell(
    onTap: () {
      context.pushNamed(Routes.shiftDetailsScreen,
          arguments:
              context.read<ShiftCubit>().allShiftsModel!.data![index].id);
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          context
              .read<UserManagementCubit>()
              .userShiftDetailsModel!
              .data!
              .shifts![index]
              .name!,
          style: TextStyles.font14BlackSemiBold,
        ),
        Text(
          context
              .read<UserManagementCubit>()
              .userShiftDetailsModel!
              .data!
              .shifts![index]
              .startTime!,
          style: TextStyles.font11BlackMedium,
        ),
        Text(
          context
              .read<UserManagementCubit>()
              .userShiftDetailsModel!
              .data!
              .shifts![index]
              .startDate!,
          style: TextStyles.font11BlackMedium,
        ),
      ],
    ),
  );
}
