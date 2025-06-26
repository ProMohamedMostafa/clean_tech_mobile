import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/logic/cubit/shift_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/ui/widgets/sections/section_list_item_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class SectionListBuild extends StatelessWidget {
  const SectionListBuild({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSectionList(context),
        ],
      ),
    );
  }

  Widget _buildSectionList(BuildContext context) {
    final sectiontsData =
        context.read<ShiftDetailsCubit>().shiftDetailsModel?.data?.sections;

    if (sectiontsData == null || sectiontsData.isEmpty) {
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
        itemCount: sectiontsData.length,
        separatorBuilder: (context, index) {
          return verticalSpace(10);
        },
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SectionItemBuild(index: index),
            ],
          );
        },
      );
    }
  }
}
