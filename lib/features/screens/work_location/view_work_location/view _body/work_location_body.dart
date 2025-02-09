import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/row_details_build.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/attendance_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/leaves_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/shift_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/task_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_states.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class WorkLocationDetailsBody extends StatefulWidget {
  final int selectedIndex;
  final int id;
  const WorkLocationDetailsBody(
      {super.key, required this.id, required this.selectedIndex});

  @override
  State<WorkLocationDetailsBody> createState() =>
      _WorkLocationDetailsBodyState();
}

class _WorkLocationDetailsBodyState extends State<WorkLocationDetailsBody>
    with TickerProviderStateMixin {
  late TabController controller;
  bool descTextShowFlag = false;

  @override
  void initState() {
    // context.read<WorkLocationCubit>().getUserWorkLocationDetails(widget.id);
    // context.read<WorkLocationCubit>().getUserShiftDetails(widget.id);
    // context.read<WorkLocationCubit>().getUserTaskDetails(widget.id);
    // context.read<WorkLocationCubit>().getAllHistory(widget.id);
    // context.read<WorkLocationCubit>().getAllLeaves(widget.id);
    controller = TabController(length: 5, vsync: this);
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).userDetailsTitle,
          style: TextStyles.font16BlackSemiBold,
        ),
        centerTitle: true,
        leading: customBackButton(context),
        actions: [
          IconButton(
            onPressed: () {
              // generateAndSavePDF(context);
            },
            icon: Icon(
              CupertinoIcons.tray_arrow_down,
              color: Colors.red,
              size: 22.sp,
            ),
          ),
          IconButton(
              onPressed: () {
                widget.selectedIndex == 0
                    ? context.pushNamed(Routes.editAreaScreen,
                        arguments: widget.id)
                    : widget.selectedIndex == 1
                        ? context.pushNamed(Routes.editCityScreen,
                            arguments: widget.id)
                        : widget.selectedIndex == 2
                            ? context.pushNamed(Routes.editOrganizationScreen,
                                arguments: widget.id)
                            : widget.selectedIndex == 3
                                ? context.pushNamed(Routes.editBuildingScreen,
                                    arguments: widget.id)
                                : widget.selectedIndex == 4
                                    ? context.pushNamed(Routes.editFloorScreen,
                                        arguments: widget.id)
                                    : context.pushNamed(Routes.editPointScreen,
                                        arguments: widget.id);
              },
              icon: Icon(
                Icons.edit,
                color: AppColor.primaryColor,
              ))
        ],
      ),
      body: BlocConsumer<WorkLocationCubit, WorkLocationState>(
        listener: (context, state) {
          if (state is PointDeleteSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.pushNamedAndRemoveLastTwo(Routes.workLocationScreen);
          }
          if (state is PointDeleteErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          if (context.read<WorkLocationCubit>().pointDetailsModel == null ||
              context.read<WorkLocationCubit>().pointManagersDetailsModel ==
                  null ||
              context.read<WorkLocationCubit>().pointShiftsDetailsModel ==
                  null) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ),
            );
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 42.h,
                    width: double.infinity,
                    child: TabBar(
                        tabAlignment: TabAlignment.center,
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.tab,
                        controller: controller,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.r)),
                          color: controller.index == controller.index
                              ? AppColor.primaryColor
                              : Colors.transparent,
                        ),
                        tabs: [
                          Tab(
                            child: Text(
                              " Work Location",
                              style: TextStyle(
                                  color: controller.index == 0
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Shifts",
                              style: TextStyle(
                                  color: controller.index == 1
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Tasks",
                              style: TextStyle(
                                  color: controller.index == 2
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Attendance",
                              style: TextStyle(
                                  color: controller.index == 3
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Leaves",
                              style: TextStyle(
                                  color: controller.index == 4
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp),
                            ),
                          ),
                        ]),
                  ),
                  verticalSpace(20),
                  Expanded(
                    child: TabBarView(controller: controller, children: [
                      locationUserDetails(),
                      userShiftsDetails(),
                      userTasksDetails(),
                      userAttendanceDetails(),
                      userLeavesDetails()
                    ]),
                  ),
                  verticalSpace(15),
                  (uId == widget.id)
                      ? SizedBox.shrink()
                      : DefaultElevatedButton(
                          name: S.of(context).deleteButton,
                          onPressed: () {
                            showCustomDialog(
                                context, S.of(context).deleteMessage, () {
                              widget.selectedIndex == 0
                                  ? context
                                      .read<WorkLocationCubit>()
                                      .deleteArea(widget.id)
                                  : widget.selectedIndex == 1
                                      ? context
                                          .read<WorkLocationCubit>()
                                          .deleteCity(widget.id)
                                      : widget.selectedIndex == 2
                                          ? context
                                              .read<WorkLocationCubit>()
                                              .deleteOrganization(widget.id)
                                          : widget.selectedIndex == 3
                                              ? context
                                                  .read<WorkLocationCubit>()
                                                  .deleteBuilding(widget.id)
                                              : widget.selectedIndex == 4
                                                  ? context
                                                      .read<WorkLocationCubit>()
                                                      .deleteFloor(widget.id)
                                                  : context
                                                      .read<WorkLocationCubit>()
                                                      .deletePoint(widget.id);
                            });
                          },
                          color: Colors.red,
                          height: 48,
                          width: double.infinity,
                          textStyles: TextStyles.font20Whitesemimedium),
                  verticalSpace(20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget locationUserDetails() {
    final workLocationDetailsModel =
        context.read<WorkLocationCubit>().pointDetailsModel!.data!;

    return SingleChildScrollView(
      child: Column(
        children: [
          rowDetailsBuild(
              context, "Country", workLocationDetailsModel.countryName!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(context, "Area", workLocationDetailsModel.areaName!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(context, "City", workLocationDetailsModel.cityName!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(context, "Organization",
              workLocationDetailsModel.organizationName!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(
              context, "Building", workLocationDetailsModel.buildingName!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(
              context, "Floor", workLocationDetailsModel.floorName!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          if(widget.selectedIndex == 6)
          rowDetailsBuild(context, "Point", workLocationDetailsModel.name!,color: AppColor.primaryColor),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          Text(
            'Description',
            style: TextStyles.font14GreyRegular,
          ),
          Text(
            workLocationDetailsModel.description!,
            overflow: TextOverflow.ellipsis,
            maxLines: descTextShowFlag ? 40 : 3,
            style: TextStyles.font14GreyRegular,
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                  borderRadius: BorderRadius.circular(5.r),
                  onTap: () {
                    setState(() {
                      descTextShowFlag = !descTextShowFlag;
                    });
                  },
                  child: descTextShowFlag
                      ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            "Read less",
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            "Read more",
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                        ))),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
        ],
      ),
    );
    // if (workLocationModel.data == null) {
    //   return Center(
    //     child: Text(
    //       "There's no data",
    //       style: TextStyles.font13Blackmedium,
    //     ),
    //   );
    // } else {
    //   return SingleChildScrollView(child: listWorkLocationItemBuild(context));
    // }
  }

  Widget userShiftsDetails() {
    final shiftModel =
        context.read<UserManagementCubit>().userShiftDetailsModel!;
    if (shiftModel.data!.shifts == null || shiftModel.data!.shifts!.isEmpty) {
      return Center(
        child: Text(
          "There's no data",
          style: TextStyles.font13Blackmedium,
        ),
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: shiftModel.data!.shifts!.length,
              separatorBuilder: (context, index) {
                return verticalSpace(10);
              },
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    listShiftItemBuild(context, index),
                  ],
                );
              },
            ),
          ),
        ],
      );
    }
  }

  Widget userTasksDetails() {
    final taskModel = context.read<UserManagementCubit>().userTaskDetailsModel!;
    if (taskModel.data!.data == null || taskModel.data!.data!.isEmpty) {
      return Center(
        child: Text(
          "There's no data",
          style: TextStyles.font13Blackmedium,
        ),
      );
    }
    return Column(
      children: [
        Divider(),
        verticalSpace(5),
        SizedBox(
          height: 45.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter',
                style: TextStyles.font16BlackSemiBold,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColor.secondaryColor),
                  ),
                  child: Icon(
                    Icons.tune,
                    color: AppColor.primaryColor,
                    size: 25.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpace(10),
        ListView.separated(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: taskModel.data!.data!.length,
          separatorBuilder: (context, index) {
            return verticalSpace(10);
          },
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildTaskCardItem(context, index),
              ],
            );
          },
        )
      ],
    );
  }

  Widget userAttendanceDetails() {
    final attendanceData =
        context.read<UserManagementCubit>().attendanceHistoryModel?.data?.data;

    if (attendanceData == null || attendanceData.isEmpty) {
      return Center(
        child: Text(
          "There's no data",
          style: TextStyles.font13Blackmedium,
        ),
      );
    }
    return Column(
      children: [
        Divider(),
        verticalSpace(5),
        SizedBox(
          height: 45.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter',
                style: TextStyles.font16BlackSemiBold,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColor.secondaryColor),
                  ),
                  child: Icon(
                    Icons.tune,
                    color: AppColor.primaryColor,
                    size: 25.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpace(10),
        ListView.separated(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: attendanceData.length,
          separatorBuilder: (context, index) {
            return verticalSpace(10);
          },
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildAttendanceCardItem(context, index),
              ],
            );
          },
        )
      ],
    );
  }

  Widget userLeavesDetails() {
    final attendanceData =
        context.read<UserManagementCubit>().attendanceLeavesModel?.data?.data;

    if (attendanceData == null || attendanceData.isEmpty) {
      return Center(
        child: Text(
          "There's no data",
          style: TextStyles.font13Blackmedium,
        ),
      );
    }
    return Column(
      children: [
        Divider(),
        verticalSpace(5),
        SizedBox(
          height: 45.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter',
                style: TextStyles.font16BlackSemiBold,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColor.secondaryColor),
                  ),
                  child: Icon(
                    Icons.tune,
                    color: AppColor.primaryColor,
                    size: 25.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpace(10),
        ListView.separated(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: attendanceData.length,
          separatorBuilder: (context, index) {
            return verticalSpace(10);
          },
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildLeavesCardItem(context, index),
              ],
            );
          },
        )
      ],
    );
  }
}
