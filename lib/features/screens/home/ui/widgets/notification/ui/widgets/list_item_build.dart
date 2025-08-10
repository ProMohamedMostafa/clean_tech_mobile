import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/notification/logic/notification_cubit.dart';

Widget listItemBuild(BuildContext context, selectedIndex, index) {
  final cubit = context.read<NotificationCubit>();
  String getTimeOnly(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    return DateFormat('HH:mm').format(dateTime);
  }

  final activity = selectedIndex == 0
      ? cubit.notificationModel!.data!.data![index]
      : cubit.unReadNotificationModel!.data!.data![index];
  final module = activity.module;
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
      case 'Device':
      case 'DeviceLimit':
        return Routes.sensorDetailsScreen;
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

  final routeName = getRouteName();
  return InkWell(
    borderRadius: BorderRadius.circular(11.r),
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
    child: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: selectedIndex == 0
              ? cubit.notificationModel!.data!.data![index].isRead == false
                  ? Color(0xff68B9FD).withOpacity(0.1)
                  : Colors.white
              : Color(0xff68B9FD).withOpacity(0.1),
          borderRadius: BorderRadius.circular(11.r),
          border: Border.all(color: Colors.black12)),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          height: 45.h,
          width: 45.w,
          decoration: BoxDecoration(shape: BoxShape.circle),
          clipBehavior: Clip.hardEdge,
          child: Image.network(
            selectedIndex == 0
                ? '${cubit.notificationModel!.data!.data![index].image}'
                : '${cubit.unReadNotificationModel!.data!.data![index].image}',
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/person.png',
                fit: BoxFit.fill,
              );
            },
          ),
        ),
        title: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            children: [
              TextSpan(
                text: selectedIndex == 0
                    ? cubit.notificationModel!.data!.data![index].userName!
                    : cubit
                        .unReadNotificationModel!.data!.data![index].userName!,
                style: TextStyles.font14BlackSemiBold,
              ),
              TextSpan(
                text:
                    ('  (${selectedIndex == 0 ? cubit.notificationModel!.data!.data![index].role! : cubit.unReadNotificationModel!.data!.data![index].role!})'),
                style: TextStyles.font11lightPrimary,
              ),
            ],
          ),
        ),
        subtitle: Text(
          selectedIndex == 0
              ? cubit.notificationModel!.data!.data![index].message!
              : cubit.unReadNotificationModel!.data!.data![index].message!,
          style: TextStyles.font12GreyRegular,
        ),
        trailing: Text(
          getTimeOnly(selectedIndex == 0
              ? cubit.notificationModel!.data!.data![index].createdAt.toString()
              : cubit.unReadNotificationModel!.data!.data![index].createdAt
                  .toString()),
          style: TextStyles.font12GreyRegular,
        ),
      ),
    ),
  );
}
