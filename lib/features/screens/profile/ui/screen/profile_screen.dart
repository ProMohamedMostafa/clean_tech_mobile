import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/row_details_build.dart';
import 'package:smart_cleaning_application/features/screens/profile/logic/profile_cubit.dart';
import 'package:smart_cleaning_application/features/screens/profile/logic/profile_state.dart';
import 'package:smart_cleaning_application/features/screens/profile/ui/widgets/attendance_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/profile/ui/widgets/filter_attendance_dialog.dart';
import 'package:smart_cleaning_application/features/screens/profile/ui/widgets/filter_leaves_dialog.dart';
import 'package:smart_cleaning_application/features/screens/profile/ui/widgets/filter_task_dialog_.dart';
import 'package:smart_cleaning_application/features/screens/profile/ui/widgets/leaves_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/profile/ui/widgets/shift_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/profile/ui/widgets/task_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/profile/ui/widgets/work_location_list_item_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    context.read<ProfileCubit>().getUserProfileDetails();
    if (role != 'Admin') {
      context.read<ProfileCubit>().getUserShiftDetails(uId);
      context.read<ProfileCubit>().getUserTaskDetails(uId);
      context.read<ProfileCubit>().getUserWorkLocationDetails(uId);
      context.read<ProfileCubit>().getAllHistory(uId);
      context.read<ProfileCubit>().getAllLeaves(uId);
      context.read<ProfileCubit>().getUserProfileStatus();
      context.read<ProfileCubit>().getAllArea();
      context.read<ProfileCubit>().getShifts();
    }

    controller = TabController(length: role != 'Admin' ? 6 : 1, vsync: this);
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
                context.pushNamed(Routes.editProfileScreen, arguments: uId);
              },
              icon: Icon(
                Icons.edit,
                color: AppColor.primaryColor,
              ))
        ],
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (context.read<ProfileCubit>().profileModel?.data == null) {
            return Center(
              child: Image.asset(
                'assets/images/loading.gif',
                width: 100.w,
                height: 100.h,
                fit: BoxFit.contain,
              ),
            );
          }
          if (role != 'Admin') {
            if ((context.read<ProfileCubit>().profileModel?.data == null &&
                    context.read<ProfileCubit>().userStatusProfileModel?.data ==
                        null) ||
                context.read<ProfileCubit>().userShiftDetailsModel?.data ==
                    null ||
                context.read<ProfileCubit>().userTaskDetailsModel?.data ==
                    null ||
                context
                        .read<ProfileCubit>()
                        .userWorkLocationDetailsModel
                        ?.data ==
                    null ||
                context.read<ProfileCubit>().attendanceLeavesModel?.data ==
                    null) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              );
            }
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (contextt) => Scaffold(
                                  appBar: AppBar(
                                    leading: customBackButton(context),
                                  ),
                                  body: Center(
                                    child: PhotoView(
                                      imageProvider: NetworkImage(
                                        '${ApiConstants.apiBaseUrlImage}${context.read<ProfileCubit>().profileModel!.data!.image}',
                                      ),
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/person.png',
                                          fit: BoxFit.fill,
                                        );
                                      },
                                      backgroundDecoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 80.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Image.network(
                                '${ApiConstants.apiBaseUrlImage}${context.read<ProfileCubit>().profileModel!.data!.image}',
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
                        ),
                        if (role != 'Admin')
                          Positioned(
                            bottom: 1,
                            right: 10,
                            child: Container(
                              width: 15.w,
                              height: 15.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: context
                                              .read<ProfileCubit>()
                                              .userStatusProfileModel!
                                              .data!
                                              .status ==
                                          'not working'
                                      ? Colors.red
                                      : Colors.green,
                                  border: Border.all(
                                      color: Colors.white, width: 2.w)),
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
                            .read<ProfileCubit>()
                            .profileModel!
                            .data!
                            .firstName!,
                        style: TextStyles.font16BlackSemiBold,
                      ),
                      horizontalSpace(5),
                      Text(
                        context
                            .read<ProfileCubit>()
                            .profileModel!
                            .data!
                            .lastName!,
                        style: TextStyles.font16BlackSemiBold,
                      ),
                    ],
                  ),
                  verticalSpace(5),
                  Text(
                    context.read<ProfileCubit>().profileModel!.data!.role!,
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
                          if (role != 'Admin') ...[
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
                          ]
                        ]),
                  ),
                  verticalSpace(20),
                  Expanded(
                    child: TabBarView(controller: controller, children: [
                      userDetails(),
                      if (role != 'Admin') ...[
                        locationUserDetails(),
                        userShiftsDetails(),
                        userTasksDetails(),
                        userAttendanceDetails(),
                        userLeavesDetails()
                      ]
                    ]),
                  ),
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
    final userModel = context.read<ProfileCubit>().profileModel!;

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
        context.read<ProfileCubit>().userWorkLocationDetailsModel!;
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
    final shiftModel = context.read<ProfileCubit>().userShiftDetailsModel!;
    if (shiftModel.data == null || shiftModel.data!.isEmpty) {
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
              itemCount: shiftModel.data!.length,
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
    final taskModel = context.read<ProfileCubit>().userTaskDetailsModel!;
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
                    context.read<ProfileCubit>().createdByController.clear();
                    context.read<ProfileCubit>().assignToController.clear();
                    context.read<ProfileCubit>().statusController.clear();
                    context.read<ProfileCubit>().startDateController.clear();
                    context.read<ProfileCubit>().endDateController.clear();
                    context.read<ProfileCubit>().priorityController.clear();
                    context.read<ProfileCubit>().roleController.clear();

                    context.read<ProfileCubit>().startTimeController.clear();
                    context.read<ProfileCubit>().endTimeController.clear();
                    context.read<ProfileCubit>().areaController.clear();
                    context.read<ProfileCubit>().cityController.clear();
                    context.read<ProfileCubit>().organizationController.clear();
                    context.read<ProfileCubit>().buildingController.clear();
                    context.read<ProfileCubit>().floorController.clear();
                    context.read<ProfileCubit>().pointController.clear();

                    CustomFilterTaskDialog.show(context: context, id: uId);
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
        context.read<ProfileCubit>().attendanceHistoryModel?.data?.data;

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
                    CustomFilterAttedanceDialog.show(context: context, id: uId);
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
        context.read<ProfileCubit>().attendanceLeavesModel?.data?.leaves;

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
                    CustomFilterLeavesDialog.show(context: context, id: uId);
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
