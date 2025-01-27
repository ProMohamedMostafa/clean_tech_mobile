import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/logic/add_user_cubit.dart';

class AddProviderBottomDialog {
  void showBottomDialog(BuildContext context, AddUserCubit cubit) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: true,
      barrierColor: Colors.black12,
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: _buildDialogContent(context, cubit),
        );
      },
      transitionBuilder: (_, animation1, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation1),
          child: child,
        );
      },
    );
  }

  Widget _buildDialogContent(BuildContext context, AddUserCubit cubit) {
    return Container(
      width: double.maxFinite,
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: cubit.formAddKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildContinueText(),
                  verticalSpace(8),
                  _buildAddField(context, cubit),
                  verticalSpace(8),
                  _buildDeleteField(context, cubit),
                  verticalSpace(8),
                  _buildRestoreField(context, cubit),
                  verticalSpace(16),
                  _buildContinueButton(context, cubit),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueText() {
    return Text(
      'Provider settings',
      style: TextStyles.font20PrimsemiBold,
    );
  }

  Widget _buildAddField(BuildContext context, AddUserCubit cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: CustomTextFormField(
              controller: cubit.providerController,
              onlyRead: false,
              hint: '',
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Provider is required";
                }
                return null;
              },
            ),
          ),
          horizontalSpace(10),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                if (cubit.formAddKey.currentState?.validate() ?? false) {
                  cubit.addProvider();
                  Navigator.of(context, rootNavigator: true).pop();
                }
              },
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 25.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteField(BuildContext context, AddUserCubit cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: CustomDropDownList(
              hint: 'Delete provider',
              onPressed: (selectedValue) {
                final selectedId = cubit.providersModel?.data?.data
                    ?.firstWhere(
                      (provider) => provider.name == selectedValue,
                    )
                    .id
                    ?.toString();

                if (selectedId != null) {
                  cubit.providerIdController.text = selectedId;
                }
              },
              items: cubit.providersModel?.data?.data?.isEmpty ?? true
                  ? ['No Providers available']
                  : cubit.providersModel?.data?.data
                          ?.map((e) => e.name ?? 'Unknown')
                          .toList() ??
                      [],
              controller: cubit.deletedProviderController,
              keyboardType: TextInputType.text,
              suffixIcon: IconBroken.arrowDown2,
            ),
          ),
          horizontalSpace(10),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                if (cubit.providerIdController.text.isNotEmpty) {
                  cubit.deleteProvider(cubit.providerIdController.text);
                  Navigator.of(context, rootNavigator: true).pop();
                }
              },
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  IconBroken.delete,
                  color: Colors.white,
                  size: 25.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestoreField(BuildContext context, AddUserCubit cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: CustomDropDownList(
              hint: 'Restore provider',
              onPressed: (selectedValue) {
                final selectedId = cubit.allDeletedProvidersModel?.data
                    ?.firstWhere(
                      (provider) => provider.name == selectedValue,
                    )
                    .id
                    ?.toString();

                if (selectedId != null) {
                  cubit.providerIdController.text = selectedId;
                }
              },
              items: cubit.allDeletedProvidersModel?.data?.isEmpty ?? true
                  ? ['No Providers available']
                  : cubit.allDeletedProvidersModel?.data
                          ?.map((e) => e.name ?? 'Unknown')
                          .toList() ??
                      [],
              controller: cubit.restoreProviderController,
              keyboardType: TextInputType.text,
              suffixIcon: IconBroken.arrowDown2,
            ),
          ),
          horizontalSpace(10),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                if (cubit.providerIdController.text.isNotEmpty) {
                  cubit.restoreDeletedProvider(cubit.providerIdController.text);
                  Navigator.of(context, rootNavigator: true).pop();
                }
              },
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.replay_outlined,
                  color: Colors.white,
                  size: 25.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context, AddUserCubit cubit) {
    return DefaultElevatedButton(
      name: "Close",
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
      color: AppColor.primaryColor,
      height: 45,
      width: 150,
      textStyles: TextStyles.font20Whitesemimedium,
    );
  }
}
