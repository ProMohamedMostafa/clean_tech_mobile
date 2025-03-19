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
import 'package:smart_cleaning_application/features/screens/stock/edit_material/logic/edit_material_state.dart';
import 'package:smart_cleaning_application/features/screens/stock/edit_material/logic/edit_material_cubit.dart';

class EditMaterialBody extends StatefulWidget {
  final int id;
  const EditMaterialBody({super.key, required this.id});

  @override
  State<EditMaterialBody> createState() => _EditMaterialBodyState();
}

class _EditMaterialBodyState extends State<EditMaterialBody> {
  int? categoryId;

  @override
  void initState() {
    context.read<EditMaterialCubit>().getMaterialDetails(widget.id);
    context.read<EditMaterialCubit>().getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Material",
            style: TextStyles.font16BlackSemiBold,
          ),
          centerTitle: true,
          leading: customBackButton(context),
        ),
        body: BlocConsumer<EditMaterialCubit, EditMaterialState>(
          listener: (context, state) {
            if (state is EditMaterialSuccessState) {
              toast(text: state.editMaterialModel.message!, color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.materialScreen);
            }
            if (state is EditMaterialErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            if (context.read<EditMaterialCubit>().materialDetailsModel ==
                    null ||
                context.read<EditMaterialCubit>().categoryManagementModel ==
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
              key: context.read<EditMaterialCubit>().formKey,
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
                          hint: context
                              .read<EditMaterialCubit>()
                              .materialDetailsModel!
                              .data!
                              .name!,
                          controller:
                              context.read<EditMaterialCubit>().nameController
                                ..text = context
                                    .read<EditMaterialCubit>()
                                    .materialDetailsModel!
                                    .data!
                                    .name!,
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
                          hint: context
                              .read<EditMaterialCubit>()
                              .materialDetailsModel!
                              .data!
                              .categoryName!,
                          items: context
                                      .read<EditMaterialCubit>()
                                      .categoryManagementModel
                                      ?.data
                                      .categories
                                      .isEmpty ??
                                  true
                              ? ['No category']
                              : context
                                      .read<EditMaterialCubit>()
                                      .categoryManagementModel
                                      ?.data
                                      .categories
                                      .map((e) => e.name)
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedCategory = context
                                .read<EditMaterialCubit>()
                                .categoryManagementModel
                                ?.data
                                .categories
                                .firstWhere((category) =>
                                    category.name ==
                                    context
                                        .read<EditMaterialCubit>()
                                        .categoryController
                                        .text);

                            categoryId = selectedCategory!.id;
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller: context
                              .read<EditMaterialCubit>()
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
                          hint: context
                              .read<EditMaterialCubit>()
                              .materialDetailsModel!
                              .data!
                              .minThreshold
                              .toString(),
                          controller:
                              context.read<EditMaterialCubit>().miniController
                                ..text = context
                                    .read<EditMaterialCubit>()
                                    .materialDetailsModel!
                                    .data!
                                    .minThreshold
                                    .toString(),
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
                                .read<EditMaterialCubit>()
                                .descriptionController
                              ..text = context
                                  .read<EditMaterialCubit>()
                                  .materialDetailsModel!
                                  .data!
                                  .description!,
                            hint: context
                                    .read<EditMaterialCubit>()
                                    .materialDetailsModel!
                                    .data!
                                    .categoryName ??
                                "description..."),
                        verticalSpace(20),
                        state is EditMaterialLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: AppColor.primaryColor),
                              )
                            : Center(
                                child: DefaultElevatedButton(
                                    name: "Edit",
                                    onPressed: () {
                                      if (context
                                          .read<EditMaterialCubit>()
                                          .formKey
                                          .currentState!
                                          .validate()) {
                                        context
                                            .read<EditMaterialCubit>()
                                            .editMaterial(
                                              widget.id,
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
