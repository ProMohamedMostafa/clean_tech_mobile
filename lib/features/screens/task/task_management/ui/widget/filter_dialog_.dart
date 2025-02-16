import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_date_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_time_picker.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/logic/task_management_cubit.dart';

class CustomFilterTaskDialog {
  static Future<String?> show({
    required BuildContext context,
  }) async {
    return await showDialog(
      context: context,
      builder: (dialogContext) {
        int? areaId;
        int? cityId;
        int? organizationId;
        int? buildingId;
        int? floorId;
        int? pointId;
        int? statusId;
        int? priorityId;
        int? createdId;
        int? assignToId;
         int? providerId;
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Created By',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: "Select user",
                        items: context
                                    .read<TaskManagementCubit>()
                                    .usersModel
                                    ?.data
                                    ?.users
                                    ?.isEmpty ??
                                true
                            ? ['No user']
                            : context
                                    .read<TaskManagementCubit>()
                                    .usersModel
                                    ?.data
                                    ?.users
                                    ?.where((e) => e.role != "Cleaner")
                                    .map((e) => e.userName ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedUser = context
                              .read<TaskManagementCubit>()
                              .usersModel
                              ?.data
                              ?.users
                              ?.firstWhere((user) =>
                                  user.userName ==
                                  context
                                      .read<TaskManagementCubit>()
                                      .createdByController
                                      .text);

                          createdId = selectedUser!.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<TaskManagementCubit>()
                            .createdByController,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        'Assgin to',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: "Select user",
                        items: context
                                    .read<TaskManagementCubit>()
                                    .usersModel
                                    ?.data
                                    ?.users
                                    ?.isEmpty ??
                                true
                            ? ['No user']
                            : context
                                    .read<TaskManagementCubit>()
                                    .usersModel
                                    ?.data
                                    ?.users
                                    ?.where((e) => e.role != "Admin")
                                    .map((e) => e.userName ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedUser = context
                              .read<TaskManagementCubit>()
                              .usersModel
                              ?.data
                              ?.users
                              ?.firstWhere((user) =>
                                  user.userName ==
                                  context
                                      .read<TaskManagementCubit>()
                                      .assignToController
                                      .text);

                          assignToId = selectedUser!.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<TaskManagementCubit>()
                            .assignToController,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        "Status",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
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
                          statusId = selectedIndex;

                          context
                              .read<TaskManagementCubit>()
                              .statusController
                              .text = selectedValue;
                        },
                        hint: 'status',
                        items: [
                          'Pending',
                          'In Progress',
                          'Not Approval',
                          'Rejected',
                          'Completed',
                          'Not Resolved',
                          'Overdue',
                        ],
                        suffixIcon: IconBroken.arrowDown2,
                        keyboardType: TextInputType.text,
                        controller: context
                            .read<TaskManagementCubit>()
                            .statusController,
                      ),
                      verticalSpace(10),
                      Text(
                        "Priority",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        onChanged: (selectedValue) {
                          final items = [
                            "Low",
                            "Medium",
                            "High",
                          ];
                          final selectedIndex = items.indexOf(selectedValue!);
                          priorityId = selectedIndex;

                          context
                              .read<TaskManagementCubit>()
                              .priorityController
                              .text = selectedValue;
                        },
                        hint: 'priority',
                        items: [
                          "Low",
                          "Medium",
                          "High",
                        ],
                        suffixIcon: IconBroken.arrowDown2,
                        keyboardType: TextInputType.text,
                        controller: context
                            .read<TaskManagementCubit>()
                            .priorityController,
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
                                    .read<TaskManagementCubit>()
                                    .startDateController,
                                suffixIcon: Icons.calendar_today,
                                suffixPressed: () async {
                                  final selectedDate =
                                      await CustomDatePicker.show(
                                          context: context);

                                  if (selectedDate != null && context.mounted) {
                                    context
                                        .read<TaskManagementCubit>()
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
                                controller: context
                                    .read<TaskManagementCubit>()
                                    .endDateController,
                                suffixIcon: Icons.calendar_today,
                                suffixPressed: () async {
                                  final selectedDate =
                                      await CustomDatePicker.show(
                                          context: context);

                                  if (selectedDate != null && context.mounted) {
                                    context
                                        .read<TaskManagementCubit>()
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
                                    .read<TaskManagementCubit>()
                                    .startTimeController,
                                suffixIcon: Icons.timer_sharp,
                                suffixPressed: () async {
                                  final selectedTime =
                                      await CustomTimePicker.show(
                                          context: context);

                                  if (selectedTime != null && context.mounted) {
                                    context
                                        .read<TaskManagementCubit>()
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
                                controller: context
                                    .read<TaskManagementCubit>()
                                    .endTimeController,
                                suffixIcon: Icons.timer_sharp,
                                suffixPressed: () async {
                                  final selectedTime =
                                      await CustomTimePicker.show(
                                          context: context);

                                  if (selectedTime != null && context.mounted) {
                                    context
                                        .read<TaskManagementCubit>()
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
                        'Area',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: "Select area",
                        items: context
                                    .read<TaskManagementCubit>()
                                    .allAreaModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No organizations']
                            : context
                                    .read<TaskManagementCubit>()
                                    .allAreaModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedArea = context
                              .read<TaskManagementCubit>()
                              .allAreaModel
                              ?.data
                              ?.data
                              ?.firstWhere((area) =>
                                  area.name ==
                                  context
                                      .read<TaskManagementCubit>()
                                      .areaController
                                      .text);

                          context
                              .read<TaskManagementCubit>()
                              .getCity(selectedArea!.id!);
                          areaId = selectedArea.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<TaskManagementCubit>().areaController,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        "City",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: "Select city",
                        items: context
                                    .read<TaskManagementCubit>()
                                    .cityModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No cities']
                            : context
                                    .read<TaskManagementCubit>()
                                    .cityModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedCity = context
                              .read<TaskManagementCubit>()
                              .cityModel
                              ?.data
                              ?.firstWhere((city) =>
                                  city.name ==
                                  context
                                      .read<TaskManagementCubit>()
                                      .cityController
                                      .text);
                          context
                              .read<TaskManagementCubit>()
                              .getOrganization(selectedCity!.id!);
                          cityId = selectedCity.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<TaskManagementCubit>().cityController,
                        isRead: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        'Organization',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: "Select organizations",
                        items: context
                                    .read<TaskManagementCubit>()
                                    .organizationModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No organizations']
                            : context
                                    .read<TaskManagementCubit>()
                                    .organizationModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedOrganization = context
                              .read<TaskManagementCubit>()
                              .organizationModel
                              ?.data
                              ?.firstWhere((organization) =>
                                  organization.name ==
                                  context
                                      .read<TaskManagementCubit>()
                                      .organizationController
                                      .text);

                          context
                              .read<TaskManagementCubit>()
                              .getBuilding(selectedOrganization!.id!);
                          organizationId = selectedOrganization.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<TaskManagementCubit>()
                            .organizationController,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        'Building',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: "Select building",
                        items: context
                                    .read<TaskManagementCubit>()
                                    .buildingModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No building']
                            : context
                                    .read<TaskManagementCubit>()
                                    .buildingModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedBuilding = context
                              .read<TaskManagementCubit>()
                              .buildingModel
                              ?.data
                              ?.firstWhere((building) =>
                                  building.name ==
                                  context
                                      .read<TaskManagementCubit>()
                                      .buildingController
                                      .text);

                          context
                              .read<TaskManagementCubit>()
                              .getFloor(selectedBuilding!.id!);
                          buildingId = selectedBuilding.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<TaskManagementCubit>()
                            .buildingController,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        'Floor',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: "Select floor",
                        items: context
                                    .read<TaskManagementCubit>()
                                    .floorModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No floors']
                            : context
                                    .read<TaskManagementCubit>()
                                    .floorModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedFloor = context
                              .read<TaskManagementCubit>()
                              .floorModel
                              ?.data
                              ?.firstWhere((floor) =>
                                  floor.name ==
                                  context
                                      .read<TaskManagementCubit>()
                                      .floorController
                                      .text);

                          context
                              .read<TaskManagementCubit>()
                              .getPoints(selectedFloor!.id!);
                          floorId = selectedFloor.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<TaskManagementCubit>().floorController,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        'Points',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: "Select point",
                        items: context
                                    .read<TaskManagementCubit>()
                                    .pointsModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No point']
                            : context
                                    .read<TaskManagementCubit>()
                                    .pointsModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedPoint = context
                              .read<TaskManagementCubit>()
                              .pointsModel
                              ?.data
                              ?.firstWhere((point) =>
                                  point.name ==
                                  context
                                      .read<TaskManagementCubit>()
                                      .pointController
                                      .text);

                          context
                              .read<TaskManagementCubit>()
                              .getPoints(selectedPoint!.id!);
                          pointId = selectedPoint.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<TaskManagementCubit>().pointController,
                        keyboardType: TextInputType.text,
                      ),
                    
                          verticalSpace(10),
                      Text(
                        'Provider',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: 'Select Provider',
                        items: context
                                    .read<TaskManagementCubit>()
                                    .providersModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No providers available']
                            : context
                                    .read<TaskManagementCubit>()
                                    .providersModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedProvider = context
                              .read<TaskManagementCubit>()
                              .providersModel
                              ?.data
                              ?.data
                              ?.firstWhere((provider) =>
                                  provider.name ==
                                  context
                                      .read<TaskManagementCubit>()
                                      .providerController
                                      .text);

                          providerId = selectedProvider!.id;
                        },
                        controller: context
                            .read<TaskManagementCubit>()
                            .providerController,
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      
                      verticalSpace(20),
                      Center(
                        child: DefaultElevatedButton(
                            name: 'Done',
                            onPressed: () {
                              final String startDateText = context
                                  .read<TaskManagementCubit>()
                                  .startDateController
                                  .text;
                              final DateTime startDate =
                                  startDateText.isNotEmpty
                                      ? DateTime.parse(startDateText)
                                      : DateTime.now();
                              context.read<TaskManagementCubit>().getAllTasks(
                                    startDate: startDate,
                                    assignTo: assignToId,
                                    createdBy: createdId,
                                    priority: priorityId,
                                    status: statusId,
                                    areaId: areaId,
                                    cityId: cityId,
                                    organizationId: organizationId,
                                    buildingId: buildingId,
                                    floorId: floorId,
                                    pointId: pointId,
                                        providerId: providerId,
                                  );
                              context.pop();
                            },
                            color: AppColor.primaryColor,
                            height: 47,
                            width: double.infinity,
                            textStyles: TextStyles.font20Whitesemimedium),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
