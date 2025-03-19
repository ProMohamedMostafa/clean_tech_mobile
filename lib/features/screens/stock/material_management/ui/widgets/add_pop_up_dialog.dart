import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/logic/material_mangement_cubit.dart';

class AddPopUpDialog {
  static Future<String?> show(
      {required BuildContext context, required int id}) async {
    return await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          insetPadding: const EdgeInsets.all(20),
          contentPadding: const EdgeInsets.all(20),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quantity',
                  style: TextStyles.font16BlackRegular,
                ),
                verticalSpace(5),
                CustomTextFormField(
                  onlyRead: false,
                  hint: "Write Number",
                  controller: context
                      .read<MaterialManagementCubit>()
                      .quantityController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "quantity is Required";
                    } else if (value.length > 20) {
                      return 'quantity is too long';
                    }
                    return null;
                  },
                ),
                verticalSpace(10),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Price',
                        style: TextStyles.font16BlackRegular,
                      ),
                      TextSpan(
                        text: ' (unit)',
                        style: TextStyles.font14GreyRegular,
                      ),
                    ],
                  ),
                ),
                verticalSpace(5),
                CustomTextFormField(
                  onlyRead: false,
                  hint: "Write Number",
                  controller:
                      context.read<MaterialManagementCubit>().priceController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Price is Required";
                    } else if (value.length > 20) {
                      return 'Price is too long';
                    }
                    return null;
                  },
                ),
                verticalSpace(10),
                Text(
                  'provider',
                  style: TextStyles.font16BlackRegular,
                ),
                verticalSpace(5),
                CustomDropDownList(
                  hint: 'Select provider',
                  onPressed: (selectedValue) {
                    final selectedId = context
                        .read<MaterialManagementCubit>()
                        .providersModel
                        ?.data
                        ?.data
                        ?.firstWhere(
                          (provider) => provider.name == selectedValue,
                        )
                        .id
                        ?.toString();

                    if (selectedId != null) {
                      context
                          .read<MaterialManagementCubit>()
                          .providerIdController
                          .text = selectedId;
                    }
                  },
                  items: context
                              .read<MaterialManagementCubit>()
                              .providersModel
                              ?.data
                              ?.data
                              ?.isEmpty ??
                          true
                      ? ['No Providers available']
                      : context
                              .read<MaterialManagementCubit>()
                              .providersModel
                              ?.data
                              ?.data
                              ?.map((e) => e.name ?? 'Unknown')
                              .toList() ??
                          [],
                  controller: context
                      .read<MaterialManagementCubit>()
                      .providerController,
                  keyboardType: TextInputType.text,
                  suffixIcon: IconBroken.arrowDown2,
                ),
                verticalSpace(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultElevatedButton(
                      name: "Add",
                      onPressed: () {
                        // context
                        //     .read<MaterialManagementCubit>()
                        //     .changeTaskStatus(widget.id, 2);
                      },
                      color: AppColor.primaryColor,
                      height: 47.h,
                      width: 105.w,
                      textStyles: TextStyles.font16WhiteSemiBold,
                    ),
                    DefaultElevatedButton(
                      name: "Cancel",
                      onPressed: () {
                        context.pop();
                      },
                      color: AppColor.secondaryColor,
                      height: 47.h,
                      width: 105.w,
                      textStyles: TextStyles.font16WhiteSemiBold,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
