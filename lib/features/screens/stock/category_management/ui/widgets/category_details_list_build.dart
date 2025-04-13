import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/logic/category_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/ui/widgets/item_list_build.dart';

Widget categoryDetailsBuild(BuildContext context, int selectedIndex) {
  final categoriesData = selectedIndex == 0
      ? context
          .read<CategoryManagementCubit>()
          .categoryManagementModel
          ?.data
          .categories
      : context.read<CategoryManagementCubit>().deletedCategoryListModel?.data;

  if (categoriesData == null || categoriesData.isEmpty) {
    return Center(
      child: Text(
        "There's no data",
        style: TextStyles.font13Blackmedium,
      ),
    );
  } else {
    return ListView.separated(
      controller: selectedIndex == 0
          ? context.read<CategoryManagementCubit>().scrollController
          : null,
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
            listItemBuild(context, selectedIndex, index),
            Divider(
              color: Colors.grey[300],
              height: 0.1,
            ),
          ],
        );
      },
    );
  }
}
