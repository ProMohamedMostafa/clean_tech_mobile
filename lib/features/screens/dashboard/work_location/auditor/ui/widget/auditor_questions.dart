import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/custom_description_text_form_field/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/auditor/logic/cubit/auditor_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AuditorQuestions extends StatelessWidget {
  final int id;
  const AuditorQuestions({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text(S.of(context).auditor_questions),
      ),
      body: BlocConsumer<AuditorCubit, AuditorState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = context.watch<AuditorCubit>();
          final data = cubit.allQuestionsModel?.data?.data;

          final emotions = [
            {"icon": "assets/images/happy.png", "text": S.of(context).good},
            {"icon": "assets/images/normal.png", "text": S.of(context).normal},
            {"icon": "assets/images/sad.png", "text": S.of(context).bad},
          ];

          if (cubit.allQuestionsModel?.data == null) {
            return const Loading();
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (data == null || data.isEmpty)
                      ? Center(
                          child: Text(
                            S.of(context).no_questions,
                            style: TextStyles.font14BlackRegular,
                          ),
                        )
                      : ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          separatorBuilder: (context, index) =>
                              verticalSpace(10),
                          itemBuilder: (context, index) {
                            final question =
                                cubit.allQuestionsModel!.data!.data![index];
                            final answers = question.choices ?? [];
                            return Card(
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
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    minTileHeight: 50.h,
                                    title: Text(
                                      question.text ?? "",
                                      style: TextStyles.font12BlackSemi,
                                    ),
                                    trailing: _statusChip(
                                      text: question.type!,
                                      color: AppColor.fourthColor,
                                      textColor: AppColor.primaryColor,
                                    ),
                                  ),
                                  _buildAnswerOptions(context, question,
                                      answers, emotions, cubit),
                                  verticalSpace(10),
                                ],
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<AuditorCubit, AuditorState>(
        builder: (context, state) {
          final cubit = context.watch<AuditorCubit>();
          return Padding(
            padding: const EdgeInsets.all(16),
            child: state is AddAuditorAnswerLoadingState
                ? const Loading()
                : DefaultElevatedButton(
                    name: S.of(context).send,
                    onPressed: () {
                      cubit.addAuditorAnswer(id);
                    },
                    color: AppColor.primaryColor,
                    textStyles: TextStyles.font16WhiteSemiBold,
                  ),
          );
        },
      ),
    );
  }

  Widget _buildAnswerOptions(context, question, answers, emotions, cubit) {
    // --- Single choice (typeId 0) ---
    if (question.typeId == 0) {
      final selectedId = cubit.answers.firstWhere(
        (a) => a['questionId'] == question.id,
        orElse: () => <String, dynamic>{'answer': -1},
      )['answer'];

      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: answers.map<Widget>((ans) {
            final isSelected = selectedId == ans.id;
            return GestureDetector(
              onTap: () {
                cubit.setAnswer(question.id, question.typeId, ans.id);
                cubit.emit(AuditorUpdateState());
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50.r,
                    height: 50.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: isSelected
                            ? AppColor.primaryColor
                            : Colors.grey[200]!,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: ans.image != null
                        ? ClipOval(
                            child: Image.network(ans.image!, fit: BoxFit.fill),
                          )
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
                    width: 50.w,
                    child: Text(
                      ans.text ?? "",
                      style: isSelected
                          ? TextStyles.font12PrimSemi
                          : TextStyles.font11BlackMedium,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    }

    // --- Multi-choice (typeId 1) ---
    else if (question.typeId == 1) {
      final selectedList = cubit.answers.firstWhere(
            (a) => a['questionId'] == question.id,
            orElse: () => <String, dynamic>{'answer': <int>[]},
          )['answer'] as List? ??
          [];

      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: answers.map<Widget>((ans) {
            final isSelected = selectedList.contains(ans.id);
            return GestureDetector(
              onTap: () {
                final updated = List<int>.from(selectedList);
                if (isSelected) {
                  updated.remove(ans.id);
                } else {
                  updated.add(ans.id);
                }
                cubit.setAnswer(question.id, question.typeId, updated);
                cubit.emit(AuditorUpdateState());
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50.r,
                    height: 50.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: isSelected
                            ? AppColor.primaryColor
                            : Colors.grey[200]!,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: ans.image != null
                        ? ClipOval(
                            child: Image.network(ans.image!, fit: BoxFit.fill),
                          )
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
                    width: 50.w,
                    child: Text(
                      ans.text ?? "",
                      style: isSelected
                          ? TextStyles.font12PrimSemi
                          : TextStyles.font11BlackMedium,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    }

    // --- Text (typeId 2) ---
    else if (question.typeId == 2) {
      // Get initial value from answers
      final initialValue = cubit.answers.firstWhere(
            (a) => a['questionId'] == question.id,
            orElse: () => {'answer': ''},
          )['answer'] ??
          '';

      final controller = cubit.getTextController(question.id, initialValue);

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomDescriptionTextFormField(
          controller: controller,
          hint: S.of(context).enter_your_answer,
          onChanged: (val) {
            cubit.setAnswer(question.id, question.typeId, val);
          },
        ),
      );
    }

    // --- Rating / Emotions (typeId 3) ---
    else if (question.typeId == 3) {
      final selectedId = cubit.answers.firstWhere(
        (a) => a['questionId'] == question.id,
        orElse: () => <String, dynamic>{'answer': -1},
      )['answer'];

      return Center(
        child: (answers.isNotEmpty && answers.first.icon == "0")
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (i) {
                  final isSelected = selectedId == i + 1;
                  return GestureDetector(
                    onTap: () {
                      cubit.setAnswer(question.id, question.typeId, i + 1);
                      cubit.emit(AuditorUpdateState());
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 50.r,
                          height: 50.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: isSelected
                                  ? AppColor.primaryColor
                                  : Colors.grey[200]!,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Icon(
                            Icons.star_border_rounded,
                            size: 32.r,
                            color: AppColor.primaryColor,
                          ),
                        ),
                        verticalSpace(4),
                        Text(
                          "${i + 1}",
                          style: isSelected
                              ? TextStyles.font14Primarybold
                              : TextStyles.font12BlackSemi,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: emotions.map<Widget>((emotion) {
                  final idx = emotions.indexOf(emotion);
                  final isSelected = selectedId == idx;
                  return GestureDetector(
                    onTap: () {
                      cubit.setAnswer(question.id, question.typeId, idx);
                      cubit.emit(AuditorUpdateState());
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 50.r,
                          height: 50.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: isSelected
                                  ? AppColor.primaryColor
                                  : Colors.grey[200]!,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Center(
                            child: Image.asset(
                              emotion["icon"]!,
                              fit: BoxFit.fill,
                              width: 40.r,
                              height: 40.r,
                            ),
                          ),
                        ),
                        verticalSpace(4),
                        Text(
                          emotion["text"]!,
                          style: isSelected
                              ? TextStyles.font14Primarybold
                              : TextStyles.font12BlackSemi,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
      );
    }

    // --- Boolean (typeId 4) ---
    else if (question.typeId == 4) {
      final selected = cubit.selectedRatingType;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              cubit.answerBoolQuestion(false);
              cubit.setAnswer(question.id, question.typeId, false);
            },
            child: Container(
              height: 33,
              width: 80,
              decoration: BoxDecoration(
                color: selected == 0 ? AppColor.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(5.r),
                border: Border.all(
                  color: selected == 0 ? AppColor.primaryColor : Colors.grey,
                ),
              ),
              child: Center(
                child: Text(
                  S.of(context).true_value,
                  style: TextStyle(
                    color: selected == 0 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              cubit.answerBoolQuestion(true);
              cubit.setAnswer(question.id, question.typeId, true);
            },
            child: Container(
              height: 33,
              width: 80,
              decoration: BoxDecoration(
                color: selected == 1 ? AppColor.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(5.r),
                border: Border.all(
                  color: selected == 1 ? AppColor.primaryColor : Colors.grey,
                ),
              ),
              child: Center(
                child: Text(
                  S.of(context).false_value,
                  style: TextStyle(
                    color: selected == 1 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    // --- Fallback ---
    else {
      return SizedBox.shrink();
    }
  }

  Widget _statusChip({
    required String text,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        text,
        style: TextStyles.font11WhiteSemiBold.copyWith(color: textColor),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
