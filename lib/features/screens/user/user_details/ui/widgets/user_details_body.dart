import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/row_details_build.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/attendance_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/filter_attendance_dialog.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/filter_leaves_dialog.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/filter_task_dialog_.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/leaves_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/shift_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/task_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/work_location_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class UserDetailsBody extends StatefulWidget {
  final int id;
  const UserDetailsBody({super.key, required this.id});

  @override
  State<UserDetailsBody> createState() => _UserDetailsBodyState();
}

class _UserDetailsBodyState extends State<UserDetailsBody>
    with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    context.read<UserManagementCubit>().getUserDetails(widget.id);
    context.read<UserManagementCubit>().getUserShiftDetails(widget.id);
    context.read<UserManagementCubit>().getUserTaskDetails(widget.id);
    context.read<UserManagementCubit>().getUserWorkLocationDetails(widget.id);
    context.read<UserManagementCubit>().getAllHistory(widget.id);
    context.read<UserManagementCubit>().getAllLeaves(widget.id);
    context.read<UserManagementCubit>().getUserStatus(widget.id);
    context.read<UserManagementCubit>().getAllArea();
    context.read<UserManagementCubit>().getProviders();
    context.read<UserManagementCubit>().getRole();
    context.read<UserManagementCubit>().getShifts();

    controller = TabController(length: 6, vsync: this);
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
                context.pushNamed(Routes.editUserScreen, arguments: widget.id);
              },
              icon: Icon(
                Icons.edit,
                color: AppColor.primaryColor,
              ))
        ],
      ),
      body: BlocConsumer<UserManagementCubit, UserManagementState>(
        listener: (context, state) {
          if (state is UserDeleteInDetailsSuccessState) {
            toast(
                text: state.deleteUserDetailsModel.message!,
                color: Colors.blue);
            context.pushNamedAndRemoveLastTwo(Routes.userManagmentScreen);
          }
          if (state is UserDeleteInDetailsErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          if ((context.read<UserManagementCubit>().userDetailsModel?.data ==
                      null &&
                  context.read<UserManagementCubit>().userStatusModel?.data ==
                      null) ||
              context.read<UserManagementCubit>().userShiftDetailsModel?.data ==
                  null ||
              context.read<UserManagementCubit>().userTaskDetailsModel?.data ==
                  null ||
              context
                      .read<UserManagementCubit>()
                      .userWorkLocationDetailsModel
                      ?.data ==
                  null ||
              context.read<UserManagementCubit>().attendanceLeavesModel?.data ==
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
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 80.w,
                          height: 80.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: Image.network(
                              '${ApiConstants.apiBaseUrl}${context.read<UserManagementCubit>().userDetailsModel!.data!.image}',
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/noImage.png',
                                  fit: BoxFit.fill,
                                );
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 1,
                          right: 10,
                          child: InkWell(
                            onTap: () {
                              // context.read<EditUserCubit>().galleryFile();
                            },
                            child: Container(
                              width: 15.w,
                              height: 15.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: context
                                              .read<UserManagementCubit>()
                                              .userStatusModel!
                                              .data!
                                              .status ==
                                          'not working'
                                      ? Colors.red
                                      : Colors.green,
                                  border: Border.all(
                                      color: Colors.white, width: 2.w)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  verticalSpace(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context
                            .read<UserManagementCubit>()
                            .userDetailsModel!
                            .data!
                            .firstName!,
                        style: TextStyles.font16BlackSemiBold,
                      ),
                      horizontalSpace(5),
                      Text(
                        context
                            .read<UserManagementCubit>()
                            .userDetailsModel!
                            .data!
                            .lastName!,
                        style: TextStyles.font16BlackSemiBold,
                      ),
                    ],
                  ),
                  verticalSpace(5),
                  Text(
                    context
                        .read<UserManagementCubit>()
                        .userDetailsModel!
                        .data!
                        .role!,
                    style: TextStyles.font11GreyMedium,
                  ),
                  verticalSpace(15),
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
                              "User Details",
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
                              " Work Location",
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
                              "Shifts",
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
                              "Tasks",
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
                              "Attendance",
                              style: TextStyle(
                                  color: controller.index == 4
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
                                  color: controller.index == 5
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
                      userDetails(),
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
                              context
                                  .read<UserManagementCubit>()
                                  .userDelete(widget.id);
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

  Widget userDetails() {
    final userModel = context.read<UserManagementCubit>().userDetailsModel!;

    return SingleChildScrollView(
      child: Column(
        children: [
          rowDetailsBuild(
              context, S.of(context).addUserText5, userModel.data!.userName!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(
              context, S.of(context).addUserText1, userModel.data!.firstName!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(
              context, S.of(context).addUserText2, userModel.data!.lastName!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(
              context, S.of(context).addUserText3, userModel.data!.email!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(context, S.of(context).addUserText10,
              userModel.data!.phoneNumber!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(
              context, S.of(context).addUserText4, userModel.data!.birthdate!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(
              context, S.of(context).addUserText7, userModel.data!.idNumber!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(context, S.of(context).addUserText8,
              userModel.data!.nationalityName!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(context, S.of(context).addUserText12,
              userModel.data!.countryName!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(
              context, S.of(context).addUserText9, userModel.data!.gender!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(context, 'Role', userModel.data!.role!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(
              context, 'Manager', userModel.data!.managerName ?? 'No Manager'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          rowDetailsBuild(context, S.of(context).addUserText15,
              userModel.data!.providerName ?? 'No provider'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
        ],
      ),
    );
  }

  Widget locationUserDetails() {
    final workLocationModel =
        context.read<UserManagementCubit>().userWorkLocationDetailsModel!;
    if (workLocationModel.data == null ||
        (workLocationModel.data!.areas!.isEmpty &&
            workLocationModel.data!.cities!.isEmpty &&
            workLocationModel.data!.organizations!.isEmpty &&
            workLocationModel.data!.buildings!.isEmpty &&
            workLocationModel.data!.floors!.isEmpty &&
            workLocationModel.data!.points!.isEmpty)) {
      return Center(
        child: Text(
          "There's no data",
          style: TextStyles.font13Blackmedium,
        ),
      );
    }
    return SingleChildScrollView(child: listWorkLocationItemBuild(context));
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
    return SingleChildScrollView(
      child: Column(
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
                  onTap: () {
                    context
                        .read<UserManagementCubit>()
                        .createdByController
                        .clear();
                    context
                        .read<UserManagementCubit>()
                        .assignToController
                        .clear();
                    context
                        .read<UserManagementCubit>()
                        .statusController
                        .clear();
                    context
                        .read<UserManagementCubit>()
                        .startDateController
                        .clear();
                    context
                        .read<UserManagementCubit>()
                        .endDateController
                        .clear();
                    context
                        .read<UserManagementCubit>()
                        .priorityController
                        .clear();
                    context.read<UserManagementCubit>().roleController.clear();

                    context
                        .read<UserManagementCubit>()
                        .startTimeController
                        .clear();
                    context
                        .read<UserManagementCubit>()
                        .endTimeController
                        .clear();
                    context.read<UserManagementCubit>().areaController.clear();
                    context.read<UserManagementCubit>().cityController.clear();
                    context
                        .read<UserManagementCubit>()
                        .organizationController
                        .clear();
                    context
                        .read<UserManagementCubit>()
                        .buildingController
                        .clear();
                    context.read<UserManagementCubit>().floorController.clear();
                    context.read<UserManagementCubit>().pointController.clear();

                    CustomFilterTaskDialog.show(
                        context: context, id: widget.id);
                  },
                  child: Container(
                    height: 49.h,
                    width: 49.w,
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
      ),
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
    return SingleChildScrollView(
      child: Column(
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
                  onTap: () {
                    CustomFilterAttedanceDialog.show(
                        context: context, id: widget.id);
                  },
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
      ),
    );
  }

  Widget userLeavesDetails() {
    final attendanceData =
        context.read<UserManagementCubit>().attendanceLeavesModel?.data?.leaves;

    if (attendanceData == null || attendanceData.isEmpty) {
      return Center(
        child: Text(
          "There's no data",
          style: TextStyles.font13Blackmedium,
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
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
                  onTap: () {
                    CustomFilterLeavesDialog.show(
                        context: context, id: widget.id);
                  },
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
      ),
    );
  }
}
