import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/filter/logic/cubit/filter_dialog_cubit.dart';
import 'package:smart_cleaning_application/core/widgets/filter/ui/screen/filter_dialog_widget.dart';
import 'package:smart_cleaning_application/core/widgets/filter_and_search_build/filter_search_build.dart';
import 'package:smart_cleaning_application/core/widgets/floating_action_button/floating_action_button.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/question_mangement/logic/question_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/question_mangement/ui/widget/question_list_build.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/question_mangement/ui/widget/top_bar.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class QuestionBody extends StatelessWidget {
  const QuestionBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuestionCubit>();

    return Scaffold(
        appBar: AppBar(
          leading: CustomBackButton(),
          title: Text(S.of(context).question),
        ),
        floatingActionButton: floatingActionButton(
          icon: Icons.rate_review_outlined,
          onPressed: () async {
            final result = await context.pushNamed(Routes.addQuestionScreen);

            if (result == true) {
              cubit.refresh();
            }
          },
        ),
        body: BlocConsumer<QuestionCubit, QuestionState>(
          listener: (context, state) {
            if (state is DeleteQuestionSuccessState) {
              toast(text: state.message, isSuccess: true);
              cubit.getQuestions();
            }
            if (state is DeleteQuestionErrorState) {
              toast(text: state.error, isSuccess: false);
            }
            if (state is AssignQuestionSuccessState) {
              toast(text: state.message, isSuccess: true);
            }
            if (state is AssignQuestionErrorState) {
              toast(text: state.error, isSuccess: false);
            }
          },
          builder: (context, state) {
            return Skeletonizer(
              enabled: cubit.allQuestionsModel == null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FilterAndSearchWidget(
                      hintText: S.of(context).find_question,
                      searchController: cubit.searchController,
                      onSearchChanged: (value) {
                        cubit.getQuestions();
                      },
                      onFilterTap: () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return BlocProvider(
                              create: (context) =>
                                  FilterDialogCubit()..getSection(),
                              child: FilterDialogWidget(
                                index: 'Q',
                                onPressed: (data) {
                                  cubit.filterModel = data;
                                  cubit.getQuestions();
                                },
                              ),
                            );
                          },
                        );
                      },
                      isFilterActive: cubit.filterModel != null,
                      onClearFilter: () {
                        cubit.filterModel = null;
                        cubit.searchController.clear();
                        cubit.getQuestions();
                      },
                    ),
                  ),
                  verticalSpace(10),
                  TopBar(),
                  verticalSpace(10),
                  Expanded(child: QuestionListBuild()),
                  verticalSpace(10),
                ],
              ),
            );
          },
        ));
  }
}
