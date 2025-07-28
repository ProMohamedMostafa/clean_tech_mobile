import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/custom_row/row_details_build.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/shift_details/logic/cubit/shift_details_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ShiftItemDetailsBuild extends StatelessWidget {
  const ShiftItemDetailsBuild({super.key});

  @override
  Widget build(BuildContext context) {
    final shiftDetailsModel =
        context.read<ShiftDetailsCubit>().shiftDetailsModel?.data;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rowDetailsBuild(
            context, S.of(context).shiftName, shiftDetailsModel!.name!,
            color: AppColor.primaryColor),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        rowDetailsBuild(
            context, S.of(context).startDate, shiftDetailsModel.startDate!),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        rowDetailsBuild(
            context, S.of(context).endDate, shiftDetailsModel.endDate!),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        rowDetailsBuild(
            context, S.of(context).startTime, shiftDetailsModel.startTime!),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        rowDetailsBuild(
            context, S.of(context).endTime, shiftDetailsModel.endTime!),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
      ],
    );
  }
}
