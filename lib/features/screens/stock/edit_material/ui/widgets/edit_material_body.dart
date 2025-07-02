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
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/stock/edit_material/logic/edit_material_state.dart';
import 'package:smart_cleaning_application/features/screens/stock/edit_material/logic/edit_material_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EditMaterialBody extends StatelessWidget {
  final int id;
  const EditMaterialBody({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditMaterialCubit>();
    return Scaffold(
        appBar: AppBar(
            title: Text(S.of(context).editMaterial),
            leading: CustomBackButton()),
        body: BlocConsumer<EditMaterialCubit, EditMaterialState>(
          listener: (context, state) {
            if (state is EditMaterialSuccessState) {
              toast(text: state.editMaterialModel.message!, color: Colors.blue);
              context.popWithTrueResult();
            }
            if (state is EditMaterialErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            if (cubit.materialDetailsModel == null ||
                cubit.categoryManagementModel == null) {
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
                          hint: cubit.materialDetailsModel!.data!.name!,
                          controller: cubit.nameController
                            ..text = cubit.materialDetailsModel!.data!.name!,
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
                          hint: cubit.materialDetailsModel!.data!.categoryName!,
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
                          hint: cubit.materialDetailsModel!.data!.minThreshold
                              .toString(),
                          controller: cubit.miniController
                            ..text = cubit
                                .materialDetailsModel!.data!.minThreshold
                                .toString(),
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
                            controller: cubit.descriptionController
                              ..text = cubit
                                  .materialDetailsModel!.data!.description!,
                            hint: cubit
                                    .materialDetailsModel!.data!.categoryName ??
                                S.of(context).descriptionHint),
                        verticalSpace(20),
                        state is EditMaterialLoadingState
                            ? Loading()
                            : Center(
                                child: DefaultElevatedButton(
                                    name: S.of(context).editButton,
                                    onPressed: () {
                                      if (cubit.formKey.currentState!
                                          .validate()) {
                                        showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return PopUpMessage(
                                                  title:
                                                      S.of(context).TitleEdit,
                                                  body: S
                                                      .of(context)
                                                      .materialBody,
                                                  onPressed: () {
                                                    cubit.editMaterial(id);
                                                  });
                                            });
                                      }
                                    },
                                    color: AppColor.primaryColor,
                                    height: 47,
                                    width: double.infinity,
                                    textStyles:
                                        TextStyles.font20Whitesemimedium)),
                        verticalSpace(30),
                      ])),
            ));
          },
        ));
  }
}
