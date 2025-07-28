import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/shift_details/logic/cubit/shift_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/shift_details/ui/widgets/buildings/building_list_item_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class BuildingListBuild extends StatelessWidget {
  const BuildingListBuild({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildBuildingList(context),
        ],
      ),
    );
  }

  Widget _buildBuildingList(BuildContext context) {
    final buildingsData =
        context.read<ShiftDetailsCubit>().shiftDetailsModel?.data?.building;

    if (buildingsData == null || buildingsData.isEmpty) {
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
        itemCount: buildingsData.length,
        separatorBuilder: (context, index) {
          return verticalSpace(10);
        },
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BuildingItemListBuild(index: index),
            ],
          );
        },
      );
    }
  }
}
