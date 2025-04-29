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
import 'package:smart_cleaning_application/features/screens/stock/add_category/logic/add_category_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/add_category/logic/add_category_state.dart';

class AddCategoryBody extends StatefulWidget {
  const AddCategoryBody({super.key});

  @override
  State<AddCategoryBody> createState() => _AddCategoryBodyState();
}

class _AddCategoryBodyState extends State<AddCategoryBody> {
  int? unit;
  int? parentCategoryId;
  @override
  void initState() {
    context.read<AddCategoryCubit>().getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Create Category",
            style: TextStyles.font16BlackSemiBold,
          ),
          centerTitle: true,
          leading: customBackButton(context),
        ),
        body: BlocConsumer<AddCategoryCubit, AddCategoryState>(
          listener: (context, state) {
            if (state is AddCategorySuccessState) {
              toast(text: state.addCategoryModel.message!, color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.categoryScreen);
            }
            if (state is AddCategoryErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            if (context.read<AddCategoryCubit>().categoryManagementModel ==
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
              key: context.read<AddCategoryCubit>().formKey,
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
                          hint: "Enter Category",
                          controller:
                              context.read<AddCategoryCubit>().nameController,
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
                          hint: 'Select',
                          items: ['Ml', 'L', 'Kg', 'G', 'M', 'Cm', 'Pieces'],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Unit is Required";
                            }
                            return null;
                          },
                          controller:
                              context.read<AddCategoryCubit>().unitController,
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
                        verticalSpace(10),
                        CustomDropDownList(
                          hint: "Select category",
                          items: context
                                      .read<AddCategoryCubit>()
                                      .categoryManagementModel
                                      ?.data!
                                      .categories!
                                      .isEmpty ??
                                  true
                              ? ['No category']
                              : context
                                      .read<AddCategoryCubit>()
                                      .categoryManagementModel
                                      ?.data
                                      ?.categories!
                                      .map((e) => e.name!)
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedCategory = context
                                .read<AddCategoryCubit>()
                                .categoryManagementModel
                                ?.data!
                                .categories!
                                .firstWhere((category) =>
                                    category.name ==
                                    context
                                        .read<AddCategoryCubit>()
                                        .parentCategoryController
                                        .text);

                            parentCategoryId = selectedCategory!.id;
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller: context
                              .read<AddCategoryCubit>()
                              .parentCategoryController,
                          isRead: false,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(20),
                        state is AddCategoryLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: AppColor.primaryColor),
                              )
                            : Center(
                                child: DefaultElevatedButton(
                                    name: "Create",
                                    onPressed: () {
                                      if (context
                                          .read<AddCategoryCubit>()
                                          .formKey
                                          .currentState!
                                          .validate()) {
                                        context
                                            .read<AddCategoryCubit>()
                                            .addCategory(
                                                unit, parentCategoryId);
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
