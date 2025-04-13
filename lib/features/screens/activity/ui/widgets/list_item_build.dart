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
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
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
                        .data
                        .data[index]
                        .createdAt)
                    : _formatTimeDifference(context
                        .read<ActivityCubit>()
                        .teamActivities!
                        .data
                        .data[index]
                        .createdAt),
                style: TextStyles.font11GreyMedium),
            horizontalSpace(8),
            Text(
              selectedIndex == 0
                  ? context
                      .read<ActivityCubit>()
                      .myActivities!
                      .data
                      .data[index]
                      .role
                  : context
                      .read<ActivityCubit>()
                      .teamActivities!
                      .data
                      .data[index]
                      .role,
              style: TextStyles.font9PrimRegular,
            ),
          ],
        ),
      ),
      horizontalSpace(8),
      Expanded(
        child: InkWell(
          onTap: () {
            context.pushNamed(
              Routes.userDetailsScreen,
              arguments: selectedIndex == 0
                  ? context
                      .read<ActivityCubit>()
                      .myActivities!
                      .data
                      .data[index]
                      .userId
                  : context
                      .read<ActivityCubit>()
                      .teamActivities!
                      .data
                      .data[index]
                      .userId,
            );
          },
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
            minTileHeight: 60.h,
            leading: buildActionIcon(selectedIndex == 0
                ? context
                    .read<ActivityCubit>()
                    .myActivities!
                    .data
                    .data[index]
                    .actionTypeId!
                : context
                    .read<ActivityCubit>()
                    .teamActivities!
                    .data
                    .data[index]
                    .actionTypeId!),
            title: Text(
              selectedIndex == 0
                  ? context
                      .read<ActivityCubit>()
                      .myActivities!
                      .data
                      .data[index]
                      .userName
                  : context
                      .read<ActivityCubit>()
                      .teamActivities!
                      .data
                      .data[index]
                      .userName,
              style: TextStyles.font14Primarybold,
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
                          .data
                          .data[index]
                          .actionType
                      : context
                          .read<ActivityCubit>()
                          .teamActivities!
                          .data
                          .data[index]
                          .actionType,
                  style: TextStyles.font12BlackSemi,
                ),
                Text(
                  selectedIndex == 0
                      ? context
                          .read<ActivityCubit>()
                          .myActivities!
                          .data
                          .data[index]
                          .message
                      : context
                          .read<ActivityCubit>()
                          .teamActivities!
                          .data
                          .data[index]
                          .message,
                  style: TextStyles.font12GreyRegular,
                ),
              ],
            ),
          ),
        ),
      )
    ],
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
