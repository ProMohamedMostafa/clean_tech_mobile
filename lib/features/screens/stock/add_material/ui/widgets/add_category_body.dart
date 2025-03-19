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
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/stock/add_material/logic/add_material_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/add_material/logic/add_material_state.dart';

class AddMaterialBody extends StatefulWidget {
  const AddMaterialBody({super.key});

  @override
  State<AddMaterialBody> createState() => _AddMaterialBodyState();
}

class _AddMaterialBodyState extends State<AddMaterialBody> {
  int? categoryId;

  @override
  void initState() {
    context.read<AddMaterialCubit>().getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Create Material",
            style: TextStyles.font16BlackSemiBold,
          ),
          centerTitle: true,
          leading: customBackButton(context),
        ),
        body: BlocConsumer<AddMaterialCubit, AddMaterialState>(
          listener: (context, state) {
            if (state is AddMaterialSuccessState) {
              toast(text: state.addMaterialModel.message!, color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.materialScreen);
            }
            if (state is AddMaterialErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            if (context.read<AddMaterialCubit>().categoryManagementModel ==
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
              key: context.read<AddMaterialCubit>().formKey,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Material Name",
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomTextFormField(
                          onlyRead: false,
                          hint: "Enter Material",
                          controller:
                              context.read<AddMaterialCubit>().nameController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Material Name is Required";
                            } else if (value.length > 55) {
                              return 'Material name too long';
                            } else if (value.length < 3) {
                              return 'Material name too short';
                            }
                            return null;
                          },
                        ),
                        verticalSpace(10),
                        Text(
                          'Category',
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: "Select category",
                          items: context
                                      .read<AddMaterialCubit>()
                                      .categoryManagementModel
                                      ?.data
                                      .categories
                                      .isEmpty ??
                                  true
                              ? ['No category']
                              : context
                                      .read<AddMaterialCubit>()
                                      .categoryManagementModel
                                      ?.data
                                      .categories
                                      .map((e) => e.name)
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedCategory = context
                                .read<AddMaterialCubit>()
                                .categoryManagementModel
                                ?.data
                                .categories
                                .firstWhere((category) =>
                                    category.name ==
                                    context
                                        .read<AddMaterialCubit>()
                                        .categoryController
                                        .text);

                            categoryId = selectedCategory!.id;
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller: context
                              .read<AddMaterialCubit>()
                              .categoryController,
                          isRead: false,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                        Text(
                          'Minimum',
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomTextFormField(
                          onlyRead: false,
                          hint: "Write Number",
                          controller:
                              context.read<AddMaterialCubit>().miniController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Minimum is Required";
                            } else if (value.length > 20) {
                              return 'Minimum is too long';
                            }
                            return null;
                          },
                        ),
                        verticalSpace(10),
                        Text(
                          'Description',
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomDescriptionTextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "material description is Required";
                              } else if (value.length < 3) {
                                return 'material description too short';
                              }
                              return null;
                            },
                            controller: context
                                .read<AddMaterialCubit>()
                                .descriptionController,
                            hint: "description..."),
                        verticalSpace(20),
                        state is AddMaterialLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: AppColor.primaryColor),
                              )
                            : Center(
                                child: DefaultElevatedButton(
                                    name: "Create",
                                    onPressed: () {
                                      if (context
                                          .read<AddMaterialCubit>()
                                          .formKey
                                          .currentState!
                                          .validate()) {
                                        context
                                            .read<AddMaterialCubit>()
                                            .addMaterial(
                                              categoryId,
                                            );
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
