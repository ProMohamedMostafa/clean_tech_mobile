import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/custom_text_form_field.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/ui/widgets/work_location_questions/assign_more_question_point/logic/cubit/assign_question_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/ui/widgets/work_location_questions/assign_more_question_point/ui/widget/expand_assign_questions_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/ui/widgets/work_location_questions/assign_more_question_point/ui/widget/top_bar_assign_question.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AssignQuestionPointBody extends StatelessWidget {
  final int id;
  final int sectionId;
  const AssignQuestionPointBody({super.key, required this.id, required this.sectionId});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AssignQuestionPointCubit>();

    return Scaffold(
        appBar: AppBar(
          leading: CustomBackButton(),
          title: Text(S.of(context).assign_questions),
        ),
        body: BlocConsumer<AssignQuestionPointCubit, AssignQuestionPointState>(
          listener: (context, state) {
            if (state is AssignQuestionPointSuccessState) {
              toast(text: state.message, isSuccess: true);
              context.popWithTrueResult();
            }
            if (state is AssignQuestionPointErrorState) {
              toast(text: state.error, isSuccess: false);
            }
          },
          builder: (context, state) {
            final data = cubit.pointQuestionModel?.data?.data;

            if (cubit.pointQuestionModel == null) {
              return Loading();
            }
            if (state is QuestionSuccessState && !cubit.initialized) {
              cubit.initializeQuestions();
              cubit.initialized = true;
            }
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomTextFormField(
                            color: AppColor.secondaryColor,
                            perfixIcon: Icon(IconBroken.search),
                            controller: cubit.searchController,
                            hint: S.of(context).search,
                            keyboardType: TextInputType.text,
                            onlyRead: false,
                            onChanged: (value) {
                              cubit.getQuestionsSection(id,sectionId);
                            },
                          ),
                        ),
                        verticalSpace(10),
                        TopBarAssignQuestion(),
                        verticalSpace(10),
                        Expanded(
                          child: (data == null || data.isEmpty)
                              ? Center(
                                  child: Text(
                                    S.of(context).no_questions,
                                    style: TextStyles.font14BlackRegular,
                                  ),
                                )
                              : ListView.separated(
                                  controller: cubit.scrollController,
                                  itemCount: data.length,
                                  separatorBuilder: (context, index) =>
                                      verticalSpace(10),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: AssignQuestionsExpandListItemBuild(
                                          index: index),
                                    );
                                  },
                                ),
                        ),
                        verticalSpace(10),
                      ],
                    ),
                  ),
                  state is AssignQuestionPointLoadingState
                      ? Loading()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: DefaultElevatedButton(
                              name: S.of(context).saveButton,
                              onPressed: () {
                                cubit.assignQuestion(id);
                              },
                              color: AppColor.primaryColor,
                              textStyles: TextStyles.font20Whitesemimedium),
                        ),
                  verticalSpace(20)
                ],
              ),
            );
          },
        ));
  }
}
