import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/logic/organizations_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/ui/widgets/organizations_list_item_build.dart';

Widget organizationDetailsBuild(BuildContext context, int selectedIndex) {
  final organizationData = selectedIndex == 0
      ? context.read<OrganizationsCubit>().areaModel?.data
      : selectedIndex == 1
          ? context.read<OrganizationsCubit>().cityModel?.data
          : selectedIndex == 2
              ? context.read<OrganizationsCubit>().organizationModel?.data
              : selectedIndex == 3
                  ? context.read<OrganizationsCubit>().buildingModel?.data
                  : selectedIndex == 4
                      ? context.read<OrganizationsCubit>().floorModel?.data
                      : context.read<OrganizationsCubit>().pointModel?.data;

  if (organizationData == null || organizationData.isEmpty) {
    return Center(
      child: Text(
        "There's no data",
        style: TextStyles.font13Blackmedium,
      ),
    );
  } else {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: organizationData.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            organizationsListItemBuild(context, selectedIndex, index),
            Divider(
              color: Colors.grey[300],
            ),
          ],
        );
      },
    );
  }
}
