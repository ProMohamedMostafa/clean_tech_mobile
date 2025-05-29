import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/row_details_build.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/logic/cubit/shift_details_cubit.dart';

class ShiftItemDetailsBuild extends StatelessWidget {
  const ShiftItemDetailsBuild({super.key});

  @override
  Widget build(BuildContext context) {
    final shiftDetailsModel =
        context.read<ShiftDetailsCubit>().shiftDetailsModel?.data;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rowDetailsBuild(context, "Name Shift", shiftDetailsModel!.name!,
            color: AppColor.primaryColor),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        rowDetailsBuild(context, "Start Date", shiftDetailsModel.startDate!),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        rowDetailsBuild(context, "End Date", shiftDetailsModel.endDate!),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        rowDetailsBuild(context, "Start Time", shiftDetailsModel.startTime!),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        rowDetailsBuild(context, "End Time", shiftDetailsModel.endTime!),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
      ],
    );
  }
}
