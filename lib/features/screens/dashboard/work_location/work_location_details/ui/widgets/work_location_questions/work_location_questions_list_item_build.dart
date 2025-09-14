import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/custom_text_form_field.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/logic/cubit/work_location_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/ui/widgets/work_location_questions/question_top_bar.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/ui/widgets/work_location_questions/questions_list_item_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class WorkLocationQuestions extends StatelessWidget {
  final int id;
  final int selectedIndex;
  const WorkLocationQuestions(
      {super.key, required this.selectedIndex, required this.id});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkLocationDetailsCubit>();

    return BlocConsumer<WorkLocationDetailsCubit, WorkLocationDetailsState>(
      listener: (context, state) {
        if (state is DeleteQuestionSuccessState) {
          toast(text: state.message, isSuccess: true);
          if (selectedIndex == 5) {
            cubit.getQuestions(
                id,
                cubit.selectedQuestionSection == 1
                    ? cubit.sectionUsersShiftDetailsModel?.data?.feedbackId ?? 0
                    : cubit.selectedQuestionSection == 2
                        ? cubit.sectionUsersShiftDetailsModel?.data?.auditId ??
                            0
                        : 0);
          } else {
            cubit.getPointQuestions(id);
          }
        }
        if (state is DeleteQuestionErrorState) {
          toast(text: state.error, isSuccess: false);
        }
      },
      builder: (context, state) {
        final sectionData = cubit.sectionQuestionsModel?.data?.data;
        final pointData = cubit.pointQuestionsModel?.data?.data;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
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
                          if (selectedIndex == 5) {
                            int? feedbackAuditId;

                            if (cubit.selectedQuestionSection == 1) {
                              feedbackAuditId = cubit
                                  .sectionUsersShiftDetailsModel
                                  ?.data
                                  ?.feedbackId;
                            } else if (cubit.selectedQuestionSection == 2) {
                              feedbackAuditId = cubit
                                  .sectionUsersShiftDetailsModel?.data?.auditId;
                            }

                            cubit.getQuestions(id, feedbackAuditId ?? 0);
                          } else {
                            cubit.getPointQuestions(id);
                          }
                        },
                      ),
                    ),
                    horizontalSpace(5),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 38.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColor.secondaryColor),
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
                            width: MediaQuery.of(context).size.width * 0.34,
                          ),
                          itemBuilder: (context) => [
                            for (int i = 0; i < cubit.items.length; i++) ...[
                              if (i > 0) PopupMenuDivider(height: 0.5.h),
                              PopupMenuItem<String>(
                                value: cubit.items[i],
                                height: 34.h,
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Text(
                                  cubit.items[i],
                                  style: TextStyles.font12BlackSemi,
                                ),
                              ),
                            ],
                          ],
                          onSelected: (value) {
                            cubit.updateType(value);
                            final selectedIndex = cubit.items.indexOf(value);
                            if (selectedIndex != -1) {
                              cubit.typeIdController.text =
                                  selectedIndex.toString();
                              if (selectedIndex == 5) {
                                int? feedbackAuditId;
                                if (cubit.selectedQuestionSection == 1) {
                                  feedbackAuditId = cubit
                                      .sectionUsersShiftDetailsModel
                                      ?.data
                                      ?.feedbackId;
                                } else if (cubit.selectedQuestionSection == 2) {
                                  feedbackAuditId = cubit
                                      .sectionUsersShiftDetailsModel
                                      ?.data
                                      ?.auditId;
                                }

                                // Fetch filtered questions after selecting type
                                cubit.getQuestions(id, feedbackAuditId ?? 0);
                              } else {
                                cubit.getPointQuestions(id);
                              }
                            }
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      cubit.typeController.text.isEmpty
                                          ? S.of(context).select_type
                                          : cubit.typeController.text,
                                      style: cubit.typeController.text.isEmpty
                                          ? TextStyles.font12GreyRegular
                                          : TextStyles.font12BlackSemi,
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
            ),
            if (selectedIndex == 5) ...[
              verticalSpace(5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 40.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: cubit.tabs.length,
                    separatorBuilder: (context, index) => horizontalSpace(10),
                    itemBuilder: (context, index) {
                      final isSelected = index == cubit.selectedQuestionSection;

                      return GestureDetector(
                        onTap: () =>
                            cubit.changeSelectedQuestionSection(id, index),
                        child: IntrinsicWidth(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                cubit.tabs[index],
                                style: TextStyle(
                                  color: isSelected
                                      ? AppColor.primaryColor
                                      : Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                height: 2.h,
                                color: isSelected
                                    ? AppColor.primaryColor
                                    : Colors.grey[300],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
            if (selectedIndex == 6) ...[
              verticalSpace(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                          color: const Color(0xff49B848).withOpacity(0.4)),
                      color: const Color(0xff49B848).withOpacity(0.1)),
                  child: ListTile(
                    minTileHeight: 44.h,
                    contentPadding: EdgeInsets.symmetric(horizontal: 13),
                    dense: true,
                    title: Text(S.of(context).assign_more_questions,
                        style: TextStyles.font14BlackRegular
                            .copyWith(color: const Color(0xff49B848))),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: const Color(0xff49B848),
                      size: 16.sp,
                    ),
                    onTap: () async {
                      final result = await Navigator.pushNamed(
                        context,
                        Routes.workLocationAssignQuestionPoint,
                        arguments: {
                          'id': id,
                          'sectionId':
                              cubit.pointUsersDetailsModel!.data!.sectionId,
                        },
                      );
                      if (result == true) {
                        cubit.getPointQuestions(id);
                      }
                    },
                  ),
                ),
              )
            ],
            verticalSpace(10),
            QuestionTopBar(selectedIndex: selectedIndex, id: id),
            verticalSpace(10),
            Expanded(
              child: (state is QuestionLoadingState ||
                      (selectedIndex == 5
                          ? sectionData == null
                          : pointData == null))
                  ? Loading()
                  : (() {
                      final data = selectedIndex == 5 ? sectionData : pointData;

                      if (data == null || data.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: Text(
                              S.of(context).no_questions,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                        );
                      }

                      return ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: data.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: QuestionsListItemBuild(
                              index: index,
                              selectedIndex: selectedIndex,
                            ),
                          );
                        },
                      );
                    }()),
            ),
          ],
        );
      },
    );
  }
}
