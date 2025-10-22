import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/feedback_audit_details/logic/cubit/feedback_audit_details_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class FeedbackAuditQuestionsListItemBuild extends StatelessWidget {
  final int index;
  const FeedbackAuditQuestionsListItemBuild({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<FeedbackAuditDetailsCubit>();
    final isExpanded = cubit.expandedItems[index];

    final question = cubit.allQuestionsModel!.data!.data![index];
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
              _buildExpandedContent(
                  context, question.typeId ?? -1, answers, emotions),
              verticalSpace(10),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedContent(
    BuildContext context,
    int typeId,
    List<dynamic> answers,
    List<Map<String, String>> emotions,
  ) {
    switch (typeId) {
      case 0:
      case 1:
        // Multiple choice / checkbox
        if (answers.isEmpty) return _buildNoOptionsAvailable(context);
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: answers.map((ans) {
              return Column(
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
                  ),
                ],
              );
            }).toList(),
          ),
        );

      case 2:
        // Text input
        return _buildNoOptionsAvailable(context);

      case 3:
        // True or False
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 50.r,
                height: 50.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Center(
                  child: Text(
                    S.of(context).true_value,
                    style: TextStyles.font14BlackMedium,
                  ),
                ),
              ),
              Container(
                width: 50.r,
                height: 50.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Center(
                  child: Text(
                    S.of(context).false_value,
                    style: TextStyles.font14BlackMedium,
                  ),
                ),
              ),
            ],
          ),
        );

      case 4:
        // Rating (stars/numbers)
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (i) {
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
                      border: Border.all(color: Colors.grey[200]!),
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
          ),
        );

      case 5:
        // Rating (emotions)
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: emotions.map((emotion) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50.r,
                    height: 50.r,
                    child: Image.asset(
                      emotion["icon"]!,
                      fit: BoxFit.fill,
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
        );

      default:
        return _buildNoOptionsAvailable(context);
    }
  }

  Widget _buildNoOptionsAvailable(BuildContext context) {
    return Center(
      child: Text(
        S.of(context).no_options_available,
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
