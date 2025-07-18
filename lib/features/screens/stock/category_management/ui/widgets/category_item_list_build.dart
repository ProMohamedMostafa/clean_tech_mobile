import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/logic/category_mangement_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class CategoryListItemBuild extends StatelessWidget {
  final int index;
  const CategoryListItemBuild({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CategoryManagementCubit>();
    return InkWell(
      borderRadius: BorderRadius.circular(11.r),
      onTap: () async {
        if (cubit.selectedIndex == 0) {
          final result = await context.pushNamed(Routes.materialScreen,
              arguments:
                  cubit.categoryManagementModel!.data!.categories![index].id);

          if (result == true) {
            cubit.refreshCategories();
          }
        }
      },
      child: Card(
        elevation: 1,
        margin: EdgeInsets.zero,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11.r),
            side: BorderSide(color: AppColor.secondaryColor)),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          title: Text(
            cubit.selectedIndex == 0
                ? cubit.categoryManagementModel!.data!.categories![index].name!
                : cubit.deletedCategoryListModel!.data![index].name!,
            style: TextStyles.font16BlackSemiBold,
          ),
          subtitle: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: S.of(context).unitLabel,
                  style: TextStyles.font12GreyRegular,
                ),
                TextSpan(
                  text: cubit.selectedIndex == 0
                      ? cubit.categoryManagementModel!.data!.categories![index]
                          .unit
                      : cubit.deletedCategoryListModel!.data![index].unit!,
                  style: TextStyles.font14Primarybold,
                ),
              ],
            ),
          ),
          trailing: SizedBox(
            width: 80.w,
            child: Row(
              children: [
                InkWell(
                    onTap: () async {
                      if (cubit.selectedIndex == 0) {
                        final result = await context.pushNamed(
                          Routes.editCategoryScreen,
                          arguments: cubit.categoryManagementModel!.data!
                              .categories![index].id,
                        );

                        if (result == true) {
                          cubit.refreshCategories();
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return PopUpMessage(
                                  title: S.of(context).TitleRestore,
                                  body: S.of(context).categoryBody,
                                  onPressed: () {
                                    cubit.restoreDeletedCategory(
                                      cubit.deletedCategoryListModel!
                                          .data![index].id!,
                                    );
                                  });
                            });
                      }
                    },
                    child: Icon(
                      cubit.selectedIndex == 0
                          ? Icons.mode_edit_outlined
                          : Icons.replay_outlined,
                      color: AppColor.primaryColor,
                    )),
                horizontalSpace(10),
                InkWell(
                    onTap: () {
                      cubit.selectedIndex == 0
                          ? showDialog(
                              context: context,
                              builder: (dialogContext) {
                                return PopUpMessage(
                                    title: S.of(context).TitleDelete,
                                    body: S.of(context).categoryBody,
                                    onPressed: () {
                                      cubit.deleteCategory(cubit
                                          .categoryManagementModel!
                                          .data!
                                          .categories![index]
                                          .id!);
                                    });
                              })
                          : showDialog(
                              context: context,
                              builder: (dialogContext) {
                                return PopUpMessage(
                                    title: S.of(context).TitleDelete,
                                    body: S.of(context).categoryBody,
                                    onPressed: () {
                                      cubit.forcedDeletedCategory(cubit
                                          .deletedCategoryListModel!
                                          .data![index]
                                          .id!);
                                    });
                              });
                    },
                    child: Icon(
                      IconBroken.delete,
                      color: Colors.red,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
