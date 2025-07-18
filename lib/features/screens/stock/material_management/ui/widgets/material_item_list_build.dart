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
import 'package:smart_cleaning_application/features/screens/stock/material_management/logic/material_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/ui/widgets/add_pop_up_dialog.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/ui/widgets/pop_up_dialog.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/ui/widgets/reduce_pop_up_dialog.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class MaterialListItemBuild extends StatelessWidget {
  final int index;
  const MaterialListItemBuild({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MaterialManagementCubit>();
    return InkWell(
      borderRadius: BorderRadius.circular(11.r),
      onTap: () async {
        final result = await context.pushNamed(
          Routes.materialDetailsScreen,
          arguments: cubit.materialManagementModel!.data!.materials![index].id,
        );

        if (result == true) {
          cubit.refreshMaterials();
        }
      },
      child: Card(
          elevation: 1,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11.r),
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11.r),
              border: Border.all(color: AppColor.secondaryColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cubit.selectedIndex == 0
                          ? cubit.materialManagementModel!.data!
                              .materials![index].name!
                          : cubit.deletedMaterialListModel!.data![index].name!,
                      style: TextStyles.font16BlackSemiBold,
                    ),
                    cubit.selectedIndex == 0
                        ? IconButton(
                            onPressed: () {
                              PopUpDialog.show(
                                  context: context,
                                  id: cubit.materialManagementModel!.data!
                                      .materials![index].id!,
                                  categoryId: cubit.materialManagementModel!
                                      .data!.materials![index].categoryId!);
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
                                      showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return PopUpMessage(
                                                title:
                                                    S.of(context).TitleRestore,
                                                body:
                                                    S.of(context).materialBody,
                                                onPressed: () {
                                                  cubit.restoreDeletedMaterial(
                                                    cubit
                                                        .deletedMaterialListModel!
                                                        .data![index]
                                                        .id!,
                                                  );
                                                });
                                          });
                                    },
                                    child: Icon(
                                      Icons.replay_outlined,
                                      color: AppColor.thirdColor,
                                    )),
                                horizontalSpace(10),
                                InkWell(
                                    onTap: () {
                                      cubit.selectedIndex == 0
                                          ? showDialog(
                                              context: context,
                                              builder: (dialogContext) {
                                                return PopUpMessage(
                                                    title: S
                                                        .of(context)
                                                        .TitleDelete,
                                                    body: S
                                                        .of(context)
                                                        .materialBody,
                                                    onPressed: () {
                                                      cubit.deleteMaterial(cubit
                                                          .deletedMaterialListModel!
                                                          .data![index]
                                                          .id!);
                                                    });
                                              })
                                          : showDialog(
                                              context: context,
                                              builder: (dialogContext) {
                                                return PopUpMessage(
                                                    title: S
                                                        .of(context)
                                                        .TitleDelete,
                                                    body: S
                                                        .of(context)
                                                        .materialBody,
                                                    onPressed: () {
                                                      cubit.forcedDeletedMaterial(
                                                          cubit
                                                              .deletedMaterialListModel!
                                                              .data![index]
                                                              .id!);
                                                    });
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
                            text: S.of(context).quantityLabel,
                            style: TextStyles.font12GreyRegular,
                          ),
                          TextSpan(
                            text: cubit.selectedIndex == 0
                                ? cubit.materialManagementModel!.data!
                                    .materials![index].quantity
                                    .toString()
                                : cubit.deletedMaterialListModel!.data![index]
                                    .quantity!
                                    .toString(),
                            style: TextStyles.font14Primarybold,
                          ),
                          TextSpan(
                            text:
                                ' ${cubit.selectedIndex == 0 ? cubit.materialManagementModel!.data!.materials![index].unit : cubit.deletedMaterialListModel!.data![index].unit}',
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
                            text: S.of(context).minimumLabel,
                            style: TextStyles.font12GreyRegular,
                          ),
                          TextSpan(
                            text: cubit.selectedIndex == 0
                                ? cubit.materialManagementModel!.data!
                                    .materials![index].minThreshold
                                    .toString()
                                : cubit.deletedMaterialListModel!.data![index]
                                    .minThreshold!
                                    .toString(),
                            style: TextStyles.font14Primarybold,
                          ),
                          TextSpan(
                            text:
                                ' ${cubit.selectedIndex == 0 ? cubit.materialManagementModel!.data!.materials![index].unit : cubit.deletedMaterialListModel!.data![index].unit}',
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
                            text: S.of(context).categoryLabel,
                            style: TextStyles.font12GreyRegular,
                          ),
                          TextSpan(
                            text: cubit.selectedIndex == 0
                                ? cubit.materialManagementModel!.data!
                                    .materials![index].categoryName
                                : cubit.deletedMaterialListModel!.data![index]
                                    .categoryName!,
                            style: TextStyles.font14Primarybold,
                          ),
                        ],
                      ),
                    ),
                    cubit.selectedIndex == 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(50.r),
                                onTap: () {
                                  ReducePopUpDialog.show(
                                    context: context,
                                    id: cubit.materialManagementModel!.data!
                                        .materials![index].id!,
                                  );
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child:
                                      Icon(Icons.remove, color: Colors.white),
                                ),
                              ),
                              horizontalSpace(8),
                              InkWell(
                                borderRadius: BorderRadius.circular(50.r),
                                onTap: () {
                                  AddPopUpDialog.show(
                                    context: context,
                                    id: cubit.materialManagementModel!.data!
                                        .materials![index].id!,
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
                              horizontalSpace(8),
                            ],
                          )
                        : SizedBox.shrink(),
                  ],
                ),
                verticalSpace(5),
              ],
            ),
          )),
    );
  }
}
