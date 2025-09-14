import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/custom_row/row_details_build.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/custom_text_form_field.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/feedback_audit_details/logic/cubit/feedback_audit_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/feedback_audit_details/ui/widget/feedback_audit_questions_list_item_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class FeedbackAuditDetailsBody extends StatelessWidget {
  final int id;
  final int selectIndex;
  const FeedbackAuditDetailsBody(
      {super.key, required this.id, required this.selectIndex});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FeedbackAuditDetailsCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text("${selectIndex == 0 ? S.of(context).feedback : S.of(context).audit} ${S.of(context).details}"),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await context.pushNamed(
                Routes.editFeedbackAuditScreen,
                arguments: {
                  'id': id,
                  'selectIndex': selectIndex,
                },
              );

              if (result == true) {
                cubit.getFeedbackAuditDetails(selectIndex, id);
              }
            },
            icon: Icon(Icons.edit, color: AppColor.primaryColor),
          )
        ],
      ),
      body: BlocConsumer<FeedbackAuditDetailsCubit, FeedbackAuditDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          final data = cubit.allQuestionsModel?.data?.data;

          final steps = [
            {
              'title': S.of(context).Organization,
              'icon': Icons.business,
              "value":
                  cubit.feedbackAuditDetailsModel?.data?.organizationName ??
                      "--"
            },
            {
              'title': S.of(context).Building,
              'icon': Icons.home_work,
              "value":
                  cubit.feedbackAuditDetailsModel?.data?.buildingName ?? "--"
            },
            {
              'title': S.of(context).Floor,
              'icon': Icons.house,
              "value": cubit.feedbackAuditDetailsModel?.data?.floorName ?? "--"
            },
            {
              'title': S.of(context).Section,
              'icon': Icons.stairs,
              "value":
                  cubit.feedbackAuditDetailsModel?.data?.sectionName ?? "--"
            },
          ];
          if (cubit.feedbackAuditDetailsModel == null ||
              cubit.allQuestionsModel == null) {
            return Loading();
          }
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.r),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Column(
                            children: [
                              rowDetailsBuild(
                                context,
                                S.of(context).feedback_name,
                                cubit.feedbackAuditDetailsModel!.data!.name!,
                                suffixColor: AppColor.primaryColor,
                              ),
                              if (selectIndex == 0) ...[
                                verticalSpace(5),
                                rowDetailsBuild(
                                  context,
                                  S.of(context).device_name,
                                  cubit.feedbackAuditDetailsModel!.data!
                                          .feedbackDeviceName ??
                                      '',
                                  suffixColor: AppColor.primaryColor,
                                ),
                              ]
                            ],
                          ),
                        ),
                        verticalSpace(10),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.r),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                               S.of(context).location,
                                style: TextStyles.font14PrimRegular,
                              ),
                              verticalSpace(10),
                              SizedBox(
                                height: 110,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40),
                                      child: CustomPaint(
                                        size: const Size(double.infinity, 40),
                                        painter: TimelinePainter(
                                          stepsCount: steps.length,
                                          color: AppColor.primaryColor,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children:
                                          List.generate(steps.length, (index) {
                                        final step = steps[index];
                                        return Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              index == 0
                                                  ? context.pushNamed(
                                                      Routes
                                                          .workLocationDetailsScreen,
                                                      arguments: {
                                                          'id': cubit
                                                              .feedbackAuditDetailsModel!
                                                              .data!
                                                              .organizationId,
                                                          'selectedIndex': 2
                                                        })
                                                  : index == 1
                                                      ? context.pushNamed(
                                                          Routes
                                                              .workLocationDetailsScreen,
                                                          arguments: {
                                                              'id': cubit
                                                                  .feedbackAuditDetailsModel!
                                                                  .data!
                                                                  .buildingId,
                                                              'selectedIndex': 3
                                                            })
                                                      : index == 2
                                                          ? context.pushNamed(
                                                              Routes
                                                                  .workLocationDetailsScreen,
                                                              arguments: {
                                                                  'id': cubit
                                                                      .feedbackAuditDetailsModel!
                                                                      .data!
                                                                      .floorId,
                                                                  'selectedIndex':
                                                                      4
                                                                })
                                                          : context.pushNamed(
                                                              Routes
                                                                  .workLocationDetailsScreen,
                                                              arguments: {
                                                                  'id': cubit
                                                                      .feedbackAuditDetailsModel!
                                                                      .data!
                                                                      .sectionId,
                                                                  'selectedIndex':
                                                                      5
                                                                });
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  step["icon"] as IconData,
                                                  color: AppColor.primaryColor,
                                                  size: 20.sp,
                                                ),
                                                verticalSpace(5),
                                                Text(
                                                  step["title"] as String,
                                                  style: TextStyles
                                                      .font12BlackSemi,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                verticalSpace(3),
                                                Text(
                                                  step["value"] as String,
                                                  style: TextStyles
                                                      .font11lightPrimary,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        verticalSpace(10),
                        Text(
                          "${selectIndex == 0 ? S.of(context).feedback : S.of(context).audit} ${S.of(context).question}",
                          style: TextStyles.font14BlackSemiBold,
                        ),
                        verticalSpace(10),
                        SizedBox(
                          height: 40.h,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: CustomTextFormField(
                                  color: AppColor.secondaryColor,
                                  perfixIcon: Icon(IconBroken.search),
                                  controller: cubit.searchController,
                                  hint: S.of(context).search,
                                  keyboardType: TextInputType.text,
                                  onlyRead: false,
                                  onChanged: (value) {
                                    cubit.getQuestions(id);
                                  },
                                ),
                              ),
                              horizontalSpace(10),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 38.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: AppColor.secondaryColor),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: PopupMenuButton<String>(
                                    padding: EdgeInsets.zero,
                                    color: Colors.white,
                                    offset: Offset(0, 38.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    constraints: BoxConstraints.tightFor(
                                      width: MediaQuery.of(context).size.width *
                                          0.34,
                                    ),
                                    itemBuilder: (context) => [
                                      for (int i = 0;
                                          i < cubit.items.length;
                                          i++) ...[
                                        if (i > 0)
                                          PopupMenuDivider(height: 0.5.h),
                                        PopupMenuItem<String>(
                                          value: cubit.items[i],
                                          height: 34.h,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w),
                                          child: Text(
                                            cubit.items[i],
                                            style: TextStyles.font12BlackSemi,
                                          ),
                                        ),
                                      ],
                                    ],
                                    onSelected: (value) {
                                      cubit.updateType(value);
                                      final selectedIndex =
                                          cubit.items.indexOf(value);
                                      if (selectedIndex != -1) {
                                        cubit.typeIdController.text =
                                            selectedIndex.toString();
                                        cubit.getQuestions(id);
                                      }
                                    },
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                cubit.typeController.text
                                                        .isEmpty
                                                    ? S.of(context).select_type
                                                    : cubit.typeController.text,
                                                style: cubit.typeController.text
                                                        .isEmpty
                                                    ? TextStyles
                                                        .font12GreyRegular
                                                    : TextStyles
                                                        .font12BlackSemi,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Icon(
                                              IconBroken.arrowDown2,
                                              color: AppColor.thirdColor,
                                              size: 18.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
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
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: data.length,
                                  separatorBuilder: (context, index) =>
                                      verticalSpace(10),
                                  itemBuilder: (context, index) {
                                    return FeedbackAuditQuestionsListItemBuild(
                                        index: index);
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Fixed Container at Bottom
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: DefaultElevatedButton(
                      name: S.of(context).assign_more_questions,
                      onPressed: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          Routes.assignQuestionWithFeedbackAuditScreen,
                          arguments: {
                            'id': id,
                            'sectionId': cubit
                                .feedbackAuditDetailsModel!.data!.sectionId,
                          },
                        );
                        if (result == true) {
                          cubit.getQuestions(id);
                        }
                      },
                      color: Colors.green,
                      textStyles: TextStyles.font14WhiteMedium),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TimelinePainter extends CustomPainter {
  final int stepsCount;
  final Color color;

  TimelinePainter({required this.stepsCount, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final double spacing = size.width / (stepsCount - 1);
    final double lineY = 10;

    canvas.drawLine(Offset(0, lineY), Offset(size.width, lineY), paint);

    final circlePaint = Paint()..color = color;
    canvas.drawCircle(Offset(0, lineY), 5, circlePaint);

    for (int i = 1; i < stepsCount; i++) {
      double x = i * spacing;

      canvas.drawLine(Offset(x, lineY), Offset(x, lineY + 10), paint);

      double arrowHeight = (i == stepsCount - 1) ? 12 : 6;
      double arrowWidth = (i == stepsCount - 1) ? 6 : 4;

      final path = Path()
        ..moveTo(x - arrowWidth, lineY + 10)
        ..lineTo(x, lineY + 10 + arrowHeight)
        ..lineTo(x + arrowWidth, lineY + 10)
        ..close();

      canvas.drawPath(path, circlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
