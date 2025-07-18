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
import 'package:smart_cleaning_application/core/widgets/filter/ui/widget/battery_indicator.dart';
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

    final List<String> filteredLevelOrder = cubit.levelOrder.where((level) {
      if (index == 'Se') return level == 'Point';
      return !((index == 'A-h' ||
                  index == 'A-hU' ||
                  index == 'A-l' ||
                  index == 'A-lU' ||
                  index == 'T' ||
                  index == 'TU') &&
              level == 'Country') &&
          !(index == 'S' && (level == 'Country' || level == 'Point'));
    }).toList();
    return Dialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        insetPadding: EdgeInsets.all(20),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: BlocBuilder<FilterDialogCubit, FilterDialogState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(),
                    if (index == 'S-c' || index == 'S-m' || index == 'S-t') ...[
                      Text(
                        (index == 'S-c')
                            ? S.of(context).parentCategory
                            : S.of(context).category,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: S.of(context).select_parent_category,
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
                            cubit.parentCategoryIdController.text = selectedId;
                          }
                        },
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(10),
                    ],
                    if (index == 'S-c') ...[
                      Text(
                        S.of(context).unitTitle,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: S.of(context).selectUnit,
                        controller: cubit.unitController,
                        items: [
                          S.of(context).ml,
                          S.of(context).l,
                          S.of(context).kg,
                          S.of(context).g,
                          S.of(context).m,
                          S.of(context).cm,
                          S.of(context).pieces
                        ],
                        onChanged: (selectedValue) {
                          final items = [
                            S.of(context).ml,
                            S.of(context).l,
                            S.of(context).kg,
                            S.of(context).g,
                            S.of(context).m,
                            S.of(context).cm,
                            S.of(context).pieces
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
                        S.of(context).transaction_type,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: S.of(context).selectType,
                        controller: cubit.transactionController,
                        items: [
                          S.of(context).inSelect,
                          S.of(context).outSelect
                        ],
                        onChanged: (selectedValue) {
                          final items = [
                            S.of(context).inSelect,
                            S.of(context).outSelect,
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
                    if (index == 'Se') ...[
                      Text(
                        S.of(context).activity_status,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: S.of(context).select_status,
                        controller: cubit.activityStatusController,
                        items: [S.of(context).active, S.of(context).inactive],
                        onChanged: (selectedValue) {
                          if (selectedValue == S.of(context).active) {
                            cubit.activityStatusIdController.text = 'true';
                          } else if (selectedValue == S.of(context).inactive) {
                            cubit.activityStatusIdController.text = 'false';
                          }
                        },
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(10),
                    ],
                    if (index == 'Se') ...[
                      Text(
                        S.of(context).type,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: S.of(context).selectType,
                        controller: cubit.activityTypeController,
                        items: cubit.activityTypeDataItem
                            .map((e) => e.name ?? 'Unknown')
                            .toList(),
                        onChanged: (selectedValue) {
                          final selectedId = cubit.activityTypeModel?.data
                              ?.firstWhere(
                                (type) => type.name == selectedValue,
                              )
                              .id
                              ?.toString();
                          if (selectedId != null) {
                            cubit.activityTypeIdController.text = selectedId;
                          }
                        },
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(10),
                    ],
                    if (index == 'W-p' || index == 'Se') ...[
                      Text(
                        S.of(context).is_assign,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: S.of(context).select,
                        controller: cubit.isAsignController,
                        items: [
                          S.of(context).trueSelect,
                          S.of(context).falseSelect
                        ],
                        onChanged: (selectedValue) {
                          if (selectedValue == S.of(context).trueSelect) {
                            cubit.isAsignController.text = 'true';
                          } else if (selectedValue ==
                              S.of(context).falseSelect) {
                            cubit.isAsignController.text = 'false';
                          }
                        },
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(10),
                    ],
                    if (index == 'Se') ...[
                      Text(
                        S.of(context).battery,
                        style: TextStyles.font16BlackRegular,
                      ),
                      BatterySlider(),
                      verticalSpace(10),
                    ],
                    if (index == 'T' || index == 'TU') ...[
                      if (role == 'Admin' || role == 'Manager') ...[
                        Text(
                          S.of(context).created_by,
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: S.of(context).select_user,
                          controller: cubit.createdByController,
                          items: role == 'Admin'
                              ? cubit.usersModel?.data?.users?.isEmpty ?? true
                                  ? [S.of(context).no_user]
                                  : cubit.usersModel?.data?.users
                                          ?.where((e) => e.roleId != 4)
                                          .map((e) => e.userName ?? 'Unknown')
                                          .toList() ??
                                      []
                              : cubit.usersModel?.data?.users?.isEmpty ?? true
                                  ? [S.of(context).no_user]
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
                      if (role != 'Cleaner' && !(index == 'TU')) ...[
                        Text(
                          S.of(context).assign_to,
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: S.of(context).select_user,
                          controller: cubit.assignToController,
                          items: cubit.usersModel?.data?.users?.isEmpty ?? true
                              ? [S.of(context).no_user]
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
                        S.of(context).status,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: S.of(context).select_status,
                        controller: cubit.taskStatusController,
                        items: [
                          S.of(context).pending,
                          S.of(context).inProgress,
                          S.of(context).notApproval,
                          S.of(context).rejected,
                          S.of(context).completed,
                          S.of(context).notResolved,
                          S.of(context).overdue,
                        ],
                        onChanged: (selectedValue) {
                          final items = [
                            S.of(context).pending,
                            S.of(context).inProgress,
                            S.of(context).notApproval,
                            S.of(context).rejected,
                            S.of(context).completed,
                            S.of(context).notResolved,
                            S.of(context).overdue,
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
                        S.of(context).priority,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: S.of(context).select_priority,
                        controller: cubit.priorityController,
                        items: [
                          S.of(context).low,
                          S.of(context).medium,
                          S.of(context).high,
                        ],
                        onChanged: (selectedValue) {
                          final items = [
                            S.of(context).low,
                            S.of(context).medium,
                            S.of(context).high,
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
                        hint: S.of(context).select_role,
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
                    if (index == 'A-h' || index == 'A-hU') ...[
                      Text(
                        S.of(context).shiftBody,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: S.of(context).selectShift,
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
                    if (index == 'A-l' || index == 'A-lU') ...[
                      Text(
                        S.of(context).type,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        onPressed: (selectedValue) {
                          final items = [
                            S.of(context).sick,
                            S.of(context).annual,
                            S.of(context).ordinary
                          ];
                          final selectedIndex = items.indexOf(selectedValue);
                          if (selectedIndex != -1) {
                            cubit.typeIdController.text =
                                selectedIndex.toString();
                          }
                        },
                        hint: S.of(context).selectType,
                        items: [
                          S.of(context).sick,
                          S.of(context).annual,
                          S.of(context).ordinary
                        ],
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
                        S.of(context).user,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: S.of(context).select_user,
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
                        S.of(context).module,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: S.of(context).select_module,
                        controller: cubit.moduleController,
                        items: cubit.allModules,
                        onChanged: (selectedValue) {
                          final selectedIndex =
                              cubit.allModules.indexOf(selectedValue!);
                          if (selectedIndex != -1) {
                            cubit
                              ..moduleIdController.text =
                                  selectedIndex.toString()
                              ..moduleController.text = selectedValue
                              ..actionController.text = ''
                              ..actionIdController.text = ''
                              ..updateActionsForModule(selectedValue);
                          }
                        },
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(10),
                      Text(
                        S.of(context).action,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: S.of(context).select_action,
                        controller: cubit.actionController,
                        items: cubit.currentActions,
                        onChanged: (selectedValue) {
                          final selectedIndex =
                              cubit.allActions.indexOf(selectedValue!);
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
                        S.of(context).date,
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
                    if (index == 'A-h' || index == 'A-hU') ...[
                      Text(
                        S.of(context).status,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        onPressed: (selectedValue) {
                          final items = [
                            S.of(context).present,
                            S.of(context).absent,
                            S.of(context).complete
                          ];
                          final selectedIndex = items.indexOf(selectedValue);
                          if (selectedIndex != -1) {
                            cubit.statusIdController.text =
                                selectedIndex.toString();
                          }
                        },
                        hint: S.of(context).select_status,
                        items: [
                          S.of(context).present,
                          S.of(context).absent,
                          S.of(context).complete
                        ],
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
                        S.of(context).provider,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: S.of(context).select_provider,
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
                    if ((index == 'T' || index == 'TU') && role == 'Admin') ...[
                      Text(
                        S.of(context).sensor,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: S.of(context).selectSensor,
                        controller: cubit.deviceController,
                        items: cubit.sensorItem
                            .map((e) => e.name ?? 'Unknown')
                            .toList(),
                        onChanged: (selectedValue) {
                          final selectedId = cubit.sensorsModel?.data?.data
                              ?.firstWhere(
                                (sensor) => sensor.name == selectedValue,
                              )
                              .id
                              ?.toString();

                          if (selectedId != null) {
                            cubit.deviceIdController.text = selectedId;
                          }
                        },
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(10),
                    ],
                    if (index == 'S' ||
                        index == 'A-h' ||
                        index == 'A-hU' ||
                        index == 'A-l' ||
                        index == 'A-lU' ||
                        index == 'T' ||
                        index == 'S-t' ||
                        index == 'TU') ...[
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

                                  if (selectedDate != null && context.mounted) {
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

                                  if (selectedDate != null && context.mounted) {
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
                    if (index == 'T' || index == 'TU') ...[
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

                                  if (selectedTime != null && context.mounted) {
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

                                  if (selectedTime != null && context.mounted) {
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
                      Text(
                        S.of(context).is_active,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: S.of(context).select,
                        controller: cubit.isActiveController,
                        items: [
                          S.of(context).trueSelect,
                          S.of(context).falseSelect
                        ],
                        onChanged: (selectedValue) {
                          if (selectedValue == S.of(context).trueSelect) {
                            cubit.isActiveController.text = 'true';
                          } else if (selectedValue ==
                              S.of(context).falseSelect) {
                            cubit.isActiveController.text = 'false';
                          }
                        },
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
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

                                  if (selectedTime != null && context.mounted) {
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

                                  if (selectedTime != null && context.mounted) {
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
                    if (index == 'U') ...[
                      Text(
                        S.of(context).addUserText9,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        onPressed: (selectedValue) {
                          final items = [
                            S.of(context).genderMale,
                            S.of(context).genderFemale
                          ];
                          final selectedIndex = items.indexOf(selectedValue);
                          if (selectedIndex != -1) {
                            cubit.genderIdController.text =
                                selectedIndex.toString();
                          }
                        },
                        hint: S.of(context).gender,
                        items: [
                          S.of(context).genderMale,
                          S.of(context).genderFemale
                        ],
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
                        hint: S.of(context).select_nationality,
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
                            index == 'S-t') ||
                        index == 'Se') ...[
                      Text(S.of(context).workLocation,
                          style: TextStyles.font16BlackRegular),
                      CustomDropDownList(
                        hint: S.of(context).select_work_location,
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
                      Text(S.of(context).country,
                          style: TextStyles.font16BlackRegular),
                      CustomDropDownList(
                        hint: S.of(context).selectCountry,
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
                      Text(S.of(context).Area,
                          style: TextStyles.font16BlackRegular),
                      CustomDropDownList(
                        hint: S.of(context).selectArea,
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
                                index == 'A-hU' ||
                                index == 'A-l' ||
                                index == 'A-lU' ||
                                index == 'T' ||
                                index == 'TU') &&
                            cubit.shouldShow('Area')) ||
                        (index == 'W-o')) ...[
                      Text(S.of(context).Area,
                          style: TextStyles.font16BlackRegular),
                      CustomDropDownList(
                        hint: S.of(context).selectArea,
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
                      Text(S.of(context).City,
                          style: TextStyles.font16BlackRegular),
                      CustomDropDownList(
                        hint: S.of(context).selectCity,
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
                      Text(S.of(context).Organization,
                          style: TextStyles.font16BlackRegular),
                      CustomDropDownList(
                        hint: S.of(context).selectOrganizations,
                        controller: cubit.organizationController,
                        items: cubit.organizationItem
                            .map((e) => e.name ?? 'Unknown')
                            .toList(),
                        onChanged: (value) {
                          final selectedOrganization = cubit
                              .organizationModel?.data?.data
                              ?.firstWhere((org) =>
                                  org.name == cubit.organizationController.text)
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
                      Text(S.of(context).Building,
                          style: TextStyles.font16BlackRegular),
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
                            cubit.buildingIdController.text = selectedBuilding;
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
                      Text(S.of(context).Floor,
                          style: TextStyles.font16BlackRegular),
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
                    ],
                    if (cubit.shouldShow('Section') || (index == 'W-p')) ...[
                      Text(S.of(context).Section,
                          style: TextStyles.font16BlackRegular),
                      CustomDropDownList(
                        hint: S.of(context).selectSection,
                        controller: cubit.sectionController,
                        items: cubit.sectionItem
                            .map((e) => e.name ?? 'Unknown')
                            .toList(),
                        onChanged: (value) {
                          final selectedSection = cubit.sectionModel?.data?.data
                              ?.firstWhere((section) =>
                                  section.name == cubit.sectionController.text)
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
                      Text(S.of(context).Point,
                          style: TextStyles.font16BlackRegular),
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
                      verticalSpace(10),
                    ],
                    verticalSpace(10),
                    Center(
                      child: DefaultElevatedButton(
                        name: S.of(context).doneButton2,
                        onPressed: () {
                          final date =
                              DateTime.tryParse(cubit.dateController.text);
                          final startDate =
                              DateTime.tryParse(cubit.startDateController.text);
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
                                  ? _tryParseInt(cubit.sectionIdController.text)
                                  : null,
                              pointId: cubit.pointIdController.text.isNotEmpty
                                  ? _tryParseInt(cubit.pointIdController.text)
                                  : null,
                              roleId: cubit.roleIdController.text.isNotEmpty
                                  ? _tryParseInt(cubit.roleIdController.text)
                                  : null,
                              providerId: cubit.providerIdController.text.isNotEmpty
                                  ? _tryParseInt(
                                      cubit.providerIdController.text)
                                  : null,
                              nationality: cubit.nationalityController.text.isNotEmpty
                                  ? cubit.nationalityController.text
                                  : null,
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
                              applicationId: cubit.activityTypeIdController.text.isNotEmpty ? _tryParseInt(cubit.activityTypeIdController.text) : null,
                              activityStatus: cubit.activityStatusIdController.text,
                              statusId: _tryParseInt(cubit.statusIdController.text),
                              minBattery: cubit.currentRange.start.round(),
                              maxBattery: cubit.currentRange.end.round(),
                              isAsign: cubit.isAsignController.text,
                              isActive: cubit.isActiveController.text,
                              typeId: cubit.typeIdController.text.isNotEmpty ? _tryParseInt(cubit.typeIdController.text) : null,
                              deviceId: cubit.deviceIdController.text.isNotEmpty ? _tryParseInt(cubit.deviceIdController.text) : null,
                              startDate: startDate,
                              endDate: endDate,
                              date: date,
                              startTime: cubit.startTimeController.text,
                              endTime: cubit.endTimeController.text));
                          context.pop();
                        },
                        color: AppColor.primaryColor,
                      
                        textStyles: TextStyles.font20Whitesemimedium,
                      ),
                    ),
                    verticalSpace(5),
                  ],
                );
              },
            ),
          ),
        ));
  }
}

int? _tryParseInt(String value) {
  if (value.isEmpty) return null;
  return int.tryParse(value);
}
