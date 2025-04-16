import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/notification/logic/notification_cubit.dart';
import 'package:smart_cleaning_application/features/screens/notification/ui/widgets/list_item_build.dart';

Widget notificationListDetailsBuild(BuildContext context, int selectedIndex) {
  String getDateOnly(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final inputDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (inputDate == today) {
      return 'Today';
    } else if (inputDate == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('yyyy-MM-dd').format(dateTime);
    }
  }

  final notificationData = selectedIndex == 0
      ? context.read<NotificationCubit>().notificationModel?.data?.data
      : context.read<NotificationCubit>().unReadNotificationModel?.data?.data;

  if (notificationData == null || notificationData.isEmpty) {
    return Center(
      child: Text(
        "There's no data",
        style: TextStyles.font13Blackmedium,
      ),
    );
  }

  // Group notifications by date
  final Map<String, List<dynamic>> groupedNotifications = {};

  for (var notification in notificationData) {
    final dateKey = getDateOnly(notification.createdAt.toString());
    groupedNotifications.putIfAbsent(dateKey, () => []).add(notification);
  }

  // Sort keys: Today first, then Yesterday, then by date descending
  final groupedKeys = groupedNotifications.keys.toList()
    ..sort((a, b) {
      if (a == 'Today') return -1;
      if (b == 'Today') return 1;
      if (a == 'Yesterday') return -1;
      if (b == 'Yesterday') return 1;
      return b.compareTo(a);
    });

  return ListView.builder(
    controller: selectedIndex == 0
        ? context.read<NotificationCubit>().scrollController
        : context.read<NotificationCubit>().unreadScrollController,
    shrinkWrap: true,
    itemCount: groupedKeys.length,
    itemBuilder: (context, groupIndex) {
      final dateKey = groupedKeys[groupIndex];
      final items = groupedNotifications[dateKey]!;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              dateKey,
              style: TextStyles.font14BlackSemiBold,
            ),
          ),
          ...List.generate(items.length, (index) {
            final notification = items[index];
            final originalIndex = notificationData.indexOf(notification);
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: listItemBuild(context, selectedIndex, originalIndex),
            );
          }),
        ],
      );
    },
  );
}
