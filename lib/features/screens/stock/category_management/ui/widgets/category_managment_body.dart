import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/logic/category_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/logic/category_mangement_state.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/ui/widgets/category_details_list_build.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/ui/widgets/filter_search_build.dart';

class CategoryManagmentBody extends StatefulWidget {
  const CategoryManagmentBody({super.key});

  @override
  State<CategoryManagmentBody> createState() => _CategoryManagmentBodyState();
}

class _CategoryManagmentBodyState extends State<CategoryManagmentBody> {
  @override
  void initState() {
    context.read<CategoryManagementCubit>().initialize();
    context.read<CategoryManagementCubit>().getCategoryList();
    context.read<CategoryManagementCubit>().getAllDeletedCategory();

    super.initState();
  }

  int? selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text(
          'Category Management',
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: SizedBox(
          height: 57.h,
          width: 57.w,
          child: ElevatedButton(
            onPressed: () {
              context.pushNamed(Routes.addCategoryScreen);
            },
            style: ElevatedButton.styleFrom(
              padding: REdgeInsets.all(0),
              backgroundColor: AppColor.primaryColor,
              shape: CircleBorder(),
              side: BorderSide(
                color: AppColor.secondaryColor,
                width: 1.w,
              ),
            ),
            child: Icon(
              Icons.post_add_rounded,
              color: Colors.white,
              size: 28.sp,
            ),
          ),
        ),
      ),
      body: BlocConsumer<CategoryManagementCubit, CategoryManagementState>(
        listener: (context, state) {
          if (state is DeleteCategorySuccessState) {
            context.read<CategoryManagementCubit>().getAllDeletedCategory();
            toast(text: state.deleteCategoryModel.message!, color: Colors.blue);
          }
          if (state is ForceDeleteCategorySuccessState) {
            context.read<CategoryManagementCubit>().getCategoryList();
            context.read<CategoryManagementCubit>().getAllDeletedCategory();
            toast(text: state.message, color: Colors.blue);
          }
          if (state is RestoreCategorySuccessState) {
            toast(text: state.message, color: Colors.blue);
          }

          if (state is CategoryManagementErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is DeleteCategoryErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is ForceDeleteCategoryErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is RestoreCategoryErrorState) {
            toast(text: state.error, color: Colors.red);
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
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(15),
                    filterAndSearchBuild(
                        context, context.read<CategoryManagementCubit>()),
                    verticalSpace(15),
                    SizedBox(
                      height: 45.h,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double totalWidth = constraints.maxWidth;
                          double gap = 10;
                          double containerWidth = (totalWidth - gap) / 2;
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: (role == 'Admin') ? 2 : 1,
                            separatorBuilder: (context, index) {
                              return SizedBox(width: gap);
                            },
                            itemBuilder: (context, index) {
                              bool isSelected = selectedIndex == index;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  height: 45.h,
                                  width: containerWidth,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColor.primaryColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: AppColor.secondaryColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        (role == 'Admin')
                                            ? index == 0
                                                ? "${context.read<CategoryManagementCubit>().categoryManagementModel?.data.categories.length ?? 0}"
                                                : "${context.read<CategoryManagementCubit>().deletedCategoryListModel?.data?.length ?? 0}"
                                            : "${context.read<CategoryManagementCubit>().categoryManagementModel?.data.categories.length ?? 0}",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: isSelected
                                              ? Colors.white
                                              : AppColor.primaryColor,
                                        ),
                                      ),
                                      horizontalSpace(5),
                                      Text(
                                        (role == 'Admin')
                                            ? index == 0
                                                ? "Total Categories"
                                                : 'Deleted Category'
                                            : "Total Categories",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: isSelected
                                              ? Colors.white
                                              : AppColor.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    verticalSpace(10),
                    Divider(
                      color: Colors.grey[300],
                    ),
                    Expanded(
                      child: state is CategoryManagementLoadingState &&
                              (context
                                          .read<CategoryManagementCubit>()
                                          .categoryManagementModel ==
                                      null &&
                                  context
                                          .read<CategoryManagementCubit>()
                                          .deletedCategoryListModel ==
                                      null)
                          ? Center(
                              child: CircularProgressIndicator(
                                  color: AppColor.primaryColor))
                          : categoryDetailsBuild(context, selectedIndex!),
                    ),
                    verticalSpace(10),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
