import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
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
import 'package:smart_cleaning_application/core/widgets/pdf_image_view/pdf_image_view.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/row_details_build.dart';
import 'package:smart_cleaning_application/features/screens/task/view_task/logic/task_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/task/view_task/ui/widget/current_read_dialog_.dart';
import 'package:smart_cleaning_application/features/screens/task/view_task/ui/widget/upload_files_dialog.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
        title: Text(S.of(context).task_details),
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

            toast(text: state.message, isSuccess: true);
            cubit.getTaskDetails(widget.id);
          }
          if (state is GetChangeTaskStatusSuccessState) {
            toast(text: state.changeTaskStatusModel.message!, isSuccess: true);
            cubit.getTaskDetails(widget.id);
          }
          if (state is AddCommentsErrorState) {
            toast(text: state.error, isSuccess: false);
          }

          if (state is GetChangeTaskStatusErrorState) {
            toast(text: state.error, isSuccess: false);
          }

          if (state is TaskDeleteSuccessState) {
            toast(text: state.deleteTaskModel.message!, isSuccess: true);
            context.popWithTrueResult();
          }
          if (state is TaskDeleteErrorState) {
            toast(text: state.error, isSuccess: false);
          }
        },
        builder: (context, state) {
          if (cubit.taskDetailsModel == null) {
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
                                ? S.of(context).duration2
                                : S.of(context).total_time,
                            style: TextStyles.font14BlackSemiBold,
                          ),
                          TextSpan(
                            text: ' : ',
                            style: TextStyles.font14BlackSemiBold,
                          ),
                          TextSpan(
                            text: cubit.taskDetailsModel!.data!.duration == null
                                ? cubit.taskDetailsModel!.data!.started == null
                                    ? S.of(context).task_not_started
                                    : S.of(context).task_not_completed
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
                                  child: Text(
                                    S.of(context).ReadLessButton,
                                    style: TextStyle(
                                        color: AppColor.primaryColor,
                                        fontSize: 12),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    S.of(context).ReadMoreButton,
                                    style: TextStyle(
                                        color: AppColor.primaryColor,
                                        fontSize: 12),
                                  ),
                                ))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          S.of(context).startDate,
                          style: TextStyles.font14GreyRegular,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          S.of(context).endDate,
                          style: TextStyles.font14GreyRegular,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: cubit.taskDetailsModel!.data!.startDate!,
                                style: TextStyles.font14BlackRegular,
                              ),
                              TextSpan(
                                text: ' ${S.of(context).start_time} ',
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
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: cubit.taskDetailsModel!.data!.endDate!,
                                style: TextStyles.font14BlackRegular,
                              ),
                              TextSpan(
                                text: ' ${S.of(context).end_time} ',
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
                      ),
                    ],
                  ),
                  verticalSpace(3),
                  Divider(),
                  if (cubit.taskDetailsModel!.data!.createdUserName != null ||
                      cubit.taskDetailsModel!.data!.deviceName != null) ...[
                    rowDetailsBuild(
                      context,
                      cubit.taskDetailsModel!.data!.createdUserName != null
                          ? S.of(context).created_by
                          : S.of(context).device_name,
                      cubit.taskDetailsModel!.data!.createdUserName ??
                          cubit.taskDetailsModel!.data!.deviceName!,
                    ),
                    Divider(),
                  ],
                  if (role != 'Cleaner') ...[
                    rowDetailsBuild(context, S.of(context).parent_task,
                        cubit.taskDetailsModel!.data!.parentTitle ?? '--'),
                    Divider(),
                  ],
                  rowDetailsBuild(context, S.of(context).Organization,
                      cubit.taskDetailsModel!.data!.organizationName ?? "--"),
                  Divider(),
                  rowDetailsBuild(context, S.of(context).Building,
                      cubit.taskDetailsModel!.data!.buildingName ?? "--"),
                  Divider(),
                  rowDetailsBuild(context, S.of(context).Floor,
                      cubit.taskDetailsModel!.data!.floorName ?? "--"),
                  Divider(),
                  rowDetailsBuild(context, S.of(context).Section,
                      cubit.taskDetailsModel!.data!.sectionName ?? "--"),
                  Divider(),
                  rowDetailsBuild(context, S.of(context).Point,
                      cubit.taskDetailsModel!.data!.pointName ?? "--"),
                  Divider(),
                  if (cubit.taskDetailsModel?.data?.currentReading != null) ...[
                    rowDetailsBuild(
                      context,
                      S.of(context).currently_reading,
                      cubit.taskDetailsModel!.data!.currentReading.toString(),
                    ),
                    Divider()
                  ],
                  if (cubit.taskDetailsModel?.data?.readingAfter != null) ...[
                    rowDetailsBuild(
                      context,
                      S.of(context).after_reading,
                      cubit.taskDetailsModel!.data!.readingAfter.toString(),
                    ),
                    Divider()
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).task_team,
                        style: TextStyles.font14BlackSemiBold,
                      ),
                      Text(
                        cubit.taskDetailsModel!.data!.users!.isEmpty
                            ? S.of(context).no_employee_added
                            : '',
                        style: TextStyles.font13greymedium,
                      ),
                    ],
                  ),
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
                          (uId ==
                                      cubit.taskDetailsModel!.data!
                                          .users![index].id &&
                                  role == 'Cleaner')
                              ? null
                              : context.pushNamed(
                                  Routes.userDetailsScreen,
                                  arguments: cubit
                                      .taskDetailsModel!.data!.users![index].id,
                                );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
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
                                  backgroundImage: cubit.taskDetailsModel!.data!
                                              .users![index].image ==
                                          null
                                      ? AssetImage(
                                          'assets/images/person.png',
                                        )
                                      : NetworkImage(
                                          '${cubit.taskDetailsModel!.data!.users![index].image}',
                                        )),
                              horizontalSpace(10),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (cubit.taskDetailsModel?.data?.users?[index]
                                                .firstName ??
                                            '')
                                        .substring(
                                            0,
                                            (cubit
                                                        .taskDetailsModel
                                                        ?.data
                                                        ?.users?[index]
                                                        .firstName ??
                                                    '')
                                                .length
                                                .clamp(0, 14)),
                                    style: TextStyles.font12BlackSemi,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    cubit.taskDetailsModel!.data!.users![index]
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).files,
                        style: TextStyles.font14BlackSemiBold,
                      ),
                      Text(
                        cubit.taskDetailsModel!.data!.files!.isEmpty
                            ? S.of(context).no_file_uploaded
                            : '${cubit.taskDetailsModel!.data!.files!.length} ${S.of(context).files_uploaded}',
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
                          final filePath = file.path ?? '';
                          final isPDF = filePath.toLowerCase().endsWith('.pdf');

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Scaffold(
                                    appBar: AppBar(leading: CustomBackButton()),
                                    body: Center(
                                      child: isPDF
                                          ? SfPdfViewer.network(filePath)
                                          : PhotoView(
                                              imageProvider:
                                                  NetworkImage(filePath),
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
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: isPDF
                                    ? Icon(Icons.picture_as_pdf,
                                        color: Colors.red, size: 40.sp)
                                    : Image.network(
                                        filePath,
                                        fit: BoxFit.fill,
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
                          );
                        },
                      ),
                    ),
                  Divider(),
                  Text(
                    S.of(context).comments,
                    style: TextStyles.font14BlackSemiBold,
                  ),
                  verticalSpace(5),
                  cubit.taskDetailsModel!.data!.comments!.every((task) =>
                          task.comment == null &&
                          (task.file == null || task.file!.isEmpty))
                      ? Center(
                          child: Text(
                            S.of(context).no_comments,
                            style: TextStyles.font13greymedium,
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              cubit.taskDetailsModel!.data!.comments!.length,
                          separatorBuilder: (context, index) =>
                              verticalSpace(8),
                          itemBuilder: (context, index) {
                            final task =
                                cubit.taskDetailsModel!.data!.comments![index];

                            if (task.comment != null ||
                                (task.file != null && task.file!.isNotEmpty)) {
                              return Container(
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
                                      Container(
                                        height: 40.h,
                                        width: 40.w,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle),
                                        clipBehavior: Clip.hardEdge,
                                        child: Image.network(
                                          cubit.taskDetailsModel!.data!
                                                  .comments![index].image ??
                                              '',
                                          fit: BoxFit.fill,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/images/person.png',
                                              fit: BoxFit.fill,
                                            );
                                          },
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
                                            if (task.comment != null)
                                              Text(
                                                task.comment!,
                                                style: TextStyles
                                                    .font13Blackmedium,
                                              ),
                                            verticalSpace(8),
                                            if (task.file != null &&
                                                task.file!.isNotEmpty)
                                              PdfImageView(fileUrl: task.file),
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
                  if (cubit.taskDetailsModel!.data!.statusId != 3) ...[
                    verticalSpace(10),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: S.of(context).add_comment,
                            style: TextStyles.font16BlackRegular,
                          ),
                          TextSpan(
                            text: S.of(context).labelOptional,
                            style: TextStyles.font14GreyRegular,
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(5),
                    Form(
                      key: cubit.formKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 5,
                            child: TextFormField(
                              controller: cubit.commentController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: BorderSide(
                                    color: AppColor.thirdColor,
                                  ),
                                ),
                                hintText: S.of(context).write_comment,
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
                                  return S
                                      .of(context)
                                      .comment_or_image_required;
                                }
                                return null;
                              },
                            ),
                          ),
                          horizontalSpace(4),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: MaterialButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    if (cubit.formKey.currentState!
                                        .validate()) {
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
                            ),
                          )
                        ],
                      ),
                    ),
                    verticalSpace(10),
                  ],
                  (state is ImageSelectedState || state is CameraSelectedState)
                      ? Stack(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final path = cubit.image!.path;
                                final isPDF =
                                    path.toLowerCase().endsWith('.pdf');

                                if (isPDF) {
                                  await OpenFile.open(path);
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (contextt) => Scaffold(
                                        appBar:
                                            AppBar(leading: CustomBackButton()),
                                        body: Center(
                                          child: PhotoView(
                                            imageProvider:
                                                FileImage(File(path)),
                                            backgroundDecoration:
                                                const BoxDecoration(
                                                    color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Builder(builder: (_) {
                                final path = cubit.image!.path;
                                final isPDF =
                                    path.toLowerCase().endsWith('.pdf');

                                return Container(
                                  height: 80,
                                  width: 80,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: isPDF
                                      ? Icon(Icons.picture_as_pdf,
                                          color: Colors.red, size: 40.sp)
                                      : Image.file(File(path),
                                          fit: BoxFit.cover),
                                );
                              }),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  cubit.removeSelectedFile();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                  child: Icon(Icons.close,
                                      size: 14, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
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
                                                    Expanded(
                                                      child:
                                                          DefaultElevatedButton(
                                                        name: S
                                                            .of(context)
                                                            .startButton,
                                                        onPressed: () {
                                                          cubit
                                                              .changeTaskStatus(
                                                            widget.id,
                                                            1,
                                                          );
                                                        },
                                                        color: AppColor
                                                            .primaryColor,
                                                        textStyles: TextStyles
                                                            .font16WhiteSemiBold,
                                                      ),
                                                    ),
                                                    horizontalSpace(8),
                                                    Expanded(
                                                      child:
                                                          DefaultElevatedButton(
                                                        name: S
                                                            .of(context)
                                                            .notresolvedButton,
                                                        onPressed: () {
                                                          cubit
                                                              .changeTaskStatus(
                                                            widget.id,
                                                            5,
                                                          );
                                                        },
                                                        color: AppColor
                                                            .secondaryColor,
                                                        textStyles: TextStyles
                                                            .font16WhiteSemiBold,
                                                      ),
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
                                                        Expanded(
                                                          child:
                                                              DefaultElevatedButton(
                                                            name: S
                                                                .of(context)
                                                                .completeButton,
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
                                                            textStyles: TextStyles
                                                                .font16WhiteSemiBold,
                                                          ),
                                                        ),
                                                        horizontalSpace(8),
                                                        Expanded(
                                                          child:
                                                              DefaultElevatedButton(
                                                            name: S
                                                                .of(context)
                                                                .notresolvedButton,
                                                            onPressed: () {
                                                              cubit
                                                                  .changeTaskStatus(
                                                                widget.id,
                                                                5,
                                                              );
                                                            },
                                                            color: AppColor
                                                                .secondaryColor,
                                                            textStyles: TextStyles
                                                                .font16WhiteSemiBold,
                                                          ),
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
                                                Expanded(
                                                  child: DefaultElevatedButton(
                                                    name: S
                                                        .of(context)
                                                        .completeButton,
                                                    onPressed: () {
                                                      cubit.changeTaskStatus(
                                                        widget.id,
                                                        3,
                                                      );
                                                    },
                                                    color:
                                                        AppColor.primaryColor,
                                                    textStyles: TextStyles
                                                        .font16WhiteSemiBold,
                                                  ),
                                                ),
                                                horizontalSpace(8),
                                                Expanded(
                                                  child: DefaultElevatedButton(
                                                    name: S
                                                        .of(context)
                                                        .rejectButton,
                                                    onPressed: () {
                                                      cubit.changeTaskStatus(
                                                        widget.id,
                                                        4,
                                                      );
                                                    },
                                                    color:
                                                        AppColor.secondaryColor,
                                                    textStyles: TextStyles
                                                        .font16WhiteSemiBold,
                                                  ),
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
                                                  name: S
                                                      .of(context)
                                                      .deleteButton,
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (dialogContext) {
                                                          return PopUpMessage(
                                                              title: S
                                                                  .of(context)
                                                                  .TitleDelete,
                                                              body: S
                                                                  .of(context)
                                                                  .taskbody,
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
                                                      name: S
                                                          .of(context)
                                                          .notresolvedButton,
                                                      onPressed: () {
                                                        cubit.changeTaskStatus(
                                                          widget.id,
                                                          5,
                                                        );
                                                      },
                                                      color: AppColor
                                                          .secondaryColor,
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
                                                            Expanded(
                                                              child:
                                                                  DefaultElevatedButton(
                                                                name: S
                                                                    .of(context)
                                                                    .deleteButton,
                                                                onPressed: () {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (dialogContext) {
                                                                        return PopUpMessage(
                                                                            title:
                                                                                S.of(context).TitleDelete,
                                                                            body: S.of(context).taskbody,
                                                                            onPressed: () {
                                                                              cubit.taskDelete(cubit.taskDetailsModel!.data!.id!);
                                                                            });
                                                                      });
                                                                },
                                                                color:
                                                                    Colors.red,
                                                                textStyles:
                                                                    TextStyles
                                                                        .font16WhiteSemiBold,
                                                              ),
                                                            ),
                                                            horizontalSpace(8),
                                                            Expanded(
                                                              child:
                                                                  DefaultElevatedButton(
                                                                name: S
                                                                    .of(context)
                                                                    .rejectButton,
                                                                onPressed: () {
                                                                  cubit
                                                                      .changeTaskStatus(
                                                                    widget.id,
                                                                    4,
                                                                  );
                                                                },
                                                                color: AppColor
                                                                    .secondaryColor,
                                                                textStyles:
                                                                    TextStyles
                                                                        .font16WhiteSemiBold,
                                                              ),
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
