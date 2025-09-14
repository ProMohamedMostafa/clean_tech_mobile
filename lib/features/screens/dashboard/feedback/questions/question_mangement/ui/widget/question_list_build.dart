import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/question_mangement/logic/question_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/questions/question_mangement/ui/widget/question_list_item_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class QuestionListBuild extends StatelessWidget {
  const QuestionListBuild({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuestionCubit>();

    final data = cubit.allQuestionsModel?.data?.data;

    if (data == null || data.isEmpty) {
      return Center(
        child: Text(
          S.of(context).noData,
          style: TextStyles.font13Blackmedium,
        ),
      );
    }

    return ListView.separated(
      controller: cubit.scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      separatorBuilder: (context, index) => verticalSpace(10),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: QuestionListItemBuild(index: index),
        );
      },
    );
  }
}
