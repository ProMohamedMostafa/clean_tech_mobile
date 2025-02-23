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
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/logic/shift_cubit.dart';

class CustomFilterShiftDialog {
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
                                    .read<ShiftCubit>()
                                    .startDateController,
                                suffixIcon: Icons.calendar_today,
                                suffixPressed: () async {
                                  final selectedDate =
                                      await CustomDatePicker.show(
                                          context: context);

                                  if (selectedDate != null && context.mounted) {
                                    context
                                        .read<ShiftCubit>()
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
                                    .read<ShiftCubit>()
                                    .endDateController,
                                suffixIcon: Icons.calendar_today,
                                suffixPressed: () async {
                                  final selectedDate =
                                      await CustomDatePicker.show(
                                          context: context);

                                  if (selectedDate != null && context.mounted) {
                                    context
                                        .read<ShiftCubit>()
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
                                    .read<ShiftCubit>()
                                    .startTimeController,
                                suffixIcon: Icons.timer_sharp,
                                suffixPressed: () async {
                                  final selectedTime =
                                      await CustomTimePicker.show(
                                          context: context);

                                  if (selectedTime != null && context.mounted) {
                                    context
                                        .read<ShiftCubit>()
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
                                    .read<ShiftCubit>()
                                    .endTimeController,
                                suffixIcon: Icons.timer_sharp,
                                suffixPressed: () async {
                                  final selectedTime =
                                      await CustomTimePicker.show(
                                          context: context);

                                  if (selectedTime != null && context.mounted) {
                                    context
                                        .read<ShiftCubit>()
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
                      Text(
                        'Area',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: "Select area",
                        items: context
                                    .read<ShiftCubit>()
                                    .allAreaModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No organizations']
                            : context
                                    .read<ShiftCubit>()
                                    .allAreaModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedArea = context
                              .read<ShiftCubit>()
                              .allAreaModel
                              ?.data
                              ?.data
                              ?.firstWhere((area) =>
                                  area.name ==
                                  context
                                      .read<ShiftCubit>()
                                      .areaController
                                      .text);

                          context.read<ShiftCubit>().getCity(selectedArea!.id!);
                          areaId = selectedArea.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context.read<ShiftCubit>().areaController,
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
                                    .read<ShiftCubit>()
                                    .cityModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No cities']
                            : context
                                    .read<ShiftCubit>()
                                    .cityModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedCity = context
                              .read<ShiftCubit>()
                              .cityModel
                              ?.data
                              ?.firstWhere((city) =>
                                  city.name ==
                                  context
                                      .read<ShiftCubit>()
                                      .cityController
                                      .text);
                          context
                              .read<ShiftCubit>()
                              .getOrganization(selectedCity!.id!);
                          cityId = selectedCity.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context.read<ShiftCubit>().cityController,
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
                                    .read<ShiftCubit>()
                                    .organizationModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No organizations']
                            : context
                                    .read<ShiftCubit>()
                                    .organizationModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedOrganization = context
                              .read<ShiftCubit>()
                              .organizationModel
                              ?.data
                              ?.firstWhere((organization) =>
                                  organization.name ==
                                  context
                                      .read<ShiftCubit>()
                                      .organizationController
                                      .text);

                          context
                              .read<ShiftCubit>()
                              .getBuilding(selectedOrganization!.id!);
                          organizationId = selectedOrganization.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<ShiftCubit>().organizationController,
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
                                    .read<ShiftCubit>()
                                    .buildingModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No building']
                            : context
                                    .read<ShiftCubit>()
                                    .buildingModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedBuilding = context
                              .read<ShiftCubit>()
                              .buildingModel
                              ?.data
                              ?.firstWhere((building) =>
                                  building.name ==
                                  context
                                      .read<ShiftCubit>()
                                      .buildingController
                                      .text);

                          context
                              .read<ShiftCubit>()
                              .getFloor(selectedBuilding!.id!);
                          buildingId = selectedBuilding.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<ShiftCubit>().buildingController,
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
                                    .read<ShiftCubit>()
                                    .floorModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No floors']
                            : context
                                    .read<ShiftCubit>()
                                    .floorModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedFloor = context
                              .read<ShiftCubit>()
                              .floorModel
                              ?.data
                              ?.firstWhere((floor) =>
                                  floor.name ==
                                  context
                                      .read<ShiftCubit>()
                                      .floorController
                                      .text);

                          context
                              .read<ShiftCubit>()
                              .getPoints(selectedFloor!.id!);
                          floorId = selectedFloor.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context.read<ShiftCubit>().floorController,
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
                                    .read<ShiftCubit>()
                                    .pointsModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No point']
                            : context
                                    .read<ShiftCubit>()
                                    .pointsModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedPoint = context
                              .read<ShiftCubit>()
                              .pointsModel
                              ?.data
                              ?.firstWhere((point) =>
                                  point.name ==
                                  context
                                      .read<ShiftCubit>()
                                      .pointController
                                      .text);

                          context
                              .read<ShiftCubit>()
                              .getPoints(selectedPoint!.id!);
                          pointId = selectedPoint.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context.read<ShiftCubit>().pointController,
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
                                      .read<ShiftCubit>()
                                      .providersModel
                                      ?.data
                                      ?.data
                                      ?.isEmpty ??
                                  true
                              ? ['No providers available']
                              : context
                                      .read<ShiftCubit>()
                                      .providersModel
                                      ?.data
                                      ?.data
                                      ?.map((e) => e.name ?? 'Unknown')
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedProvider = context
                                .read<ShiftCubit>()
                                .providersModel
                                ?.data
                                ?.data
                                ?.firstWhere((provider) =>
                                    provider.name ==
                                    context
                                        .read<ShiftCubit>()
                                        .providerController
                                        .text);

                            providerId = selectedProvider!.id;
                          },
                          controller:
                              context.read<ShiftCubit>().providerController,
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                      ],
                      verticalSpace(20),
                      Center(
                        child: DefaultElevatedButton(
                            name: 'Done',
                            onPressed: () {
                              context.read<ShiftCubit>().getAllShifts(
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
                      verticalSpace(20),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
