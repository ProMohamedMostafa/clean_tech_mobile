import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/provider/provider_management/logic/cubit/provider_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class BuildProviderItemList extends StatelessWidget {
  final int index;
  const BuildProviderItemList({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProviderCubit>();
    return Container(
      height: 45.h,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            cubit.selectedIndex == 0
                ? cubit.providersModel!.data!.data![index].name!
                : cubit.allDeletedProvidersModel!.data![index].name!,
            style: TextStyles.font14BlackSemiBold,
          ),
          Spacer(),
          InkWell(
            onTap: () {
              if (cubit.selectedIndex == 0) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                        insetPadding: EdgeInsets.all(20),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 8.w,
                                      height: 24.h,
                                      decoration: BoxDecoration(
                                          color: AppColor.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(2.r)),
                                    ),
                                    horizontalSpace(8),
                                    Text(S.of(context).editProvider,
                                        style: TextStyles.font18BlackMedium),
                                    const Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        Icons.close_rounded,
                                        size: 26.sp,
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                                verticalSpace(10),
                                Text(
                                  S.of(context).providerName,
                                  style: TextStyles.font14BlackMedium,
                                ),
                                verticalSpace(5),
                                Form(
                                  key: cubit.formAddKey,
                                  child: CustomTextFormField(
                                      color: Colors.grey,
                                      controller: cubit.providerController
                                        ..text = cubit.providersModel!.data!
                                            .data![index].name!,
                                      onlyRead: false,
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value!.length > 55) {
                                          return S
                                              .of(context)
                                              .providerNameTooLongValidation;
                                        } else if (value.length < 3) {
                                          return S
                                              .of(context)
                                              .providerNameTooShortValidation;
                                        }
                                        return null;
                                      }),
                                ),
                                verticalSpace(25),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: DefaultElevatedButton(
                                          name: S.of(context).editButton,
                                          textStyles:
                                              TextStyles.font16WhiteSemiBold,
                                          onPressed: () {
                                            {
                                              if (cubit.formAddKey.currentState
                                                      ?.validate() ??
                                                  false) {
                                                showDialog(
                                                    context: context,
                                                    builder: (dialogContext) {
                                                      return PopUpMessage(
                                                          title: S
                                                              .of(context)
                                                              .TitleEdit,
                                                          body: S
                                                              .of(context)
                                                              .providerBody,
                                                          onPressed: () {
                                                            cubit.editProvider(cubit
                                                                .providersModel!
                                                                .data!
                                                                .data![index]
                                                                .id);
                                                            context.pop();
                                                          });
                                                    });
                                              }
                                            }
                                          },
                                          color: AppColor.primaryColor,
                                     
                                          width: double.infinity),
                                    ),
                                    horizontalSpace(16),
                                    Expanded(
                                      child: DefaultElevatedButton(
                                          name: S.of(context).cancelButton,
                                          textStyles:
                                              TextStyles.font16PrimSemiBold,
                                          onPressed: () {
                                            context.pop();
                                          },
                                          color: AppColor.fourthColor,
                                         
                                          width: double.infinity),
                                    ),
                                  ],
                                ),
                                verticalSpace(5),
                              ],
                            )));
                  },
                );
              } else {
                showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return PopUpMessage(
                          title: S.of(context).TitleRestore,
                          body: S.of(context).providerBody,
                          onPressed: () {
                            cubit.restoreDeletedProvider(
                              cubit.allDeletedProvidersModel!.data![index].id!,
                            );
                          });
                    });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Icon(
                cubit.selectedIndex == 0
                    ? Icons.mode_edit_outlined
                    : Icons.replay_outlined,
                color: AppColor.primaryColor,
              ),
            ),
          ),
          horizontalSpace(12),
          InkWell(
            onTap: () {
              if (cubit.selectedIndex == 0) {
                showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return PopUpMessage(
                          title: S.of(context).TitleDelete,
                          body: S.of(context).providerBody,
                          onPressed: () {
                            cubit.providerDelete(
                                cubit.providersModel!.data!.data![index].id!);
                          });
                    });
              } else {
                showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return PopUpMessage(
                          title: S.of(context).TitleDelete,
                          body: S.of(context).providerBody,
                          onPressed: () {
                            cubit.forcedDeletedProvider(cubit
                                .allDeletedProvidersModel!.data![index].id!);
                          });
                    });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Icon(
                IconBroken.delete,
                color: Colors.red,
                size: 24.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
