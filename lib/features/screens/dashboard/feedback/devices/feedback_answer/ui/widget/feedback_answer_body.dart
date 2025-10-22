import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/feedback_answer/data/model/feedback_answer_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/feedback_answer/logic/cubit/feedback_answer_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class FeedbackAnswerBody extends StatelessWidget {
  const FeedbackAnswerBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FeedbackAnswerCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).answer_details),
      ),
      body: BlocBuilder<FeedbackAnswerCubit, FeedbackAnswerState>(
        builder: (context, state) {
          final questions = cubit.feedbackAnswerModel?.data?.questions;

          if (questions == null || questions.isEmpty) {
            return Center(
              child: Text(S.of(context).noData,
                  style: TextStyles.font13Blackmedium),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: questions.length,
            separatorBuilder: (context, index) => verticalSpace(10),
            itemBuilder: (context, index) {
              final question = questions[index];
              final answers = question.choices ?? const <Choices>[];
              final isExpanded = (index < cubit.expandedItems.length)
                  ? cubit.expandedItems[index]
                  : false;

              return InkWell(
                borderRadius: BorderRadius.circular(6.r),
                onTap: () => cubit.toggleExpand(index),
                child: Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        minTileHeight: 50.h,
                        leading: _statusChip(
                          text: question.type ?? "",
                          color: AppColor.fourthColor,
                          textColor: AppColor.primaryColor,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question.questionText ?? "",
                              style: TextStyles.font12BlackSemi,
                              maxLines: isExpanded ? null : 2,
                              overflow: isExpanded
                                  ? TextOverflow.visible
                                  : TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        trailing: question.isAnswered == true
                            ? Icon(Icons.check_circle,
                                color: Colors.green, size: 20.r)
                            : SizedBox.shrink(),
                      ),
                      if (isExpanded) ...[
                        if (question.typeId == 0 && answers.isNotEmpty)
                          _choicesRow(
                            answers: answers,
                            isSelected: (ans) =>
                                question.choiceIdAnswer != null &&
                                ans.id == question.choiceIdAnswer,
                          ),
                        if (question.typeId == 1 && answers.isNotEmpty)
                          _choicesRow(
                            answers: answers,
                            isSelected: (ans) {
                              final ids =
                                  question.choiceIdsAnswer ?? const <int>[];
                              final id = ans.id;
                              return id != null && ids.contains(id);
                            },
                          ),
                        if (question.typeId == 2 &&
                            (question.textAnswer?.trim().isNotEmpty ?? false))
                          Padding(
                            padding: EdgeInsets.fromLTRB(100, 6, 0, 0),
                            child: Text(
                              question.textAnswer!,
                              style: TextStyles.font13PrimRegular,
                            ),
                          ),
                        if (question.typeId == 3 && answers.isNotEmpty)
                          _boolRow(context, selected: question.boolAnswer),
                        if (question.typeId == 4)
                          _ratingRow(selected: question.rateAnswer),
                        if (question.typeId == 5)
                          _emotionsRow(context, selected: question.rateAnswer),
                        verticalSpace(10),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _choicesRow({
    required List<Choices> answers,
    required bool Function(Choices ans) isSelected,
  }) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12.w,
        runSpacing: 12.h,
        children: answers.map((ans) {
          final selected = isSelected(ans);

          return Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: selected
                  ? Border.all(color: AppColor.primaryColor, width: 2)
                  : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 50.r,
                  height: 50.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: (ans.image != null && ans.image!.isNotEmpty)
                      ? Image.network(ans.image!, fit: BoxFit.cover)
                      : Center(
                          child: Image.asset(
                            'assets/images/noPic.png',
                            width: 28.r,
                            height: 28.r,
                            fit: BoxFit.fill,
                          ),
                        ),
                ),
                verticalSpace(4),
                SizedBox(
                  width: 60.w,
                  child: Text(
                    ans.text ?? "",
                    style: TextStyles.font11BlackMedium,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _ratingRow({required int? selected}) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12.w,
        children: List.generate(5, (i) {
          final value = i + 1;
          final isSelected = selected == value;
          return Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: isSelected
                  ? Border.all(color: AppColor.primaryColor, width: 2)
                  : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 50.r,
                  height: 50.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Icon(Icons.star_border_rounded,
                      size: 32.r, color: AppColor.primaryColor),
                ),
                verticalSpace(4),
                Text("$value",
                    style: TextStyles.font14BlackMedium,
                    textAlign: TextAlign.center),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _emotionsRow(context, {required int? selected}) {
    final emotions = [
      {"icon": "assets/images/happy.png", "text": S.of(context).good},
      {"icon": "assets/images/normal.png", "text": S.of(context).normal},
      {"icon": "assets/images/sad.png", "text": S.of(context).bad},
    ];

    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 50.w,
        children: List.generate(emotions.length, (i) {
          final emotion = emotions[i];
          final isSelected = selected == i + 1;
          return Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: isSelected
                  ? Border.all(color: AppColor.primaryColor, width: 2)
                  : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(emotion["icon"]!,
                    width: 40.r, height: 40.r, fit: BoxFit.fill),
                verticalSpace(4),
                Text(emotion["text"]!,
                    style: TextStyles.font14BlackMedium,
                    textAlign: TextAlign.center),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _boolRow(context, {required bool? selected}) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12.w,
        children: [
          _boolChip(
              label: S.of(context).true_value, isSelected: selected == true),
          _boolChip(
              label: S.of(context).false_value, isSelected: selected == false),
        ],
      ),
    );
  }

  Widget _boolChip({required String label, required bool isSelected}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: isSelected
            ? Border.all(color: AppColor.primaryColor, width: 2)
            : Border.all(color: Colors.transparent),
        color: Colors.white,
      ),
      child: Text(label, style: TextStyles.font13Blackmedium),
    );
  }

  Widget _statusChip({
    required String text,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      width: 70.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(4.r)),
      child: Text(
        textAlign: TextAlign.center,
        text,
        style: TextStyles.font11WhiteSemiBold.copyWith(color: textColor),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
