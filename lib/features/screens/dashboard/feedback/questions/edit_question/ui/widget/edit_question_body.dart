import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/custom_text_form_field.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/edit_question/logic/cubit/edit_question_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/edit_question/ui/widget/choices_part.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/edit_question/ui/widget/toggle_part.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EditQuestionBody extends StatelessWidget {
  final int id;
  const EditQuestionBody({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: CustomBackButton(),
          title: Text(S.of(context).edit_question)),
      body: BlocConsumer<EditQuestionCubit, EditQuestionState>(
        listener: (context, state) {
          if (state is EditQuestionSuccessState) {
            toast(text: state.message, isSuccess: true);
            // cubit.clearAllFields();
          }
          if (state is EditQuestionErrorState) {
            toast(text: state.error, isSuccess: false);
          }
        },
        builder: (context, state) {
          final cubit = context.read<EditQuestionCubit>();
          if (cubit.questionDetailsModel?.data! == null) {
            return Loading();
          }
          return CustomScrollView(slivers: [
            SliverFillRemaining(
                hasScrollBody: false,
                child: SafeArea(
                    child: Form(
                        key: cubit.formKey,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        S.of(context).the_question,
                                        style: TextStyles.font16BlackMedium,
                                      ),
                                      verticalSpace(5),
                                      CustomTextFormField(
                                        onlyRead: false,
                                        hint: S.of(context).write_question_here,
                                        controller: cubit.questionController
                                          ..text = cubit.questionDetailsModel!
                                              .data!.text!,
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return S
                                                .of(context)
                                                .question_required;
                                          } else if (value.length > 250) {
                                            return S
                                                .of(context)
                                                .question_too_long;
                                          } else if (value.length < 3) {
                                            return S
                                                .of(context)
                                                .question_too_short;
                                          }
                                          return null;
                                        },
                                      ),
                                      verticalSpace(10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            S.of(context).selectType,
                                            style: TextStyles.font16BlackMedium,
                                          ),
                                          horizontalSpace(2),
                                          Text(
                                            " ( ${cubit.selectedTabIndex != -1 ? cubit.getOptions(context)[cubit.selectedTabIndex] : cubit.questionDetailsModel!.data!.type} )",
                                            style: TextStyles.font13PrimRegular,
                                          ),
                                        ],
                                      ),
                                      verticalSpace(10),
                                      EditOptionTabs(),
                                      verticalSpace(10),
                                      if (cubit.selectedTabIndex != -1) ...[
                                        EditChoicesBody(
                                          selectedTabIndex:
                                              cubit.selectedTabIndex,
                                        ),
                                      ],
                                    ],
                                  )),
                                  verticalSpace(20),
                                  state is EditQuestionLoadingState
                                      ? const Loading()
                                      : Center(
                                          child: DefaultElevatedButton(
                                            name: S.of(context).createButton,
                                            onPressed: () {
                                              if (cubit.formKey.currentState!
                                                  .validate()) {
                                                // ✅ Validate multiple or checkbox questions
                                                if (cubit.selectedTabIndex ==
                                                        0 ||
                                                    cubit.selectedTabIndex ==
                                                        1) {
                                                  final textChoices = cubit
                                                      .choiceControllers
                                                      .where((c) => c.text
                                                          .trim()
                                                          .isNotEmpty)
                                                      .length;
                                                  final imageChoices = cubit
                                                      .choiceImages
                                                      .where(
                                                          (img) => img != null)
                                                      .length;
                                                  final totalChoices =
                                                      textChoices +
                                                          imageChoices;

                                                  if (totalChoices < 4) {
                                                    toast(
                                                      text: S
                                                          .of(context)
                                                          .please_add_4_choices,
                                                      isSuccess: false,
                                                    );
                                                    return;
                                                  }
                                                }

                                                // ✅ Validate rating question (type 4)
                                                if (cubit.selectedTabIndex ==
                                                        4 &&
                                                    cubit.selectedRatingType ==
                                                        -1) {
                                                  toast(
                                                    text: S
                                                        .of(context)
                                                        .please_select_type_of_rating,
                                                    isSuccess: false,
                                                  );
                                                  return;
                                                }

                                                // Proceed to add question
                                                cubit.editQuestion(id);
                                              }
                                            },
                                            color: AppColor.primaryColor,
                                            textStyles:
                                                TextStyles.font16WhiteSemiBold,
                                          ),
                                        ),
                                  verticalSpace(20),
                                ])))))
          ]);
        },
      ),
    );
  }
}
