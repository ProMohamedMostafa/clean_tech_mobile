import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/ui/widgets/work_location_questions/assign_more_question_point/logic/cubit/assign_question_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AssignQuestionsExpandListItemBuild extends StatelessWidget {
  final int index;
  const AssignQuestionsExpandListItemBuild({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AssignQuestionPointCubit>();
    final isSelected = cubit.selectedItems[index];
    final isExpanded = cubit.expandedItems[index];

    final question = cubit.pointQuestionModel!.data!.data![index];
    final answers = question.choices ?? [];
    final emotions = [
      {"icon": "assets/images/happy.png", "text": S.of(context).good},
      {"icon": "assets/images/normal.png", "text": S.of(context).normal},
      {"icon": "assets/images/sad.png", "text": S.of(context).bad},
    ];
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
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              minTileHeight: 50.h,
              leading: SizedBox(
                width: 45.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => cubit.toggleItem(index),
                      child: Container(
                        width: 16.w,
                        height: 16.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(color: Colors.grey[300]!),
                          color:
                              isSelected ? AppColor.primaryColor : Colors.white,
                        ),
                        child: isSelected
                            ? Icon(Icons.check, size: 13.w, color: Colors.white)
                            : null,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: Container(
                        width: 1,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
              title: Text(
                question.text ?? "",
                style: TextStyles.font12BlackSemi,
                maxLines: isExpanded ? null : 2,
                overflow:
                    isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
              trailing: _statusChip(
                  text: question.type!,
                  color: AppColor.fourthColor,
                  textColor: AppColor.primaryColor),
            ),
            if (isExpanded) ...[
              (question.typeId == 0 || question.typeId == 1)
                  ? (answers.isNotEmpty
                      ? Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: answers.map((ans) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 50.r,
                                    height: 50.r,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Colors.grey[200]!),
                                    ),
                                    child: ans.image != null
                                        ? ClipOval(
                                            child: Image.network(
                                              ans.image!,
                                              fit: BoxFit.fill,
                                            ),
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
                                      style: TextStyles.font11BlackMedium,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  )
                                ],
                              );
                            }).toList(),
                          ),
                        )
                      : _buildNoOptionsAvailable(context))
                  : question.typeId == 3
                      ? Center(
                          child: (answers.isNotEmpty &&
                                  answers.first.icon == "0")
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List.generate(5, (i) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 50.r,
                                          height: 50.r,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.grey[200]!),
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
                                          style: TextStyles.font14BlackMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    );
                                  }),
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: emotions.map((emotion) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 50.r,
                                          height: 50.r,
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
                                          style: TextStyles.font14BlackMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                        )
                      : _buildNoOptionsAvailable(context),
              verticalSpace(10),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildNoOptionsAvailable(BuildContext context) {
    return Center(
      child: Text(
        S.of(context).no_questions,
        style: TextStyles.font13PrimRegular,
        textAlign: TextAlign.center,
      ),
    );
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
