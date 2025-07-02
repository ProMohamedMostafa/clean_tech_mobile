import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/stock/add_material/logic/add_material_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/add_material/logic/add_material_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AddMaterialBody extends StatelessWidget {
  const AddMaterialBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddMaterialCubit>();
    return Scaffold(
        appBar: AppBar(
            title: Text(S.of(context).createMaterial),
            leading: CustomBackButton()),
        body: BlocConsumer<AddMaterialCubit, AddMaterialState>(
          listener: (context, state) {
            if (state is AddMaterialSuccessState) {
              toast(text: state.addMaterialModel.message!, color: Colors.blue);

              context.popWithTrueResult();
            }
            if (state is AddMaterialErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            if (cubit.categoryManagementModel == null) {
              return Loading();
            }
            return SingleChildScrollView(
                child: Form(
              key: cubit.formKey,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).materialName,
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomTextFormField(
                          onlyRead: false,
                          hint: S.of(context).enterMaterial,
                          controller: cubit.nameController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).materialNameRequired;
                            } else if (value.length > 55) {
                              return S.of(context).materialNameTooLong;
                            } else if (value.length < 3) {
                              return S.of(context).materialNameTooShort;
                            }
                            return null;
                          },
                        ),
                        verticalSpace(10),
                        Text(
                          S.of(context).category,
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: S.of(context).selectCategory,
                          items: cubit.categoryModel
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          onPressed: (value) {
                            final selectedCategory = cubit
                                .categoryManagementModel?.data?.categories
                                ?.firstWhere((category) =>
                                    category.name ==
                                    cubit.categoryController.text);

                            cubit.categoryIdController.text =
                                selectedCategory!.id.toString();
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller: cubit.categoryController,
                          isRead: false,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                        Text(
                          S.of(context).minimum,
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomTextFormField(
                          onlyRead: false,
                          hint: S.of(context).writeMinimum,
                          controller: cubit.miniController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).minimumRequired;
                            } else if (value.length > 20) {
                              return S.of(context).minimumTooLong;
                            }
                            return null;
                          },
                        ),
                        verticalSpace(10),
                        Text(
                          S.of(context).description,
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomDescriptionTextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S
                                    .of(context)
                                    .materialDescriptionRequired;
                              } else if (value.length < 3) {
                                return S
                                    .of(context)
                                    .materialDescriptionTooShort;
                              }
                              return null;
                            },
                            controller: cubit.descriptionController,
                            hint: S.of(context).descriptionHint),
                        verticalSpace(20),
                        state is AddMaterialLoadingState
                            ? Loading()
                            : Center(
                                child: DefaultElevatedButton(
                                    name: S.of(context).createButton,
                                    onPressed: () {
                                      if (cubit.formKey.currentState!
                                          .validate()) {
                                        cubit.addMaterial();
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
            ));
          },
        ));
  }
}
