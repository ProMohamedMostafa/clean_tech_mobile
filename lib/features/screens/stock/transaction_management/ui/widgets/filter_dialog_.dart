import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/filter_top_widget/filter_top_widget.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_date_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/logic/transaction_mangement_cubit.dart';

class CustomFilterMaterialDialog {
  static Future<String?> show({
    required BuildContext context,
  }) async {
    return await showDialog(
      context: context,
      builder: (dialogContext) {
        int? categoryId;
        int? providerId;
        int? userId;
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
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [                      buildHeader(context),

                      Text(
                        'User',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: 'Select user',
                        onPressed: (selectedValue) {
                          final selectedId = context
                              .read<TransactionManagementCubit>()
                              .usersModel
                              ?.data
                              ?.users
                              ?.firstWhere(
                                (user) => user.userName == selectedValue,
                              )
                              .id
                              ?.toString();

                          if (selectedId != null) {
                            context
                                .read<TransactionManagementCubit>()
                                .userIdController
                                .text = selectedId;
                          }
                        },
                        items: context
                                    .read<TransactionManagementCubit>()
                                    .usersModel
                                    ?.data
                                    ?.users
                                    ?.isEmpty ??
                                true
                            ? ['No users available']
                            : context
                                    .read<TransactionManagementCubit>()
                                    .usersModel
                                    ?.data
                                    ?.users
                                    ?.map((e) => e.userName ?? 'Unknown')
                                    .toList() ??
                                [],
                        controller: context
                            .read<TransactionManagementCubit>()
                            .userController,
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(10),
                      Text(
                        'Category',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: "Select category",
                        items: context
                                    .read<TransactionManagementCubit>()
                                    .categoryManagementModel
                                    ?.data
                                    .categories
                                    .isEmpty ??
                                true
                            ? ['No category']
                            : context
                                    .read<TransactionManagementCubit>()
                                    .categoryManagementModel
                                    ?.data
                                    .categories
                                    .map((e) => e.name)
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedCategory = context
                              .read<TransactionManagementCubit>()
                              .categoryManagementModel
                              ?.data
                              .categories
                              .firstWhere((category) =>
                                  category.name ==
                                  context
                                      .read<TransactionManagementCubit>()
                                      .categoryController
                                      .text);

                          categoryId = selectedCategory!.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<TransactionManagementCubit>()
                            .categoryController,
                        isRead: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        'Provider',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: 'Select provider',
                        onPressed: (selectedValue) {
                          final selectedId = context
                              .read<TransactionManagementCubit>()
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
                                .read<TransactionManagementCubit>()
                                .providerIdController
                                .text = selectedId;
                          }
                        },
                        items: context
                                    .read<TransactionManagementCubit>()
                                    .providersModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No Providers available']
                            : context
                                    .read<TransactionManagementCubit>()
                                    .providersModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        controller: context
                            .read<TransactionManagementCubit>()
                            .providerController,
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Start Date",
                                style: TextStyles.font16BlackRegular,
                              ),
                              CustomTextFormField(
                                onlyRead: true,
                                hint: "--/--/---",
                                controller: context
                                    .read<TransactionManagementCubit>()
                                    .startDateController,
                                suffixIcon: Icons.calendar_today,
                                suffixPressed: () async {
                                  final selectedDate =
                                      await CustomDatePicker.show(
                                          context: context);

                                  if (selectedDate != null && context.mounted) {
                                    context
                                        .read<TransactionManagementCubit>()
                                        .startDateController
                                        .text = selectedDate;
                                  }
                                },
                                keyboardType: TextInputType.none,
                              ),
                            ],
                          )),
                          horizontalSpace(10),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "End Date",
                                style: TextStyles.font16BlackRegular,
                              ),
                              CustomTextFormField(
                                onlyRead: true,
                                hint: "--/--/---",
                                controller: context
                                    .read<TransactionManagementCubit>()
                                    .endDateController,
                                suffixIcon: Icons.calendar_today,
                                suffixPressed: () async {
                                  final selectedDate =
                                      await CustomDatePicker.show(
                                          context: context);

                                  if (selectedDate != null && context.mounted) {
                                    context
                                        .read<TransactionManagementCubit>()
                                        .endDateController
                                        .text = selectedDate;
                                  }
                                },
                                keyboardType: TextInputType.none,
                              ),
                            ],
                          )),
                        ],
                      ),
                      verticalSpace(20),
                      Center(
                        child: DefaultElevatedButton(
                            name: 'Done',
                            onPressed: () {
                             
                              context
                                  .read<TransactionManagementCubit>()
                                  .getTransactionList(
                                    userId: userId,
                                    categoryId: categoryId,
                                    providerId: providerId,
                                  );
                              context.pop();
                            },
                            color: AppColor.primaryColor,
                            height: 47,
                            width: double.infinity,
                            textStyles: TextStyles.font20Whitesemimedium),
                      ),
                      verticalSpace(10),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
