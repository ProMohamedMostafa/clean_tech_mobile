import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/stock/edit_category/logic/edit_category_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/edit_category/logic/edit_category_state.dart';

class EditCategoryBody extends StatefulWidget {
  final int id;
  const EditCategoryBody({super.key, required this.id});

  @override
  State<EditCategoryBody> createState() => _EditCategoryBodyState();
}

class _EditCategoryBodyState extends State<EditCategoryBody> {
  int? unit;
  int? parentCategory;
  @override
  void initState() {
    context.read<EditCategoryCubit>().getCategoryDetails(widget.id);
    context.read<EditCategoryCubit>().getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Category",
            style: TextStyles.font16BlackSemiBold,
          ),
          centerTitle: true,
          leading: customBackButton(context),
        ),
        body: BlocConsumer<EditCategoryCubit, EditCategoryState>(
          listener: (context, state) {
            if (state is EditCategorySuccessState) {
              toast(text: state.editCategoryModel.message!, color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.categoryScreen);
            }
            if (state is EditCategoryErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            if (context.read<EditCategoryCubit>().categoryDetailsModel ==
                    null ||
                context.read<EditCategoryCubit>().categoryManagementModel ==
                    null) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              );
            }
            return SafeArea(
                child: SingleChildScrollView(
                    child: Form(
              key: context.read<EditCategoryCubit>().formKey,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Category Name",
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomTextFormField(
                          onlyRead: false,
                          hint: context
                              .read<EditCategoryCubit>()
                              .categoryDetailsModel!
                              .data!
                              .name!,
                          controller:
                              context.read<EditCategoryCubit>().nameController
                                ..text = context
                                    .read<EditCategoryCubit>()
                                    .categoryDetailsModel!
                                    .data!
                                    .name!,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Category Name is Required";
                            } else if (value.length > 55) {
                              return 'Category name too long';
                            } else if (value.length < 3) {
                              return 'Category name too short';
                            }
                            return null;
                          },
                        ),
                        verticalSpace(10),
                        Text(
                          'Unit',
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          onPressed: (selectedValue) {
                            final items = [
                              'Ml',
                              'L',
                              'Kg',
                              'G',
                              'M',
                              'Cm',
                              'Pieces'
                            ];
                            final selectedIndex = items.indexOf(selectedValue);
                            if (selectedIndex != -1) {
                              unit = selectedIndex;
                            }
                          },
                          hint: context
                              .read<EditCategoryCubit>()
                              .categoryDetailsModel!
                              .data!
                              .unit!,
                          items: ['Ml', 'L', 'Kg', 'G', 'M', 'Cm', 'Pieces'],
                          controller:
                              context.read<EditCategoryCubit>().unitController,
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                        verticalSpace(10),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Parent Category',
                                style: TextStyles.font16BlackRegular,
                              ),
                              TextSpan(
                                text: ' (Optional)',
                                style: TextStyles.font14GreyRegular,
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: context
                                  .read<EditCategoryCubit>()
                                  .categoryDetailsModel
                                  ?.data
                                  ?.parentCategoryName ??
                              '',
                          items: (context
                                          .read<EditCategoryCubit>()
                                          .categoryManagementModel
                                          ?.data
                                          ?.categories ??
                                      [])
                                  .where((e) => e.id != widget.id)
                                  .map((e) => e.name)
                                  .toList()
                                  .isEmpty
                              ? ['No category']
                              : (context
                                          .read<EditCategoryCubit>()
                                          .categoryManagementModel
                                          ?.data
                                          ?.categories ??
                                      [])
                                  .where((e) => e.id != widget.id)
                                  .map((e) => e.name!)
                                  .toList(),
                          onPressed: (value) {
                            final selectedCategory = context
                                .read<EditCategoryCubit>()
                                .categoryManagementModel
                                ?.data
                                ?.categories
                                ?.firstWhere(
                                  (category) =>
                                      category.name ==
                                      context
                                          .read<EditCategoryCubit>()
                                          .parentCategoryController
                                          .text,
                                );

                            if (selectedCategory != null) {
                              parentCategory = selectedCategory.id;
                            }
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller: context
                              .read<EditCategoryCubit>()
                              .parentCategoryController,
                          isRead: false,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(20),
                        state is EditCategoryLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: AppColor.primaryColor),
                              )
                            : Center(
                                child: DefaultElevatedButton(
                                    name: "Edit",
                                    onPressed: () {
                                      if (context
                                          .read<EditCategoryCubit>()
                                          .formKey
                                          .currentState!
                                          .validate()) {
                                        context
                                            .read<EditCategoryCubit>()
                                            .editCategory(widget.id, unit,
                                                parentCategory);
                                      }
                                    },
                                    color: AppColor.primaryColor,
                                    height: 47,
                                    width: double.infinity,
                                    textStyles:
                                        TextStyles.font20Whitesemimedium),
                              ),
                        verticalSpace(30),
                      ])),
            )));
          },
        ));
  }
}
