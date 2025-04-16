import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/row_details_build.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/logic/task_management_cubit.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/logic/task_management_state.dart';
import 'package:smart_cleaning_application/features/screens/task/view_task/ui/widget/current_read_dialog_.dart';
import 'package:smart_cleaning_application/features/screens/task/view_task/ui/widget/upload_files_dialog.dart';

class TaskDetailsBody extends StatefulWidget {
  final int id;
  const TaskDetailsBody({super.key, required this.id});

  @override
  State<TaskDetailsBody> createState() => _TaskDetailsBodyState();
}

class _TaskDetailsBodyState extends State<TaskDetailsBody> {
  @override
  void initState() {
    context.read<TaskManagementCubit>().getTaskDetails(widget.id);
    if (role != 'Cleaner') {
      context.read<TaskManagementCubit>().getAllUsers();
    }

    super.initState();
  }

  final List<String> priority = ["High", "Medium", "Low"];
  final List<Color> priorityColor = [
    Colors.red,
    Colors.orange,
    Colors.green,
  ];

  Color? priorityColorForTask;
  bool descTextShowFlag = false;

  String formatTime(String time) {
    List<String> parts = time.split(':');
    return '${parts[0]}:${parts[1]}';
  }

  String formatDuration(String duration) {
    try {
      if (duration.contains(".")) {
        duration = duration.split(".")[0];
      }

      List<String> parts = duration.split(":");
      int hours = 0, minutes = 0, seconds = 0;

      if (parts.length == 3) {
        hours = int.parse(parts[0]);
        minutes = int.parse(parts[1]);
        seconds = int.parse(parts[2]);
      } else if (parts.length == 2) {
        minutes = int.parse(parts[0]);
        seconds = int.parse(parts[1]);
      } else {
        throw FormatException("Invalid duration format");
      }

      if (hours > 0) {
        return "$hours hour${hours > 1 ? 's' : ''}";
      } else if (minutes > 0) {
        return "$minutes min${minutes > 1 ? 's' : ''}";
      } else {
        return "$seconds sec${seconds > 1 ? 's' : ''}";
      }
    } catch (e) {
      return "Invalid duration";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task details"),
        leading: customBackButton(context),
        actions: [
          role == 'Cleaner'
              ? SizedBox.shrink()
              : IconButton(
                  onPressed: () {
                    context.pushNamed(Routes.editTaskScreen,
                        arguments: widget.id);
                  },
                  icon: Icon(
                    Icons.edit,
                    color: AppColor.primaryColor,
                  ))
        ],
      ),
      body: BlocConsumer<TaskManagementCubit, TaskManagementState>(
        listener: (context, state) {
          if (state is AddCommentsSuccessState) {
            context.read<TaskManagementCubit>().commentController.clear();
            context.read<TaskManagementCubit>().image = null;

            toast(text: state.message, color: Colors.blue);
            context.read<TaskManagementCubit>().getTaskDetails(widget.id);
            context.read<TaskManagementCubit>().getAllUsers();
          }
          if (state is GetChangeTaskStatusSuccessState) {
            toast(
                text: state.changeTaskStatusModel.message!, color: Colors.blue);
            context.read<TaskManagementCubit>().getTaskDetails(widget.id);
            context.read<TaskManagementCubit>().getAllUsers();
          }
          if (state is AddCommentsErrorState) {
            toast(text: state.error, color: Colors.red);
          }

          if (state is GetChangeTaskStatusErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          if (context.read<TaskManagementCubit>().taskDetailsModel == null) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ),
            );
          }

          String taskPriority = context
              .read<TaskManagementCubit>()
              .taskDetailsModel!
              .data!
              .priority!;
          if (priority.contains(taskPriority)) {
            priorityColorForTask =
                priorityColor[priority.indexOf(taskPriority)];
          } else {
            priorityColorForTask = Colors.black;
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: context
                                        .read<TaskManagementCubit>()
                                        .taskDetailsModel!
                                        .data!
                                        .duration ==
                                    null
                                ? 'Duration'
                                : 'Total Time',
                            style: TextStyles.font14BlackSemiBold,
                          ),
                          TextSpan(
                            text: ' : ',
                            style: TextStyles.font14BlackSemiBold,
                          ),
                          TextSpan(
                            text: context
                                        .read<TaskManagementCubit>()
                                        .taskDetailsModel!
                                        .data!
                                        .duration ==
                                    null
                                ? context
                                            .read<TaskManagementCubit>()
                                            .taskDetailsModel!
                                            .data!
                                            .started ==
                                        null
                                    ? 'The task isn\'t start yet.'
                                    : 'The task isn\'t complete yet.'
                                : formatDuration(context
                                    .read<TaskManagementCubit>()
                                    .taskDetailsModel!
                                    .data!
                                    .duration!),
                            style: TextStyles.font13greymedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  verticalSpace(10),
                  Row(
                    children: [
                      Container(
                        height: 23.h,
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: priorityColorForTask!.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Center(
                          child: Text(
                            context
                                .read<TaskManagementCubit>()
                                .taskDetailsModel!
                                .data!
                                .priority!,
                            style: TextStyles.font11WhiteSemiBold.copyWith(
                              color: priorityColorForTask,
                            ),
                          ),
                        ),
                      ),
                      horizontalSpace(5),
                      Container(
                        height: 23.h,
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Color(0xffD3DCF9),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Center(
                          child: Text(
                            context
                                .read<TaskManagementCubit>()
                                .taskDetailsModel!
                                .data!
                                .status!,
                            style: TextStyles.font11WhiteSemiBold
                                .copyWith(color: AppColor.primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  Text(
                    context
                        .read<TaskManagementCubit>()
                        .taskDetailsModel!
                        .data!
                        .title!,
                    style: TextStyles.font16BlackSemiBold,
                  ),
                  verticalSpace(10),
                  Text(
                    context
                        .read<TaskManagementCubit>()
                        .taskDetailsModel!
                        .data!
                        .description!,
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
                                    style: TextStyle(
                                        color: AppColor.primaryColor,
                                        fontSize: 12),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: const Text(
                                    "Read more",
                                    style: TextStyle(
                                        color: AppColor.primaryColor,
                                        fontSize: 12),
                                  ),
                                ))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Start Date',
                        style: TextStyles.font14GreyRegular,
                      ),
                      horizontalSpace(MediaQuery.of(context).size.width / 3.5),
                      Text(
                        'End Date',
                        style: TextStyles.font14GreyRegular,
                      ),
                    ],
                  ),
                  verticalSpace(3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: context
                                  .read<TaskManagementCubit>()
                                  .taskDetailsModel!
                                  .data!
                                  .startDate!,
                              style: TextStyles.font14BlackRegular,
                            ),
                            TextSpan(
                              text: ' Start: ',
                              style: TextStyles.font14Primarybold,
                            ),
                            TextSpan(
                              text: formatTime(context
                                  .read<TaskManagementCubit>()
                                  .taskDetailsModel!
                                  .data!
                                  .startTime!),
                              style: TextStyles.font14BlackRegular,
                            ),
                          ],
                        ),
                      ),
                      horizontalSpace(MediaQuery.of(context).size.width / 11),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: context
                                  .read<TaskManagementCubit>()
                                  .taskDetailsModel!
                                  .data!
                                  .endDate!,
                              style: TextStyles.font14BlackRegular,
                            ),
                            TextSpan(
                              text: ' End: ',
                              style: TextStyles.font14Primarybold,
                            ),
                            TextSpan(
                              text: formatTime(context
                                  .read<TaskManagementCubit>()
                                  .taskDetailsModel!
                                  .data!
                                  .endTime!),
                              style: TextStyles.font14BlackRegular,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(3),
                  Divider(),
                  rowDetailsBuild(
                      context,
                      'Created By',
                      context
                          .read<TaskManagementCubit>()
                          .taskDetailsModel!
                          .data!
                          .createdUserName!),
                  Divider(),
                  if (role != 'Cleaner') ...[
                    rowDetailsBuild(
                        context,
                        'Parent Task',
                        context
                                .read<TaskManagementCubit>()
                                .taskDetailsModel!
                                .data!
                                .parentTitle ??
                            'No parent task'),
                    Divider(),
                  ],
                  rowDetailsBuild(
                      context,
                      'Organization',
                      context
                              .read<TaskManagementCubit>()
                              .taskDetailsModel!
                              .data!
                              .organizationName ??
                          "No item selected"),
                  Divider(),
                  rowDetailsBuild(
                      context,
                      'Building',
                      context
                              .read<TaskManagementCubit>()
                              .taskDetailsModel!
                              .data!
                              .buildingName ??
                          "No item selected"),
                  Divider(),
                  rowDetailsBuild(
                      context,
                      'Floor',
                      context
                              .read<TaskManagementCubit>()
                              .taskDetailsModel!
                              .data!
                              .floorName ??
                          "No item selected"),
                  Divider(),
                  rowDetailsBuild(
                      context,
                      'Section',
                      context
                              .read<TaskManagementCubit>()
                              .taskDetailsModel!
                              .data!
                              .sectionName ??
                          "No item selected"),
                  Divider(),
                  rowDetailsBuild(
                      context,
                      'Point',
                      context
                              .read<TaskManagementCubit>()
                              .taskDetailsModel!
                              .data!
                              .pointName ??
                          "No item selected"),
                  Divider(),
                  if (context
                          .read<TaskManagementCubit>()
                          .taskDetailsModel
                          ?.data
                          ?.currentReading !=
                      null) ...[
                    rowDetailsBuild(
                      context,
                      'Current Reading',
                      context
                          .read<TaskManagementCubit>()
                          .taskDetailsModel!
                          .data!
                          .currentReading
                          .toString(),
                    ),
                    Divider()
                  ],
                  if (context
                          .read<TaskManagementCubit>()
                          .taskDetailsModel
                          ?.data
                          ?.readingAfter !=
                      null) ...[
                    rowDetailsBuild(
                      context,
                      'After Reading',
                      context
                          .read<TaskManagementCubit>()
                          .taskDetailsModel!
                          .data!
                          .readingAfter
                          .toString(),
                    ),
                    Divider()
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Task Team',
                        style: TextStyles.font14BlackSemiBold,
                      ),
                      Text(
                        context
                                .read<TaskManagementCubit>()
                                .taskDetailsModel!
                                .data!
                                .users!
                                .isEmpty
                            ? "No employee added"
                            : '',
                        style: TextStyles.font13greymedium,
                      ),
                    ],
                  ),
                  if (role != 'Cleaner' &&
                      context
                              .read<TaskManagementCubit>()
                              .taskDetailsModel!
                              .data!
                              .users !=
                          null) ...[
                    verticalSpace(10),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      childAspectRatio: 1 / 0.3,
                      children: List.generate(
                        context
                            .read<TaskManagementCubit>()
                            .taskDetailsModel!
                            .data!
                            .users!
                            .length,
                        (index) => InkWell(
                          borderRadius: BorderRadius.circular(10.r),
                          onTap: () {
                            (uId ==
                                        context
                                            .read<TaskManagementCubit>()
                                            .usersModel!
                                            .data!
                                            .users![index]
                                            .id &&
                                    role == 'Cleaner')
                                ? null
                                : context.pushNamed(
                                    Routes.userDetailsScreen,
                                    arguments: context
                                        .read<TaskManagementCubit>()
                                        .usersModel!
                                        .data!
                                        .users![index]
                                        .id,
                                  );
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                    radius: 20.r,
                                    backgroundImage: context
                                                .read<TaskManagementCubit>()
                                                .usersModel!
                                                .data!
                                                .users![index]
                                                .image ==
                                            null
                                        ? AssetImage(
                                            'assets/images/person.png',
                                          )
                                        : NetworkImage(
                                            '${ApiConstants.apiBaseUrlImage}${context.read<TaskManagementCubit>().usersModel!.data!.users![index].image}',
                                          )),
                                horizontalSpace(10),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      context
                                              .read<TaskManagementCubit>()
                                              .usersModel!
                                              .data!
                                              .users![index]
                                              .firstName ??
                                          '',
                                      style: TextStyles.font12BlackSemi,
                                    ),
                                    Text(
                                      context
                                              .read<TaskManagementCubit>()
                                              .usersModel!
                                              .data!
                                              .users![index]
                                              .role ??
                                          '',
                                      style: TextStyles.font11lightPrimary,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Files',
                        style: TextStyles.font14BlackSemiBold,
                      ),
                      Text(
                        context
                                .read<TaskManagementCubit>()
                                .taskDetailsModel!
                                .data!
                                .files!
                                .isEmpty
                            ? 'No file uploaded'
                            : '${context.read<TaskManagementCubit>().taskDetailsModel!.data!.files!.length} files uploaded',
                        style: TextStyles.font13greymedium,
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  if (context
                      .read<TaskManagementCubit>()
                      .taskDetailsModel!
                      .data!
                      .files!
                      .isNotEmpty)
                    SizedBox(
                      height: 80.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: context
                            .read<TaskManagementCubit>()
                            .taskDetailsModel!
                            .data!
                            .files!
                            .length,
                        itemBuilder: (context, index) {
                          final file = context
                              .read<TaskManagementCubit>()
                              .taskDetailsModel!
                              .data!
                              .files![index];

                          return GestureDetector(
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
                                          '${ApiConstants.apiBaseUrlImage}${file.path}',
                                        ),
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            'assets/images/noImage.png',
                                            fit: BoxFit.fill,
                                          );
                                        },
                                        backgroundDecoration:
                                            const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 10.w),
                              child: Container(
                                height: 70.h,
                                width: 70.w,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Image.network(
                                  '${ApiConstants.apiBaseUrlImage}${file.path}',
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
                          );
                        },
                      ),
                    ),
                  Divider(),
                  Text(
                    'Comments',
                    style: TextStyles.font14BlackSemiBold,
                  ),
                  verticalSpace(5),
                  context
                          .read<TaskManagementCubit>()
                          .taskDetailsModel!
                          .data!
                          .comments!
                          .every((task) =>
                              task.comment == null &&
                              (task.files == null || task.files!.isEmpty))
                      ? Center(
                          child: Text(
                            'There\'s no comments',
                            style: TextStyles.font13greymedium,
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: context
                              .read<TaskManagementCubit>()
                              .taskDetailsModel!
                              .data!
                              .comments!
                              .length,
                          itemBuilder: (context, index) {
                            final task = context
                                .read<TaskManagementCubit>()
                                .taskDetailsModel!
                                .data!
                                .comments![index];

                            if (task.comment != null ||
                                (task.files != null &&
                                    task.files!.isNotEmpty)) {
                              return Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(vertical: 5.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(color: Colors.black12),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (task.files != null &&
                                          task.files!.isNotEmpty)
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (contextt) => Scaffold(
                                                  appBar: AppBar(
                                                    leading: customBackButton(
                                                        context),
                                                  ),
                                                  body: Center(
                                                    child: PhotoView(
                                                      imageProvider:
                                                          NetworkImage(
                                                        '${ApiConstants.apiBaseUrlImage}${task.files!.first.path}',
                                                      ),
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return Image.asset(
                                                          'assets/images/noImage.png',
                                                          fit: BoxFit.fill,
                                                        );
                                                      },
                                                      backgroundDecoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 50.w,
                                            height: 50.h,
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey[200],
                                            ),
                                            child: Image.network(
                                              '${ApiConstants.apiBaseUrlImage}${task.files!.first.path}',
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                  'assets/images/noImage.png',
                                                  fit: BoxFit.fill,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      horizontalSpace(10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  task.userName ?? '',
                                                  style: TextStyles
                                                      .font14BlackSemiBold,
                                                ),
                                                horizontalSpace(10),
                                                Text(
                                                  task.role ?? '',
                                                  style: TextStyles
                                                      .font13greymedium,
                                                ),
                                              ],
                                            ),
                                            verticalSpace(5),
                                            if (task.comment != null)
                                              Text(
                                                task.comment!,
                                                style: TextStyles
                                                    .font13Blackmedium,
                                              ),
                                            verticalSpace(5),
                                            if (task.files != null &&
                                                task.files!.isNotEmpty)
                                              Column(
                                                children:
                                                    task.files!.map((file) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (contextt) =>
                                                              Scaffold(
                                                            appBar: AppBar(
                                                              leading:
                                                                  customBackButton(
                                                                      context),
                                                            ),
                                                            body: Center(
                                                              child: PhotoView(
                                                                imageProvider:
                                                                    NetworkImage(
                                                                  '${ApiConstants.apiBaseUrlImage}${file.path}',
                                                                ),
                                                                errorBuilder:
                                                                    (context,
                                                                        error,
                                                                        stackTrace) {
                                                                  return Image
                                                                      .asset(
                                                                    'assets/images/noImage.png',
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  );
                                                                },
                                                                backgroundDecoration:
                                                                    const BoxDecoration(
                                                                  color: Colors
                                                                      .white,
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
                                                      margin: EdgeInsets.only(
                                                          bottom: 5.h),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
                                                        border: Border.all(
                                                            color:
                                                                Colors.black12),
                                                      ),
                                                      child: Image.network(
                                                        '${ApiConstants.apiBaseUrlImage}${file.path}',
                                                        fit: BoxFit.fill,
                                                        errorBuilder: (context,
                                                            error, stackTrace) {
                                                          return Image.asset(
                                                            'assets/images/noImage.png',
                                                            fit: BoxFit.fill,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                DateFormat.jm().format(
                                                    DateTime.parse(
                                                        task.createdAt!)),
                                                style: TextStyles
                                                    .font11BlackMedium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }

                            return SizedBox.shrink();
                          },
                        ),
                  verticalSpace(10),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Add Comment',
                          style: TextStyles.font16BlackRegular,
                        ),
                        TextSpan(
                          text: ' (Optional)',
                          style: TextStyles.font14GreyRegular,
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(5),
                  Form(
                    key: context.read<TaskManagementCubit>().formKey,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: context
                                .read<TaskManagementCubit>()
                                .commentController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.r),
                                  bottomLeft: Radius.circular(8.r),
                                ),
                                borderSide: BorderSide(
                                  color: AppColor.thirdColor,
                                ),
                              ),
                              hintText: 'write your comment',
                              helperStyle: TextStyles.font12GreyRegular,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  UploadFilesBottomDialog().showBottomDialog(
                                      context,
                                      context.read<TaskManagementCubit>());
                                },
                                icon: Icon(Icons.attach_file_rounded,
                                    color: AppColor.thirdColor),
                              ),
                            ),
                            validator: (value) {
                              final cubit = context.read<TaskManagementCubit>();

                              if ((value == null || value.trim().isEmpty) &&
                                  (cubit.image == null)) {
                                return "Comment or Image is required";
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          width: 50.w,
                          height: 47.h,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8.r),
                              bottomRight: Radius.circular(8.r),
                            ),
                          ),
                          child: MaterialButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (context
                                    .read<TaskManagementCubit>()
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  final taskCubit =
                                      context.read<TaskManagementCubit>();
                                  final imagePath = taskCubit.image?.path ?? "";

                                  taskCubit.addComment(
                                    imagePath,
                                    widget.id,
                                    taskCubit.taskDetailsModel!.data!.statusId!,
                                  );
                                }
                              },
                              child: Icon(
                                IconBroken.send,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                  ),
                  verticalSpace(10),
                  (state is ImageSelectedState || state is CameraSelectedState)
                      ? GestureDetector(
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
                                      imageProvider: FileImage(
                                        File(context
                                            .read<TaskManagementCubit>()
                                            .image!
                                            .path),
                                      ),
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
                            height: 80,
                            width: 80,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Image.file(
                              File(context
                                  .read<TaskManagementCubit>()
                                  .image!
                                  .path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  verticalSpace(20),
                  state is GetChangeTaskStatusLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(
                              color: AppColor.primaryColor),
                        )
                      : Column(
                          children: [
                            role == 'Cleaner'
                                ? Column(
                                    children: [
                                      (context
                                                      .read<
                                                          TaskManagementCubit>()
                                                      .taskDetailsModel!
                                                      .data!
                                                      .status! ==
                                                  "Waiting For Approval" ||
                                              context
                                                      .read<
                                                          TaskManagementCubit>()
                                                      .taskDetailsModel!
                                                      .data!
                                                      .status! ==
                                                  "Not Resolved" ||
                                              context
                                                      .read<
                                                          TaskManagementCubit>()
                                                      .taskDetailsModel!
                                                      .data!
                                                      .status! ==
                                                  "Completed")
                                          ? SizedBox.shrink()
                                          : (context
                                                      .read<
                                                          TaskManagementCubit>()
                                                      .taskDetailsModel!
                                                      .data!
                                                      .status! ==
                                                  "Pending")
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    DefaultElevatedButton(
                                                      name: "Start",
                                                      onPressed: () {
                                                        context
                                                            .read<
                                                                TaskManagementCubit>()
                                                            .changeTaskStatus(
                                                              widget.id,
                                                              1,
                                                            );
                                                      },
                                                      color:
                                                          AppColor.primaryColor,
                                                      height: 48.h,
                                                      width: 157.w,
                                                      textStyles: TextStyles
                                                          .font16WhiteSemiBold,
                                                    ),
                                                    DefaultElevatedButton(
                                                      name: "NotResolved",
                                                      onPressed: () {
                                                        context
                                                            .read<
                                                                TaskManagementCubit>()
                                                            .changeTaskStatus(
                                                              widget.id,
                                                              5,
                                                            );
                                                      },
                                                      color: AppColor
                                                          .secondaryColor,
                                                      height: 48.h,
                                                      width: 157.w,
                                                      textStyles: TextStyles
                                                          .font16WhiteSemiBold,
                                                    ),
                                                  ],
                                                )
                                              : (context
                                                              .read<
                                                                  TaskManagementCubit>()
                                                              .taskDetailsModel!
                                                              .data!
                                                              .status! ==
                                                          "In Progress" ||
                                                      context
                                                              .read<
                                                                  TaskManagementCubit>()
                                                              .taskDetailsModel!
                                                              .data!
                                                              .status! ==
                                                          "Rejected" ||
                                                      context
                                                              .read<
                                                                  TaskManagementCubit>()
                                                              .taskDetailsModel!
                                                              .data!
                                                              .status! ==
                                                          "Overdue")
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        DefaultElevatedButton(
                                                          name: "Complete",
                                                          onPressed: () {
                                                            context
                                                                        .read<
                                                                            TaskManagementCubit>()
                                                                        .taskDetailsModel!
                                                                        .data!
                                                                        .currentReading ==
                                                                    null
                                                                ? context
                                                                    .read<
                                                                        TaskManagementCubit>()
                                                                    .changeTaskStatus(
                                                                        widget
                                                                            .id,
                                                                        2)
                                                                : CustomCurrentReadDialog.show(
                                                                    context:
                                                                        context,
                                                                    id: widget
                                                                        .id);
                                                          },
                                                          color: AppColor
                                                              .primaryColor,
                                                          height: 48.h,
                                                          width: 157.w,
                                                          textStyles: TextStyles
                                                              .font16WhiteSemiBold,
                                                        ),
                                                        DefaultElevatedButton(
                                                          name: "NotResolved",
                                                          onPressed: () {
                                                            context
                                                                .read<
                                                                    TaskManagementCubit>()
                                                                .changeTaskStatus(
                                                                  widget.id,
                                                                  5,
                                                                );
                                                          },
                                                          color: AppColor
                                                              .secondaryColor,
                                                          height: 48.h,
                                                          width: 157.w,
                                                          textStyles: TextStyles
                                                              .font16WhiteSemiBold,
                                                        ),
                                                      ],
                                                    )
                                                  : SizedBox.shrink(),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      (context
                                                  .read<TaskManagementCubit>()
                                                  .taskDetailsModel!
                                                  .data!
                                                  .status! ==
                                              "Waiting For Approval")
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                DefaultElevatedButton(
                                                  name: "Complete",
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                            TaskManagementCubit>()
                                                        .changeTaskStatus(
                                                          widget.id,
                                                          3,
                                                        );
                                                  },
                                                  color: AppColor.primaryColor,
                                                  height: 48.h,
                                                  width: 157.w,
                                                  textStyles: TextStyles
                                                      .font16WhiteSemiBold,
                                                ),
                                                DefaultElevatedButton(
                                                  name: "Rejected",
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                            TaskManagementCubit>()
                                                        .changeTaskStatus(
                                                          widget.id,
                                                          4,
                                                        );
                                                  },
                                                  color:
                                                      AppColor.secondaryColor,
                                                  height: 48.h,
                                                  width: 157.w,
                                                  textStyles: TextStyles
                                                      .font16WhiteSemiBold,
                                                ),
                                              ],
                                            )
                                          : (context
                                                          .read<
                                                              TaskManagementCubit>()
                                                          .taskDetailsModel!
                                                          .data!
                                                          .status! ==
                                                      "Pending" ||
                                                  context
                                                          .read<
                                                              TaskManagementCubit>()
                                                          .taskDetailsModel!
                                                          .data!
                                                          .status! ==
                                                      "Completed")
                                              ? DefaultElevatedButton(
                                                  name: "Delete",
                                                  onPressed: () {},
                                                  color: Colors.red,
                                                  height: 48.h,
                                                  width: double.infinity,
                                                  textStyles: TextStyles
                                                      .font16WhiteSemiBold,
                                                )
                                              : (context
                                                              .read<
                                                                  TaskManagementCubit>()
                                                              .taskDetailsModel!
                                                              .data!
                                                              .status! ==
                                                          "In Progress" ||
                                                      context
                                                              .read<
                                                                  TaskManagementCubit>()
                                                              .taskDetailsModel!
                                                              .data!
                                                              .status! ==
                                                          "Rejected" ||
                                                      context
                                                              .read<
                                                                  TaskManagementCubit>()
                                                              .taskDetailsModel!
                                                              .data!
                                                              .status! ==
                                                          "Overdue")
                                                  ? DefaultElevatedButton(
                                                      name: "Not Resolve",
                                                      onPressed: () {
                                                        context
                                                            .read<
                                                                TaskManagementCubit>()
                                                            .changeTaskStatus(
                                                              widget.id,
                                                              5,
                                                            );
                                                      },
                                                      color: AppColor
                                                          .secondaryColor,
                                                      height: 48.h,
                                                      width: double.infinity,
                                                      textStyles: TextStyles
                                                          .font16WhiteSemiBold,
                                                    )
                                                  : (context
                                                              .read<
                                                                  TaskManagementCubit>()
                                                              .taskDetailsModel!
                                                              .data!
                                                              .status! ==
                                                          "Not Resolved")
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            DefaultElevatedButton(
                                                              name: "Delete",
                                                              onPressed: () {},
                                                              color: Colors.red,
                                                              height: 48.h,
                                                              width: 157.w,
                                                              textStyles: TextStyles
                                                                  .font16WhiteSemiBold,
                                                            ),
                                                            DefaultElevatedButton(
                                                              name: "Rejected",
                                                              onPressed: () {
                                                                context
                                                                    .read<
                                                                        TaskManagementCubit>()
                                                                    .changeTaskStatus(
                                                                      widget.id,
                                                                      4,
                                                                    );
                                                              },
                                                              color: AppColor
                                                                  .secondaryColor,
                                                              height: 48.h,
                                                              width: 157.w,
                                                              textStyles: TextStyles
                                                                  .font16WhiteSemiBold,
                                                            ),
                                                          ],
                                                        )
                                                      : SizedBox.shrink(),
                                    ],
                                  ),
                          ],
                        ),
                  verticalSpace(20)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
