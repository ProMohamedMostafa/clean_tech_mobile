import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/floating_action_button/floating_action_button.dart';
import 'package:smart_cleaning_application/core/widgets/two_buttons_in_integreat_screen/two_buttons_in_integration_screen.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/logic/category_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/logic/category_mangement_state.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/ui/widgets/category_details_list_build.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/ui/widgets/filter_search_build.dart';

class CategoryManagmentBody extends StatelessWidget {
  const CategoryManagmentBody({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryManagementCubit cubit =
        context.read<CategoryManagementCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text(
          'Category Management',
        ),
      ),
      floatingActionButton: floatingActionButton(
        icon: Icons.post_add_rounded,
        onPressed: () {
          context.pushNamed(Routes.addCategoryScreen);
        },
      ),
      body: BlocConsumer<CategoryManagementCubit, CategoryManagementState>(
        listener: (context, state) {
          if (state is CategoryManagementErrorState ||
              state is DeleteCategoryErrorState) {
            final errorMessage = state is CategoryManagementErrorState
                ? state.error
                : (state as DeleteCategoryErrorState).error;
            toast(text: errorMessage, color: Colors.red);
          }
          if (state is ForceDeleteCategorySuccessState) {
            toast(text: state.message, color: Colors.blue);
            cubit.getAllDeletedCategory();
            cubit.getAllDeletedCategory();
          }
          if (state is RestoreCategorySuccessState) {
            toast(text: state.message, color: Colors.blue);
          }
          if (state is DeleteCategorySuccessState) {
            toast(text: state.deleteCategoryModel.message!, color: Colors.blue);
            cubit.getAllDeletedCategory();
          }
        },
        builder: (context, state) {
          return Skeletonizer(
            enabled: (context
                        .read<CategoryManagementCubit>()
                        .categoryManagementModel ==
                    null &&
                context
                        .read<CategoryManagementCubit>()
                        .deletedCategoryListModel ==
                    null),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(10),
                  FilterAndSearchWidget(),
                  verticalSpace(10),
                  twoButtonsIntegration(
                    selectedIndex: cubit.selectedIndex,
                    onTap: (index) => cubit.changeTap(index),
                    firstCount:
                        cubit.categoryManagementModel?.data?.totalCount ?? 0,
                    firstLabel: 'Total Categories',
                    secondCount:
                        cubit.deletedCategoryListModel?.data?.length ?? 0,
                    secondLabel: 'Deleted Categories',
                  ),
                  verticalSpace(10),
                  Divider(
                    color: Colors.grey[300],
                  ),
                  Expanded(
                    child: categoryDetailsBuild(context, cubit.selectedIndex),
                  ),
                  verticalSpace(10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
