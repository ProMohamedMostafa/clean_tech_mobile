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
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/stock/add_category/logic/add_category_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/add_category/logic/add_category_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AddCategoryBody extends StatelessWidget {
  const AddCategoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddCategoryCubit>();
    return Scaffold(
        appBar: AppBar(
            title: Text(S.of(context).createCategory),
            leading: CustomBackButton()),
        body: BlocConsumer<AddCategoryCubit, AddCategoryState>(
          listener: (context, state) {
            if (state is AddCategorySuccessState) {
              toast(text: state.addCategoryModel.message!, color: Colors.blue);
              context.pushNamedAndRemoveAllExceptFirst(Routes.categoryScreen);
            }
            if (state is AddCategoryErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            if (cubit.categoryManagementModel == null) {
              return Loading();
            }
            return SafeArea(
                child: SingleChildScrollView(
                    child: Form(
              key: cubit.formKey,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).categoryName,
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomTextFormField(
                          onlyRead: false,
                          hint: S.of(context).enterCategory,
                          controller: cubit.nameController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).categoryNameRequired;
                            } else if (value.length > 55) {
                              return S.of(context).categoryNameTooLong;
                            } else if (value.length < 3) {
                              return S.of(context).categoryNameTooShort;
                            }
                            return null;
                          },
                        ),
                        verticalSpace(10),
                        Text(
                          S.of(context).unitTitle,
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          onPressed: (selectedValue) {
                            final items = [
                              S.of(context).ml,
                              S.of(context).l,
                              S.of(context).kg,
                              S.of(context).g,
                              S.of(context).m,
                              S.of(context).cm,
                              S.of(context).pieces
                            ];
                            final selectedIndex = items.indexOf(selectedValue);
                            if (selectedIndex != -1) {
                              cubit.unitIdController.text =
                                  selectedIndex.toString();
                            }
                          },
                          hint: S.of(context).selectUnit,
                          items: [
                            S.of(context).ml,
                            S.of(context).l,
                            S.of(context).kg,
                            S.of(context).g,
                            S.of(context).m,
                            S.of(context).cm,
                            S.of(context).pieces
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).unitRequired;
                            }
                            return null;
                          },
                          controller: cubit.unitController,
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                        verticalSpace(10),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: S.of(context).parentCategory,
                                style: TextStyles.font16BlackRegular,
                              ),
                              TextSpan(
                                text: S.of(context).labelOptional,
                                style: TextStyles.font14GreyRegular,
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(10),
                        CustomDropDownList(
                          hint: S.of(context).selectCategory,
                          items: cubit.categoryModel
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          onPressed: (value) {
                            final selectedCategory = cubit
                                .categoryManagementModel?.data!.categories!
                                .firstWhere((category) =>
                                    category.name ==
                                    cubit.parentCategoryController.text);

                            cubit.parentCategoryIdController.text =
                                selectedCategory!.id.toString();
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller: cubit.parentCategoryController,
                          isRead: false,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(20),
                        state is AddCategoryLoadingState
                            ? Loading()
                            : Center(
                                child: DefaultElevatedButton(
                                    name: S.of(context).createButton,
                                    onPressed: () {
                                      if (cubit.formKey.currentState!
                                          .validate()) {
                                        cubit.addCategory();
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
