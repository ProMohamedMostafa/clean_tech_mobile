import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/filter/logic/cubit/filter_dialog_cubit.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/core/widgets/filter/ui/widget/filter_top_widget.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_date_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_time_picker.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class FilterDialogWidget extends StatelessWidget {
  final String index;
  final Function(FilterDialogDataModel) onPressed;
  const FilterDialogWidget(
      {super.key, required this.onPressed, required this.index});

  @override
  Widget build(BuildContext context) {
    final FilterDialogCubit cubit = context.read<FilterDialogCubit>();
    Map<String, List<String>> moduleActions = {
      'Provider': ['Create', 'Edit', 'Delete', 'Restore', 'ForceDelete'],
      'User': [
        'Create',
        'Edit',
        'Delete',
        'Restore',
        'ForceDelete',
        'Login',
        'Logout',
        'ClockIn',
        'ClockOut',
        'ChangePassword',
        'EditProfile',
        'Assign',
        'RemoveAssign',
        'EditSetting'
      ],
      'UserSetting': ['EditSetting'],
      'Area': [
        'Create',
        'Edit',
        'Delete',
        'Restore',
        'ForceDelete',
        'Assign',
        'RemoveAssign'
      ],
      'City': [
        'Create',
        'Edit',
        'Delete',
        'Restore',
        'ForceDelete',
        'Assign',
        'RemoveAssign'
      ],
      'Organization': [
        'Create',
        'Edit',
        'Delete',
        'Restore',
        'ForceDelete',
        'Assign',
        'RemoveAssign'
      ],
      'Building': [
        'Create',
        'Edit',
        'Delete',
        'Restore',
        'ForceDelete',
        'Assign',
        'RemoveAssign'
      ],
      'Floor': [
        'Create',
        'Edit',
        'Delete',
        'Restore',
        'ForceDelete',
        'Assign',
        'RemoveAssign'
      ],
      'Section': [
        'Create',
        'Edit',
        'Delete',
        'Restore',
        'ForceDelete',
        'Assign',
        'RemoveAssign'
      ],
      'Point': [
        'Create',
        'Edit',
        'Delete',
        'Restore',
        'ForceDelete',
        'Assign',
        'RemoveAssign'
      ],
      'Task': [
        'Create',
        'Edit',
        'Delete',
        'Restore',
        'ForceDelete',
        'ChangeStatus',
        'Comment'
      ],
      'Shift': [
        'Create',
        'Edit',
        'Delete',
        'Restore',
        'ForceDelete',
        'Assign',
        'RemoveAssign'
      ],
      'Attendacne': ['ClockIn', 'ClockOut'],
      'Leave': ['Create', 'Edit', 'Delete'],
      'Category': ['Create', 'Edit', 'Delete', 'Restore', 'ForceDelete'],
      'Material': ['Create', 'Edit', 'Delete', 'Restore', 'ForceDelete'],
      'Stock': ['StockIn', 'StockOut'],
    };

    final List<String> allModules = moduleActions.keys.toList();
    final List<String> allActions =
        moduleActions.values.expand((actions) => actions).toSet().toList();
    final List<String> filteredLevelOrder = cubit.levelOrder
        .where((level) =>
            !((index == 'A-h' || index == 'A-l' || index == 'T') &&
                level == 'Country') &&
            !(index == 'S' && (level == 'Country' || level == 'Point')))
        .toList();
    return Dialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        insetPadding: EdgeInsets.all(20),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: BlocBuilder<FilterDialogCubit, FilterDialogState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildHeader(context),
                      if (index == 'S-c' ||
                          index == 'S-m' ||
                          index == 'S-t') ...[
                        Text(
                          (index == 'S-c') ? 'Parent category' : 'Category',
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: 'Select Parent category',
                          controller: cubit.parentCategoryController,
                          items: cubit.categoryModel
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          onChanged: (selectedValue) {
                            final selectedId =
                                cubit.categoryManagementModel?.data?.categories
                                    ?.firstWhere(
                                      (category) =>
                                          category.name == selectedValue,
                                    )
                                    .id
                                    ?.toString();

                            if (selectedId != null) {
                              cubit.parentCategoryIdController.text =
                                  selectedId;
                            }
                          },
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                        verticalSpace(10),
                      ],
                      if (index == 'S-c') ...[
                        Text(
                          'Unit',
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: 'Select unit',
                          controller: cubit.unitController,
                          items: ['Ml', 'L', 'Kg', 'G', 'M', 'Cm', 'Pieces'],
                          onChanged: (selectedValue) {
                            final items = [
                              'Ml',
                              'L',
                              'Kg',
                              'G',
                              'M',
                              'Cm',
                              'Pieces'
                            ];
                            final selectedIndex = items.indexOf(selectedValue!);
                            if (selectedIndex != -1) {
                              cubit.unitIdController.text =
                                  selectedIndex.toString();
                            }
                          },
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                        verticalSpace(10),
                      ],
                      if (index == 'S-t') ...[
                        Text(
                          'Transaction type',
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: 'Select type',
                          controller: cubit.transactionController,
                          items: ['In', 'Out'],
                          onChanged: (selectedValue) {
                            final items = [
                              'In',
                              'Out',
                            ];
                            final selectedIndex = items.indexOf(selectedValue!);
                            if (selectedIndex != -1) {
                              cubit.transactionIdController.text =
                                  selectedIndex.toString();
                            }
                          },
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                        verticalSpace(10),
                      ],
                      if (index == 'T') ...[
                        if (role == 'Admin' || role == 'Manager') ...[
                          Text(
                            'Created By',
                            style: TextStyles.font16BlackRegular,
                          ),
                          CustomDropDownList(
                            hint: "Select user",
                            controller: cubit.createdByController,
                            items: role == 'Admin'
                                ? cubit.usersModel?.data?.users?.isEmpty ?? true
                                    ? ['No user']
                                    : cubit.usersModel?.data?.users
                                            ?.where((e) => e.roleId != 4)
                                            .map((e) => e.userName ?? 'Unknown')
                                            .toList() ??
                                        []
                                : cubit.usersModel?.data?.users?.isEmpty ?? true
                                    ? ['No user']
                                    : cubit.usersModel?.data?.users
                                            ?.where((e) => e.roleId == 3)
                                            .map((e) => e.userName ?? 'Unknown')
                                            .toList() ??
                                        [],
                            onChanged: (value) {
                              final selectedUser = cubit.usersModel?.data?.users
                                  ?.firstWhere((user) =>
                                      user.userName ==
                                      cubit.createdByController.text)
                                  .id
                                  .toString();
                              if (selectedUser != null) {
                                cubit.createdByIdController.text = selectedUser;
                              }
                            },
                            suffixIcon: IconBroken.arrowDown2,
                            keyboardType: TextInputType.text,
                          ),
                          verticalSpace(10),
                        ],
                        if (role != 'Cleaner') ...[
                          Text(
                            'Assgin to',
                            style: TextStyles.font16BlackRegular,
                          ),
                          CustomDropDownList(
                            hint: "Select user",
                            controller: cubit.assignToController,
                            items:
                                cubit.usersModel?.data?.users?.isEmpty ?? true
                                    ? ['No user']
                                    : cubit.usersModel?.data?.users
                                            ?.where((e) => e.roleId != 1)
                                            .map((e) => e.userName ?? 'Unknown')
                                            .toList() ??
                                        [],
                            onPressed: (value) {
                              final selectedUser = cubit.usersModel?.data?.users
                                  ?.firstWhere((user) =>
                                      user.userName ==
                                      cubit.assignToController.text)
                                  .id
                                  .toString();

                              if (selectedUser != null) {
                                cubit.organizationIdController.text =
                                    selectedUser;
                              }
                            },
                            suffixIcon: IconBroken.arrowDown2,
                            keyboardType: TextInputType.text,
                          ),
                          verticalSpace(10),
                        ],
                        Text(
                          "Status",
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: 'status',
                          controller: cubit.taskStatusController,
                          items: [
                            'Pending',
                            'In Progress',
                            'Not Approval',
                            'Rejected',
                            'Completed',
                            'Not Resolved',
                            'Overdue',
                          ],
                          onChanged: (selectedValue) {
                            final items = [
                              'Pending',
                              'In Progress',
                              'Not Approval',
                              'Rejected',
                              'Completed',
                              'Not Resolved',
                              'Overdue',
                            ];
                            final selectedIndex = items.indexOf(selectedValue!);
                            cubit.taskStatusIdController.text =
                                selectedIndex.toString();

                            cubit.taskStatusController.text = selectedValue;
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                        Text(
                          "Priority",
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: 'priority',
                          controller: cubit.priorityController,
                          items: [
                            "Low",
                            "Medium",
                            "High",
                          ],
                          onChanged: (selectedValue) {
                            final items = [
                              "Low",
                              "Medium",
                              "High",
                            ];
                            final selectedIndex = items.indexOf(selectedValue!);
                            cubit.priorityIdController.text =
                                selectedIndex.toString();

                            cubit.priorityController.text = selectedValue;
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                      ],
                      if ((index == 'U' ||
                              index == 'A-h' ||
                              index == 'A-l' ||
                              index == 'A') &&
                          role != 'Supervisor') ...[
                        Text(
                          S.of(context).addUserText13,
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: 'Select Role',
                          controller: cubit.roleController,
                          items: cubit.roleDataItem
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          onChanged: (selectedValue) {
                            final selectedId = cubit.roleModel?.data
                                ?.firstWhere(
                                  (role) => role.name == selectedValue,
                                )
                                .id
                                ?.toString();
                            if (selectedId != null) {
                              cubit.roleIdController.text = selectedId;
                            }
                          },
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                        verticalSpace(10),
                      ],
                      if (index == 'A-h') ...[
                        Text(
                          'Shift',
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: 'Select shift',
                          controller: cubit.shiftController,
                          items: cubit.shiftData
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          onChanged: (selectedValue) {
                            final selectedId = cubit.shiftsModel?.data?.shifts!
                                .firstWhere(
                                    (shift) => shift.name == selectedValue)
                                .id
                                ?.toString();

                            if (selectedId != null) {
                              cubit.shiftIdController.text = selectedId;
                            }
                          },
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                        verticalSpace(10),
                      ],
                      if (index == 'A-l') ...[
                        Text(
                          'Type',
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          onPressed: (selectedValue) {
                            final items = ['Sick', 'Annual', 'Ordinary'];
                            final selectedIndex = items.indexOf(selectedValue);
                            if (selectedIndex != -1) {
                              cubit.typeIdController.text =
                                  selectedIndex.toString();
                            }
                          },
                          hint: 'Select type',
                          items: ['Sick', 'Annual', 'Ordinary'],
                          controller: cubit.typeController,
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                        verticalSpace(10),
                      ],
                      if (index == 'A-h' ||
                          index == 'A-l' ||
                          index == 'A' ||
                          index == 'S-t') ...[
                        Text(
                          'User',
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: 'Select Users',
                          controller: cubit.userController,
                          items: cubit.userItem
                              .map((e) => e.userName ?? 'Unknown')
                              .toList(),
                          onChanged: (selectedValue) {
                            final selectedUser = cubit.usersModel?.data?.users
                                ?.firstWhere(
                                    (user) => user.userName == selectedValue)
                                .id
                                ?.toString();

                            if (selectedUser != null) {
                              cubit.userIdController.text = selectedUser;
                            }
                          },
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                        verticalSpace(10),
                      ],
                      if (index == 'A') ...[
                        Text(
                          "Module",
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: 'Select module',
                          controller: cubit.moduleController,
                          items: allModules,
                          onChanged: (selectedValue) {
                            final selectedIndex =
                                allModules.indexOf(selectedValue!);
                            if (selectedIndex != -1) {
                              cubit
                                ..moduleIdController.text =
                                    selectedIndex.toString()
                                ..moduleController.text = selectedValue
                                ..actionController.text = ''
                                ..actionIdController.text = '';
                            }
                          },
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                        verticalSpace(10),
                        Text(
                          "Action",
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: 'Select action',
                          controller: cubit.actionController,
                          items:
                              moduleActions[cubit.moduleController.text] ?? [],
                          onChanged: (selectedValue) {
                            final selectedIndex =
                                allActions.indexOf(selectedValue!);
                            if (selectedIndex != -1) {
                              cubit.actionIdController.text =
                                  selectedIndex.toString();
                            }
                          },
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                        verticalSpace(10),
                        Text(
                          "Date",
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomTextFormField(
                          hint: "--/--/---",
                          controller: cubit.dateController,
                          suffixPressed: () async {
                            final selectedDate =
                                await CustomDatePicker.show(context: context);

                            if (selectedDate != null && context.mounted) {
                              cubit.dateController.text = selectedDate;
                            }
                          },
                          keyboardType: TextInputType.none,
                          suffixIcon: Icons.calendar_today,
                          onlyRead: true,
                        ),
                        verticalSpace(10),
                      ],
                      if (index == 'A-h') ...[
                        Text(
                          'Status',
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          onPressed: (selectedValue) {
                            final items = [
                              'Late',
                              'Present',
                              'Completed',
                              'Absent'
                            ];
                            final selectedIndex = items.indexOf(selectedValue);
                            if (selectedIndex != -1) {
                              cubit.statusIdController.text =
                                  selectedIndex.toString();
                            }
                          },
                          hint: 'Select status',
                          items: ['Late', 'Present', 'Completed', 'Absent'],
                          controller: cubit.statusController,
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                        verticalSpace(10),
                      ],
                      if ((index == 'U' ||
                              index == 'A-h' ||
                              index == 'A-l' ||
                              index == 'T' ||
                              index == 'S-t') &&
                          role == 'Admin') ...[
                        Text(
                          'Provider',
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: 'Select Provider',
                          controller: cubit.providerController,
                          items: cubit.providerItem
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          onChanged: (selectedValue) {
                            final selectedId = cubit.providersModel?.data?.data
                                ?.firstWhere(
                                  (provider) => provider.name == selectedValue,
                                )
                                .id
                                ?.toString();

                            if (selectedId != null) {
                              cubit.providerIdController.text = selectedId;
                            }
                          },
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                        verticalSpace(10),
                      ],
                      if (index == 'S' ||
                          index == 'A-h' ||
                          index == 'A-l' ||
                          index == 'T' ||
                          index == 'S-t') ...[
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
                                      context
                                          .read<FilterDialogCubit>()
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
                                      context
                                          .read<FilterDialogCubit>()
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
                      ],
                      if (index == 'T') ...[
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
                                      context
                                          .read<FilterDialogCubit>()
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
                                      context
                                          .read<FilterDialogCubit>()
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
                      ],
                      if (index == 'S') ...[
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
                                      context
                                          .read<FilterDialogCubit>()
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
                                  controller: cubit.endTimeController,
                                  suffixIcon: Icons.timer_sharp,
                                  suffixPressed: () async {
                                    final selectedTime =
                                        await CustomTimePicker.show(
                                            context: context);

                                    if (selectedTime != null &&
                                        context.mounted) {
                                      context
                                          .read<FilterDialogCubit>()
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
                      ],
                      if (index == 'U') ...[
                        Text(
                          S.of(context).addUserText9,
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          onPressed: (selectedValue) {
                            final items = ['Male', 'Female'];
                            final selectedIndex = items.indexOf(selectedValue);
                            if (selectedIndex != -1) {
                              cubit.genderIdController.text =
                                  selectedIndex.toString();
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).validationGender;
                            }
                            return null;
                          },
                          hint: 'Gender',
                          items: ['Male', 'Female'],
                          controller: cubit.genderController,
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                        verticalSpace(10),
                      ],
                      if (index == 'U') ...[
                        Text(
                          S.of(context).addUserText8,
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: 'Select Nationality',
                          controller: cubit.nationalityController,
                          items: cubit.nationalityData
                              .map((e) => e.name ?? 'un known')
                              .toList(),
                          suffixIcon: IconBroken.arrowDown2,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                      ],
                      if (!(index == 'W-a' ||
                          index == 'W-c' ||
                          index == 'W-o' ||
                          index == 'W-b' ||
                          index == 'W-f' ||
                          index == 'W-s' ||
                          index == 'W-p' ||
                          index == 'A' ||
                          index == 'S-c' ||
                          index == 'S-m' ||
                          index == 'S-t')) ...[
                        Text('Work location',
                            style: TextStyles.font16BlackRegular),
                        CustomDropDownList(
                          hint: 'Select Work location',
                          controller: cubit.levelController,
                          color: AppColor.primaryColor,
                          items: filteredLevelOrder,
                          onChanged: (value) {
                            cubit.setSelectedLevel(value!);
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                      ],
                      if ((index == 'U' && cubit.shouldShow('Country') ||
                              index == 'W-a') ||
                          (index == 'W-c')) ...[
                        Text('Country', style: TextStyles.font16BlackRegular),
                        CustomDropDownList(
                          hint: 'Select Country',
                          controller: cubit.countryController,
                          items: cubit.countryData.map((e) => e.name).toList(),
                          onChanged: (value) {
                            cubit.getArea();
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                      ],
                      if ((index == 'U' && cubit.shouldShow('Area')) ||
                          (index == 'W-c')) ...[
                        Text('Area', style: TextStyles.font16BlackRegular),
                        CustomDropDownList(
                          hint: 'Select area',
                          controller: cubit.areaController,
                          items: cubit.areaItem
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          onChanged: (value) {
                            final selectedArea = cubit.areaListModel?.data?.data
                                ?.firstWhere((area) =>
                                    area.name == cubit.areaController.text)
                                .id
                                ?.toString();

                            if (selectedArea != null) {
                              cubit.areaIdController.text = selectedArea;
                            }
                            cubit.getCity();
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                      ],
                      if (((index == 'S' ||
                                  index == 'A-h' ||
                                  index == 'A-l' ||
                                  index == 'T') &&
                              cubit.shouldShow('Area')) ||
                          (index == 'W-o')) ...[
                        Text('Area', style: TextStyles.font16BlackRegular),
                        CustomDropDownList(
                          hint: 'Select area',
                          controller: cubit.areaController,
                          items: cubit.areaItem
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          onChanged: (value) {
                            final selectedArea = cubit.areaListModel?.data?.data
                                ?.firstWhere((area) =>
                                    area.name == cubit.areaController.text)
                                .id
                                ?.toString();

                            if (selectedArea != null) {
                              cubit.areaIdController.text = selectedArea;
                            }
                            cubit.getCity();
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                      ],
                      if (cubit.shouldShow('City') ||
                          (index == 'W-o') ||
                          (index == 'W-b')) ...[
                        Text('City', style: TextStyles.font16BlackRegular),
                        CustomDropDownList(
                          hint: 'Select cities',
                          controller: cubit.cityController,
                          items: cubit.cityItem
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          onChanged: (value) {
                            final selectedCity = cubit.cityModel?.data?.data
                                ?.firstWhere((city) =>
                                    city.name == cubit.cityController.text)
                                .id
                                ?.toString();

                            if (selectedCity != null) {
                              cubit.cityIdController.text = selectedCity;
                            }
                            cubit.getOrganization();
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                      ],
                      if (cubit.shouldShow('Organization') ||
                          (index == 'W-b') ||
                          (index == 'W-f')) ...[
                        Text('Organization',
                            style: TextStyles.font16BlackRegular),
                        CustomDropDownList(
                          hint: 'Select organizations',
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
                      ],
                      if (cubit.shouldShow('Building') ||
                          (index == 'W-f') ||
                          (index == 'W-s')) ...[
                        Text('Building', style: TextStyles.font16BlackRegular),
                        CustomDropDownList(
                          hint: 'Select building',
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
                      ],
                      if (cubit.shouldShow('Floor') ||
                          (index == 'W-s') ||
                          (index == 'W-p')) ...[
                        Text('Floor', style: TextStyles.font16BlackRegular),
                        CustomDropDownList(
                          hint: 'Select floor',
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
                      ],
                      if (cubit.shouldShow('Section') || (index == 'W-p')) ...[
                        Text('Section', style: TextStyles.font16BlackRegular),
                        CustomDropDownList(
                          hint: 'Select section',
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
                            cubit.getPoint();
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                      ],
                      if (cubit.shouldShow('Point')) ...[
                        Text('Point', style: TextStyles.font16BlackRegular),
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
                        verticalSpace(10),
                      ],
                      verticalSpace(10),
                      Center(
                        child: DefaultElevatedButton(
                          name: 'Done',
                          onPressed: () {
                            final date =
                                DateTime.tryParse(cubit.dateController.text);
                            final startDate = DateTime.tryParse(
                                cubit.startDateController.text);
                            final endDate =
                                DateTime.tryParse(cubit.endDateController.text);
                            onPressed(FilterDialogDataModel(
                                country: cubit.countryController.text.isNotEmpty
                                    ? cubit.countryController.text
                                    : null,
                                areaId: cubit.areaIdController.text.isNotEmpty
                                    ? _tryParseInt(cubit.areaIdController.text)
                                    : null,
                                cityId: cubit.cityIdController.text.isNotEmpty
                                    ? _tryParseInt(cubit.cityIdController.text)
                                    : null,
                                organizationId: cubit.organizationIdController.text.isNotEmpty
                                    ? _tryParseInt(
                                        cubit.organizationIdController.text)
                                    : null,
                                buildingId: cubit.buildingIdController.text.isNotEmpty
                                    ? _tryParseInt(
                                        cubit.buildingIdController.text)
                                    : null,
                                floorId: cubit.floorIdController.text.isNotEmpty
                                    ? _tryParseInt(cubit.floorIdController.text)
                                    : null,
                                sectionId: cubit.sectionIdController.text.isNotEmpty
                                    ? _tryParseInt(
                                        cubit.sectionIdController.text)
                                    : null,
                                pointId: cubit.pointIdController.text.isNotEmpty
                                    ? _tryParseInt(cubit.pointIdController.text)
                                    : null,
                                roleId: cubit.roleIdController.text.isNotEmpty
                                    ? _tryParseInt(cubit.roleIdController.text)
                                    : null,
                                providerId: cubit.providerIdController.text.isNotEmpty ? _tryParseInt(cubit.providerIdController.text) : null,
                                nationality: cubit.nationalityController.text.isNotEmpty ? cubit.nationalityController.text : null,
                                genderId: cubit.genderIdController.text.isNotEmpty ? _tryParseInt(cubit.genderIdController.text) : null,
                                createdBy: cubit.createdByIdController.text.isNotEmpty ? _tryParseInt(cubit.createdByIdController.text) : null,
                                assignTo: cubit.assignToIdController.text.isNotEmpty ? _tryParseInt(cubit.assignToIdController.text) : null,
                                taskStatusId: cubit.taskStatusIdController.text.isNotEmpty ? _tryParseInt(cubit.taskStatusIdController.text) : null,
                                priorityId: cubit.priorityIdController.text.isNotEmpty ? _tryParseInt(cubit.priorityIdController.text) : null,
                                moduleId: cubit.moduleIdController.text.isNotEmpty ? _tryParseInt(cubit.moduleIdController.text) : null,
                                actionId: cubit.actionIdController.text.isNotEmpty ? _tryParseInt(cubit.actionIdController.text) : null,
                                categoryId: cubit.parentCategoryIdController.text.isNotEmpty ? _tryParseInt(cubit.parentCategoryIdController.text) : null,
                                unitId: cubit.unitIdController.text.isNotEmpty ? _tryParseInt(cubit.unitIdController.text) : null,
                                transactionTypeId: cubit.transactionIdController.text.isNotEmpty ? _tryParseInt(cubit.transactionIdController.text) : null,
                                startDate: startDate,
                                endDate: endDate,
                                date: date,
                                startTime: cubit.startTimeController.text,
                                endTime: cubit.endTimeController.text));
                            context.pop();
                          },
                          color: AppColor.primaryColor,
                          height: 47,
                          width: double.infinity,
                          textStyles: TextStyles.font20Whitesemimedium,
                        ),
                      ),
                      verticalSpace(5),
                    ],
                  );
                },
              ),
            ),
          ),
        ));
  }
}

int? _tryParseInt(String value) {
  if (value.isEmpty) return null;
  return int.tryParse(value);
}
