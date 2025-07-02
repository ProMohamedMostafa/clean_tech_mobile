import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_date_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_time_picker.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/logic/edit_task_cubit.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/logic/edit_task_state.dart';
import 'package:smart_cleaning_application/features/screens/task/edit_task/ui/widget/upload_files_dialog.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';
import '../../../../../../core/helpers/constants/constants.dart';

class EditTaskBody extends StatefulWidget {
  final int id;
  const EditTaskBody({super.key, required this.id});

  @override
  State<EditTaskBody> createState() => _EditTaskBodyState();
}

class _EditTaskBodyState extends State<EditTaskBody> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditTaskCubit>();
    return Scaffold(
        appBar:
            AppBar(title: const Text("Edit Task"), leading: CustomBackButton()),
        body: BlocConsumer<EditTaskCubit, EditTaskState>(
          listener: (context, state) {
            if (state is EditTaskSuccessState) {
              toast(text: state.editTaskModel.message!, color: Colors.blue);
              context.popWithTrueResult();
            }
            if (state is EditTaskErrorState) {
              toast(text: state.message, color: Colors.red);
            }
          },
          builder: (context, state) {
            if (cubit.taskDetailsModel == null ||
                cubit.usersModel == null ||
                cubit.allTasksModel == null ||
                cubit.organizationModel == null) {
              return Loading();
            }
            if (cubit.selectedPriority == null &&
                cubit.taskDetailsModel?.data?.priority != null) {
              cubit.selectedPriority = cubit.taskDetailsModel!.data!.priority!;
              cubit.isSelected = cubit.priority.contains(cubit.selectedPriority)
                  ? cubit.priority.indexOf(cubit.selectedPriority!)
                  : null;
            }
            var items = cubit.usersModel?.data?.users
                ?.map((employee) => DropdownItem(
                      label: employee.userName!,
                      value: employee,
                    ))
                .toList();
            return SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                          key: cubit.formKey,
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
                                    children: List.generate(
                                        cubit.priority.length, (index) {
                                      return Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                cubit.isSelected = index;
                                                cubit.selectedPriority =
                                                    cubit.priority[index];

                                                cubit.taskDetailsModel!.data!
                                                        .priority =
                                                    cubit.priority[index];
                                              });
                                            },
                                            child: Container(
                                              height: 40.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: cubit.isSelected == index
                                                    ? cubit.tasksColor[index]
                                                        .withOpacity(0.2)
                                                    : Colors.white,
                                                border: Border.all(
                                                    color: cubit
                                                        .tasksColor[index]),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  cubit.priority[index],
                                                  style: TextStyles
                                                      .font14Redbold
                                                      .copyWith(
                                                    color:
                                                        cubit.tasksColor[index],
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
                                  hint: cubit.taskDetailsModel!.data!
                                          .parentTitle ??
                                      '',
                                  items: cubit.taskData
                                      .where((task) => task.createdBy != uId)
                                      .map((e) => e.title ?? 'Unknown')
                                      .toList(),
                                  onChanged: (value) {
                                    final selectedParentTask = cubit
                                        .allTasksModel?.data?.data
                                        ?.firstWhere((task) =>
                                            task.title ==
                                            cubit.parentTaskController.text)
                                        .id;
                                    cubit.parentIdTaskController.text =
                                        selectedParentTask!.toString();
                                    cubit.getAllTasks();
                                  },
                                  suffixIcon: IconBroken.arrowDown2,
                                  controller: cubit.parentTaskController,
                                  keyboardType: TextInputType.text,
                                ),
                                verticalSpace(10),
                                Text(
                                  "Task Title",
                                  style: TextStyles.font16BlackRegular,
                                ),
                                verticalSpace(5),
                                CustomTextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Task title is Required";
                                    } else if (value.length > 55) {
                                      return 'Task title too long';
                                    } else if (value.length < 3) {
                                      return 'Task title too short';
                                    }
                                    return null;
                                  },
                                  onlyRead: false,
                                  hint: cubit.taskDetailsModel!.data!.title!,
                                  controller: cubit.taskTitleController
                                    ..text =
                                        cubit.taskDetailsModel!.data!.title!,
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
                                  hint: cubit.taskDetailsModel!.data!
                                          .organizationName ??
                                      S.of(context).selectOrganization,
                                  controller: cubit.organizationController,
                                  items: cubit.organizationItem
                                      .map((e) => e.name ?? 'Unknown')
                                      .toList(),
                                  onChanged: (value) {
                                    final selectedOrganization = cubit
                                        .organizationModel?.data?.data
                                        ?.firstWhere((org) =>
                                            org.name ==
                                            cubit.organizationController.text)
                                        .id
                                        ?.toString();

                                    if (selectedOrganization != null) {
                                      cubit.organizationIdController.text =
                                          selectedOrganization;
                                    }
                                    cubit.getBuilding();
                                  },
                                  suffixIcon: IconBroken.arrowDown2,
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
                                  hint: cubit.taskDetailsModel!.data!
                                          .buildingName ??
                                      S.of(context).selectBuilding,
                                  controller: cubit.buildingController,
                                  items: cubit.buildingItem
                                      .map((e) => e.name ?? 'Unknown')
                                      .toList(),
                                  onChanged: (value) {
                                    final selectedBuilding = cubit
                                        .buildingModel?.data?.data
                                        ?.firstWhere((bld) =>
                                            bld.name ==
                                            cubit.buildingController.text)
                                        .id
                                        ?.toString();

                                    if (selectedBuilding != null) {
                                      cubit.buildingIdController.text =
                                          selectedBuilding;
                                    }
                                    cubit.getFloor();
                                  },
                                  suffixIcon: IconBroken.arrowDown2,
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
                                  hint:
                                      cubit.taskDetailsModel!.data!.floorName ??
                                          S.of(context).selectFloor,
                                  controller: cubit.floorController,
                                  items: cubit.floorItem
                                      .map((e) => e.name ?? 'Unknown')
                                      .toList(),
                                  onChanged: (value) {
                                    final selectedFloor = cubit
                                        .floorModel?.data?.data
                                        ?.firstWhere((floor) =>
                                            floor.name ==
                                            cubit.floorController.text)
                                        .id
                                        ?.toString();

                                    if (selectedFloor != null) {
                                      cubit.floorIdController.text =
                                          selectedFloor;
                                    }
                                    cubit.getSection();
                                  },
                                  suffixIcon: IconBroken.arrowDown2,
                                  keyboardType: TextInputType.text,
                                ),
                                verticalSpace(10),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Section',
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
                                  hint: cubit.taskDetailsModel!.data!
                                          .sectionName ??
                                      S.of(context).selectSection,
                                  controller: cubit.sectionController,
                                  items: cubit.sectionItem
                                      .map((e) => e.name ?? 'Unknown')
                                      .toList(),
                                  onChanged: (value) {
                                    final selectedSection = cubit
                                        .sectionModel?.data?.data
                                        ?.firstWhere((section) =>
                                            section.name ==
                                            cubit.sectionController.text)
                                        .id
                                        ?.toString();

                                    if (selectedSection != null) {
                                      cubit.sectionIdController.text =
                                          selectedSection;
                                    }
                                  },
                                  suffixIcon: IconBroken.arrowDown2,
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
                                  hint:
                                      cubit.taskDetailsModel!.data!.pointName ??
                                          'Select point',
                                  controller: cubit.pointController,
                                  items: cubit.pointItem
                                      .map((e) => e.name ?? 'Unknown')
                                      .toList(),
                                  onChanged: (value) {
                                    final selectedPoint = cubit
                                        .pointModel?.data?.data
                                        ?.firstWhere((point) =>
                                            point.name ==
                                            cubit.pointController.text)
                                        .id
                                        ?.toString();

                                    if (selectedPoint != null) {
                                      cubit.pointIdController.text =
                                          selectedPoint;
                                    }
                                  },
                                  suffixIcon: IconBroken.arrowDown2,
                                  keyboardType: TextInputType.text,
                                ),
                                if (cubit.isPointCountable) ...[
                                  verticalSpace(10),
                                  Text(
                                    "Currently reading",
                                    style: TextStyles.font16BlackRegular,
                                  ),
                                  CustomTextFormField(
                                    onlyRead: false,
                                    hint: cubit
                                        .taskDetailsModel!.data!.currentReading!
                                        .toString(),
                                    controller: cubit.currentlyReadingController
                                      ..text = cubit.taskDetailsModel!.data!
                                          .currentReading!
                                          .toString(),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Currently reading is Required";
                                      } else if (value.length > 30) {
                                        return 'Currently reading too long';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      cubit.currentlyReadingController.text =
                                          double.parse(value).toString();
                                    },
                                  ),
                                  verticalSpace(10),
                                ],
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
                                        cubit.statusIdController.text = '3';
                                      } else if (selectedIndex == 2) {
                                        cubit.statusIdController.text = '6';
                                      } else {
                                        cubit.statusIdController.text =
                                            selectedIndex.toString();
                                      }
                                    }

                                    cubit.statusController.text = selectedValue;
                                  },
                                  hint: cubit.taskDetailsModel!.data!.status!,
                                  items: ['Pending', 'Completed', 'Overdue'],
                                  suffixIcon: IconBroken.arrowDown2,
                                  keyboardType: TextInputType.text,
                                  controller: cubit.statusController,
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
                                          hint: cubit.taskDetailsModel!.data!
                                              .startDate!,
                                          controller: cubit.startDateController,
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
                                          hint: cubit
                                              .taskDetailsModel!.data!.endDate!,
                                          controller: cubit.endDateController,
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
                                          hint: cubit.taskDetailsModel!.data!
                                              .startTime!,
                                          controller: cubit.startTimeController,
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
                                          hint: cubit
                                              .taskDetailsModel!.data!.endTime!,
                                          controller: cubit.endTimeController,
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
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Employee',
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
                                MultiDropdown<UserItem>(
                                  items: items ?? [],
                                  controller: cubit.usersController,
                                  enabled: true,
                                  chipDecoration: ChipDecoration(
                                    backgroundColor: Colors.grey[300],
                                    wrap: true,
                                    runSpacing: 5,
                                    spacing: 5,
                                  ),
                                  fieldDecoration: FieldDecoration(
                                    hintText: cubit
                                        .taskDetailsModel!.data!.users!
                                        .map((cleaner) => cleaner.userName)
                                        .join(', '),
                                    hintStyle: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColor.thirdColor),
                                    showClearIcon: false,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide:
                                          BorderSide(color: Colors.grey[300]!),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                        color: AppColor.primaryColor,
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
                                  dropdownItemDecoration:
                                      DropdownItemDecoration(
                                    selectedIcon: const Icon(Icons.check_box,
                                        color: Colors.blue),
                                  ),
                                  onSelectionChange: (selectedItems) {
                                    cubit.selectedUsersIds = selectedItems
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Task description is Required";
                                      } else if (value.length < 3) {
                                        return 'Task description too short';
                                      }
                                      return null;
                                    },
                                    controller: cubit.descriptionController
                                      ..text = cubit
                                          .taskDetailsModel!.data!.description!,
                                    hint: cubit
                                        .taskDetailsModel!.data!.description!),
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
                                              .showBottomDialog(
                                                  context,
                                                  context
                                                      .read<EditTaskCubit>());
                                        },
                                        icon: Icon(
                                          Icons.attach_file_rounded,
                                          size: 20,
                                        ))
                                  ],
                                ),
                                if (context
                                    .read<EditTaskCubit>()
                                    .taskDetailsModel!
                                    .data!
                                    .files!
                                    .isNotEmpty)
                                  SizedBox(
                                    height: 80,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: cubit.taskDetailsModel!.data!
                                          .files!.length,
                                      itemBuilder: (context, index) {
                                        final file = context
                                            .read<EditTaskCubit>()
                                            .taskDetailsModel!
                                            .data!
                                            .files![index];
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
                                                      File(context
                                                          .read<EditTaskCubit>()
                                                          .image!
                                                          .path),
                                                    ),
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
                                          height: 80,
                                          width: 80,
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.r)),
                                          child: Image.file(
                                            File(cubit.image!.path),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                verticalSpace(20),
                                state is EditTaskLoadingState
                                    ? Loading()
                                    : Center(
                                        child: DefaultElevatedButton(
                                            name: "Edit",
                                            onPressed: () {
                                              if (context
                                                  .read<EditTaskCubit>()
                                                  .formKey
                                                  .currentState!
                                                  .validate()) {
                                                showDialog(
                                                    context: context,
                                                    builder: (dialogContext) {
                                                      return PopUpMessage(
                                                          title: 'edit',
                                                          body: 'task',
                                                          onPressed: () {
                                                            context
                                                                .read<
                                                                    EditTaskCubit>()
                                                                .editTask(
                                                                    widget.id,
                                                                    cubit.image
                                                                        ?.path);
                                                          });
                                                    });
                                              }
                                            },
                                            color: AppColor.primaryColor,
                                            height: 47,
                                            width: double.infinity,
                                            textStyles: TextStyles
                                                .font20Whitesemimedium),
                                      ),
                                verticalSpace(30),
                              ]),
                        ))));
          },
        ));
  }
}
