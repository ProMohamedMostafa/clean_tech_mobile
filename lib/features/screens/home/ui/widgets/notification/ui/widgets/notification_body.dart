import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/integration_buttons/integrations_buttons.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/notification/logic/notification_cubit.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/notification/logic/notification_state.dart';
import 'package:smart_cleaning_application/features/screens/home/ui/widgets/notification/ui/widgets/notification_list_details_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class NotificationBody extends StatelessWidget {
  const NotificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotificationCubit>();
    return BlocConsumer<NotificationCubit, NotificationState>(
      listener: (context, state) {
        if (state is MarkReadSuccessState) {
          toast(text: state.message, isSuccess: true);
        }
        if (state is MarkReadErrorState) {
          toast(text: state.error, isSuccess: false);
        }
      },
      builder: (context, state) {
        final isRead = cubit.allNotificationsRead();
        return Scaffold(
          appBar: AppBar(
            leading: CustomBackButton(),
            title: Text(S.of(context).notifications),
            actions: [
              InkWell(
                borderRadius: BorderRadius.circular(20),
                overlayColor: const WidgetStatePropertyAll(Colors.white),
                onTap: () {
                  if (!isRead) {
                    cubit.markRead();
                  } else {
                    toast(
                      text: S.of(context).alreadyMarkedAsRead,
                      isSuccess: true,
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
            enabled: (cubit.notificationModel?.data?.data?.length == null &&
                cubit.unReadNotificationModel?.data?.data?.length == null),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  integrationsButtons(
                    selectedIndex: cubit.selectedIndex,
                    onTap: (index) => cubit.changeTap(index),
                    firstCount:
                        cubit.notificationModel?.data?.data?.length ?? 0,
                    firstLabel: S.of(context).all,
                    secondCount:
                        cubit.unReadNotificationModel?.data?.data?.length ?? 0,
                    secondLabel: S.of(context).unread,
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
