import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/logic/task_management_cubit.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/logic/task_management_state.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/ui/widget/task_management_filter_search_build.dart';

class TaskManagementBody extends StatefulWidget {
  const TaskManagementBody({super.key});

  @override
  State<TaskManagementBody> createState() => _TaskManagementBodyState();
}

class _TaskManagementBodyState extends State<TaskManagementBody> {
  List<String> tapList = [
    "New",
    "In Progress",
    "Not Resolved",
    "Completed",
  ];
  @override
  void initState() {
    // context.read<OrganizationsCubit>()
    //   ..getArea()
    //   ..getCity()
    //   ..getOrganization()
    //   ..getBuilding()
    //   ..getFloor()
    //   ..getPoint();

    super.initState();
  }

  int? selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text('Tasks', style: TextStyles.font16BlackSemiBold),
        centerTitle: true,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: SizedBox(
          height: 50.h,
          width: 50.w,
          child: ElevatedButton(
            onPressed: () {
              context.pushNamed(Routes.addTaskScreen);
            },
            style: ElevatedButton.styleFrom(
              padding: REdgeInsets.all(0),
              backgroundColor: AppColor.primaryColor,
              shape: CircleBorder(),
              side: BorderSide(
                color: AppColor.secondaryColor,
                width: 1,
              ),
            ),
            child: Icon(
              IconBroken.plus,
              color: Colors.white,
              size: 26.sp,
            ),
          ),
        ),
      ),
      body: BlocConsumer<TaskManagementCubit, TaskManagementState>(
        listener: (context, state) {
          // if (state is AreaErrorState) {
          //   toast(text: state.error, color: Colors.red);
          // }
          // if (state is AreaDeleteSuccessState) {
          //   toast(text: state.message, color: Colors.blue);
          //   context.read<OrganizationsCubit>().getArea();
          // }
          // if (state is AreaDeleteSuccessState ||
          //     state is CityDeleteSuccessState ||
          //     state is OrganizationDeleteSuccessState ||
          //     state is BuildingDeleteSuccessState ||
          //     state is FloorDeleteSuccessState ||
          //     state is PointDeleteSuccessState) {
          //   String? message;

          //   if (state is AreaDeleteSuccessState) {
          //     message = state.message;
          //   } else if (state is CityDeleteSuccessState) {
          //     message = state.message;
          //   } else if (state is OrganizationDeleteSuccessState) {
          //     message = state.message;
          //   } else if (state is BuildingDeleteSuccessState) {
          //     message = state.message;
          //   } else if (state is FloorDeleteSuccessState) {
          //     message = state.message;
          //   } else if (state is PointDeleteSuccessState) {
          //     message = state.message;
          //   }

          //   if (message != null) {
          //     toast(text: message, color: Colors.blue);
          //   }
          //   context.read<OrganizationsCubit>()
          //     ..getArea()
          //     ..getCity()
          //     ..getOrganization()
          //     ..getBuilding()
          //     ..getFloor()
          //     ..getPoint();
          // }

          // if (state is AreaDeleteErrorState) {
          //   toast(text: state.error, color: Colors.red);
          // }
        },
        builder: (context, state) {
          // final cubit = context.read<OrganizationsCubit>();
          // if (state is AreaLoadingState ||
          //     state is CityLoadingState ||
          //     cubit.areaModel == null ||
          //     cubit.cityModel == null) {
          //   // Show loading indicator
          //   return const Center(
          //     child: CircularProgressIndicator(color: AppColor.primaryColor),
          //   );
          // }

          // // Ensure data is non-null before building the UI
          // final areaDetails = cubit.areaModel?.data;
          // final cityDetails = cubit.cityModel?.data;

          // if (areaDetails == null || cityDetails == null) {
          //   // Handle case where data fetching fails
          //   return const Center(
          //     child: Text("Failed to load organization details."),
          //   );
          // }

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(15),
                    taskManagementFilterAndDeleteBuild(context,
                        context.read<TaskManagementCubit>(), selectedIndex),
                    verticalSpace(15),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        height: 45.h,
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return horizontalSpace(10);
                          },
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: tapList.length,
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
                                width: 118.w,
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
                                          ? "${5}"
                                          : index == 1
                                              ? "${7}"
                                              : index == 2
                                                  ? "${3}"
                                                  : "${5}",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: isSelected
                                            ? Colors.white
                                            : AppColor.primaryColor,
                                      ),
                                    ),
                                    horizontalSpace(5),
                                    Text(
                                      tapList[index],
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
                        ),
                      ),
                    ),
                    verticalSpace(10),
                    Divider(
                      color: Colors.grey[300],
                    ),
                    // organizationDetailsBuild(context, selectedIndex!),
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
