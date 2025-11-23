import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/integration_buttons/integrations_buttons.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/activity/ui/widgets/icons_widget.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ShowActivity extends StatelessWidget {
  const ShowActivity({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<HomeCubit>();

    final isLoading = cubit.myActivities == null ||
        ((role != 'Cleaner' && role != 'Auditor') &&
            cubit.teamActivities == null);
    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: () {
          cubit.changeVisiability();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                dense: true,
                minVerticalPadding: 0,
                contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                leading: Icon(
                  Icons.timeline_sharp,
                  color: AppColor.primaryColor,
                  size: 22.sp,
                ),
                title: Text(
                  S.of(context).showActivity,
                  style: TextStyles.font14BlackSemiBold,
                ),
                trailing: RotatedBox(
                  quarterTurns: cubit.down ? 3 : 1,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColor.primaryColor,
                    size: 18.sp,
                  ),
                ),
              ),
              if (cubit.down) ...[
                Divider(height: 1.h),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: integrationsButtons(
                    selectedIndex: cubit.selectedIndex,
                    onTap: cubit.changeTap,
                    firstLabel: S.of(context).myActivity,
                    secondLabel: (role != 'Cleaner' && role != 'Auditor')
                        ? S.of(context).myTeamActivity
                        : null,
                  ),
                ),
                Divider(height: 1.h),
                SizedBox(
                  height: 260.h,
                  child: Builder(
                    builder: (context) {
                      final activitiesList = cubit.selectedIndex == 0
                          ? cubit.myActivities?.data?.activities
                          : cubit.teamActivities?.data?.activities;

                      if (activitiesList == null || activitiesList.isEmpty) {
                        return Center(
                          child: Text(
                            S.of(context).noActivities,
                            style: TextStyles.font13Blackmedium,
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: activitiesList.length,
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final activity = activitiesList[index];
                          final routeName = cubit.getRouteName(
                              activity.module, activity.moduleId);

                          return InkWell(
                            onTap: () {
                              if (role != 'Auditor') {
                                if (routeName.isNotEmpty) {
                                  if (routeName ==
                                      Routes.workLocationDetailsScreen) {
                                    context.pushNamed(routeName, arguments: {
                                      'id': activity.moduleId,
                                      'selectedIndex':
                                          cubit.getWorkLocationIndex(
                                              activity.module),
                                    });
                                  } else {
                                    context.pushNamed(routeName,
                                        arguments: activity.moduleId);
                                  }
                                }
                              }
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    minTileHeight: 60.h,
                                    leading: ActionIcon(
                                      actionId: cubit.selectedIndex == 0
                                          ? cubit.myActivities!.data!
                                              .activities![index].actionTypeId!
                                          : cubit.teamActivities!.data!
                                              .activities![index].actionTypeId!,
                                    ),
                                    title: Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            cubit.selectedIndex == 0
                                                ? cubit
                                                    .myActivities!
                                                    .data!
                                                    .activities![index]
                                                    .userName!
                                                : cubit
                                                        .teamActivities!
                                                        .data!
                                                        .activities![index]
                                                        .userName ??
                                                    '',
                                            style:
                                                TextStyles.font14BlackRegular,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        horizontalSpace(8),
                                        Text(
                                          cubit.selectedIndex == 0
                                              ? cubit.myActivities!.data!
                                                  .activities![index].role!
                                              : cubit
                                                      .teamActivities!
                                                      .data!
                                                      .activities![index]
                                                      .role ??
                                                  '',
                                          style: TextStyles.font9PrimRegular,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cubit.selectedIndex == 0
                                              ? cubit
                                                  .myActivities!
                                                  .data!
                                                  .activities![index]
                                                  .actionType!
                                              : cubit
                                                  .teamActivities!
                                                  .data!
                                                  .activities![index]
                                                  .actionType!,
                                          style: TextStyles.font12BlackSemi
                                              .copyWith(
                                            color: cubit.getActionColor(
                                              cubit.selectedIndex == 0
                                                  ? cubit
                                                      .myActivities!
                                                      .data!
                                                      .activities![index]
                                                      .actionType!
                                                  : cubit
                                                      .teamActivities!
                                                      .data!
                                                      .activities![index]
                                                      .actionType!,
                                            ),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          cubit.selectedIndex == 0
                                              ? cubit.myActivities!.data!
                                                  .activities![index].message!
                                              : cubit.teamActivities!.data!
                                                  .activities![index].message!,
                                          style: TextStyles.font12GreyRegular,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 80.w,
                                  child: Text(
                                    cubit.selectedIndex == 0
                                        ? cubit.formatTimeDifferenceFromString(
                                            cubit.myActivities!.data!
                                                .activities![index].createdAt!)
                                        : cubit.formatTimeDifferenceFromString(
                                            cubit.teamActivities!.data!
                                                .activities![index].createdAt!),
                                    style: TextStyles.font11GreyMedium,
                                  ),
                                ),
                                SizedBox(
                                  width: 80.w,
                                  child: Text(
                                    cubit.selectedIndex == 0
                                        ? cubit.formatTimeDifferenceFromString(
                                            cubit.myActivities!.data!
                                                .activities![index].createdAt!)
                                        : cubit.formatTimeDifferenceFromString(
                                            cubit.teamActivities!.data!
                                                .activities![index].createdAt!),
                                    style: TextStyles.font11GreyMedium,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0, -40),
                        blurRadius: 50,
                      ),
                    ],
                  ),
                  child: (role != 'Auditor')
                      ? InkWell(
                          onTap: () {
                            context.pushNamed(Routes.activityScreen);
                          },
                          child: SizedBox(
                            height: 30.h,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Divider(
                                      height: 1.h,
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                  horizontalSpace(10),
                                  Text(
                                    S.of(context).seeMoreButton,
                                    style: TextStyles.font12PrimSemi,
                                  ),
                                  horizontalSpace(10),
                                  Expanded(
                                    child: Divider(
                                      height: 1.h,
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
