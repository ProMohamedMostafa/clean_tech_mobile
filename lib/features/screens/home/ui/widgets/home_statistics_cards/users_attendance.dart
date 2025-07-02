import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class UsersAttendance extends StatelessWidget {
  const UsersAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();

        final isLoading = role == 'Cleaner'
            ? cubit.attendanceStatus?.data == null
            : cubit.attendanceStatus?.data == null ||
                cubit.usersCountModel?.data == null;

        return Skeletonizer(
          enabled: isLoading,
          child: Row(
            children: [
              if (role != 'Cleaner') ...[
                Expanded(
                  child: Container(
                    height: 100.h,
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
                          InkWell(
                            onTap: () {
                              context.pushNamed(Routes.userManagmentScreen);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.groups,
                                  color: AppColor.primaryColor,
                                  size: 24.sp,
                                ),
                                horizontalSpace(8),
                                Text(
                                  S.of(context).users,
                                  style: TextStyles.font14BlackSemiBold,
                                ),
                                const Spacer(),
                                Text(
                                  '${cubit.usersCountModel?.data?.total ?? 0}',
                                  style: TextStyles.font14Primarybold,
                                ),
                              ],
                            ),
                          ),
                          verticalSpace(8),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    context.pushNamed(
                                        Routes.userManagmentScreen,
                                        arguments: 1);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          S.of(context).admin,
                                          style: TextStyles.font11lightblack,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        '${cubit.usersCountModel?.data?.values?[0] ?? 0}',
                                        style: TextStyles.font11lightPrimary,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              horizontalSpace(8),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    context.pushNamed(
                                        Routes.userManagmentScreen,
                                        arguments: 2);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          S.of(context).manager,
                                          style: TextStyles.font11lightblack,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        '${cubit.usersCountModel?.data?.values?[1] ?? 0}',
                                        style: TextStyles.font11lightPrimary,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(8),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    context.pushNamed(
                                        Routes.userManagmentScreen,
                                        arguments: 3);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          S.of(context).supervisor,
                                          style: TextStyles.font11lightblack,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        '${cubit.usersCountModel?.data?.values?[2] ?? 0}',
                                        style: TextStyles.font11lightPrimary,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              horizontalSpace(8),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    context.pushNamed(
                                        Routes.userManagmentScreen,
                                        arguments: 4);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          S.of(context).cleaner,
                                          style: TextStyles.font11lightblack,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        '${cubit.usersCountModel?.data?.values?[3] ?? 0}',
                                        style: TextStyles.font11lightPrimary,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                horizontalSpace(10),
              ],
              Expanded(
                child: Container(
                  height: 100.h,
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
                        InkWell(
                          onTap: () {
                            context.pushNamed(Routes.historyScreen);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.fact_check_outlined,
                                color: AppColor.primaryColor,
                                size: 24.sp,
                              ),
                              horizontalSpace(8),
                              Flexible(
                                child: Text(
                                  S.of(context).attendance,
                                  style: TextStyles.font14BlackSemiBold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(8),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  context.pushNamed(Routes.historyScreen,
                                      arguments: 0);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.of(context).present,
                                      style: TextStyles.font11lightblack,
                                    ),
                                    Text(
                                      '${cubit.attendanceStatus?.data?.values?[0] ?? 0}',
                                      style: TextStyles.font11lightPrimary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            horizontalSpace(8),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  // context.pushNamed(Routes.historyScreen,
                                  //     arguments: 0);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.of(context).late,
                                      style: TextStyles.font11lightblack,
                                    ),
                                    Text(
                                      '1',
                                      style: TextStyles.font11lightPrimary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(8),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  context.pushNamed(Routes.historyScreen,
                                      arguments: 2);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.of(context).absent,
                                      style: TextStyles.font11lightblack,
                                    ),
                                    Text(
                                      '0',
                                      style: TextStyles.font11lightPrimary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            horizontalSpace(8),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  context.pushNamed(
                                    Routes.leavesScreen,
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.of(context).leaves,
                                      style: TextStyles.font11lightblack,
                                    ),
                                    Text(
                                      '${cubit.attendanceStatus?.data?.values?[2] ?? 0}',
                                      style: TextStyles.font11lightPrimary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
