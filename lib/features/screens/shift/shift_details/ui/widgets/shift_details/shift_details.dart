import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/logic/cubit/shift_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/ui/widgets/shift_details/shift_item_details_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ShiftDetails extends StatelessWidget {
  const ShiftDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          verticalSpace(5),
          _buildShiftDetails(context),
        ],
      ),
    );
  }

  Widget _buildShiftDetails(BuildContext context) {
     final shiftDetailsModel =
        context.read<ShiftDetailsCubit>().shiftDetailsModel?.data;
    if (shiftDetailsModel == null) {
      return Center(
        child: Text(
          S.of(context).noData,
          style: TextStyles.font13Blackmedium,
        ),
      );
    }
    return ShiftItemDetailsBuild();
  }
}
