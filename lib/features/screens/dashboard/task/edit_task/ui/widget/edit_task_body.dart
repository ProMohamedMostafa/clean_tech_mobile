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
import 'package:smart_cleaning_application/core/widgets/custom_multi_dropdown/custom_multi_dropdown.dart';
import 'package:smart_cleaning_application/core/widgets/custom_time_picker/custom_time_picker.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/core/widgets/custom_date_picker/custom_date_picker.dart';
import 'package:smart_cleaning_application/core/widgets/custom_description_text_form_field/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/core/widgets/custom_drop_down_list/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/add_task/data/models/users_shift_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/edit_task/logic/edit_task_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/edit_task/logic/edit_task_state.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/edit_task/ui/widget/upload_files_dialog.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class EditTaskBody extends StatefulWidget {
  final int id;
  const EditTaskBody({super.key, required this.id});

  @override
  State<EditTaskBody> createState() => _EditTaskBodyState();
}

class _EditTaskBodyState extends State<EditTaskBody> {
  bool _initialized = false;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditTaskCubit>();

    return Scaffold(
        appBar: AppBar(
            title: Text(S.of(context).edit_task), leading: CustomBackButton()),
        body: BlocConsumer<EditTaskCubit, EditTaskState>(
          listener: (context, state) {
            if (state is GetTaskDetailsSuccessState) {
              cubit.initializeFiles();

              cubit.getShifts();

              cubit.getAllUsers();
            }

            if (state is EditTaskSuccessState) {
              toast(text: state.editTaskModel.message!, isSuccess: true);
              context.popWithTrueResult();
            }
            if (state is EditTaskErrorState) {
              toast(text: state.message, isSuccess: false);
            }
          },
          builder: (context, state) {
            if (cubit.taskDetailsModel == null ||
                cubit.tasksBasicModel == null ||
                cubit.organizationBasicModel == null) {
              return Loading();
            }
            if (cubit.selectedPriority == null &&
                cubit.taskDetailsModel?.data?.priority != null) {
              cubit.selectedPriority = cubit.taskDetailsModel!.data!.priority!;
              cubit.isSelected = cubit.priority.contains(cubit.selectedPriority)
                  ? cubit.priority.indexOf(cubit.selectedPriority!)
                  : null;
            }
            if (!_initialized) {
              _initialized = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                cubit.initializeUsersControllers();
                cubit.initializeShiftControllers();
              });
            }
            return SingleChildScrollView(
              child: SafeArea(
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
                                children: List.generate(cubit.priority.length,
                                    (index) {
                                  return Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
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
                                                color: cubit.tasksColor[index]),
                                          ),
                                          child: Center(
                                            child: Text(
                                              cubit.priority[index],
                                              style: TextStyles.font14Redbold
                                                  .copyWith(
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
                            verticalSpace(10),
                            Text(
                              S.of(context).parent_task,
                              style: TextStyles.font16BlackRegular,
                            ),
                            verticalSpace(5),
                            CustomDropDownList(
                              hint: cubit.taskDetailsModel!.data!.parentTitle ??
                                  '',
                              items: cubit.tasksBasicModel!.data!
                                  .map((e) => e.title ?? 'Unknown')
                                  .toList(),
                              onChanged: (value) {
                                final selectedParentTask = cubit
                                    .tasksBasicModel?.data
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
                              S.of(context).task_title,
                              style: TextStyles.font16BlackRegular,
                            ),
                            verticalSpace(5),
                            CustomTextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).task_title_required;
                                } else if (value.length > 55) {
                                  return S.of(context).task_title_too_long;
                                } else if (value.length < 3) {
                                  return S.of(context).task_title_too_short;
                                }
                                return null;
                              },
                              onlyRead: false,
                              hint: cubit.taskDetailsModel!.data!.title!,
                              controller: cubit.taskTitleController
                                ..text = cubit.taskDetailsModel!.data!.title!,
                              keyboardType: TextInputType.text,
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
                                      S.of(context).startDate,
                                      style: TextStyles.font16BlackRegular,
                                    ),
                                    verticalSpace(5),
                                    CustomTextFormField(
                                      onlyRead: true,
                                      hint: cubit
                                          .taskDetailsModel!.data!.startDate!,
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
                                    ),
                                  ],
                                )),
                                horizontalSpace(10),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).endDate,
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
                                          cubit.endDateController.text =
                                              selectedDate;
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).startTime,
                                      style: TextStyles.font16BlackRegular,
                                    ),
                                    verticalSpace(5),
                                    CustomTextFormField(
                                      onlyRead: true,
                                      hint: cubit
                                          .taskDetailsModel!.data!.startTime!,
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
                                    ),
                                  ],
                                )),
                                horizontalSpace(10),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).endTime,
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
                                          cubit.endTimeController.text =
                                              selectedTime;
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
                              S.of(context).status,
                              style: TextStyles.font16BlackRegular,
                            ),
                            verticalSpace(5),
                            CustomDropDownList(
                              onChanged: (selectedValue) {
                                final items = [
                                  S.of(context).pending,
                                  S.of(context).complete,
                                  S.of(context).overdue,
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
                              items: [
                                S.of(context).pending,
                                S.of(context).complete,
                                S.of(context).overdue,
                              ],
                              suffixIcon: IconBroken.arrowDown2,
                              keyboardType: TextInputType.text,
                              controller: cubit.statusController,
                            ),
                            verticalSpace(10),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: S.of(context).Organization,
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
                            CustomDropDownList(
                              hint: cubit.taskDetailsModel!.data!
                                      .organizationName ??
                                  S.of(context).selectOrganization,
                              controller: cubit.organizationController,
                              items: cubit.organizationBasicModel!.data!
                                  .map((e) => e.name ?? 'Unknown')
                                  .toList(),
                              onChanged: (value) {
                                final selectedOrganization = cubit
                                    .organizationBasicModel?.data
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
                                    text: S.of(context).Building,
                                    style: TextStyles.font16BlackRegular,
                                  ),
                                  TextSpan(
                                    text: S.of(context).Organization,
                                    style: TextStyles.font14GreyRegular,
                                  ),
                                ],
                              ),
                            ),
                            verticalSpace(5),
                            CustomDropDownList(
                              hint:
                                  cubit.taskDetailsModel!.data!.buildingName ??
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
                                    text: S.of(context).Floor,
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
                            CustomDropDownList(
                              hint: cubit.taskDetailsModel!.data!.floorName ??
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
                                    text: S.of(context).Section,
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
                            CustomDropDownList(
                              hint: cubit.taskDetailsModel!.data!.sectionName ??
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
                                cubit.getPoint();
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
                                    text: S.of(context).Point,
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
                            CustomDropDownList(
                              hint: cubit.taskDetailsModel!.data!.pointName ??
                                  S.of(context).select_point,
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
                                  cubit.pointIdController.text = selectedPoint;
                                  cubit.getShifts();
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
                                    text: S.of(context).shiftBody,
                                    style: TextStyles.font16BlackRegular,
                                  ),
                                  TextSpan(
                                    text: S.of(context).labelOptional,
                                    style: TextStyles.font14GreyRegular,
                                  ),
                                ],
                              ),
                            ),
                            CustomMultiDropdown(
                              items: cubit.shiftModel?.data?.data?.isEmpty ??
                                      true
                                  ? [
                                      DropdownItem(
                                        label: S.of(context).noShiftsAvailable,
                                        value: ShiftItem(
                                            id: null,
                                            name: S
                                                .of(context)
                                                .noShiftsAvailable),
                                      )
                                    ]
                                  : cubit.shiftModel!.data!.data!
                                      .map((shift) => DropdownItem(
                                            label: shift.name!,
                                            value: shift,
                                          ))
                                      .toList(),
                              controller: cubit.allShiftsController,
                              onSelectionChange: (selectedItems) {
                                cubit.selectedShiftsIds = selectedItems
                                    .map((item) => item.id!)
                                    .toList();
                                if (cubit.selectedShiftsIds.length == 1) {
                                  cubit.getAllUsers();
                                } else {
                                  cubit.usersShiftModel = null;
                                  cubit.usersController.clearAll();
                                  cubit.selectedUsersIds.clear();
                                }
                              },
                              hint: S.of(context).selectShift,
                            ),
                            verticalSpace(10),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: S.of(context).employee,
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
                            CustomMultiDropdown(
                              items: cubit.usersShiftModel?.data?.isEmpty ??
                                      true
                                  ? [
                                      DropdownItem(
                                        label:
                                            S.of(context).noEmployeeValidation,
                                        value: UserShiftData(
                                            id: null,
                                            userName: S
                                                .of(context)
                                                .noEmployeeValidation),
                                      )
                                    ]
                                  : cubit.usersShiftModel!.data!
                                      .map((emp) => DropdownItem(
                                            label: emp.userName!,
                                            value: emp,
                                          ))
                                      .toList(),
                              controller: cubit.usersController,
                              onSelectionChange: (selectedItems) {
                                cubit.selectedUsersIds = selectedItems
                                    .map((item) => (item).id!)
                                    .toList();
                              },
                              hint: S.of(context).selectEmployee,
                            ),
                            verticalSpace(10),
                            if (cubit.isPointCountable) ...[
                              Text(
                                S.of(context).currently_reading,
                                style: TextStyles.font16BlackRegular,
                              ),
                              CustomTextFormField(
                                onlyRead: false,
                                hint: cubit
                                    .taskDetailsModel!.data!.currentReading!
                                    .toString(),
                                controller: cubit.currentlyReadingController
                                  ..text = cubit
                                      .taskDetailsModel!.data!.currentReading!
                                      .toString(),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S
                                        .of(context)
                                        .currently_reading_required;
                                  } else if (value.length > 30) {
                                    return S
                                        .of(context)
                                        .currently_reading_too_long;
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
                              S.of(context).description,
                              style: TextStyles.font16BlackRegular,
                            ),
                            verticalSpace(5),
                            CustomDescriptionTextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).descriptionRequired;
                                  } else if (value.length < 3) {
                                    return S.of(context).descriptionTooShort;
                                  }
                                  return null;
                                },
                                controller: cubit.descriptionController
                                  ..text = cubit
                                      .taskDetailsModel!.data!.description!,
                                hint:
                                    cubit.taskDetailsModel!.data!.description!),
                            verticalSpace(5),
                            Row(
                              children: [
                                Text(
                                  S.of(context).files,
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
                            if (cubit.existingFiles.isNotEmpty)
                              SizedBox(
                                height: 80.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: cubit
                                      .taskDetailsModel!.data!.files!.length,
                                  itemBuilder: (context, index) {
                                    final file = cubit
                                        .taskDetailsModel!.data!.files![index];
                                    final filePath = file.path ?? '';
                                    final isPDF =
                                        filePath.toLowerCase().endsWith('.pdf');

                                    return Stack(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => Scaffold(
                                                  appBar: AppBar(
                                                      leading:
                                                          CustomBackButton()),
                                                  body: Center(
                                                    child: isPDF
                                                        ? SfPdfViewer.network(
                                                            filePath)
                                                        : PhotoView(
                                                            imageProvider:
                                                                NetworkImage(
                                                                    filePath),
                                                            errorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              return Image
                                                                  .asset(
                                                                'assets/images/noImage.png',
                                                                fit:
                                                                    BoxFit.fill,
                                                              );
                                                            },
                                                            backgroundDecoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.h,
                                                horizontal: 10.w),
                                            child: Container(
                                              height: 70.h,
                                              width: 70.w,
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black12),
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              child: isPDF
                                                  ? Icon(Icons.picture_as_pdf,
                                                      color: Colors.red,
                                                      size: 40.sp)
                                                  : Image.network(
                                                      filePath,
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
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: () {
                                              cubit.removeExistingFile(index);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.black
                                                    .withOpacity(0.6),
                                              ),
                                              child: Icon(Icons.close,
                                                  size: 14,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            verticalSpace(20),
                            if (cubit.selectedFiles.isNotEmpty)
                              SizedBox(
                                height: 80.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: cubit.selectedFiles.length,
                                  itemBuilder: (context, index) {
                                    final file = cubit.selectedFiles[index];
                                    final isPDF =
                                        file.extension?.toLowerCase() == 'pdf';

                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      child: Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => Scaffold(
                                                    appBar: AppBar(
                                                        leading:
                                                            CustomBackButton()),
                                                    body: Center(
                                                      child: isPDF
                                                          ? SfPdfViewer.file(
                                                              File(file.path!))
                                                          : PhotoView(
                                                              imageProvider:
                                                                  FileImage(
                                                                      File(file
                                                                          .path!)),
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
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade300),
                                              ),
                                              clipBehavior: Clip.hardEdge,
                                              child: isPDF
                                                  ? Icon(Icons.picture_as_pdf,
                                                      color: Colors.red,
                                                      size: 40.sp)
                                                  : Image.file(
                                                      File(file.path!),
                                                      fit: BoxFit.cover,
                                                      errorBuilder:
                                                          (_, __, ___) {
                                                        return Image.asset(
                                                            'assets/images/noImage.png');
                                                      },
                                                    ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                cubit.removeSelectedFile(index);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black
                                                      .withOpacity(0.6),
                                                ),
                                                child: Icon(Icons.close,
                                                    size: 14,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            else
                              const SizedBox.shrink(),
                            verticalSpace(20),
                            state is EditTaskLoadingState
                                ? Loading()
                                : Center(
                                    child: DefaultElevatedButton(
                                        name: S.of(context).editButton,
                                        onPressed: () {
                                          if (cubit.formKey.currentState!
                                              .validate()) {
                                            showDialog(
                                                context: context,
                                                builder: (dialogContext) {
                                                  return PopUpMessage(
                                                      title: S
                                                          .of(context)
                                                          .TitleEdit,
                                                      body: S
                                                          .of(context)
                                                          .taskbody,
                                                      onPressed: () {
                                                        cubit.editTask(
                                                            widget.id);
                                                      });
                                                });
                                          }
                                        },
                                        color: AppColor.primaryColor,
                                        textStyles:
                                            TextStyles.font20Whitesemimedium),
                                  ),
                            verticalSpace(30),
                          ]),
                    )),
              ),
            );
          },
        ));
  }
}
