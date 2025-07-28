import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/filter/logic/cubit/filter_dialog_cubit.dart';
import 'package:smart_cleaning_application/core/widgets/filter/ui/screen/filter_dialog_widget.dart';
import 'package:smart_cleaning_application/core/widgets/filter_and_search_build/filter_search_build.dart';
import 'package:smart_cleaning_application/core/widgets/floating_action_button/floating_action_button.dart';
import 'package:smart_cleaning_application/core/widgets/integration_buttons/integrations_buttons.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/category_management/logic/category_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/category_management/logic/category_mangement_state.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/category_management/ui/widgets/category_details_list_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class CategoryManagmentBody extends StatelessWidget {
  const CategoryManagmentBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CategoryManagementCubit>();
    return Scaffold(
      appBar: AppBar(
          title: Text(S.of(context).categoryManagement),
          leading: CustomBackButton()),
      floatingActionButton: floatingActionButton(
        icon: Icons.post_add_rounded,
        onPressed: () async {
          final result = await context.pushNamed(Routes.addCategoryScreen);

          if (result == true) {
            cubit.refreshCategories();
          }
        },
      ),
      body: BlocConsumer<CategoryManagementCubit, CategoryManagementState>(
        listener: (context, state) {
          if (state is CategoryManagementErrorState ||
              state is DeleteCategoryErrorState) {
            final errorMessage = state is CategoryManagementErrorState
                ? state.error
                : (state as DeleteCategoryErrorState).error;
            toast(text: errorMessage, isSuccess: false);
          }
          if (state is DeleteCategorySuccessState) {
            toast(text: state.deleteCategoryModel.message!, isSuccess: true);
            cubit.getAllDeletedCategory();
          }
          if (state is ForceDeleteCategorySuccessState) {
            toast(text: state.message, isSuccess: true);
            cubit.getAllDeletedCategory();
            cubit.getAllDeletedCategory();
          }
          if (state is ForceDeleteCategoryErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is RestoreCategorySuccessState) {
            toast(text: state.message, isSuccess: true);
          }
          if (state is RestoreCategoryErrorState) {
            toast(text: state.error, isSuccess: false);
          }
        },
        builder: (context, state) {
          return Skeletonizer(
            enabled: (cubit.categoryManagementModel == null &&
                cubit.deletedCategoryListModel == null),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(10),
                  FilterAndSearchWidget(
                    hintText: S.of(context).findCategory,
                    searchController: cubit.searchController,
                    onSearchChanged: (value) {
                      cubit.getCategoryList();
                    },
                    onFilterTap: () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return BlocProvider(
                            create: (context) =>
                                FilterDialogCubit()..getCategory(),
                            child: FilterDialogWidget(
                              index: 'S-c',
                              onPressed: (data) {
                                cubit.filterModel = data;
                                cubit.getCategoryList();
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                  verticalSpace(10),
                  integrationsButtons(
                    selectedIndex: cubit.selectedIndex,
                    onTap: (index) => cubit.changeTap(index),
                    firstCount:
                        cubit.categoryManagementModel?.data?.totalCount ?? 0,
                    firstLabel: S.of(context).totalCategories,
                    secondCount:
                        cubit.deletedCategoryListModel?.data?.length ?? 0,
                    secondLabel: S.of(context).deletedCategories,
                  ),
                  verticalSpace(10),
                  Divider(color: Colors.grey[300], height: 0),
                  verticalSpace(10),
                  Expanded(child: CategoryDetailsBuild()),
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
