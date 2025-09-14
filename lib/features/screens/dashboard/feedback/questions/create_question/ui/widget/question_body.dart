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
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/create_question/logic/cubit/add_question_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/create_question/ui/widget/choices_part.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/create_question/ui/widget/toggle_part.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AddQuestionBody extends StatelessWidget {
  const AddQuestionBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddQuestionCubit>();
    return Scaffold(
      appBar: AppBar(
          leading: CustomBackButton(),
          title: Text(S.of(context).create_question)),
      body: BlocConsumer<AddQuestionCubit, AddQuestionState>(
        listener: (context, state) {
          if (state is AddQuestionSuccessState) {
            toast(text: state.message, isSuccess: true);
            cubit.clearAllFields();
          }
          if (state is AddQuestionErrorState) {
            toast(text: state.error, isSuccess: false);
          }
        },
        builder: (context, state) {
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
                                        controller: cubit.questionController,
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
                                            cubit.selectedTabIndex != -1
                                                ? " ( ${cubit.getOptions(context)[cubit.selectedTabIndex]}"
                                                : "",
                                            style: TextStyles.font13PrimRegular,
                                          ),
                                        ],
                                      ),
                                      verticalSpace(10),
                                      OptionTabs(),
                                      verticalSpace(10),
                                      if (cubit.selectedTabIndex != -1) ...[
                                        ChoicesBody(
                                          selectedTabIndex:
                                              cubit.selectedTabIndex,
                                        ),
                                      ],
                                    ],
                                  )),
                                  verticalSpace(20),
                                  state is AddQuestionLoadingState
                                      ? Loading()
                                      : Center(
                                          child: DefaultElevatedButton(
                                              name: S.of(context).createButton,
                                              onPressed: () {
                                                if (cubit.formKey.currentState!
                                                    .validate()) {
                                                  // extra validation
                                                  if (cubit.selectedTabIndex ==
                                                          0 ||
                                                      cubit.selectedTabIndex ==
                                                          1) {
                                                    // count non-empty text choices
                                                    int textChoices = cubit
                                                        .choiceControllers
                                                        .where((c) => c.text
                                                            .trim()
                                                            .isNotEmpty)
                                                        .length;

                                                    // count non-null images
                                                    int imageChoices = cubit
                                                        .choiceImages
                                                        .where((img) =>
                                                            img != null)
                                                        .length;

                                                    // total valid choices
                                                    int totalChoices =
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
                                                  if (cubit.selectedTabIndex ==
                                                          3 &&
                                                      cubit.selectedRatingType ==
                                                          -1) {
                                                    toast(
                                                        text: S
                                                            .of(context)
                                                            .please_select_type_of_rating,
                                                        isSuccess: false);
                                                    return;
                                                  }

                                                  cubit.addQuestion();
                                                }
                                              },
                                              color: AppColor.primaryColor,
                                              textStyles: TextStyles
                                                  .font16WhiteSemiBold),
                                        ),
                                  verticalSpace(20),
                                ])))))
          ]);
        },
      ),
    );
  }
}
