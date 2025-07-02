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
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/row_details_build.dart';
import 'package:smart_cleaning_application/features/screens/task/view_task/logic/task_details_cubit.dart';
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
  Widget build(BuildContext context) {
    final cubit = context.read<TaskDetailsCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Task details"),
        leading: CustomBackButton(),
        actions: [
          role == 'Cleaner'
              ? SizedBox.shrink()
              : IconButton(
                  onPressed: () async {
                    final result = await context
                        .pushNamed(Routes.editTaskScreen, arguments: widget.id);

                    if (result == true) {
                      cubit.getTaskDetails(widget.id);
                    }
                  },
                  icon: Icon(
                    Icons.edit,
                    color: AppColor.primaryColor,
                  ))
        ],
      ),
      body: BlocConsumer<TaskDetailsCubit, TaskDetailsState>(
        listener: (context, state) {
          if (state is AddCommentsSuccessState) {
            cubit.commentController.clear();
            cubit.image = null;

            toast(text: state.message, color: Colors.blue);
            cubit.getTaskDetails(widget.id);
            cubit.getAllUsers();
          }
          if (state is GetChangeTaskStatusSuccessState) {
            toast(
                text: state.changeTaskStatusModel.message!, color: Colors.blue);
            cubit.getTaskDetails(widget.id);
            cubit.getAllUsers();
          }
          if (state is AddCommentsErrorState) {
            toast(text: state.error, color: Colors.red);
          }

          if (state is GetChangeTaskStatusErrorState) {
            toast(text: state.error, color: Colors.red);
          }

          if (state is TaskDeleteSuccessState) {
            toast(text: state.deleteTaskModel.message!, color: Colors.blue);
            context.popWithTrueResult();
          }
          if (state is TaskDeleteErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          if (cubit.taskDetailsModel == null || cubit.usersModel == null) {
            return Loading();
          }

          String taskPriority = cubit.taskDetailsModel!.data!.priority!;
          if (cubit.priority.contains(taskPriority)) {
            cubit.priorityColorForTask =
                cubit.priorityColor[cubit.priority.indexOf(taskPriority)];
          } else {
            cubit.priorityColorForTask = Colors.black;
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
                            text: cubit.taskDetailsModel!.data!.duration == null
                                ? 'Duration'
                                : 'Total Time',
                            style: TextStyles.font14BlackSemiBold,
                          ),
                          TextSpan(
                            text: ' : ',
                            style: TextStyles.font14BlackSemiBold,
                          ),
                          TextSpan(
                            text: cubit.taskDetailsModel!.data!.duration == null
                                ? cubit.taskDetailsModel!.data!.started == null
                                    ? 'The task isn\'t start yet.'
                                    : 'The task isn\'t complete yet.'
                                : cubit.formatDuration(
                                    cubit.taskDetailsModel!.data!.duration!),
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
                          color: cubit.priorityColorForTask!.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Center(
                          child: Text(
                            cubit.taskDetailsModel!.data!.priority!,
                            style: TextStyles.font11WhiteSemiBold.copyWith(
                              color: cubit.priorityColorForTask,
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
                            cubit.taskDetailsModel!.data!.status!,
                            style: TextStyles.font11WhiteSemiBold
                                .copyWith(color: AppColor.primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  Text(
                    cubit.taskDetailsModel!.data!.title!,
                    style: TextStyles.font16BlackSemiBold,
                  ),
                  verticalSpace(10),
                  Text(
                    cubit.taskDetailsModel!.data!.description!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: cubit.descTextShowFlag ? 40 : 3,
                    style: TextStyles.font14GreyRegular,
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                          borderRadius: BorderRadius.circular(5.r),
                          onTap: () {
                            setState(() {
                              cubit.descTextShowFlag = !cubit.descTextShowFlag;
                            });
                          },
                          child: cubit.descTextShowFlag
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
                              text: cubit.taskDetailsModel!.data!.startDate!,
                              style: TextStyles.font14BlackRegular,
                            ),
                            TextSpan(
                              text: ' Start: ',
                              style: TextStyles.font14Primarybold,
                            ),
                            TextSpan(
                              text: cubit.formatTime(
                                  cubit.taskDetailsModel!.data!.startTime!),
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
                              text: cubit.taskDetailsModel!.data!.endDate!,
                              style: TextStyles.font14BlackRegular,
                            ),
                            TextSpan(
                              text: ' End: ',
                              style: TextStyles.font14Primarybold,
                            ),
                            TextSpan(
                              text: cubit.formatTime(
                                  cubit.taskDetailsModel!.data!.endTime!),
                              style: TextStyles.font14BlackRegular,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(3),
                  Divider(),
                  if (cubit.taskDetailsModel!.data!.deviceName == null) ...[
                    rowDetailsBuild(context, 'Created By',
                        cubit.taskDetailsModel!.data!.createdUserName!),
                    Divider(),
                  ],
                  if (cubit.taskDetailsModel!.data!.createdBy == null) ...[
                    rowDetailsBuild(context, 'Device name',
                        cubit.taskDetailsModel!.data!.deviceName!),
                    Divider(),
                  ],
                  if (role != 'Cleaner') ...[
                    rowDetailsBuild(
                        context,
                        'Parent Task',
                        cubit.taskDetailsModel!.data!.parentTitle ??
                            'No parent task'),
                    Divider(),
                  ],
                  rowDetailsBuild(
                      context,
                      'Organization',
                      cubit.taskDetailsModel!.data!.organizationName ??
                          "No item selected"),
                  Divider(),
                  rowDetailsBuild(
                      context,
                      'Building',
                      cubit.taskDetailsModel!.data!.buildingName ??
                          "No item selected"),
                  Divider(),
                  rowDetailsBuild(
                      context,
                      'Floor',
                      cubit.taskDetailsModel!.data!.floorName ??
                          "No item selected"),
                  Divider(),
                  rowDetailsBuild(
                      context,
                      'Section',
                      cubit.taskDetailsModel!.data!.sectionName ??
                          "No item selected"),
                  Divider(),
                  rowDetailsBuild(
                      context,
                      'Point',
                      cubit.taskDetailsModel!.data!.pointName ??
                          "No item selected"),
                  Divider(),
                  if (cubit.taskDetailsModel?.data?.currentReading != null) ...[
                    rowDetailsBuild(
                      context,
                      'Current Reading',
                      cubit.taskDetailsModel!.data!.currentReading.toString(),
                    ),
                    Divider()
                  ],
                  if (cubit.taskDetailsModel?.data?.readingAfter != null) ...[
                    rowDetailsBuild(
                      context,
                      'After Reading',
                      cubit.taskDetailsModel!.data!.readingAfter.toString(),
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
                        cubit.taskDetailsModel!.data!.users!.isEmpty
                            ? "No employee added"
                            : '',
                        style: TextStyles.font13greymedium,
                      ),
                    ],
                  ),
                  if (role != 'Cleaner' &&
                      cubit.taskDetailsModel!.data!.users != null) ...[
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
                        cubit.taskDetailsModel!.data!.users!.length,
                        (index) => InkWell(
                          borderRadius: BorderRadius.circular(10.r),
                          onTap: () {
                            (uId == cubit.usersModel!.data!.users![index].id &&
                                    role == 'Cleaner')
                                ? null
                                : context.pushNamed(
                                    Routes.userDetailsScreen,
                                    arguments: cubit
                                        .usersModel!.data!.users![index].id,
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
                                    backgroundImage: cubit.usersModel!.data!
                                                .users![index].image ==
                                            null
                                        ? AssetImage(
                                            'assets/images/person.png',
                                          )
                                        : NetworkImage(
                                            '${cubit.usersModel!.data!.users![index].image}',
                                          )),
                                horizontalSpace(10),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (cubit.usersModel?.data?.users?[index]
                                                  .firstName ??
                                              '')
                                          .substring(
                                              0,
                                              (cubit
                                                          .usersModel
                                                          ?.data
                                                          ?.users?[index]
                                                          .firstName ??
                                                      '')
                                                  .length
                                                  .clamp(0, 15)),
                                      style: TextStyles.font12BlackSemi,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      cubit.usersModel!.data!.users![index]
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
                        cubit.taskDetailsModel!.data!.files!.isEmpty
                            ? 'No file uploaded'
                            : '${cubit.taskDetailsModel!.data!.files!.length} files uploaded',
                        style: TextStyles.font13greymedium,
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  if (cubit.taskDetailsModel!.data!.files!.isNotEmpty)
                    SizedBox(
                      height: 80.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cubit.taskDetailsModel!.data!.files!.length,
                        itemBuilder: (context, index) {
                          final file =
                              cubit.taskDetailsModel!.data!.files![index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (contextt) => Scaffold(
                                    appBar: AppBar(
                                      leading: CustomBackButton(),
                                    ),
                                    body: Center(
                                      child: PhotoView(
                                        imageProvider: NetworkImage(
                                          '${file.path}',
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
                                  '${file.path}',
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
                  cubit.taskDetailsModel!.data!.comments!.every((task) =>
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
                          itemCount:
                              cubit.taskDetailsModel!.data!.comments!.length,
                          itemBuilder: (context, index) {
                            final task =
                                cubit.taskDetailsModel!.data!.comments![index];

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
                                                    leading: CustomBackButton(),
                                                  ),
                                                  body: Center(
                                                    child: PhotoView(
                                                      imageProvider:
                                                          NetworkImage(
                                                        '${task.files!.first.path}',
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
                                              '${task.files!.first.path}',
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
                                                                  CustomBackButton(),
                                                            ),
                                                            body: Center(
                                                              child: PhotoView(
                                                                imageProvider:
                                                                    NetworkImage(
                                                                  '${file.path}',
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
                                                        '${file.path}',
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
                  if (cubit.taskDetailsModel!.data!.statusId == 3) ...[
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
                      key: cubit.formKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: cubit.commentController,
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
                                    UploadFilesBottomDialog()
                                        .showBottomDialog(context, cubit);
                                  },
                                  icon: Icon(Icons.attach_file_rounded,
                                      color: AppColor.thirdColor),
                                ),
                              ),
                              validator: (value) {
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
                                  if (cubit.formKey.currentState!.validate()) {
                                    final taskCubit = cubit;
                                    final imagePath =
                                        taskCubit.image?.path ?? "";

                                    taskCubit.addComment(
                                      imagePath,
                                      widget.id,
                                      taskCubit
                                          .taskDetailsModel!.data!.statusId!,
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
                  ],
                  (state is ImageSelectedState || state is CameraSelectedState)
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (contextt) => Scaffold(
                                  appBar: AppBar(
                                    leading: CustomBackButton(),
                                  ),
                                  body: Center(
                                    child: PhotoView(
                                      imageProvider: FileImage(
                                        File(cubit.image!.path),
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
                              File(cubit.image!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  verticalSpace(20),
                  state is GetChangeTaskStatusLoadingState
                      ? Loading()
                      : Column(
                          children: [
                            role == 'Cleaner'
                                ? Column(
                                    children: [
                                      (cubit.taskDetailsModel!.data!
                                                      .status! ==
                                                  "Waiting For Approval" ||
                                              cubit.taskDetailsModel!.data!.status! ==
                                                  "Not Resolved" ||
                                              cubit.taskDetailsModel!.data!
                                                      .status! ==
                                                  "Completed")
                                          ? SizedBox.shrink()
                                          : (cubit.taskDetailsModel!.data!
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
                                                        cubit.changeTaskStatus(
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
                                                        cubit.changeTaskStatus(
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
                                              : (cubit.taskDetailsModel!.data!
                                                              .status! ==
                                                          "In Progress" ||
                                                      cubit.taskDetailsModel!
                                                              .data!.status! ==
                                                          "Rejected" ||
                                                      cubit.taskDetailsModel!
                                                              .data!.status! ==
                                                          "Overdue")
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        DefaultElevatedButton(
                                                          name: "Complete",
                                                          onPressed: () {
                                                            cubit.taskDetailsModel!.data!
                                                                        .currentReading ==
                                                                    null
                                                                ? cubit
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
                                                            cubit
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
                                      (cubit.taskDetailsModel!.data!.status! ==
                                              "Waiting For Approval")
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                DefaultElevatedButton(
                                                  name: "Complete",
                                                  onPressed: () {
                                                    cubit.changeTaskStatus(
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
                                                    cubit.changeTaskStatus(
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
                                          : (cubit.taskDetailsModel!.data!
                                                          .status! ==
                                                      "Pending" ||
                                                  cubit.taskDetailsModel!.data!
                                                          .status! ==
                                                      "Completed")
                                              ? DefaultElevatedButton(
                                                  name: "Delete",
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (dialogContext) {
                                                          return PopUpMessage(
                                                              title: 'delete',
                                                              body: 'task',
                                                              onPressed: () {
                                                                cubit.taskDelete(
                                                                    cubit
                                                                        .taskDetailsModel!
                                                                        .data!
                                                                        .id!);
                                                              });
                                                        });
                                                  },
                                                  color: Colors.red,
                                                  height: 48.h,
                                                  width: double.infinity,
                                                  textStyles: TextStyles
                                                      .font16WhiteSemiBold,
                                                )
                                              : (cubit.taskDetailsModel!.data!
                                                              .status! ==
                                                          "In Progress" ||
                                                      cubit.taskDetailsModel!
                                                              .data!.status! ==
                                                          "Rejected" ||
                                                      cubit.taskDetailsModel!
                                                              .data!.status! ==
                                                          "Overdue")
                                                  ? DefaultElevatedButton(
                                                      name: "Not Resolve",
                                                      onPressed: () {
                                                        cubit.changeTaskStatus(
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
                                                  : (cubit.taskDetailsModel!
                                                              .data!.status! ==
                                                          "Not Resolved")
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            DefaultElevatedButton(
                                                              name: "Delete",
                                                              onPressed: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (dialogContext) {
                                                                      return PopUpMessage(
                                                                          title:
                                                                              'delete',
                                                                          body:
                                                                              'task',
                                                                          onPressed:
                                                                              () {
                                                                            cubit.taskDelete(cubit.taskDetailsModel!.data!.id!);
                                                                          });
                                                                    });
                                                              },
                                                              color: Colors.red,
                                                              height: 48.h,
                                                              width: 157.w,
                                                              textStyles: TextStyles
                                                                  .font16WhiteSemiBold,
                                                            ),
                                                            DefaultElevatedButton(
                                                              name: "Rejected",
                                                              onPressed: () {
                                                                cubit
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
