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
import 'package:smart_cleaning_application/features/screens/profile/logic/profile_cubit.dart';

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
                      if (role == 'Admin' || role == 'Manager') ...[
                        Text(
                          'Created By',
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: "Select user",
                          items: context
                                      .read<ProfileCubit>()
                                      .usersModel
                                      ?.data
                                      ?.users
                                      ?.isEmpty ??
                                  true
                              ? ['No user']
                              : context
                                      .read<ProfileCubit>()
                                      .usersModel
                                      ?.data
                                      ?.users
                                      ?.where((e) => e.role != "Cleaner")
                                      .map((e) => e.userName ?? 'Unknown')
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedUser = context
                                .read<ProfileCubit>()
                                .usersModel
                                ?.data
                                ?.users
                                ?.firstWhere((user) =>
                                    user.userName ==
                                    context
                                        .read<ProfileCubit>()
                                        .createdByController
                                        .text);

                            createdId = selectedUser!.id!;
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller:
                              context.read<ProfileCubit>().createdByController,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                      ],
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

                          context.read<ProfileCubit>().statusController.text =
                              selectedValue;
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
                        controller:
                            context.read<ProfileCubit>().statusController,
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

                          context.read<ProfileCubit>().priorityController.text =
                              selectedValue;
                        },
                        hint: 'priority',
                        items: [
                          "Low",
                          "Medium",
                          "High",
                        ],
                        suffixIcon: IconBroken.arrowDown2,
                        keyboardType: TextInputType.text,
                        controller:
                            context.read<ProfileCubit>().priorityController,
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
                                    .read<ProfileCubit>()
                                    .startDateController,
                                suffixIcon: Icons.calendar_today,
                                suffixPressed: () async {
                                  final selectedDate =
                                      await CustomDatePicker.show(
                                          context: context);

                                  if (selectedDate != null && context.mounted) {
                                    context
                                        .read<ProfileCubit>()
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
                                    .read<ProfileCubit>()
                                    .endDateController,
                                suffixIcon: Icons.calendar_today,
                                suffixPressed: () async {
                                  final selectedDate =
                                      await CustomDatePicker.show(
                                          context: context);

                                  if (selectedDate != null && context.mounted) {
                                    context
                                        .read<ProfileCubit>()
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
                                    .read<ProfileCubit>()
                                    .startTimeController,
                                suffixIcon: Icons.timer_sharp,
                                suffixPressed: () async {
                                  final selectedTime =
                                      await CustomTimePicker.show(
                                          context: context);

                                  if (selectedTime != null && context.mounted) {
                                    context
                                        .read<ProfileCubit>()
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
                                    .read<ProfileCubit>()
                                    .endTimeController,
                                suffixIcon: Icons.timer_sharp,
                                suffixPressed: () async {
                                  final selectedTime =
                                      await CustomTimePicker.show(
                                          context: context);

                                  if (selectedTime != null && context.mounted) {
                                    context
                                        .read<ProfileCubit>()
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
                                    .read<ProfileCubit>()
                                    .areaListModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No organizations']
                            : context
                                    .read<ProfileCubit>()
                                    .areaListModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedArea = context
                              .read<ProfileCubit>()
                              .areaListModel
                              ?.data
                              ?.data
                              ?.firstWhere((area) =>
                                  area.name ==
                                  context
                                      .read<ProfileCubit>()
                                      .areaController
                                      .text);

                          context
                              .read<ProfileCubit>()
                              .getCity(selectedArea!.id!);
                          areaId = selectedArea.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context.read<ProfileCubit>().areaController,
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
                                    .read<ProfileCubit>()
                                    .cityModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No cities']
                            : context
                                    .read<ProfileCubit>()
                                    .cityModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedCity = context
                              .read<ProfileCubit>()
                              .cityModel
                              ?.data
                              ?.data
                              ?.firstWhere((city) =>
                                  city.name ==
                                  context
                                      .read<ProfileCubit>()
                                      .cityController
                                      .text);
                          context
                              .read<ProfileCubit>()
                              .getOrganization(selectedCity!.id!);
                          cityId = selectedCity.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context.read<ProfileCubit>().cityController,
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
                                    .read<ProfileCubit>()
                                    .organizationModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No organizations']
                            : context
                                    .read<ProfileCubit>()
                                    .organizationModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedOrganization = context
                              .read<ProfileCubit>()
                              .organizationModel
                              ?.data
                              ?.data
                              ?.firstWhere((organization) =>
                                  organization.name ==
                                  context
                                      .read<ProfileCubit>()
                                      .organizationController
                                      .text);

                          context
                              .read<ProfileCubit>()
                              .getBuilding(selectedOrganization!.id!);
                          organizationId = selectedOrganization.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<ProfileCubit>().organizationController,
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
                                    .read<ProfileCubit>()
                                    .buildingModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No building']
                            : context
                                    .read<ProfileCubit>()
                                    .buildingModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedBuilding = context
                              .read<ProfileCubit>()
                              .buildingModel
                              ?.data
                              ?.data
                              ?.firstWhere((building) =>
                                  building.name ==
                                  context
                                      .read<ProfileCubit>()
                                      .buildingController
                                      .text);

                          context
                              .read<ProfileCubit>()
                              .getFloor(selectedBuilding!.id!);
                          buildingId = selectedBuilding.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<ProfileCubit>().buildingController,
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
                                    .read<ProfileCubit>()
                                    .floorModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No floors']
                            : context
                                    .read<ProfileCubit>()
                                    .floorModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedFloor = context
                              .read<ProfileCubit>()
                              .floorModel
                              ?.data
                              ?.data
                              ?.firstWhere((floor) =>
                                  floor.name ==
                                  context
                                      .read<ProfileCubit>()
                                      .floorController
                                      .text);

                          context
                              .read<ProfileCubit>()
                              .getPoint(selectedFloor!.id!);
                          floorId = selectedFloor.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<ProfileCubit>().floorController,
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
                                    .read<ProfileCubit>()
                                    .pointModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No point']
                            : context
                                    .read<ProfileCubit>()
                                    .pointModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedPoint = context
                              .read<ProfileCubit>()
                              .pointModel
                              ?.data
                              ?.data
                              ?.firstWhere((point) =>
                                  point.name ==
                                  context
                                      .read<ProfileCubit>()
                                      .pointController
                                      .text);

                          context
                              .read<ProfileCubit>()
                              .getPoint(selectedPoint!.id!);
                          pointId = selectedPoint.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<ProfileCubit>().pointController,
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
                                      .read<ProfileCubit>()
                                      .providersModel
                                      ?.data
                                      ?.data
                                      ?.isEmpty ??
                                  true
                              ? ['No providers available']
                              : context
                                      .read<ProfileCubit>()
                                      .providersModel
                                      ?.data
                                      ?.data
                                      ?.map((e) => e.name ?? 'Unknown')
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedProvider = context
                                .read<ProfileCubit>()
                                .pointModel
                                ?.data
                                ?.data
                                ?.firstWhere((provider) =>
                                    provider.name ==
                                    context
                                        .read<ProfileCubit>()
                                        .providerController
                                        .text);

                            context
                                .read<ProfileCubit>()
                                .getPoint(selectedProvider!.id!);
                            providerId = selectedProvider.id;
                          },
                          controller:
                              context.read<ProfileCubit>().providerController,
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                      ],
                      verticalSpace(20),
                      Center(
                        child: DefaultElevatedButton(
                            name: 'Done',
                            onPressed: () {
                              context.read<ProfileCubit>().getUserTaskDetails(
                                  id,
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
