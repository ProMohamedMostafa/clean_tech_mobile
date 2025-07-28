import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/floating_action_button/floating_action_button.dart';
import 'package:smart_cleaning_application/core/widgets/integration_buttons/integrations_buttons.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/provider/provider_management/logic/cubit/provider_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/provider/provider_management/ui/widgets/provider_details_list_build.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/provider/provider_management/ui/widgets/search_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ProviderBody extends StatelessWidget {
  const ProviderBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProviderCubit>();
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text(S.of(context).providers),
      ),
      floatingActionButton: floatingActionButton(
        icon: Icons.add,
        onPressed: () {
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
                                  borderRadius: BorderRadius.circular(2.r)),
                            ),
                            horizontalSpace(8),
                            Text(S.of(context).addProvider,
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
                              controller: cubit.providerController,
                              onlyRead: false,
                              hint: '',
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S
                                      .of(context)
                                      .providerRequiredValidation;
                                } else if (value.length > 55) {
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: DefaultElevatedButton(
                                  name: S.of(context).addButton,
                                  textStyles: TextStyles.font16WhiteSemiBold,
                                  onPressed: () {
                                    {
                                      if (cubit.formAddKey.currentState
                                              ?.validate() ??
                                          false) {
                                        cubit.addProvider();
                                        context.pop();
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
                                  textStyles: TextStyles.font16PrimSemiBold,
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
                    ),
                  ));
            },
          );
        },
      ),
      body: BlocConsumer<ProviderCubit, ProviderState>(
        listener: (context, state) {
          if (state is ProviderDeleteSuccessState) {
            toast(text: state.deleteProviderModel.message!, isSuccess: true);
            cubit.getAllDeletedProviders();
          }
          if (state is ProviderDeleteErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is RestoreProvidersSuccessState) {
            toast(text: state.message, isSuccess: true);
          }
          if (state is RestoreProvidersErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is ForceDeleteProvidersSuccessState) {
            toast(text: state.message, isSuccess: true);
            cubit.getProviders();
            cubit.getAllDeletedProviders();
          }
          if (state is ForceDeleteProvidersErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is AddProviderSuccessState) {
            toast(text: state.message, isSuccess: true);
            cubit.getProviders();
          }
          if (state is AddProviderErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is EditProviderSuccessState) {
            toast(text: state.message, isSuccess: true);
            cubit.getProviders();
          }

          if (state is EditProviderErrorState) {
            toast(text: state.error, isSuccess: false);
          }
        },
        builder: (context, state) {
          return Skeletonizer(
            enabled: (cubit.providersModel == null &&
                cubit.allDeletedProvidersModel == null),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(10),
                  SearchProviderWidget(),
                  integrationsButtons(
                    selectedIndex: cubit.selectedIndex,
                    onTap: (index) => cubit.changeTap(index),
                    firstCount: cubit.providersModel?.data?.totalCount ?? 0,
                    firstLabel: S.of(context).totalProviders,
                    secondCount:
                        cubit.allDeletedProvidersModel?.data?.length ?? 0,
                    secondLabel: S.of(context).deletedProviders,
                  ),
                  verticalSpace(10),
                  Divider(
                    color: Colors.grey[300],
                    height: 0,
                  ),
                  Expanded(child: ProviderDetailsList()),
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
