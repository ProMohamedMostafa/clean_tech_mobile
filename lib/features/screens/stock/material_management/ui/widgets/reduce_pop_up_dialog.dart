import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/logic/material_mangement_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ReducePopUpDialog {
  static Future<String?> show(
      {required BuildContext context, required int id}) async {
    return await showDialog(
      context: context,
      builder: (dialogContext) {
        final cubit = context.read<MaterialManagementCubit>();
        cubit.clearAllControllers();
        return Dialog(
          insetPadding: EdgeInsets.all(20),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8.w,
                        height: 24.h,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(2.r)),
                      ),
                      horizontalSpace(8),
                      Text(
                        S.of(context).reduceMaterial,
                        style: TextStyles.font18RedMedium,
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          size: 26.sp,
                        ),
                        onPressed: () => context.pop(),
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  Text(
                    S.of(context).quantity,
                    style: TextStyles.font16BlackRegular,
                  ),
                  verticalSpace(5),
                  CustomTextFormField(
                    onlyRead: false,
                    hint: S.of(context).writeQuantity,
                    controller: cubit.quantityController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).quantityRequired;
                      } else if (value.length > 20) {
                        return S.of(context).quantityTooLong;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      cubit.quantityIdController.text =
                          double.parse(value).toString();
                    },
                  ),
                  verticalSpace(10),
                  Text(
                    S.of(context).providerBody,
                    style: TextStyles.font16BlackRegular,
                  ),
                  verticalSpace(5),
                  CustomDropDownList(
                    hint: S.of(context).hintSelectProvider,
                    onPressed: (selectedValue) {
                      final selectedId = cubit.providersModel?.data?.data
                          ?.firstWhere(
                            (provider) => provider.name == selectedValue,
                          )
                          .id;
                      if (selectedId != null) {
                        cubit.providerIdController.text = selectedId.toString();
                      }
                    },
                    items: cubit.providerItem
                        .map((e) => e.name ?? 'Unknown')
                        .toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).providerRequiredValidation;
                      }
                      return null;
                    },
                    controller: cubit.providerController,
                    keyboardType: TextInputType.text,
                    suffixIcon: IconBroken.arrowDown2,
                  ),
                  verticalSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: DefaultElevatedButton(
                          name: S.of(context).reduceButton,
                          onPressed: () {
                            cubit.reduceMaterial(
                              materialId: id,
                            );
                            context.pop();
                          },
                          color: Colors.red,
                   
                          width: 125.w,
                          textStyles: TextStyles.font16WhiteSemiBold,
                        ),
                      ),
                      horizontalSpace(16),
                      Expanded(
                        child: DefaultElevatedButton(
                          name: S.of(context).cancelButton,
                          onPressed: () {
                            context.pop();
                          },
                          color: Color(0xffFFE3E4),
                     
                          width: 125.w,
                          textStyles: TextStyles.font16RedSemiBold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
