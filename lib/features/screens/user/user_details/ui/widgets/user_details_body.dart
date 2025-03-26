import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/pdf.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/shift_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/task_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/work_location_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';
import 'package:photo_view/photo_view.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class UserDetailsBody extends StatefulWidget {
  final int id;
  const UserDetailsBody({super.key, required this.id});

  @override
  State<UserDetailsBody> createState() => _UserDetailsBodyState();
}

class _UserDetailsBodyState extends State<UserDetailsBody>
    with TickerProviderStateMixin {
  String formatTime(String? time) {
    if (time == null || time.isEmpty) return " ";
    try {
      DateTime parsedTime = DateTime.parse(time);
      return DateFormat('HH:mm').format(parsedTime);
    } catch (e) {
      return "Invalid Time";
    }
  }

  String formatDuration(String? duration) {
    if (duration == null || duration.isEmpty) {
      return "    ";
    }

    final durationParts = duration.split(':');
    if (durationParts.length != 3) {
      return "Invalid Format";
    }

    try {
      final hours = int.tryParse(durationParts[0]) ?? 0;
      final minutes = int.tryParse(durationParts[1]) ?? 0;
      final seconds = double.tryParse(durationParts[2])?.floor() ?? 0;

      if (hours > 0) {
        return '$hours hr';
      } else if (minutes > 0) {
        return '$minutes min';
      } else {
        return '$seconds sec';
      }
    } catch (e) {
      return "Invalid Data";
    }
  }

  late TabController controller;

  @override
  void initState() {
    if (role == 'Admin') {
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
    }

    if (role == 'Manager') {
      context.read<UserManagementCubit>().getUserDetails(widget.id);
      context.read<UserManagementCubit>().getUserShiftDetails(widget.id);
      context.read<UserManagementCubit>().getUserTaskDetails(widget.id);
      context.read<UserManagementCubit>().getUserWorkLocationDetails(widget.id);
      context.read<UserManagementCubit>().getAllHistory(widget.id);
      context.read<UserManagementCubit>().getAllLeaves(widget.id);
      context.read<UserManagementCubit>().getUserStatus(widget.id);
      context.read<UserManagementCubit>().getAllArea();
      context.read<UserManagementCubit>().getRole();
      context.read<UserManagementCubit>().getShifts();
    }

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
              createPDF();
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
                                        '${ApiConstants.apiBaseUrl}${context.read<UserManagementCubit>().userDetailsModel!.data!.image}',
                                      ),
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/noImage.png',
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
                        ),
                        Positioned(
                          bottom: 1,
                          right: 10,
                          child: Container(
                            width: 15.w,
                            height: 15.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context
                                          .read<UserManagementCubit>()
                                          .userStatusModel
                                          ?.data ==
                                      null
                                  ? Colors.red
                                  : context
                                              .read<UserManagementCubit>()
                                              .userStatusModel!
                                              .data!
                                              .clockOut ==
                                          null
                                      ? Colors.green
                                      : Colors.red,
                              border:
                                  Border.all(color: Colors.white, width: 2.w),
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
    if (workLocationModel.data!.areas!.isEmpty &&
        workLocationModel.data!.cities!.isEmpty &&
        workLocationModel.data!.organizations!.isEmpty &&
        workLocationModel.data!.buildings!.isEmpty &&
        workLocationModel.data!.floors!.isEmpty &&
        workLocationModel.data!.sections!.isEmpty &&
        workLocationModel.data!.points!.isEmpty) {
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

  Future<void> createPDF() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();
    final page2 = document.pages.add();
    final page3 = document.pages.add();
    final page4 = document.pages.add();
    final page5 = document.pages.add();
    final page6 = document.pages.add();
    final user = context.read<UserManagementCubit>().userDetailsModel!.data!;
    final userWorkLocationDetailsModel =
        context.read<UserManagementCubit>().userWorkLocationDetailsModel!.data;
    final userShiftDetails =
        context.read<UserManagementCubit>().userShiftDetailsModel!.data;
    final userTasksDetails =
        context.read<UserManagementCubit>().userTaskDetailsModel!.data;
    final userAttendanceDetails =
        context.read<UserManagementCubit>().attendanceHistoryModel!.data;

    final userLeaveDetails =
        context.read<UserManagementCubit>().attendanceLeavesModel!.data;
    PdfBrush backgroundBrush = PdfSolidBrush(PdfColor(255, 255, 255));

// Get page size
    Size pageSize = page.getClientSize();

// Draw the background rectangle
    page.graphics.drawRectangle(
        brush: backgroundBrush,
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height));

    // Load the image as a PDF bitmap
    PdfImage backgroundImage = PdfBitmap(await readImageData('background.png'));

// Draw the background image stretched to fill the page
    page.graphics.drawImage(
        backgroundImage, Rect.fromLTWH(0, 0, pageSize.width, pageSize.height));
    page2.graphics.drawImage(
        backgroundImage, Rect.fromLTWH(0, 0, pageSize.width, pageSize.height));
    page3.graphics.drawImage(
        backgroundImage, Rect.fromLTWH(0, 0, pageSize.width, pageSize.height));
    page4.graphics.drawImage(
        backgroundImage, Rect.fromLTWH(0, 0, pageSize.width, pageSize.height));

    PdfBitmap? profileImage;
    try {
      if (user.image != null && user.image!.isNotEmpty) {
        profileImage = PdfBitmap(await readImageData(user.image!));
      } else {
        profileImage = PdfBitmap(await readImageData('noImage.png'));
      }
    } catch (e) {
      profileImage = PdfBitmap(await readImageData('noImage.png'));
    }

    page.graphics.drawImage(
      profileImage,
      Rect.fromLTWH(410, 0, 50, 50),
    );

    page.graphics.drawString('${user.firstName} ${user.lastName}',
        PdfStandardFont(PdfFontFamily.helvetica, 16),
        bounds: Rect.fromLTWH(370, 55, page.getClientSize().width, 0));
    page.graphics.drawString(
      '${user.role}',
      PdfStandardFont(PdfFontFamily.helvetica, 14),
      brush: PdfBrushes.gray,
      bounds: Rect.fromLTWH(410, 75, page.getClientSize().width, 0),
    );

    page.graphics.drawImage(PdfBitmap(await readImageData('pdf_logo.png')),
        Rect.fromLTWH(0, 0, 160, 60));

    // Create Table
    PdfGrid grid = PdfGrid();
    grid.columns.add(count: 2);
    grid.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 18),
      cellPadding: PdfPaddings(left: 5, right: 5, top: 15, bottom: 5),
    );

    PdfGridRow headerRow = grid.rows.add();
    headerRow.cells[0].value = "User Details";
    headerRow.cells[0].columnSpan = 2;
    headerRow.cells[0].style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightGray,
      textBrush: PdfBrushes.black,
      font: PdfStandardFont(PdfFontFamily.helvetica, 20,
          style: PdfFontStyle.bold),
      cellPadding: PdfPaddings(left: 5, right: 5, top: 5, bottom: 5),
    );

    // Add Rows
    addRow(grid, "User Name", user.userName!);
    addRow(grid, "First Name", user.firstName!);
    addRow(grid, "Last Name", user.lastName!);
    addRow(grid, "Email", user.email!);
    addRow(grid, "Phone Number", user.phoneNumber!);
    addRow(grid, "Birthdate", user.birthdate!);
    addRow(grid, "ID Number", user.idNumber!);
    addRow(grid, "Nationality", user.nationalityName!);
    addRow(grid, "Country", user.countryName!);
    addRow(grid, "Gender", user.gender!);
    addRow(grid, "Role", user.role!);
    addRow(grid, "Manager", user.managerName ?? 'No manager');
    addRow(grid, "Provider", user.providerName ?? 'No provider');

    // Define a lighter gray color
    PdfPen lightGrayPen = PdfPen(PdfColor(220, 220, 220), width: 0.3);

// Adjust column widths to push values to the right
    grid.columns[0].width =
        page.getClientSize().width * 0.4; // Label column (40%)
    grid.columns[1].width =
        page.getClientSize().width * 0.6; // Value column (60%)

// Iterate over each row
    for (int i = 0; i < grid.rows.count; i++) {
      PdfGridRow row = grid.rows[i];

      for (int j = 0; j < row.cells.count; j++) {
        row.cells[j].style.borders = PdfBorders(
          left: PdfPen(PdfColor(255, 255, 255), width: 0), // Remove left border
          right:
              PdfPen(PdfColor(255, 255, 255), width: 0), // Remove right border
          top: PdfPen(PdfColor(255, 255, 255), width: 0), // Remove top border
          bottom: lightGrayPen, // Light gray bottom border
        );

        // Align labels to the left & values to the right
        if (j == 0) {
          row.cells[j].stringFormat.alignment = PdfTextAlignment.left;
        } else {
          row.cells[j].stringFormat.alignment = PdfTextAlignment.right;
        }
      }
    }

// Draw Table

    PdfLayoutResult result = grid.draw(
        page: page,
        bounds: Rect.fromLTWH(0, 150, page.getClientSize().width, 0))!;

// Manually Draw Lighter Gray Horizontal Lines
    double yPos = result.bounds.top;
    for (var i = 0; i < grid.rows.count; i++) {
      yPos += grid.rows[i].height;
      page.graphics.drawLine(
        lightGrayPen,
        Offset(0, yPos),
        Offset(page.getClientSize().width, yPos),
      );
    }
    // Create Table
    PdfGrid locationDetails = PdfGrid();
    locationDetails.columns.add(count: 6);
    locationDetails.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 14),
      cellPadding: PdfPaddings(left: 5, right: 5, top: 15, bottom: 5),
    );

    PdfGridRow locationDetailsHeader = locationDetails.rows.add();
    locationDetailsHeader.cells[0].value = "Work Location Details";
    locationDetailsHeader.cells[0].columnSpan = 6;
    locationDetailsHeader.cells[0].style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightGray,
      textBrush: PdfBrushes.black,
      font: PdfStandardFont(PdfFontFamily.helvetica, 20,
          style: PdfFontStyle.bold),
      cellPadding: PdfPaddings(left: 5, right: 5, top: 5, bottom: 5),
    );

    // Create Header Row
    PdfGridRow headerRow2 = locationDetails.rows.add();
    List<String> headers = [
      "Area",
      "City",
      "Organization",
      "Building",
      "Floor",
      "Point"
    ];

    for (int i = 0; i < headers.length; i++) {
      headerRow2.cells[i].value = headers[i];
      headerRow2.cells[i].style = PdfGridCellStyle(
        backgroundBrush: PdfBrushes.lightGray,
        textBrush: PdfBrushes.black,
        font: PdfStandardFont(PdfFontFamily.helvetica, 12,
            style: PdfFontStyle.bold),
        cellPadding: PdfPaddings(left: 5, right: 5, top: 5, bottom: 5),
      );
    }
    PdfGridRow dataRow = locationDetails.rows.add();
    List<String> values = userWorkLocationDetailsModel!.points!.isNotEmpty
        ? [
            userWorkLocationDetailsModel.areas!.map((e) => e.name).join("\n"),
            userWorkLocationDetailsModel.cities!.map((e) => e.name).join("\n"),
            userWorkLocationDetailsModel.organizations!
                .map((e) => e.name)
                .join("\n"),
            userWorkLocationDetailsModel.buildings!
                .map((e) => e.name)
                .join("\n"),
            userWorkLocationDetailsModel.floors!.map((e) => e.name).join("\n"),
            userWorkLocationDetailsModel.points!.map((e) => e.name).join("\n"),
          ]
        : ["There's no data"];

// Fill data row
    for (int i = 0; i < values.length; i++) {
      dataRow.cells[i].value = values[i]; // Assign names directly
      dataRow.cells[i].stringFormat =
          PdfStringFormat(alignment: PdfTextAlignment.center);
    }

// Adjust column widths evenly
    double columnWidth = page2.getClientSize().width / 6;
    for (int i = 0; i < locationDetails.columns.count; i++) {
      locationDetails.columns[i].width = columnWidth;
    }

// Draw Table
    locationDetails.draw(
        page: page2,
        bounds: Rect.fromLTWH(0, 50, page.getClientSize().width, 0));

    // Create Table
    PdfGrid shiftsDetails = PdfGrid();
    shiftsDetails.columns.add(count: 5);
    shiftsDetails.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 12),
      cellPadding: PdfPaddings(left: 5, right: 5, top: 15, bottom: 5),
    );

    PdfGridRow shiftDetailsHeader = shiftsDetails.rows.add();
    shiftDetailsHeader.cells[0].value = "Shifts Details";
    shiftDetailsHeader.cells[0].columnSpan = 5;
    shiftDetailsHeader.cells[0].style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightGray,
      textBrush: PdfBrushes.black,
      font: PdfStandardFont(PdfFontFamily.helvetica, 20,
          style: PdfFontStyle.bold),
      cellPadding: PdfPaddings(left: 5, right: 5, top: 5, bottom: 5),
    );

    // Create Header Row
    PdfGridRow headerRowShifts = shiftsDetails.rows.add();
    List<String> headersShifts = [
      "Shift Name",
      "Start Time",
      "End Time",
      "Start Date",
      "End Time",
    ];

    for (int i = 0; i < headersShifts.length; i++) {
      headerRowShifts.cells[i].value = headersShifts[i];
      headerRowShifts.cells[i].style = PdfGridCellStyle(
        backgroundBrush: PdfBrushes.lightGray,
        textBrush: PdfBrushes.black,
        font: PdfStandardFont(PdfFontFamily.helvetica, 14,
            style: PdfFontStyle.bold),
        cellPadding: PdfPaddings(left: 5, right: 5, top: 5, bottom: 5),
      );
    }
    PdfGridRow dataRowShift = shiftsDetails.rows.add();
    List<String> valuesShift = [
      userShiftDetails?.map((e) => e.name).join("\n") ?? "There's no data",
      userShiftDetails?.map((e) => e.startTime).join("\n") ?? "There's no data",
      userShiftDetails?.map((e) => e.endTime).join("\n") ?? "There's no data",
      userShiftDetails?.map((e) => e.startDate).join("\n") ?? "There's no data",
      userShiftDetails?.map((e) => e.endDate).join("\n") ?? "There's no data",
    ];

// Fill data row
    for (int i = 0; i < valuesShift.length; i++) {
      dataRowShift.cells[i].value = valuesShift[i]; // Assign names directly
      dataRowShift.cells[i].stringFormat =
          PdfStringFormat(alignment: PdfTextAlignment.center);
    }

// Adjust column widths evenly
    double columnWidthShift = page3.getClientSize().width / 5;
    for (int i = 0; i < shiftsDetails.columns.count; i++) {
      shiftsDetails.columns[i].width = columnWidthShift;
    }

// Draw Table
    shiftsDetails.draw(
      page: page3,
      bounds: Rect.fromLTWH(0, 50, page3.getClientSize().width, 0),
    );

// Create Table
    PdfGrid userTaskDetails = PdfGrid();
    userTaskDetails.columns.add(count: 2);
    userTaskDetails.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 18),
      cellPadding: PdfPaddings(left: 5, right: 5, top: 5, bottom: 5),
    );

    PdfGridRow userTaskDetailsHeaderRow = userTaskDetails.rows.add();
    userTaskDetailsHeaderRow.cells[0].value = "Task Details ";
    userTaskDetailsHeaderRow.cells[0].columnSpan = 2;
    userTaskDetailsHeaderRow.cells[0].style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightGray,
      textBrush: PdfBrushes.black,
      font: PdfStandardFont(PdfFontFamily.helvetica, 20,
          style: PdfFontStyle.bold),
      cellPadding: PdfPaddings(left: 5, right: 5, top: 5, bottom: 5),
    );

// data
    final List<Map<String, dynamic>> taskData = userTasksDetails?.data
            ?.map((task) => {
                  "tasks": task.id.toString(),
                  "details": [
                    'Title : ${task.title ?? ""}',
                    'Time : ${task.startTime ?? ""}',
                    'Status : ${task.status ?? ""}',
                    'Priority : ${task.priority ?? ""}',
                    'Description : ${task.description ?? ""}',
                  ].where((element) => element.isNotEmpty).join("\n"),
                })
            .toList() ??
        [];

// Add rows to the table
    for (var task in taskData) {
      final PdfGridRow row = userTaskDetails.rows.add();
      row.cells[0].value = task["tasks"];
      row.cells[1].value = task["details"];
    }

// Adjust column widths to push values to the right
    userTaskDetails.columns[0].width = page4.getClientSize().width * 0.1;
    userTaskDetails.columns[1].width = page4.getClientSize().width * 0.9;

// Draw Table

    userTaskDetails.draw(
        page: page4,
        bounds: Rect.fromLTWH(0, 50, page4.getClientSize().width, 0))!;

    // Create Table
    PdfGrid attendanceDetails = PdfGrid();
    attendanceDetails.columns.add(count: 7);
    attendanceDetails.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 12),
      cellPadding: PdfPaddings(left: 5, right: 5, top: 15, bottom: 5),
    );

    PdfGridRow attendanceDetailsHeader = attendanceDetails.rows.add();
    attendanceDetailsHeader.cells[0].value = "Attendance Details";
    attendanceDetailsHeader.cells[0].columnSpan = 7;
    attendanceDetailsHeader.cells[0].style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightGray,
      textBrush: PdfBrushes.black,
      font: PdfStandardFont(PdfFontFamily.helvetica, 20,
          style: PdfFontStyle.bold),
      cellPadding: PdfPaddings(left: 5, right: 5, top: 5, bottom: 5),
    );

    // Create Header Row
    PdfGridRow headerRowAttendance = attendanceDetails.rows.add();
    List<String> headersAttendance = [
      "Status",
      "Date",
      "Start Shift",
      "End Shift",
      "Clock In",
      "Clock Out",
      "Duration",
    ];

    for (int i = 0; i < headersAttendance.length; i++) {
      headerRowAttendance.cells[i].value = headersAttendance[i];
      headerRowAttendance.cells[i].style = PdfGridCellStyle(
        backgroundBrush: PdfBrushes.lightGray,
        textBrush: PdfBrushes.black,
        font: PdfStandardFont(PdfFontFamily.helvetica, 12,
            style: PdfFontStyle.bold),
        cellPadding: PdfPaddings(left: 5, right: 5, top: 5, bottom: 5),
      );
    }

    PdfGridRow dataRowAttendance = attendanceDetails.rows.add();
    List<String> valuesAttendance = [
      userAttendanceDetails?.data?.map((e) => e.status).join("\n") ?? "",
      userAttendanceDetails?.data?.map((e) => e.date).join("\n") ?? "",
      userAttendanceDetails?.data?.map((e) => e.shiftStart).join("\n") ?? "",
      userAttendanceDetails?.data?.map((e) => e.shiftEnd).join("\n") ?? "",
      userAttendanceDetails?.data
              ?.map((e) => formatTime(e.clockIn))
              .join("\n") ??
          "",
      userAttendanceDetails?.data
              ?.map((e) => formatTime(e.clockOut))
              .join("\n") ??
          "",
      userAttendanceDetails?.data
              ?.map((e) => formatDuration(e.duration))
              .join("\n") ??
          "",
    ];

// Fill data row
    for (int i = 0; i < valuesAttendance.length; i++) {
      dataRowAttendance.cells[i].value =
          valuesAttendance[i]; // Assign names directly
      dataRowAttendance.cells[i].stringFormat =
          PdfStringFormat(alignment: PdfTextAlignment.center);
    }

// Adjust column widths evenly
    double columnWidthAttendance = page5.getClientSize().width / 7;
    for (int i = 0; i < attendanceDetails.columns.count; i++) {
      attendanceDetails.columns[i].width = columnWidthAttendance;
    }

// Draw Table
    attendanceDetails.draw(
      page: page5,
      bounds: Rect.fromLTWH(0, 50, page5.getClientSize().width, 0),
    );

// Create Table
    PdfGrid userLeavesDetails = PdfGrid();
    userLeavesDetails.columns.add(count: 2);
    userLeavesDetails.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 18),
      cellPadding: PdfPaddings(left: 5, right: 5, top: 5, bottom: 5),
    );

    PdfGridRow userLeavesDetailsHeaderRow = userLeavesDetails.rows.add();
    userLeavesDetailsHeaderRow.cells[0].value = "Leaves Details ";
    userLeavesDetailsHeaderRow.cells[0].columnSpan = 2;
    userLeavesDetailsHeaderRow.cells[0].style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightGray,
      textBrush: PdfBrushes.black,
      font: PdfStandardFont(PdfFontFamily.helvetica, 20,
          style: PdfFontStyle.bold),
      cellPadding: PdfPaddings(left: 5, right: 5, top: 5, bottom: 5),
    );

// data
    final List<Map<String, dynamic>> leavesData = userLeaveDetails?.leaves
            ?.map((leaves) => {
                  "leaves": leaves.id.toString(),
                  "details": [
                    'Type : ${leaves.type ?? ""}',
                    'Start Date : ${leaves.startDate ?? ""}',
                    'End Date : ${leaves.endDate ?? ""}',
                    'Description : ${leaves.reason ?? ""}',
                  ].where((element) => element.isNotEmpty).join("\n"),
                })
            .toList() ??
        [];

// Add rows to the table
    for (var leaves in leavesData) {
      final PdfGridRow row = userLeavesDetails.rows.add();
      row.cells[0].value = leaves["leaves"];
      row.cells[1].value = leaves["details"];
    }

// Adjust column widths to push values to the right
    userLeavesDetails.columns[0].width = page6.getClientSize().width * 0.1;
    userLeavesDetails.columns[1].width = page6.getClientSize().width * 0.9;

// Draw Table

    userLeavesDetails.draw(
        page: page6,
        bounds: Rect.fromLTWH(0, 50, page6.getClientSize().width, 0))!;

// Save & Open PDF
    List<int> bytes = document.saveSync();
    document.dispose();
    saveAndLaunchFile(bytes, '${user.firstName}_details.pdf');
  }

  void addRow(PdfGrid grid, String label, String value) {
    PdfGridRow row = grid.rows.add();
    row.cells[0].value = label;
    row.cells[1].value = value;
  }

  Future<Uint8List> readImageData(String name) async {
    final data = await rootBundle.load('assets/images/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
