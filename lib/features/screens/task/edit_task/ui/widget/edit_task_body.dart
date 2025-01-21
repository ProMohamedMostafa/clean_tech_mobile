import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_date_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_time_picker.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/data/models/supervisor_model.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/logic/edit_task_cubit.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/logic/edit_task_state.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/ui/widget/upload_files_dialog.dart';
import '../../../../../../core/helpers/constants/constants.dart';

class EditTaskBody extends StatefulWidget {
  final int id;
  const EditTaskBody({super.key, required this.id});

  @override
  State<EditTaskBody> createState() => _EditTaskBodyState();
}

class _EditTaskBodyState extends State<EditTaskBody> {
  int? statusId;
  List<int> selectedSupervisorIds = [];
  int? buildingId;
  int? floorId;
  int? pointId;
  int? parentId;
  int? isSelected;
  String? selectedPriority;
  final List<String> priority = ["Low", "Medium", "High"];
  final List<Color> tasksColor = [
    Colors.green,
    Colors.orange,
    Colors.red,
  ];
  @override
  void initState() {
    super.initState();
    final editTaskCubit = context.read<EditTaskCubit>();
    editTaskCubit.getTaskDetails(widget.id);
    editTaskCubit.getUsersTask(widget.id);
    editTaskCubit.getTaskFiles(widget.id);
    editTaskCubit.getAllTasks();
    editTaskCubit.getOrganization();
    editTaskCubit.getSupervisor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Task"),
          leading: customBackButton(context),
        ),
        body: BlocConsumer<EditTaskCubit, EditTaskState>(
          listener: (context, state) {
            if (state is EditTaskSuccessState) {
              toast(text: state.editTaskModel.message!, color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.taskManagementScreen);
            }
            if (state is EditTaskErrorState) {
              toast(text: state.message, color: Colors.red);
            }
          },
          builder: (context, state) {
            final editTaskCubit = context.read<EditTaskCubit>();
            final supervisorModel = editTaskCubit.supervisorModel;
            final taskDetailsModel = editTaskCubit.taskDetailsModel;
            final usersTaskModel = editTaskCubit.usersTaskModel;
            final organizationModel = editTaskCubit.organizationModel;
            final taskFilesModel = editTaskCubit.taskFilesModel;
            final allTasksModel = editTaskCubit.allTasksModel;

            if (state is GetAllTasksLoadingState ||
                state is GetSupervisorLoadingState ||
                state is GetUsersTaskLoadingState ||
                state is GetTaskFilesLoadingState ||
                state is GetTaskDetailsLoadingState ||
                state is GetOrganizationLoadingState ||
                taskDetailsModel == null ||
                supervisorModel == null ||
                usersTaskModel == null ||
                taskFilesModel == null ||
                organizationModel == null ||
                allTasksModel == null) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              );
            }
            if (selectedPriority == null &&
                taskDetailsModel.data?.priority != null) {
              selectedPriority = taskDetailsModel.data!.priority!;
              isSelected = priority.contains(selectedPriority)
                  ? priority.indexOf(selectedPriority!)
                  : null;
            }
            final items = supervisorModel.data!
                .map((supervisor) => DropdownItem(
                      label: supervisor.userName!,
                      value: supervisor,
                    ))
                .toList();
            return SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40.h,
                                width: double.infinity,
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children:
                                      List.generate(priority.length, (index) {
                                    return Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.w),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              isSelected = index;
                                              selectedPriority =
                                                  priority[index];

                                              context
                                                  .read<EditTaskCubit>()
                                                  .taskDetailsModel!
                                                  .data!
                                                  .priority = priority[index];
                                            });
                                          },
                                          child: Container(
                                            height: 40.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: isSelected == index
                                                  ? tasksColor[index]
                                                      .withOpacity(0.2)
                                                  : Colors.white,
                                              border: Border.all(
                                                  color: tasksColor[index]),
                                            ),
                                            child: Center(
                                              child: Text(
                                                priority[index],
                                                style: TextStyles.font14Redbold
                                                    .copyWith(
                                                  color: tasksColor[index],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              verticalSpace(10),
                              Text(
                                'Parent task',
                                style: TextStyles.font16BlackRegular,
                              ),
                              verticalSpace(5),
                              CustomDropDownList(
                                hint: context
                                        .read<EditTaskCubit>()
                                        .taskDetailsModel!
                                        .data!
                                        .parentTitle ??
                                    '',
                                items: context
                                            .read<EditTaskCubit>()
                                            .allTasksModel
                                            ?.data
                                            ?.data
                                            ?.where(
                                                (task) => task.createdBy != uId)
                                            .toList()
                                            .isEmpty ??
                                        true
                                    ? ['No task']
                                    : context
                                            .read<EditTaskCubit>()
                                            .allTasksModel
                                            ?.data
                                            ?.data
                                            ?.where(
                                                (task) => task.createdBy != uId)
                                            .map((e) => e.title ?? 'Unknown')
                                            .toList() ??
                                        [],
                                onChanged: (value) {
                                  final selectedParentTask = context
                                      .read<EditTaskCubit>()
                                      .allTasksModel
                                      ?.data
                                      ?.data
                                      ?.firstWhere((task) =>
                                          task.title ==
                                          context
                                              .read<EditTaskCubit>()
                                              .parentTaskController
                                              .text);
                                  parentId = selectedParentTask!.id!;
                                  context.read<EditTaskCubit>().getAllTasks();
                                },
                                suffixIcon: IconBroken.arrowDown2,
                                controller: context
                                    .read<EditTaskCubit>()
                                    .parentTaskController,
                                keyboardType: TextInputType.text,
                              ),
                              verticalSpace(10),
                              Text(
                                "Task Title",
                                style: TextStyles.font16BlackRegular,
                              ),
                              verticalSpace(5),
                              CustomTextFormField(
                                onlyRead: false,
                                hint: context
                                    .read<EditTaskCubit>()
                                    .taskDetailsModel!
                                    .data!
                                    .title!,
                                controller: context
                                    .read<EditTaskCubit>()
                                    .taskTitleController,
                                keyboardType: TextInputType.text,
                              ),
                              verticalSpace(10),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Organization',
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
                              CustomDropDownList(
                                hint: context
                                        .read<EditTaskCubit>()
                                        .taskDetailsModel!
                                        .data!
                                        .organizationName ??
                                    '',
                                items: context
                                            .read<EditTaskCubit>()
                                            .organizationModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No organizations']
                                    : context
                                            .read<EditTaskCubit>()
                                            .organizationModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                onChanged: (value) {
                                  final selectedOrganization = context
                                      .read<EditTaskCubit>()
                                      .organizationModel
                                      ?.data
                                      ?.firstWhere((organization) =>
                                          organization.name ==
                                          context
                                              .read<EditTaskCubit>()
                                              .organizationController
                                              .text);

                                  context
                                      .read<EditTaskCubit>()
                                      .getBuilding(selectedOrganization!.id!);
                                },
                                suffixIcon: IconBroken.arrowDown2,
                                controller: context
                                    .read<EditTaskCubit>()
                                    .organizationController,
                                keyboardType: TextInputType.text,
                              ),
                              verticalSpace(10),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Building',
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
                              CustomDropDownList(
                                hint: context
                                        .read<EditTaskCubit>()
                                        .taskDetailsModel!
                                        .data!
                                        .buildingName ??
                                    '',
                                items: context
                                            .read<EditTaskCubit>()
                                            .buildingModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No building']
                                    : context
                                            .read<EditTaskCubit>()
                                            .buildingModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                onChanged: (value) {
                                  final selectedBuilding = context
                                      .read<EditTaskCubit>()
                                      .buildingModel
                                      ?.data
                                      ?.firstWhere((building) =>
                                          building.name ==
                                          context
                                              .read<EditTaskCubit>()
                                              .buildingController
                                              .text);

                                  context
                                      .read<EditTaskCubit>()
                                      .getFloor(selectedBuilding!.id!);
                                  buildingId = selectedBuilding.id;
                                },
                                suffixIcon: IconBroken.arrowDown2,
                                controller: context
                                    .read<EditTaskCubit>()
                                    .buildingController,
                                keyboardType: TextInputType.text,
                              ),
                              verticalSpace(10),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Floor',
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
                              CustomDropDownList(
                                hint: context
                                        .read<EditTaskCubit>()
                                        .taskDetailsModel!
                                        .data!
                                        .floorName ??
                                    '',
                                items: context
                                            .read<EditTaskCubit>()
                                            .floorModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No floors']
                                    : context
                                            .read<EditTaskCubit>()
                                            .floorModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                onChanged: (value) {
                                  final selectedFloor = context
                                      .read<EditTaskCubit>()
                                      .floorModel
                                      ?.data
                                      ?.firstWhere((floor) =>
                                          floor.name ==
                                          context
                                              .read<EditTaskCubit>()
                                              .floorController
                                              .text);

                                  context
                                      .read<EditTaskCubit>()
                                      .getPoints(selectedFloor!.id!);
                                  floorId = selectedFloor.id;
                                },
                                suffixIcon: IconBroken.arrowDown2,
                                controller: context
                                    .read<EditTaskCubit>()
                                    .floorController,
                                keyboardType: TextInputType.text,
                              ),
                              verticalSpace(10),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Points',
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
                              CustomDropDownList(
                                hint: context
                                        .read<EditTaskCubit>()
                                        .taskDetailsModel!
                                        .data!
                                        .pointName ??
                                    '',
                                items: context
                                            .read<EditTaskCubit>()
                                            .pointsModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No point']
                                    : context
                                            .read<EditTaskCubit>()
                                            .pointsModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                onChanged: (value) {
                                  final selectedPoint = context
                                      .read<EditTaskCubit>()
                                      .pointsModel
                                      ?.data
                                      ?.firstWhere((point) =>
                                          point.name ==
                                          context
                                              .read<EditTaskCubit>()
                                              .pointController
                                              .text);

                                  context
                                      .read<EditTaskCubit>()
                                      .getPoints(selectedPoint!.id!);
                                  pointId = selectedPoint.id;
                                },
                                suffixIcon: IconBroken.arrowDown2,
                                controller: context
                                    .read<EditTaskCubit>()
                                    .pointController,
                                keyboardType: TextInputType.text,
                              ),
                              verticalSpace(10),
                              Text(
                                "Status",
                                style: TextStyles.font16BlackRegular,
                              ),
                              verticalSpace(5),
                              CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final items = [
                                    'Pending',
                                    'Completed',
                                    'Overdue',
                                  ];
                                  final selectedIndex =
                                      items.indexOf(selectedValue!);
                                  if (selectedIndex != -1) {
                                    if (selectedIndex == 1) {
                                      statusId = 3;
                                    } else if (selectedIndex == 2) {
                                      statusId = 6;
                                    } else {
                                      statusId = selectedIndex;
                                    }
                                  }

                                  context
                                      .read<EditTaskCubit>()
                                      .statusController
                                      .text = selectedValue;
                                },
                                hint: context
                                    .read<EditTaskCubit>()
                                    .taskDetailsModel!
                                    .data!
                                    .status!,
                                items: ['Pending', 'Completed', 'Overdue'],
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text,
                                controller: context
                                    .read<EditTaskCubit>()
                                    .statusController,
                              ),
                              verticalSpace(10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Start Date",
                                        style: TextStyles.font16BlackRegular,
                                      ),
                                      verticalSpace(5),
                                      CustomTextFormField(
                                        onlyRead: true,
                                        hint: context
                                            .read<EditTaskCubit>()
                                            .taskDetailsModel!
                                            .data!
                                            .startDate!,
                                        controller: context
                                            .read<EditTaskCubit>()
                                            .startDateController,
                                        suffixIcon: Icons.calendar_today,
                                        suffixPressed: () async {
                                          final selectedDate =
                                              await CustomDatePicker.show(
                                                  context: context);

                                          if (selectedDate != null &&
                                              context.mounted) {
                                            context
                                                .read<EditTaskCubit>()
                                                .startDateController
                                                .text = selectedDate;
                                          }
                                        },
                                        keyboardType: TextInputType.none,
                                      ),
                                    ],
                                  )),
                                  horizontalSpace(10),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "End Date",
                                        style: TextStyles.font16BlackRegular,
                                      ),
                                      verticalSpace(5),
                                      CustomTextFormField(
                                        onlyRead: true,
                                        hint: context
                                            .read<EditTaskCubit>()
                                            .taskDetailsModel!
                                            .data!
                                            .endDate!,
                                        controller: context
                                            .read<EditTaskCubit>()
                                            .endDateController,
                                        suffixIcon: Icons.calendar_today,
                                        suffixPressed: () async {
                                          final selectedDate =
                                              await CustomDatePicker.show(
                                                  context: context);

                                          if (selectedDate != null &&
                                              context.mounted) {
                                            context
                                                .read<EditTaskCubit>()
                                                .endDateController
                                                .text = selectedDate;
                                          }
                                        },
                                        keyboardType: TextInputType.none,
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                              verticalSpace(10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Start Time",
                                        style: TextStyles.font16BlackRegular,
                                      ),
                                      verticalSpace(5),
                                      CustomTextFormField(
                                        onlyRead: true,
                                        hint: context
                                            .read<EditTaskCubit>()
                                            .taskDetailsModel!
                                            .data!
                                            .startTime!,
                                        controller: context
                                            .read<EditTaskCubit>()
                                            .startTimeController,
                                        suffixIcon: Icons.timer_sharp,
                                        suffixPressed: () async {
                                          final selectedTime =
                                              await CustomTimePicker.show(
                                                  context: context);

                                          if (selectedTime != null &&
                                              context.mounted) {
                                            context
                                                .read<EditTaskCubit>()
                                                .startTimeController
                                                .text = selectedTime;
                                          }
                                        },
                                        keyboardType: TextInputType.none,
                                      ),
                                    ],
                                  )),
                                  horizontalSpace(10),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "End Time",
                                        style: TextStyles.font16BlackRegular,
                                      ),
                                      verticalSpace(5),
                                      CustomTextFormField(
                                        onlyRead: true,
                                        hint: context
                                            .read<EditTaskCubit>()
                                            .taskDetailsModel!
                                            .data!
                                            .endTime!,
                                        controller: context
                                            .read<EditTaskCubit>()
                                            .endTimeController,
                                        suffixIcon: Icons.timer_sharp,
                                        suffixPressed: () async {
                                          final selectedTime =
                                              await CustomTimePicker.show(
                                                  context: context);

                                          if (selectedTime != null &&
                                              context.mounted) {
                                            context
                                                .read<EditTaskCubit>()
                                                .endTimeController
                                                .text = selectedTime;
                                          }
                                        },
                                        keyboardType: TextInputType.none,
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                              verticalSpace(10),
                              Text(
                                role == 'Manager' ? 'Supervisor' : 'Cleaner',
                                style: TextStyles.font16BlackRegular,
                              ),
                              verticalSpace(5),
                              MultiDropdown<SupervisorData>(
                                items: items,
                                controller: context
                                    .read<EditTaskCubit>()
                                    .supervisorsController,
                                enabled: true,
                                chipDecoration: ChipDecoration(
                                  backgroundColor: Colors.grey[300],
                                  wrap: true,
                                  runSpacing: 5,
                                  spacing: 5,
                                ),
                                fieldDecoration: FieldDecoration(
                                  hintText: role == 'Manager'
                                      ? 'supervisor'
                                      : 'cleaner',
                                  hintStyle: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColor.thirdColor),
                                  showClearIcon: false,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                dropdownDecoration:
                                    const DropdownDecoration(maxHeight: 200),
                                dropdownItemDecoration: DropdownItemDecoration(
                                  selectedIcon: const Icon(Icons.check_box,
                                      color: Colors.blue),
                                ),
                                onSelectionChange: (selectedItems) {
                                  selectedSupervisorIds = selectedItems
                                      .map((item) => (item).id!)
                                      .toList();
                                },
                              ),
                              verticalSpace(10),
                              Text(
                                'Description',
                                style: TextStyles.font16BlackRegular,
                              ),
                              verticalSpace(5),
                              CustomDescriptionTextFormField(
                                  controller: context
                                      .read<EditTaskCubit>()
                                      .descriptionController,
                                  hint: context
                                      .read<EditTaskCubit>()
                                      .taskDetailsModel!
                                      .data!
                                      .description!),
                              verticalSpace(5),
                              Row(
                                children: [
                                  Text(
                                    'Files',
                                    style: TextStyles.font16BlackRegular,
                                  ),
                                  verticalSpace(5),
                                  IconButton(
                                      onPressed: () {
                                        UploadFilesBottomDialog()
                                            .showBottomDialog(context,
                                                context.read<EditTaskCubit>());
                                      },
                                      icon: Icon(
                                        Icons.attach_file_rounded,
                                        size: 20,
                                      ))
                                ],
                              ),
                              if (context
                                  .read<EditTaskCubit>()
                                  .taskFilesModel!
                                  .data!
                                  .isNotEmpty)
                                SizedBox(
                                  height: 80,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: context
                                        .read<EditTaskCubit>()
                                        .taskFilesModel!
                                        .data!
                                        .length,
                                    itemBuilder: (context, index) {
                                      final file = context
                                          .read<EditTaskCubit>()
                                          .taskFilesModel!
                                          .data![index];
                                      return Padding(
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
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: Image.network(
                                            "http://10.0.2.2:7111${file.path}",
                                            fit: BoxFit.cover,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          (loadingProgress
                                                                  .expectedTotalBytes ??
                                                              1)
                                                      : null,
                                                ),
                                              );
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                'assets/images/noImage.png',
                                                fit: BoxFit.fill,
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              verticalSpace(20),
                              (state is ImageSelectedState ||
                                      state is CameraSelectedState)
                                  ? Container(
                                      height: 80,
                                      width: 80,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: Image.file(
                                        File(context
                                            .read<EditTaskCubit>()
                                            .image!
                                            .path),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              verticalSpace(20),
                              state is EditTaskLoadingState
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                          color: AppColor.primaryColor),
                                    )
                                  : Center(
                                      child: DefaultElevatedButton(
                                          name: "Edit",
                                          onPressed: () {
                                            context
                                                .read<EditTaskCubit>()
                                                .editTask(
                                                    widget.id,
                                                    isSelected!,
                                                    statusId,
                                                    buildingId,
                                                    floorId,
                                                    pointId,
                                                    selectedSupervisorIds,
                                                    parentId);
                                          },
                                          color: AppColor.primaryColor,
                                          height: 47,
                                          width: double.infinity,
                                          textStyles:
                                              TextStyles.font20Whitesemimedium),
                                    ),
                              verticalSpace(30),
                            ]))));
          },
        ));
  }
}
