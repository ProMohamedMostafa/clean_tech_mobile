import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/logic/material_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/ui/widgets/material_item_list_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class MaterialDetailsListBuild extends StatelessWidget {
  const MaterialDetailsListBuild({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MaterialManagementCubit>();
    final materialsData = cubit.selectedIndex == 0
        ? cubit.materialManagementModel?.data?.materials
        : cubit.deletedMaterialListModel?.data;

    if (materialsData == null || materialsData.isEmpty) {
      return Center(
        child: Text(
          S.of(context).noData,
          style: TextStyles.font13Blackmedium,
        ),
      );
    } else {
      return ListView.separated(
        controller: cubit.selectedIndex == 0 ? cubit.scrollController : null,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: materialsData.length,
        separatorBuilder: (context, index) {
          return verticalSpace(10);
        },
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [MaterialListItemBuild(index: index)],
          );
        },
      );
    }
  }
}
