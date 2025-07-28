import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/shift_details/logic/cubit/shift_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/shift_details/ui/widgets/organization/organization_list_item_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class OrganizationListBuild extends StatelessWidget {
  const OrganizationListBuild({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildOrganizationList(context),
        ],
      ),
    );
  }

  Widget _buildOrganizationList(BuildContext context) {
    final organizationsData = context
        .read<ShiftDetailsCubit>()
        .shiftDetailsModel
        ?.data
        ?.organizations;

    if (organizationsData == null || organizationsData.isEmpty) {
      return Center(
        child: Text(
          S.of(context).noData,
          style: TextStyles.font13Blackmedium,
        ),
      );
    } else {
      return ListView.separated(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: organizationsData.length,
        separatorBuilder: (context, index) {
          return verticalSpace(10);
        },
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OrganizationListItemBuild(index: index),
            ],
          );
        },
      );
    }
  }
}
