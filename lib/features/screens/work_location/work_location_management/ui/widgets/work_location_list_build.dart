import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/ui/widgets/work_location_list_item_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class WorkLocationListBuild extends StatelessWidget {
  final int selectedIndex;

  const WorkLocationListBuild({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkLocationCubit>();

    final data = cubit.tapIndex == 0
        ? cubit.getWorkLocationData(selectedIndex)
        : cubit.getDeletedWorkLocationData(selectedIndex);

    if (data == null || data.isEmpty) {
      return Center(
        child: Text(
          S.of(context).noData,
          style: TextStyles.font13Blackmedium,
        ),
      );
    }

    return ListView.separated(
      controller: cubit.scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      separatorBuilder: (context, index) => verticalSpace(10),
      itemBuilder: (context, index) {
        return WorkLocationListItemBuild(
          selectedIndex: selectedIndex,
          index: index,
        );
      },
    );
  }
}
