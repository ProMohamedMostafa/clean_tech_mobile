import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/activity/logic/activity_cubit.dart';
import 'package:smart_cleaning_application/features/screens/activity/ui/widgets/icons_widget.dart';

Widget listItemBuild(BuildContext context, selectedIndex, index) {
  final activity = selectedIndex == 0
      ? context.read<ActivityCubit>().myActivities?.data?.activities![index]
      : context.read<ActivityCubit>().teamActivities?.data?.activities![index];
  final module = activity!.module;
  final moduleId = activity.moduleId;

  String getRouteName() {
    if (moduleId == null) return '';
    switch (module) {
      case 'User':
        return Routes.userDetailsScreen;
      case 'Area':
      case 'City':
      case 'Organization':
      case 'Building':
      case 'Floor':
      case 'Section':
      case 'Point':
        return Routes.workLocationDetailsScreen;
      case 'Task':
        return Routes.taskDetailsScreen;
      case 'Shift':
        return Routes.shiftDetailsScreen;
      case 'Leave':
        return Routes.leavesDetailsScreen;
      case 'Material':
        return Routes.materialDetailsScreen;
      default:
        return '';
    }
  }

  int getWorkLocationIndex() {
    switch (module) {
      case 'Area':
        return 0;
      case 'City':
        return 1;
      case 'Organization':
        return 2;
      case 'Building':
        return 3;
      case 'Floor':
        return 4;
      case 'Section':
        return 5;
      case 'Point':
        return 6;
      default:
        return 0;
    }
  }

  Color getActionColor(String actionType) {
    switch (actionType) {
      case 'Create':
        return Colors.green;
      case 'Edit':
        return Colors.orange;
      case 'Delete':
        return Colors.red;
      case 'Restore':
        return Colors.teal;
      case 'ForceDelete':
        return Colors.deepOrange;
      case 'Login':
        return Colors.blue;
      case 'Logout':
        return Colors.indigo;
      case 'ClockInOut':
        return Colors.cyan;
      case 'ChangePassword':
        return Colors.brown;
      case 'EditProfile':
        return Colors.purple;
      case 'Assign':
        return Colors.lightGreen;
      case 'RemoveAssign':
        return Colors.pink;
      case 'StockIn':
        return Colors.blueGrey;
      case 'StockOut':
        return Colors.deepPurple;
      case 'ChangeStatus':
        return Colors.lime;
      case 'Comment':
        return Colors.amber;
      case 'EditSetting':
        return Colors.lightBlue;
      default:
        return Colors.black;
    }
  }

  final routeName = getRouteName();
  return InkWell(
    onTap: () {
      if (routeName.isNotEmpty) {
        if (routeName == Routes.workLocationDetailsScreen) {
          context.pushNamed(
            routeName,
            arguments: {
              'id': moduleId,
              'selectedIndex': getWorkLocationIndex()
            },
          );
        } else {
          context.pushNamed(routeName, arguments: moduleId);
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
            leading: buildActionIcon(selectedIndex == 0
                ? context
                    .read<ActivityCubit>()
                    .myActivities!
                    .data!
                    .activities![index]
                    .actionTypeId!
                : context
                    .read<ActivityCubit>()
                    .teamActivities!
                    .data!
                    .activities![index]
                    .actionTypeId!),
            title: Row(
              children: [
                Text(
                    selectedIndex == 0
                        ? context
                            .read<ActivityCubit>()
                            .myActivities!
                            .data!
                            .activities![index]
                            .userName!
                        : context
                            .read<ActivityCubit>()
                            .teamActivities!
                            .data!
                            .activities![index]
                            .userName!,
                    style: TextStyles.font14BlackRegular),
                horizontalSpace(8),
                Text(
                  selectedIndex == 0
                      ? context
                          .read<ActivityCubit>()
                          .myActivities!
                          .data!
                          .activities![index]
                          .role!
                      : context
                          .read<ActivityCubit>()
                          .teamActivities!
                          .data!
                          .activities![index]
                          .role!,
                  style: TextStyles.font9PrimRegular,
                ),
              ],
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedIndex == 0
                      ? context
                          .read<ActivityCubit>()
                          .myActivities!
                          .data!
                          .activities![index]
                          .actionType!
                      : context
                          .read<ActivityCubit>()
                          .teamActivities!
                          .data!
                          .activities![index]
                          .actionType!,
                  style: TextStyles.font12BlackSemi.copyWith(
                    color: getActionColor(
                      selectedIndex == 0
                          ? context
                              .read<ActivityCubit>()
                              .myActivities!
                              .data!
                              .activities![index]
                              .actionType!
                          : context
                              .read<ActivityCubit>()
                              .teamActivities!
                              .data!
                              .activities![index]
                              .actionType!,
                    ),
                  ),
                ),
                Text(
                  selectedIndex == 0
                      ? context
                          .read<ActivityCubit>()
                          .myActivities!
                          .data!
                          .activities![index]
                          .message!
                      : context
                          .read<ActivityCubit>()
                          .teamActivities!
                          .data!
                          .activities![index]
                          .message!,
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
                  selectedIndex == 0
                      ? _formatTimeDifference(context
                          .read<ActivityCubit>()
                          .myActivities!
                          .data!
                          .activities![index]
                          .createdAt!)
                      : _formatTimeDifference(context
                          .read<ActivityCubit>()
                          .teamActivities!
                          .data!
                          .activities![index]
                          .createdAt!),
                  style: TextStyles.font11GreyMedium),
            ],
          ),
        ),
      ],
    ),
  );
}

String _formatTimeDifference(DateTime time) {
  final now = DateTime.now();
  final difference = now.difference(time);

  if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
  } else {
    return DateFormat('MMM d, y').format(time);
  }
}
