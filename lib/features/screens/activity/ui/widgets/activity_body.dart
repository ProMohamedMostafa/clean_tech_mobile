import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/activity/logic/activity_cubit.dart';
import 'package:smart_cleaning_application/features/screens/activity/logic/activity_state.dart';
import 'package:smart_cleaning_application/features/screens/activity/ui/widgets/activity_list_details_build.dart';
import 'package:smart_cleaning_application/features/screens/activity/ui/widgets/filter_search_build.dart';

class ActivityBody extends StatefulWidget {
  const ActivityBody({super.key});

  @override
  State<ActivityBody> createState() => _ActivityBodyState();
}

class _ActivityBodyState extends State<ActivityBody> {
  int selectedIndex = 0;

  @override
  void initState() {
    final cubit = context.read<ActivityCubit>();
    cubit.getMyActivities();
    cubit.getTeamActivities();
    cubit.myInitialize();
    cubit.teamInitialize();
    cubit.getRole();
    super.initState();
  }

  @override
  void dispose() {
    context.read<ActivityCubit>().myActivitiesScrollController.dispose();
    context.read<ActivityCubit>().teamActivitiesScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity'),
        leading: customBackButton(context),
      ),
      body: BlocConsumer<ActivityCubit, ActivityState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = context.watch<ActivityCubit>();
          final isLoading =
              cubit.myActivities == null && cubit.teamActivities == null;

          return Skeletonizer(
            enabled: isLoading,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(15),
                    filterAndSearchBuild(context, cubit),
                    verticalSpace(15),

                    // Tab Switcher: My Activity / Team Activity
                    SizedBox(
                      height: 45.h,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double totalWidth = constraints.maxWidth;
                          double gap = 10;
                          double containerWidth = (totalWidth - gap) / 2;
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 2,
                            separatorBuilder: (context, index) =>
                                SizedBox(width: gap),
                            itemBuilder: (context, index) {
                              bool isSelected = selectedIndex == index;
                              final count = index == 0
                                  ? cubit.myActivities?.data.data.length ?? 0
                                  : cubit.teamActivities?.data.data.length ?? 0;

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
                                        "$count",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: isSelected
                                              ? Colors.white
                                              : AppColor.primaryColor,
                                        ),
                                      ),
                                      horizontalSpace(5),
                                      Text(
                                        index == 0
                                            ? "My Activity"
                                            : "My Team Activity",
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
                    Divider(color: Colors.grey[300]),
                    Expanded(
                      child: state is ActivityLoadingState &&
                              (cubit.myActivities == null ||
                                  cubit.teamActivities == null)
                          ? Center(
                              child: CircularProgressIndicator(
                                  color: AppColor.primaryColor))
                          : activityListDetailsBuild(context, selectedIndex),
                    ),
                    verticalSpace(10),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
