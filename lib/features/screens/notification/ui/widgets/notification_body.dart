import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/two_buttons_in_integreat_screen/two_buttons_in_integration_screen.dart';
import 'package:smart_cleaning_application/features/screens/notification/logic/notification_cubit.dart';
import 'package:smart_cleaning_application/features/screens/notification/logic/notification_state.dart';
import 'package:smart_cleaning_application/features/screens/notification/ui/widgets/notification_list_details_build.dart';

class NotificationBody extends StatelessWidget {
  const NotificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationCubit cubit = context.read<NotificationCubit>();
    return BlocConsumer<NotificationCubit, NotificationState>(
      listener: (context, state) {
        if (state is MarkReadSuccessState) {
          toast(text: state.message, color: Colors.blue);
        }
        if (state is MarkReadErrorState) {
          toast(text: state.error, color: Colors.red);
        }
      },
      builder: (context, state) {
        final isRead = context.read<NotificationCubit>().allNotificationsRead();
        return Scaffold(
          appBar: AppBar(
            leading: customBackButton(context),
            title: Text('Notifications'),
            actions: [
              InkWell(
                borderRadius: BorderRadius.circular(20),
                overlayColor: const WidgetStatePropertyAll(Colors.white),
                onTap: () {
                  if (!isRead) {
                    context.read<NotificationCubit>().markRead();
                  } else {
                    toast(
                      text: "Already marked as read",
                      color: Colors.blue,
                    );
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.done,
                        size: 24.sp,
                        color: isRead ? AppColor.primaryColor : Colors.grey,
                      ),
                      Transform.translate(
                        offset: Offset(-12, 0),
                        child: Icon(
                          Icons.done,
                          size: 24.sp,
                          color: isRead ? AppColor.primaryColor : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          body: Skeletonizer(
            enabled: (context
                        .read<NotificationCubit>()
                        .notificationModel
                        ?.data
                        ?.data
                        ?.length ==
                    null &&
                context
                        .read<NotificationCubit>()
                        .unReadNotificationModel
                        ?.data
                        ?.data
                        ?.length ==
                    null),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  twoButtonsIntegration(
                    selectedIndex: cubit.selectedIndex,
                    onTap: (index) => cubit.changeTap(index),
                    firstCount:
                        cubit.notificationModel?.data?.data?.length ?? 0,
                    firstLabel: 'All',
                    secondCount:
                        cubit.unReadNotificationModel?.data?.data?.length ?? 0,
                    secondLabel: 'Unread',
                  ),
                  verticalSpace(10),
                  Divider(color: Colors.grey[300]),
                  Expanded(
                      child: notificationListDetailsBuild(
                          context, cubit.selectedIndex)),
                  verticalSpace(10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
