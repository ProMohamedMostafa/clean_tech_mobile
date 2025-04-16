import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/notification/logic/notification_cubit.dart';
import 'package:smart_cleaning_application/features/screens/notification/logic/notification_state.dart';
import 'package:smart_cleaning_application/features/screens/notification/ui/widgets/notification_list_details_build.dart';

class NotificationBody extends StatefulWidget {
  const NotificationBody({super.key});

  @override
  State<NotificationBody> createState() => _NotificationBodyState();
}

int? selectedIndex = 0;

class _NotificationBodyState extends State<NotificationBody> {
  @override
  void initState() {
    context.read<NotificationCubit>().getNotification();
    context.read<NotificationCubit>().getUnReadNotification();

    super.initState();
  }

  bool isRead = false;
  @override
  Widget build(BuildContext context) {
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
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 45.h,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          // Total available width
                          double totalWidth = constraints.maxWidth;
                          // Gap between the containers
                          double gap = 10;
                          // Width for each container
                          double containerWidth = (totalWidth - gap) / 2;

                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 2,
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                  width: gap); // 10px gap between containers
                            },
                            itemBuilder: (context, index) {
                              bool isSelected = selectedIndex == index;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  height: 45.h,
                                  width: containerWidth,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColor.primaryColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: AppColor.secondaryColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        index == 0
                                            ? "${context.read<NotificationCubit>().notificationModel?.data?.data?.length ?? 0}"
                                            : "${context.read<NotificationCubit>().unReadNotificationModel?.data?.data?.length ?? 0}",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: isSelected
                                              ? Colors.white
                                              : AppColor.primaryColor,
                                        ),
                                      ),
                                      horizontalSpace(5),
                                      Text(
                                        index == 0 ? "All" : 'Unread',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: isSelected
                                              ? Colors.white
                                              : AppColor.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    verticalSpace(10),
                    Divider(
                      color: Colors.grey[300],
                    ),
                    Expanded(
                      child: state is NotificationLoadingState &&
                              (context
                                          .read<NotificationCubit>()
                                          .notificationModel ==
                                      null ||
                                  context
                                          .read<NotificationCubit>()
                                          .unReadNotificationModel ==
                                      null)
                          ? Center(
                              child: CircularProgressIndicator(
                                  color: AppColor.primaryColor))
                          : notificationListDetailsBuild(
                              context, selectedIndex!),
                    ),
                    verticalSpace(10),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
