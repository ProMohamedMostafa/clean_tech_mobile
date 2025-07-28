import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/activity/logic/activity_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/activity/ui/widgets/icons_widget.dart';

class ActivityListItemBuild extends StatelessWidget {
  final int index;
  const ActivityListItemBuild({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ActivityCubit>();
    final activity = cubit.selectedIndex == 0
        ? cubit.myActivities?.data?.activities![index]
        : cubit.teamActivities?.data?.activities![index];

    final routeName = cubit.getRouteName(activity?.module, activity?.moduleId);

    return InkWell(
      onTap: () {
        if (routeName.isNotEmpty) {
          if (routeName == Routes.workLocationDetailsScreen) {
            context.pushNamed(
              routeName,
              arguments: {
                'id': activity?.moduleId,
                'selectedIndex': cubit.getWorkLocationIndex(activity?.module),
              },
            );
          } else {
            context.pushNamed(routeName, arguments: activity?.moduleId);
          }
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 5),
              minTileHeight: 60.h,
              leading: ActionIcon(
                  actionId: cubit.selectedIndex == 0
                      ? cubit
                          .myActivities!.data!.activities![index].actionTypeId!
                      : cubit.teamActivities!.data!.activities![index]
                          .actionTypeId!),
              title: Row(
                children: [
                  Text(
                      cubit.selectedIndex == 0
                          ? cubit
                              .myActivities!.data!.activities![index].userName!
                          : cubit.teamActivities!.data!.activities![index]
                                  .userName ??
                              '',
                      style: TextStyles.font14BlackRegular),
                  horizontalSpace(8),
                  Text(
                    cubit.selectedIndex == 0
                        ? cubit.myActivities!.data!.activities![index].role!
                        : cubit.teamActivities!.data!.activities![index].role ??
                            '',
                    style: TextStyles.font9PrimRegular,
                  ),
                ],
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cubit.selectedIndex == 0
                        ? cubit
                            .myActivities!.data!.activities![index].actionType!
                        : cubit.teamActivities!.data!.activities![index]
                            .actionType!,
                    style: TextStyles.font12BlackSemi.copyWith(
                      color: cubit.getActionColor(
                        cubit.selectedIndex == 0
                            ? cubit.myActivities!.data!.activities![index]
                                .actionType!
                            : cubit.teamActivities!.data!.activities![index]
                                .actionType!,
                      ),
                    ),
                  ),
                  Text(
                    cubit.selectedIndex == 0
                        ? cubit.myActivities!.data!.activities![index].message!
                        : cubit
                            .teamActivities!.data!.activities![index].message!,
                    style: TextStyles.font12GreyRegular,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 80.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    cubit.selectedIndex == 0
                        ? cubit.formatTimeDifference(cubit
                            .myActivities!.data!.activities![index].createdAt!)
                        : cubit.formatTimeDifference(cubit.teamActivities!.data!
                            .activities![index].createdAt!),
                    style: TextStyles.font11GreyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
