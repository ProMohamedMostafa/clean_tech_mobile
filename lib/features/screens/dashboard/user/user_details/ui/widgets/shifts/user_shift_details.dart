import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_details/logic/cubit/user_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_details/ui/widgets/shifts/shift_list_item_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class UserShiftDetails extends StatelessWidget {
  const UserShiftDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          verticalSpace(5),
          _buildShiftList(context),
        ],
      ),
    );
  }

  Widget _buildShiftList(BuildContext context) {
    final shiftModel = context.read<UserDetailsCubit>().userShiftDetailsModel!;
    if (shiftModel.data == null || shiftModel.data!.isEmpty) {
      return Center(
        child: Text(
        S.of(context).noData,
          style: TextStyles.font13Blackmedium,
        ),
      );
    }
    return ListView.separated(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: shiftModel.data!.length,
        separatorBuilder: (context, index) => verticalSpace(10),
        itemBuilder: (context, index) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ShiftItemBuild(index: index),
              ],
            ));
  }
}
