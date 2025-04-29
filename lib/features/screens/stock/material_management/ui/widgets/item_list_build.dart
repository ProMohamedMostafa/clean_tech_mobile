import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/logic/material_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/ui/widgets/add_pop_up_dialog.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/ui/widgets/pop_up_dialog.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/ui/widgets/reduce_pop_up_dialog.dart';

Widget listItemBuild(BuildContext context, selectedIndex, index) {
  return InkWell(
    borderRadius: BorderRadius.circular(11.r),
    onTap: () {
      context.pushNamed(
        Routes.materialDetailsScreen,
        arguments: context
            .read<MaterialManagementCubit>()
            .materialManagementModel!
            .data!
            .materials![index]
            .id,
      );
    },
    child: Card(
        elevation: 1,
        margin: EdgeInsets.zero,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11.r),
            side: BorderSide(color: AppColor.secondaryColor)),
        child: Padding(
          padding: selectedIndex == 0
              ? const EdgeInsets.fromLTRB(10, 0, 10, 10)
              : const EdgeInsets.fromLTRB(10, 10, 0, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedIndex == 0
                        ? context
                            .read<MaterialManagementCubit>()
                            .materialManagementModel!
                            .data!
                            .materials![index]
                            .name!
                        : context
                            .read<MaterialManagementCubit>()
                            .deletedMaterialListModel!
                            .data![index]
                            .name!,
                    style: TextStyles.font16BlackSemiBold,
                  ),
                  selectedIndex == 0
                      ? IconButton(
                          onPressed: () {
                            PopUpDialog.show(
                              context: context,
                              id: context
                                  .read<MaterialManagementCubit>()
                                  .materialManagementModel!
                                  .data!
                                  .materials![index]
                                  .id!,
                            );
                          },
                          icon: Icon(
                            Icons.more_horiz_rounded,
                            size: 22.sp,
                          ),
                        )
                      : SizedBox(
                          width: 80.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {
                                    showCustomDialog(context,
                                        "Are you Sure to restore this material ?",
                                        () {
                                      context
                                          .read<MaterialManagementCubit>()
                                          .restoreDeletedMaterial(
                                            context
                                                .read<MaterialManagementCubit>()
                                                .deletedMaterialListModel!
                                                .data![index]
                                                .id!,
                                          );
                                      context.pop();
                                    });
                                  },
                                  child: Icon(
                                    Icons.replay_outlined,
                                    color: AppColor.thirdColor,
                                  )),
                              horizontalSpace(10),
                              InkWell(
                                  onTap: () {
                                    showCustomDialog(
                                        context, "Forced Delete this material",
                                        () {
                                      context
                                          .read<MaterialManagementCubit>()
                                          .forcedDeletedMaterial(context
                                              .read<MaterialManagementCubit>()
                                              .deletedMaterialListModel!
                                              .data![index]
                                              .id!);
                                      context.pop();
                                    });
                                  },
                                  child: Icon(
                                    IconBroken.delete,
                                    color: AppColor.thirdColor,
                                  )),
                            ],
                          ),
                        ),
                ],
              ),
              verticalSpace(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Quantity: ',
                          style: TextStyles.font12GreyRegular,
                        ),
                        TextSpan(
                          text: selectedIndex == 0
                              ? context
                                  .read<MaterialManagementCubit>()
                                  .materialManagementModel!
                                  .data!
                                  .materials![index]
                                  .quantity
                                  .toString()
                              : context
                                  .read<MaterialManagementCubit>()
                                  .deletedMaterialListModel!
                                  .data![index]
                                  .quantity!
                                  .toString(),
                          style: TextStyles.font14Primarybold,
                        ),
                        TextSpan(
                          text:
                              ' ${selectedIndex == 0 ? context.read<MaterialManagementCubit>().materialManagementModel!.data!.materials![index].unit : context.read<MaterialManagementCubit>().deletedMaterialListModel!.data![index].unit}',
                          style: TextStyles.font12GreyRegular
                              .copyWith(color: AppColor.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  horizontalSpace(30),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Minimum: ',
                          style: TextStyles.font12GreyRegular,
                        ),
                        TextSpan(
                          text: selectedIndex == 0
                              ? context
                                  .read<MaterialManagementCubit>()
                                  .materialManagementModel!
                                  .data!
                                  .materials![index]
                                  .minThreshold
                                  .toString()
                              : context
                                  .read<MaterialManagementCubit>()
                                  .deletedMaterialListModel!
                                  .data![index]
                                  .minThreshold!
                                  .toString(),
                          style: TextStyles.font14Primarybold,
                        ),
                        TextSpan(
                          text:
                              ' ${selectedIndex == 0 ? context.read<MaterialManagementCubit>().materialManagementModel!.data!.materials![index].unit : context.read<MaterialManagementCubit>().deletedMaterialListModel!.data![index].unit}',
                          style: TextStyles.font12GreyRegular
                              .copyWith(color: AppColor.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              verticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Category: ',
                          style: TextStyles.font12GreyRegular,
                        ),
                        TextSpan(
                          text: selectedIndex == 0
                              ? context
                                  .read<MaterialManagementCubit>()
                                  .materialManagementModel!
                                  .data!
                                  .materials![index]
                                  .categoryName
                              : context
                                  .read<MaterialManagementCubit>()
                                  .deletedMaterialListModel!
                                  .data![index]
                                  .categoryName!,
                          style: TextStyles.font14Primarybold,
                        ),
                      ],
                    ),
                  ),
                  selectedIndex == 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(50.r),
                              onTap: () {
                                ReducePopUpDialog.show(
                                  context: context,
                                  id: context
                                      .read<MaterialManagementCubit>()
                                      .materialManagementModel!
                                      .data!
                                      .materials![index]
                                      .id!,
                                );
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.remove, color: Colors.white),
                              ),
                            ),
                            horizontalSpace(8),
                            InkWell(
                              borderRadius: BorderRadius.circular(50.r),
                              onTap: () {
                                AddPopUpDialog.show(
                                  context: context,
                                  id: context
                                      .read<MaterialManagementCubit>()
                                      .materialManagementModel!
                                      .data!
                                      .materials![index]
                                      .id!,
                                );
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.add, color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ],
          ),
        )),
  );
}
