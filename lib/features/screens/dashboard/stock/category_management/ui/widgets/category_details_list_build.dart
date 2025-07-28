import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/category_management/logic/category_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/category_management/ui/widgets/category_item_list_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class CategoryDetailsBuild extends StatelessWidget {
  const CategoryDetailsBuild({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CategoryManagementCubit>();
    final categoriesData = cubit.selectedIndex == 0
        ? cubit.categoryManagementModel?.data?.categories
        : cubit.deletedCategoryListModel?.data;

    if (categoriesData == null || categoriesData.isEmpty) {
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
        itemCount: categoriesData.length,
        separatorBuilder: (context, index) {
          return verticalSpace(10);
        },
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CategoryListItemBuild(index: index),
            ],
          );
        },
      );
    }
  }
}
