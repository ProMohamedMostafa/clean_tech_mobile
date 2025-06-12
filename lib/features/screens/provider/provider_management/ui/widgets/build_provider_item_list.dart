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
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/provider/provider_management/logic/cubit/provider_cubit.dart';

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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 4, 0),
                              child: Row(
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
                                  Text("Edit Provider",
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
                            ),
                            verticalSpace(10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Provider Name ",
                                style: TextStyles.font14BlackMedium,
                              ),
                            ),
                            verticalSpace(5),
                            Form(
                              key: cubit.formAddKey,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: CustomTextFormField(
                                    color: Colors.grey,
                                    controller: cubit.providerController
                                      ..text = cubit.providersModel!.data!
                                          .data![index].name!,
                                    onlyRead: false,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.length > 55) {
                                        return 'return "name is too long';
                                      } else if (value.length < 3) {
                                        return 'name is too short';
                                      }
                                      return null;
                                    }),
                              ),
                            ),
                            verticalSpace(25),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: DefaultElevatedButton(
                                        name: 'Edit',
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
                                                    return PopUpMeassage(
                                                        title: 'edit',
                                                        body: 'provider',
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
                                        height: 43.h,
                                        width: double.infinity),
                                  ),
                                  horizontalSpace(16),
                                  Expanded(
                                    child: DefaultElevatedButton(
                                        name: 'Cancel',
                                        textStyles:
                                            TextStyles.font16PrimSemiBold,
                                        onPressed: () {
                                          context.pop();
                                        },
                                        color: AppColor.fourthColor,
                                        height: 43.h,
                                        width: double.infinity),
                                  ),
                                ],
                              ),
                            ),
                            verticalSpace(5),
                          ],
                        ));
                  },
                );
              } else {
                showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return PopUpMeassage(
                          title: 'restore',
                          body: 'provider',
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
                      return PopUpMeassage(
                          title: 'delete',
                          body: 'provider',
                          onPressed: () {
                            cubit.providerDelete(
                                cubit.providersModel!.data!.data![index].id!);
                          });
                    });
              } else {
                showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return PopUpMeassage(
                          title: 'delete',
                          body: 'provider',
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
