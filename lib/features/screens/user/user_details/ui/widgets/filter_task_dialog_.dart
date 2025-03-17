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
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_date_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_time_picker.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_cubit.dart';

class CustomFilterTaskDialog {
  static Future<String?> show({required BuildContext context, id}) async {
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
                                    .read<UserManagementCubit>()
                                    .usersModel
                                    ?.data
                                    ?.users
                                    ?.isEmpty ??
                                true
                            ? ['No user']
                            : context
                                    .read<UserManagementCubit>()
                                    .usersModel
                                    ?.data
                                    ?.users
                                    ?.where((e) => e.role != "Cleaner")
                                    .map((e) => e.userName ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedUser = context
                              .read<UserManagementCubit>()
                              .usersModel
                              ?.data
                              ?.users
                              ?.firstWhere((user) =>
                                  user.userName ==
                                  context
                                      .read<UserManagementCubit>()
                                      .createdByController
                                      .text);

                          createdId = selectedUser!.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<UserManagementCubit>()
                            .createdByController,
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
                              .read<UserManagementCubit>()
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
                            .read<UserManagementCubit>()
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
                              .read<UserManagementCubit>()
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
                            .read<UserManagementCubit>()
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
                                    .read<UserManagementCubit>()
                                    .startDateController,
                                suffixIcon: Icons.calendar_today,
                                suffixPressed: () async {
                                  final selectedDate =
                                      await CustomDatePicker.show(
                                        
                                          context: context);

                                  if (selectedDate != null && context.mounted) {
                                    context
                                        .read<UserManagementCubit>()
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
                                    .read<UserManagementCubit>()
                                    .endDateController,
                                suffixIcon: Icons.calendar_today,
                                suffixPressed: () async {
                                  final selectedDate =
                                      await CustomDatePicker.show(
                                          context: context);

                                  if (selectedDate != null && context.mounted) {
                                    context
                                        .read<UserManagementCubit>()
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
                                    .read<UserManagementCubit>()
                                    .startTimeController,
                                suffixIcon: Icons.timer_sharp,
                                suffixPressed: () async {
                                  final selectedTime =
                                      await CustomTimePicker.show(
                                          context: context);

                                  if (selectedTime != null && context.mounted) {
                                    context
                                        .read<UserManagementCubit>()
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
                                    .read<UserManagementCubit>()
                                    .endTimeController,
                                suffixIcon: Icons.timer_sharp,
                                suffixPressed: () async {
                                  final selectedTime =
                                      await CustomTimePicker.show(
                                          context: context);

                                  if (selectedTime != null && context.mounted) {
                                    context
                                        .read<UserManagementCubit>()
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
                                    .read<UserManagementCubit>()
                                    .allAreaModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No organizations']
                            : context
                                    .read<UserManagementCubit>()
                                    .allAreaModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedArea = context
                              .read<UserManagementCubit>()
                              .allAreaModel
                              ?.data
                              ?.data
                              ?.firstWhere((area) =>
                                  area.name ==
                                  context
                                      .read<UserManagementCubit>()
                                      .areaController
                                      .text);

                          context
                              .read<UserManagementCubit>()
                              .getCity(selectedArea!.id!);
                          areaId = selectedArea.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<UserManagementCubit>().areaController,
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
                                    .read<UserManagementCubit>()
                                    .cityModel
                                   ?.data?.data
                                    ?.isEmpty ??
                                true
                            ? ['No cities']
                            : context
                                    .read<UserManagementCubit>()
                                    .cityModel
                                   ?.data?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedCity = context
                              .read<UserManagementCubit>()
                              .cityModel
                             ?.data?.data
                              ?.firstWhere((city) =>
                                  city.name ==
                                  context
                                      .read<UserManagementCubit>()
                                      .cityController
                                      .text);
                          context
                              .read<UserManagementCubit>()
                              .getOrganization(selectedCity!.id!);
                          cityId = selectedCity.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<UserManagementCubit>().cityController,
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
                                    .read<UserManagementCubit>()
                                    .organizationModel
                                   ?.data?.data
                                    ?.isEmpty ??
                                true
                            ? ['No organizations']
                            : context
                                    .read<UserManagementCubit>()
                                    .organizationModel
                                   ?.data?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedOrganization = context
                              .read<UserManagementCubit>()
                              .organizationModel
                             ?.data?.data
                              ?.firstWhere((organization) =>
                                  organization.name ==
                                  context
                                      .read<UserManagementCubit>()
                                      .organizationController
                                      .text);

                          context
                              .read<UserManagementCubit>()
                              .getBuilding(selectedOrganization!.id!);
                          organizationId = selectedOrganization.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<UserManagementCubit>()
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
                                    .read<UserManagementCubit>()
                                    .buildingModel
                                   ?.data?.data
                                    ?.isEmpty ??
                                true
                            ? ['No building']
                            : context
                                    .read<UserManagementCubit>()
                                    .buildingModel
                                   ?.data?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedBuilding = context
                              .read<UserManagementCubit>()
                              .buildingModel
                             ?.data?.data
                              ?.firstWhere((building) =>
                                  building.name ==
                                  context
                                      .read<UserManagementCubit>()
                                      .buildingController
                                      .text);

                          context
                              .read<UserManagementCubit>()
                              .getFloor(selectedBuilding!.id!);
                          buildingId = selectedBuilding.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<UserManagementCubit>()
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
                                    .read<UserManagementCubit>()
                                    .floorModel
                                   ?.data?.data
                                    ?.isEmpty ??
                                true
                            ? ['No floors']
                            : context
                                    .read<UserManagementCubit>()
                                    .floorModel
                                   ?.data?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedFloor = context
                              .read<UserManagementCubit>()
                              .floorModel
                             ?.data?.data
                              ?.firstWhere((floor) =>
                                  floor.name ==
                                  context
                                      .read<UserManagementCubit>()
                                      .floorController
                                      .text);

                          context
                              .read<UserManagementCubit>()
                              .getPoint(selectedFloor!.id!);
                          floorId = selectedFloor.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<UserManagementCubit>().floorController,
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
                                    .read<UserManagementCubit>()
                                    .pointModel
                                   ?.data?.data
                                    ?.isEmpty ??
                                true
                            ? ['No point']
                            : context
                                    .read<UserManagementCubit>()
                                    .pointModel
                                   ?.data?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedPoint = context
                              .read<UserManagementCubit>()
                              .pointModel
                             ?.data?.data
                              ?.firstWhere((point) =>
                                  point.name ==
                                  context
                                      .read<UserManagementCubit>()
                                      .pointController
                                      .text);

                          context
                              .read<UserManagementCubit>()
                              .getPoint(selectedPoint!.id!);
                          pointId = selectedPoint.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<UserManagementCubit>().pointController,
                        keyboardType: TextInputType.text,
                      ),
                      if (role == 'Admin') ...[
                        verticalSpace(10),
                        Text(
                          'Provider',
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: 'Select Provider',
                          items: context
                                      .read<UserManagementCubit>()
                                      .providersModel
                                      ?.data
                                      ?.data
                                      ?.isEmpty ??
                                  true
                              ? ['No providers available']
                              : context
                                      .read<UserManagementCubit>()
                                      .providersModel
                                      ?.data
                                      ?.data
                                      ?.map((e) => e.name ?? 'Unknown')
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedProvider = context
                                .read<UserManagementCubit>()
                                .pointModel
                                ?.data?.data
                                ?.firstWhere((provider) =>
                                    provider.name ==
                                    context
                                        .read<UserManagementCubit>()
                                        .providerController
                                        .text);

                            context
                                .read<UserManagementCubit>()
                                .getPoint(selectedProvider!.id!);
                            providerId = selectedProvider.id;
                          },
                          controller: context
                              .read<UserManagementCubit>()
                              .providerController,
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                      ],
                      verticalSpace(20),
                      Center(
                        child: DefaultElevatedButton(
                            name: 'Done',
                            onPressed: () {
                              context
                                  .read<UserManagementCubit>()
                                  .getUserTaskDetails(id,
                                      createdBy: createdId,
                                      priority: priorityId,
                                      status: statusId,
                                      areaId: areaId,
                                      cityId: cityId,
                                      organizationId: organizationId,
                                      buildingId: buildingId,
                                      floorId: floorId,
                                      pointId: pointId,
                                      providerId: providerId);
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
