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
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_date_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_time_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/logic/add_task_cubit.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/logic/add_task_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AddTaskBody extends StatefulWidget {
  const AddTaskBody({super.key});

  @override
  State<AddTaskBody> createState() => _AddTaskBodyState();
}

class _AddTaskBodyState extends State<AddTaskBody> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddTaskCubit>();
    return Scaffold(
        appBar: AppBar(title: Text("Create Task"), leading: CustomBackButton()),
        body: BlocConsumer<AddTaskCubit, AddTaskState>(
          listener: (context, state) {
            if (state is AddTaskSuccessState) {
              toast(text: state.createTaskModel.message!, color: Colors.blue);
              context.popWithTrueResult();
            }
            if (state is AddTaskErrorState) {
              toast(text: state.message, color: Colors.red);
            }
          },
          builder: (context, state) {
            if (cubit.usersModel == null ||
                cubit.organizationModel == null ||
                cubit.allTasksModel == null) {
              return Loading();
            }

            var items = cubit.usersModel?.data?.users
                ?.map((employee) => DropdownItem(
                      label: employee.userName!,
                      value: employee,
                    ))
                .toList();
            return SingleChildScrollView(
                child: Form(
              key: cubit.formKey,
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
                            children: List.generate(cubit.priorityMap.length,
                                (index) {
                              String priorityName =
                                  cubit.priorityMap.keys.elementAt(index);
                              int priorityValue =
                                  cubit.priorityMap.values.elementAt(index);
                              return Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        cubit.priorityIdController.text =
                                            priorityValue.toString();
                                      });
                                    },
                                    child: Container(
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color:
                                            cubit.priorityIdController.text ==
                                                    priorityValue.toString()
                                                ? cubit.tasksColor[index]
                                                    .withOpacity(0.2)
                                                : Colors.white,
                                        border: Border.all(
                                            color: cubit.tasksColor[index]),
                                      ),
                                      child: Center(
                                        child: Text(
                                          priorityName,
                                          style:
                                              TextStyles.font14Redbold.copyWith(
                                            color: cubit.tasksColor[index],
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
                        if (cubit.isFormSubmitted &&
                            cubit.priorityController.text.isEmpty)
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
                          items: cubit.taskData
                              .map((e) => e.title ?? 'Unknown')
                              .toList(),
                          onPressed: (value) {
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
                          onlyRead: false,
                          hint: "Enter task title",
                          controller: cubit.taskTitleController,
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
                          hint: S.of(context).selectOrganization,
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
                          hint: S.of(context).selectBuilding,
                          controller: cubit.buildingController,
                          items: cubit.buildingItem
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          onChanged: (value) {
                            final selectedBuilding = cubit
                                .buildingModel?.data?.data
                                ?.firstWhere((bld) =>
                                    bld.name == cubit.buildingController.text)
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
                          hint: S.of(context).selectFloor,
                          controller: cubit.floorController,
                          items: cubit.floorItem
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          onChanged: (value) {
                            final selectedFloor = cubit.floorModel?.data?.data
                                ?.firstWhere((floor) =>
                                    floor.name == cubit.floorController.text)
                                .id
                                ?.toString();

                            if (selectedFloor != null) {
                              cubit.floorIdController.text = selectedFloor;
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
                          hint: S.of(context).selectSection,
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
                              cubit.sectionIdController.text = selectedSection;
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
                          hint: 'Select point',
                          controller: cubit.pointController,
                          items: cubit.pointItem
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          onChanged: (value) {
                            final selectedPoint = cubit.pointModel?.data?.data
                                ?.firstWhere((point) =>
                                    point.name == cubit.pointController.text)
                                .id
                                ?.toString();

                            if (selectedPoint != null) {
                              cubit.pointIdController.text = selectedPoint;
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
                            hint: "Write Currently reading",
                            controller: cubit.currentlyReadingController,
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
                          controller: cubit.statusController,
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
                                  controller: cubit.startDateController,
                                  suffixIcon: Icons.calendar_today,
                                  suffixPressed: () async {
                                    final selectedDate =
                                        await CustomDatePicker.show(
                                            context: context);

                                    if (selectedDate != null &&
                                        context.mounted) {
                                      cubit.startDateController.text =
                                          selectedDate;
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
                                  controller: cubit.endDateController,
                                  suffixIcon: Icons.calendar_today,
                                  suffixPressed: () async {
                                    final selectedDate =
                                        await CustomDatePicker.show(
                                            context: context);

                                    if (selectedDate != null &&
                                        context.mounted) {
                                      cubit.endDateController.text =
                                          selectedDate;
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
                                  controller: cubit.startTimeController,
                                  suffixIcon: Icons.timer_sharp,
                                  suffixPressed: () async {
                                    final selectedTime =
                                        await CustomTimePicker.show(
                                            context: context);

                                    if (selectedTime != null &&
                                        context.mounted) {
                                      cubit.startTimeController.text =
                                          selectedTime;
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
                                  controller: cubit.endTimeController,
                                  suffixIcon: Icons.timer_sharp,
                                  suffixPressed: () async {
                                    final selectedTime =
                                        await CustomTimePicker.show(
                                            context: context);

                                    if (selectedTime != null &&
                                        context.mounted) {
                                      cubit.endTimeController.text =
                                          selectedTime;
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
                          controller: cubit.usersController,
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
                              borderSide: BorderSide(color: Colors.grey[300]!),
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
                          dropdownItemDecoration: DropdownItemDecoration(
                            selectedIcon:
                                const Icon(Icons.check_box, color: Colors.blue),
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
                            controller: cubit.descriptionController,
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
                                    cubit.galleryFile();
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
                                    cubit.cameraFile();
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
                                              File(cubit.image!.path),
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
                        state is AddTaskLoadingState
                            ? Loading()
                            : Center(
                                child: DefaultElevatedButton(
                                    name: "Create",
                                    onPressed: () {
                                      setState(() {
                                        cubit.isFormSubmitted = true;
                                      });
                                      if (cubit.formKey.currentState!
                                          .validate()) {
                                        cubit.addTask(image: cubit.image?.path);
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
            ));
          },
        ));
  }
}
