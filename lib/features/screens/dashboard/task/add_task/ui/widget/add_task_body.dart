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
import 'package:smart_cleaning_application/core/widgets/custom_time_picker/custom_time_picker.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/core/widgets/custom_date_picker/custom_date_picker.dart';
import 'package:smart_cleaning_application/core/widgets/custom_description_text_form_field/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/core/widgets/custom_drop_down_list/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/add_task/logic/add_task_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/task/add_task/logic/add_task_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
        appBar: AppBar(
            title: Text(S.of(context).create_task),
            leading: CustomBackButton()),
        body: BlocConsumer<AddTaskCubit, AddTaskState>(
          listener: (context, state) {
            if (state is AddTaskSuccessState) {
              toast(text: state.createTaskModel.message!, isSuccess: true);
              context.popWithTrueResult();
            }
            if (state is AddTaskErrorState) {
              toast(text: state.message, isSuccess: false);
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
                          S.of(context).select_priority,
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
                              S.of(context).priority_required,
                              style: TextStyle(
                                color: Colors.red[800],
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        verticalSpace(10),
                        Text(
                          S.of(context).parent_task,
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: S.of(context).select_parent_task,
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
                          S.of(context).task_title,
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomTextFormField(
                          onlyRead: false,
                          hint: S.of(context).enter_task_title,
                          controller: cubit.taskTitleController,
                          keyboardType: TextInputType.text,
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
                                text: S.of(context).Building,
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
                          hint: S.of(context).select_point,
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
                            S.of(context).currently_reading,
                            style: TextStyles.font16BlackRegular,
                          ),
                          CustomTextFormField(
                            onlyRead: false,
                            hint: S.of(context).write_currently_reading,
                            controller: cubit.currentlyReadingController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).currently_reading_required;
                              } else if (value.length > 30) {
                                return S.of(context).currently_reading_too_long;
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
                          S.of(context).status,
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          onPressed: (selectedValue) {
                            final items = [
                              S.of(context).pending,
                              S.of(context).complete,
                              S.of(context).overdue,
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
                              return S.of(context).status_required;
                            }
                            return null;
                          },
                          hint: 'status',
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
                                      return S
                                          .of(context)
                                          .startDateRequiredValidation;
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
                                  S.of(context).endDate,
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
                                      return S
                                          .of(context)
                                          .endDateRequiredValidation;
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
                                  S.of(context).startTime,
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
                                      return S
                                          .of(context)
                                          .startTimeRequiredValidation;
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
                                  S.of(context).endTime,
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
                                      return S
                                          .of(context)
                                          .endTimeRequiredValidation;
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
                            hintText: S.of(context).selectEmployee,
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
                            controller: cubit.descriptionController,
                            hint: S.of(context).descriptionHint),
                        verticalSpace(10),
                        Text(
                          S.of(context).uploadFile,
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
                                    cubit.pickFiles();
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
                                  S.of(context).uploadFile,
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
                                  S.of(context).take_photo,
                                  style: TextStyles.font14BlackSemiBold,
                                ),
                              ],
                            ),
                          ],
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
                                                              FileImage(File(
                                                                  file.path!)),
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
                                          width: 80.w,
                                          height: 80.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            border: Border.all(
                                                color: Colors.grey.shade300),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child: isPDF
                                              ? Icon(Icons.picture_as_pdf,
                                                  color: Colors.red,
                                                  size: 40.sp)
                                              : Image.file(
                                                  File(file.path!),
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (_, __, ___) {
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
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                            child: Icon(Icons.close,
                                                size: 14, color: Colors.white),
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
                        state is AddTaskLoadingState
                            ? Loading()
                            : Center(
                                child: DefaultElevatedButton(
                                    name: S.of(context).createButton,
                                    onPressed: () {
                                      setState(() {
                                        cubit.isFormSubmitted = true;
                                      });
                                      if (cubit.formKey.currentState!
                                          .validate()) {
                                        cubit.addTask();
                                      }
                                    },
                                    color: AppColor.primaryColor,
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
