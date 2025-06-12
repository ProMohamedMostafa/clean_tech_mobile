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
import 'package:smart_cleaning_application/core/widgets/two_buttons_in_integreat_screen/two_buttons_in_integration_screen.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/provider/provider_management/logic/cubit/provider_cubit.dart';
import 'package:smart_cleaning_application/features/screens/provider/provider_management/ui/widgets/provider_details_list_build.dart';
import 'package:smart_cleaning_application/features/screens/provider/provider_management/ui/widgets/search_build.dart';

class ProviderBody extends StatelessWidget {
  const ProviderBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProviderCubit>();
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text('Provider'),
      ),
      floatingActionButton: floatingActionButton(
        icon: Icons.add_location_outlined,
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
                                  borderRadius: BorderRadius.circular(2.r)),
                            ),
                            horizontalSpace(8),
                            Text("Add Provider",
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
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Provider Name ",
                          style: TextStyles.font14BlackMedium,
                        ),
                      ),
                      verticalSpace(5),
                      Form(
                        key: cubit.formAddKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CustomTextFormField(
                              color: Colors.grey,
                              controller: cubit.providerController,
                              onlyRead: false,
                              hint: '',
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Provider is required';
                                } else if (value.length > 55) {
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: DefaultElevatedButton(
                                  name: 'Add',
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
                                  height: 43.h,
                                  width: double.infinity),
                            ),
                            horizontalSpace(16),
                            Expanded(
                              child: DefaultElevatedButton(
                                  name: 'Cancel',
                                  textStyles: TextStyles.font16PrimSemiBold,
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
        },
      ),
      body: BlocConsumer<ProviderCubit, ProviderState>(
        listener: (context, state) {
          if (state is ProviderDeleteSuccessState) {
            toast(text: state.deleteProviderModel.message!, color: Colors.blue);
            cubit.getAllDeletedProviders();
          }
          if (state is AllDeletedProvidersErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is RestoreProvidersSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }
          if (state is RestoreProvidersErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is ForceDeleteProvidersSuccessState) {
            toast(text: state.message, color: Colors.blue);
            cubit.getProviders();
            cubit.getAllDeletedProviders();
          }
          if (state is AddProviderSuccessState) {
            toast(text: state.message, color: Colors.blue);
            cubit.getProviders();
          }
          if (state is EditProviderSuccessState) {
            toast(text: state.message, color: Colors.blue);
            cubit.getProviders();
          }
          if (state is AddProviderErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is EditProviderErrorState) {
            toast(text: state.error, color: Colors.red);
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
                  twoButtonsIntegration(
                    selectedIndex: cubit.selectedIndex,
                    onTap: (index) => cubit.changeTap(index),
                    firstCount: cubit.providersModel?.data?.totalCount ?? 0,
                    firstLabel: 'Total providers',
                    secondCount:
                        cubit.allDeletedProvidersModel?.data?.length ?? 0,
                    secondLabel: 'deleted providers',
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
