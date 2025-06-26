import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/logic/cubit/shift_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/ui/widgets/floor/floor_list_item_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class FloorListBuild extends StatelessWidget {
  const FloorListBuild({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildFloorList(context),
        ],
      ),
    );
  }

  Widget _buildFloorList(BuildContext context) {
    final floorsData =
        context.read<ShiftDetailsCubit>().shiftDetailsModel?.data?.floors;

    if (floorsData == null || floorsData.isEmpty) {
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
        itemCount: floorsData.length,
        separatorBuilder: (context, index) {
          return verticalSpace(10);
        },
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloorListItemBuild(index: index),
            ],
          );
        },
      );
    }
  }
}
