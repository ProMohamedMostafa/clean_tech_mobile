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

class ReducePopUpDialog {
  static Future<String?> show(
      {required BuildContext context, required int id}) async {
    return await showDialog(
      context: context,
      builder: (dialogContext) {
        int? providerId;
        double? quantityId;
        return Dialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            insetPadding: EdgeInsets.all(20),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.r)),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                        onChanged: (value) {
                          quantityId = double.parse(value);
                        },
                      ),
                      verticalSpace(10),
                      Text(
                        'Provider',
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
                              ?.providers
                              ?.firstWhere(
                                (provider) => provider.name == selectedValue,
                              )
                              .id;

                          if (selectedId != null) {
                            providerId = selectedId;
                          }
                        },
                        items: context
                                    .read<MaterialManagementCubit>()
                                    .providersModel
                                    ?.data
                                    ?.providers
                                    ?.isEmpty ??
                                true
                            ? ['No Providers available']
                            : context
                                    .read<MaterialManagementCubit>()
                                    .providersModel
                                    ?.data
                                    ?.providers
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "provider is Required";
                          }
                          return null;
                        },
                        controller: context
                            .read<MaterialManagementCubit>()
                            .providerController,
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          DefaultElevatedButton(
                            name: "Add",
                            onPressed: () {
                              if (providerId != null && quantityId != null) {
                                context
                                    .read<MaterialManagementCubit>()
                                    .reduceMaterial(
                                      materialId: id,
                                      providerId: providerId,
                                      quantityId: quantityId,
                                    );
                                context.pop();
                              }
                            },
                            color: AppColor.primaryColor,
                            height: 47.h,
                            width: 125.w,
                            textStyles: TextStyles.font16WhiteSemiBold,
                          ),
                          DefaultElevatedButton(
                            name: "Cancel",
                            onPressed: () {
                              context.pop();
                            },
                            color: AppColor.secondaryColor,
                            height: 47.h,
                            width: 125.w,
                            textStyles: TextStyles.font16WhiteSemiBold,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
