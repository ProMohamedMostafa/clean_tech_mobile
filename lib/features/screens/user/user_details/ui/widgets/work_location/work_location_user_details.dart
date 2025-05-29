import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/work_location/work_location_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/logic/cubit/user_details_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class WorkLocationUserDetails extends StatelessWidget {
  const WorkLocationUserDetails({super.key});

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
    final workLocationModel =
        context.read<UserDetailsCubit>().userWorkLocationDetailsModel!;
    if (workLocationModel.data!.areas!.isEmpty &&
        workLocationModel.data!.cities!.isEmpty &&
        workLocationModel.data!.organizations!.isEmpty &&
        workLocationModel.data!.buildings!.isEmpty &&
        workLocationModel.data!.floors!.isEmpty &&
        workLocationModel.data!.sections!.isEmpty &&
        workLocationModel.data!.points!.isEmpty) {
      return Center(
        child: Text(
         S.of(context).noData,
          style: TextStyles.font13Blackmedium,
        ),
      );
    }
    return SingleChildScrollView(child: WorkLocationItemBuild());
  }
}
