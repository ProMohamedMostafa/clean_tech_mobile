import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:photo_view/photo_view.dart';
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
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_date_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_time_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/logic/add_task_cubit.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/logic/add_task_state.dart';

class AddTaskBody extends StatefulWidget {
  const AddTaskBody({super.key});

  @override
  State<AddTaskBody> createState() => _AddTaskBodyState();
}

class _AddTaskBodyState extends State<AddTaskBody> {
  int? statusId;
  List<int> selectedSupervisorIds = [];
  int? buildingId;
  int? floorId;
  int? sectionId;
  int? pointId;
  double? currentReading;
  int? parentId;
  bool _isFormSubmitted = false;
  int? selectedPriority;
  bool isPointCountable = false;

  final Map<String, int> priorityMap = {
    "High": 2,
    "Medium": 1,
    "Low": 0,
  };

  final List<Color> tasksColor = [
    Colors.red,
    Colors.orange,
    Colors.green,
  ];
  @override
  void initState() {
    context.read<AddTaskCubit>().getAllTasks();
    context.read<AddTaskCubit>().getOrganization();
    context.read<AddTaskCubit>().getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Create Task",
          ),
          leading: CustomBackButton(),
        ),
        body: BlocConsumer<AddTaskCubit, AddTaskState>(
          listener: (context, state) {
            if (state is AddTaskSuccessState) {
              toast(text: state.createTaskModel.message!, color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.taskManagementScreen);
            }
            if (state is AddTaskErrorState) {
              toast(text: state.message, color: Colors.red);
            }
          },
          builder: (context, state) {
            if (context.read<AddTaskCubit>().usersModel == null) {
              return Loading();
            }

            var items = context
                .read<AddTaskCubit>()
                .usersModel
                ?.data
                ?.users
                ?.map((employee) => DropdownItem(
                      label: employee.userName!,
                      value: employee,
                    ))
                .toList();
            return SafeArea(
                child: SingleChildScrollView(
                    child: Form(
              key: context.read<AddTaskCubit>().formKey,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Priority",
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        Container(
                          height: 40.h,
                          width: double.infinity,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:
                                List.generate(priorityMap.length, (index) {
                              String priorityName =
                                  priorityMap.keys.elementAt(index);
                              int priorityValue =
                                  priorityMap.values.elementAt(index);
                              return Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedPriority = priorityValue;
                                      });
                                    },
                                    child: Container(
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: selectedPriority == priorityValue
                                            ? tasksColor[index].withOpacity(0.2)
                                            : Colors.white,
                                        border: Border.all(
                                            color: tasksColor[index]),
                                      ),
                                      child: Center(
                                        child: Text(
                                          priorityName,
                                          style:
                                              TextStyles.font14Redbold.copyWith(
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
                        if (_isFormSubmitted && selectedPriority == null)
                          Padding(
                            padding: EdgeInsets.only(left: 10, top: 3),
                            child: Text(
                              'Priority is Required',
                              style: TextStyle(
                                color: Colors.red[800],
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        verticalSpace(10),
                        Text(
                          'Parent task',
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: "Select parent task",
                          items: context
                                      .read<AddTaskCubit>()
                                      .allTasksModel
                                      ?.data
                                      ?.data
                                      ?.toList()
                                      .isEmpty ??
                                  true
                              ? ['No task']
                              : context
                                      .read<AddTaskCubit>()
                                      .allTasksModel
                                      ?.data
                                      ?.data
                                      ?.map((e) => e.title ?? 'Unknown')
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedParentTask = context
                                .read<AddTaskCubit>()
                                .allTasksModel
                                ?.data
                                ?.data
                                ?.firstWhere((task) =>
                                    task.title ==
                                    context
                                        .read<AddTaskCubit>()
                                        .parentTaskController
                                        .text);
                            parentId = selectedParentTask!.id!;
                            context.read<AddTaskCubit>().getAllTasks();
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller:
                              context.read<AddTaskCubit>().parentTaskController,
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
                          hint: "Enter task title",
                          controller:
                              context.read<AddTaskCubit>().taskTitleController,
                          keyboardType: TextInputType.text,
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
                          hint: "Select organizations",
                          items: context
                                      .read<AddTaskCubit>()
                                      .organizationListModel
                                      ?.data
                                      ?.data
                                      ?.isEmpty ??
                                  true
                              ? ['No organizations']
                              : context
                                      .read<AddTaskCubit>()
                                      .organizationListModel
                                      ?.data
                                      ?.data
                                      ?.map((e) => e.name ?? 'Unknown')
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedOrganization = context
                                .read<AddTaskCubit>()
                                .organizationListModel
                                ?.data
                                ?.data
                                ?.firstWhere((organization) =>
                                    organization.name ==
                                    context
                                        .read<AddTaskCubit>()
                                        .organizationController
                                        .text);

                            context
                                .read<AddTaskCubit>()
                                .getBuilding(selectedOrganization!.id!);
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller: context
                              .read<AddTaskCubit>()
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
                          hint: "Select building",
                          items: context
                                      .read<AddTaskCubit>()
                                      .buildingModel
                                      ?.data
                                      ?.data
                                      ?.isEmpty ??
                                  true
                              ? ['No building']
                              : context
                                      .read<AddTaskCubit>()
                                      .buildingModel
                                      ?.data
                                      ?.data
                                      ?.map((e) => e.name ?? 'Unknown')
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedBuilding = context
                                .read<AddTaskCubit>()
                                .buildingModel
                                ?.data
                                ?.data
                                ?.firstWhere((building) =>
                                    building.name ==
                                    context
                                        .read<AddTaskCubit>()
                                        .buildingController
                                        .text);

                            context
                                .read<AddTaskCubit>()
                                .getFloor(selectedBuilding!.id!);
                            buildingId = selectedBuilding.id;
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller:
                              context.read<AddTaskCubit>().buildingController,
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
                          hint: "Select floor",
                          items: context
                                      .read<AddTaskCubit>()
                                      .floorModel
                                      ?.data
                                      ?.data
                                      ?.isEmpty ??
                                  true
                              ? ['No floors']
                              : context
                                      .read<AddTaskCubit>()
                                      .floorModel
                                      ?.data
                                      ?.data
                                      ?.map((e) => e.name ?? 'Unknown')
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedFloor = context
                                .read<AddTaskCubit>()
                                .floorModel
                                ?.data
                                ?.data
                                ?.firstWhere((floor) =>
                                    floor.name ==
                                    context
                                        .read<AddTaskCubit>()
                                        .floorController
                                        .text);

                            context
                                .read<AddTaskCubit>()
                                .getSection(selectedFloor!.id!);
                            floorId = selectedFloor.id;
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller:
                              context.read<AddTaskCubit>().floorController,
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
                          hint: "Select section",
                          items: context
                                      .read<AddTaskCubit>()
                                      .sectionModel
                                      ?.data
                                      ?.data
                                      ?.isEmpty ??
                                  true
                              ? ['No sections']
                              : context
                                      .read<AddTaskCubit>()
                                      .sectionModel
                                      ?.data
                                      ?.data
                                      ?.map((e) => e.name ?? 'Unknown')
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedSection = context
                                .read<AddTaskCubit>()
                                .sectionModel
                                ?.data
                                ?.data
                                ?.firstWhere((section) =>
                                    section.name ==
                                    context
                                        .read<AddTaskCubit>()
                                        .sectionController
                                        .text);

                            context
                                .read<AddTaskCubit>()
                                .getPoint(selectedSection!.id!);
                            sectionId = selectedSection.id;
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller:
                              context.read<AddTaskCubit>().sectionController,
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
                          hint: "Select point",
                          items: context
                                      .read<AddTaskCubit>()
                                      .pointModel
                                      ?.data
                                      ?.data
                                      ?.isEmpty ??
                                  true
                              ? ['No point']
                              : context
                                      .read<AddTaskCubit>()
                                      .pointModel
                                      ?.data
                                      ?.data
                                      ?.map((e) => e.name ?? 'Unknown')
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedPoint = context
                                .read<AddTaskCubit>()
                                .pointModel
                                ?.data
                                ?.data
                                ?.firstWhere((point) =>
                                    point.name ==
                                    context
                                        .read<AddTaskCubit>()
                                        .pointController
                                        .text);

                            context
                                .read<AddTaskCubit>()
                                .getPoint(selectedPoint!.id!);
                            pointId = selectedPoint.id;
                            isPointCountable =
                                selectedPoint.isCountable ?? false;
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller:
                              context.read<AddTaskCubit>().pointController,
                          keyboardType: TextInputType.text,
                        ),
                        if (isPointCountable) ...[
                          verticalSpace(10),
                          Text(
                            "Currently reading",
                            style: TextStyles.font16BlackRegular,
                          ),
                          CustomTextFormField(
                            onlyRead: false,
                            hint: "Write Currently reading",
                            controller: context
                                .read<AddTaskCubit>()
                                .currentlyReadingController,
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
                              currentReading = double.parse(value);
                            },
                          ),
                          verticalSpace(10),
                        ],
                        verticalSpace(10),
                        Text(
                          "Status",
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          onPressed: (selectedValue) {
                            final items = [
                              'Pending',
                              'Completed',
                              'Overdue',
                            ];
                            final selectedIndex = items.indexOf(selectedValue);
                            if (selectedIndex != -1) {
                              if (selectedIndex == 1) {
                                statusId = 3;
                              } else if (selectedIndex == 2) {
                                statusId = 6;
                              } else {
                                statusId = selectedIndex;
                              }
                            }

                            context.read<AddTaskCubit>().statusController.text =
                                selectedValue;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return " Status is Required";
                            }
                            return null;
                          },
                          hint: 'status',
                          items: ['Pending', 'Completed', 'Overdue'],
                          suffixIcon: IconBroken.arrowDown2,
                          keyboardType: TextInputType.text,
                          controller:
                              context.read<AddTaskCubit>().statusController,
                        ),
                        verticalSpace(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Start Date",
                                  style: TextStyles.font16BlackRegular,
                                ),
                                verticalSpace(5),
                                CustomTextFormField(
                                  onlyRead: true,
                                  hint: "--/--/---",
                                  controller: context
                                      .read<AddTaskCubit>()
                                      .startDateController,
                                  suffixIcon: Icons.calendar_today,
                                  suffixPressed: () async {
                                    final selectedDate =
                                        await CustomDatePicker.show(
                                            context: context);

                                    if (selectedDate != null &&
                                        context.mounted) {
                                      context
                                          .read<AddTaskCubit>()
                                          .startDateController
                                          .text = selectedDate;
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Start date is required";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            )),
                            horizontalSpace(10),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "End Date",
                                  style: TextStyles.font16BlackRegular,
                                ),
                                verticalSpace(5),
                                CustomTextFormField(
                                  onlyRead: true,
                                  hint: "--/--/---",
                                  controller: context
                                      .read<AddTaskCubit>()
                                      .endDateController,
                                  suffixIcon: Icons.calendar_today,
                                  suffixPressed: () async {
                                    final selectedDate =
                                        await CustomDatePicker.show(
                                            context: context);

                                    if (selectedDate != null &&
                                        context.mounted) {
                                      context
                                          .read<AddTaskCubit>()
                                          .endDateController
                                          .text = selectedDate;
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Start date is required";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            )),
                          ],
                        ),
                        verticalSpace(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Start Time",
                                  style: TextStyles.font16BlackRegular,
                                ),
                                verticalSpace(5),
                                CustomTextFormField(
                                  onlyRead: true,
                                  hint: '00:00 AM',
                                  controller: context
                                      .read<AddTaskCubit>()
                                      .startTimeController,
                                  suffixIcon: Icons.timer_sharp,
                                  suffixPressed: () async {
                                    final selectedTime =
                                        await CustomTimePicker.show(
                                            context: context);

                                    if (selectedTime != null &&
                                        context.mounted) {
                                      context
                                          .read<AddTaskCubit>()
                                          .startTimeController
                                          .text = selectedTime;
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Start time is required";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            )),
                            horizontalSpace(10),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "End Time",
                                  style: TextStyles.font16BlackRegular,
                                ),
                                verticalSpace(5),
                                CustomTextFormField(
                                  onlyRead: true,
                                  hint: "09:30 PM",
                                  controller: context
                                      .read<AddTaskCubit>()
                                      .endTimeController,
                                  suffixIcon: Icons.timer_sharp,
                                  suffixPressed: () async {
                                    final selectedTime =
                                        await CustomTimePicker.show(
                                            context: context);

                                    if (selectedTime != null &&
                                        context.mounted) {
                                      context
                                          .read<AddTaskCubit>()
                                          .endTimeController
                                          .text = selectedTime;
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Start date is required";
                                    }
                                    return null;
                                  },
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
                          items: items!,
                          controller: context
                              .read<AddTaskCubit>()
                              .supervisorsController,
                          enabled: true,
                          chipDecoration: ChipDecoration(
                            backgroundColor: Colors.grey[300],
                            wrap: true,
                            runSpacing: 5,
                            spacing: 5,
                          ),
                          fieldDecoration: FieldDecoration(
                            hintText: 'Select employee',
                            hintStyle: TextStyle(
                                fontSize: 12.sp, color: AppColor.thirdColor),
                            showClearIcon: false,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(color: Colors.grey),
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
                            selectedIcon:
                                const Icon(Icons.check_box, color: Colors.blue),
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Task description is Required";
                              } else if (value.length < 3) {
                                return 'Task description too short';
                              }
                              return null;
                            },
                            controller: context
                                .read<AddTaskCubit>()
                                .descriptionController,
                            hint: "description..."),
                        verticalSpace(10),
                        Text(
                          'Upload file',
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<AddTaskCubit>().galleryFile();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(10),
                                      backgroundColor: AppColor.primaryColor,
                                      elevation: 4),
                                  child: const Icon(IconBroken.upload,
                                      color: Colors.white, size: 26),
                                ),
                                verticalSpace(8),
                                Text(
                                  'Upload file',
                                  style: TextStyles.font14BlackSemiBold,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<AddTaskCubit>().cameraFile();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(10),
                                      backgroundColor: AppColor.primaryColor,
                                      elevation: 4),
                                  child: const Icon(IconBroken.camera,
                                      color: Colors.white, size: 26),
                                ),
                                verticalSpace(8),
                                Text(
                                  'Take photo',
                                  style: TextStyles.font14BlackSemiBold,
                                ),
                              ],
                            ),
                          ],
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
                                                  .read<AddTaskCubit>()
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
                                    File(context
                                        .read<AddTaskCubit>()
                                        .image!
                                        .path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        verticalSpace(20),
                        state is AddTaskLoadingState
                            ? Loading()
                            : Center(
                                child: DefaultElevatedButton(
                                    name: "Create",
                                    onPressed: () {
                                      setState(() {
                                        _isFormSubmitted = true;
                                      });
                                      if (context
                                          .read<AddTaskCubit>()
                                          .formKey
                                          .currentState!
                                          .validate()) {
                                        context.read<AddTaskCubit>().addTask(
                                            priorityId: selectedPriority,
                                            statusId: statusId,
                                            buildingId: buildingId,
                                            floorId: floorId,
                                            sectionId: sectionId,
                                            pointId: pointId,
                                            selectedSupervisorIds:
                                                selectedSupervisorIds,
                                            parentId: parentId,
                                            currentReading: currentReading);
                                      }
                                    },
                                    color: AppColor.primaryColor,
                                    height: 47,
                                    width: double.infinity,
                                    textStyles:
                                        TextStyles.font20Whitesemimedium),
                              ),
                        verticalSpace(30),
                      ])),
            )));
          },
        ));
  }
}
