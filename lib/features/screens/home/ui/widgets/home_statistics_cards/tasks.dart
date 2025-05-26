import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_state.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  String selectedPriority = 'High';

  final List<String> priorities = ['High', 'Medium', 'Low'];
  final Map<String, Color> priorityColors = {
    'High': Colors.red,
    'Medium': Colors.orange,
    'Low': Colors.green,
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();

        final isLoading = cubit.attendanceStatus?.data == null ||
            cubit.usersCountModel?.data == null;

        return Skeletonizer(
          enabled: isLoading,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          context.pushNamed(Routes.taskManagementScreen);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.fact_check,
                              color: AppColor.primaryColor,
                              size: 24.sp,
                            ),
                            horizontalSpace(8),
                            Text(
                              'Tasks  ',
                              style: TextStyles.font14BlackSemiBold,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 21.h,
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        decoration: BoxDecoration(
                          color: priorityColors[selectedPriority]!
                              .withOpacity(0.1),
                          border: Border.all(
                              color: priorityColors[selectedPriority]!),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: PopupMenuButton<String>(
                          padding: EdgeInsets.zero,
                          color: Colors.white,
                          icon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  selectedPriority,
                                  style: TextStyle(
                                    color: priorityColors[selectedPriority],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                horizontalSpace(4.w),
                                RotatedBox(
                                  quarterTurns: 3,
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: priorityColors[selectedPriority],
                                    size: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          menuPadding: EdgeInsets.zero,
                          itemBuilder: (context) {
                            List<PopupMenuEntry<String>> items = [];
                            for (int i = 0; i < priorities.length; i++) {
                              if (i > 0) {
                                items.add(PopupMenuDivider(height: 0.5.h));
                              }
                              items.add(
                                PopupMenuItem<String>(
                                  value: priorities[i],
                                  height: 28.h,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  child: Text(
                                    priorities[i],
                                    style: TextStyles.font12BlackSemi.copyWith(
                                      color: priorityColors[priorities[i]],
                                    ),
                                  ),
                                ),
                              );
                            }
                            return items;
                          },
                          onSelected: (value) {
                            setState(() {
                              selectedPriority = value;
                            });
                          },
                          offset: Offset(10, 22.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                        ),
                      )
                    ],
                  ),
                  verticalSpace(8),
                  StatusCountWidget(
                    label: 'Pending',
                    count: cubit.usersCountModel?.data?.values?[0] ?? 0,
                    onTap: () {},
                  ),
                  StatusCountWidget(
                    label: 'In Progress',
                    count: cubit.usersCountModel?.data?.values?[1] ?? 0,
                    onTap: () {},
                  ),
                  StatusCountWidget(
                    label: 'Waiting for Approvable',
                    count: cubit.usersCountModel?.data?.values?[2] ?? 0,
                    onTap: () {},
                  ),
                  StatusCountWidget(
                    label: 'Complete',
                    count: cubit.usersCountModel?.data?.values?[3] ?? 0,
                    onTap: () {},
                  ),
                  StatusCountWidget(
                    label: 'Not Resolved',
                    count: cubit.usersCountModel?.data?.values?[3] ?? 0,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class StatusCountWidget extends StatelessWidget {
  final String label;
  final int count;
  final VoidCallback? onTap;

  const StatusCountWidget({
    super.key,
    required this.label,
    required this.count,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 7.w,
              height: 7.h,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
            horizontalSpace(5),
            Text(
              label,
              style: TextStyles.font11lightblack,
              overflow: TextOverflow.ellipsis,
            ),
            Spacer(),
            Text(
              '$count',
              style: TextStyles.font11lightPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
