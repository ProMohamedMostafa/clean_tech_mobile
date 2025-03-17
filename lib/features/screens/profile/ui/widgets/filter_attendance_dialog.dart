import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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
import 'package:smart_cleaning_application/features/screens/profile/logic/profile_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class CustomFilterAttedanceDialog {
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
        int? providerId;
        int? shiftId;
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
                          S.of(context).addUserText13,
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: 'Select Role',
                          items: context
                                      .read<ProfileCubit>()
                                      .roleModel
                                      ?.data
                                      ?.isEmpty ??
                                  true
                              ? ['No roles available']
                              : context
                                      .read<ProfileCubit>()
                                      .roleModel
                                      ?.data
                                      ?.map((e) => e.name ?? 'Unknown')
                                      .toList() ??
                                  [],
                          controller:
                              context.read<ProfileCubit>().roleController,
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                        verticalSpace(10),
                      ],
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
                            statusId = selectedIndex;
                          }
                        },
                        hint: 'Select status',
                        items: ['Late', 'Present', 'Completed', 'Absent'],
                        controller:
                            context.read<ProfileCubit>().statusController,
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(10),
                      Text(
                        'Shift',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        onPressed: (selectedValue) {
                          final selectedId = context
                              .read<ProfileCubit>()
                              .shiftModel
                              ?.data
                              ?.data!
                              .firstWhere(
                                  (shift) => shift.name == selectedValue);

                          if (selectedId != null) {
                            shiftId = selectedId.id;
                          }
                        },
                        hint: 'Select shift',
                        items: context
                                    .read<ProfileCubit>()
                                    .shiftModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No shift available']
                            : context
                                    .read<ProfileCubit>()
                                    .shiftModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        controller:
                            context.read<ProfileCubit>().shiftController,
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
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(3025),
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          dialogBackgroundColor: Colors.white,
                                          colorScheme: ColorScheme.light(
                                            primary: AppColor.primaryColor,
                                            onPrimary: Colors.white,
                                            onSurface: Colors.black,
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (pickedDate != null) {
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);

                                    context
                                        .read<ProfileCubit>()
                                        .startDateController
                                        .text = formattedDate;
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
                      Text(
                        'Area',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: "Select area",
                        items: context
                                    .read<ProfileCubit>()
                                    .allAreaModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No organizations']
                            : context
                                    .read<ProfileCubit>()
                                    .allAreaModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedArea = context
                              .read<ProfileCubit>()
                              .allAreaModel
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
                          areaId = selectedArea.id;
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
                                    ?.data?.data
                                    ?.isEmpty ??
                                true
                            ? ['No cities']
                            : context
                                    .read<ProfileCubit>()
                                    .cityModel
                                      ?.data?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedCity = context
                              .read<ProfileCubit>()
                              .cityModel
                                ?.data?.data
                              ?.firstWhere((city) =>
                                  city.name ==
                                  context
                                      .read<ProfileCubit>()
                                      .cityController
                                      .text);
                          context
                              .read<ProfileCubit>()
                              .getOrganization(selectedCity!.id!);
                          cityId = selectedCity.id;
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
                                      ?.data?.data
                                    ?.isEmpty ??
                                true
                            ? ['No organizations']
                            : context
                                    .read<ProfileCubit>()
                                    .organizationModel
                                      ?.data?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedOrganization = context
                              .read<ProfileCubit>()
                              .organizationModel
                                ?.data?.data
                              ?.firstWhere((organization) =>
                                  organization.name ==
                                  context
                                      .read<ProfileCubit>()
                                      .organizationController
                                      .text);

                          context
                              .read<ProfileCubit>()
                              .getBuilding(selectedOrganization!.id!);
                          organizationId = selectedOrganization.id;
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
                                      ?.data?.data
                                    ?.isEmpty ??
                                true
                            ? ['No building']
                            : context
                                    .read<ProfileCubit>()
                                    .buildingModel
                                      ?.data?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedBuilding = context
                              .read<ProfileCubit>()
                              .buildingModel
                                ?.data?.data
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
                                      ?.data?.data
                                    ?.isEmpty ??
                                true
                            ? ['No floors']
                            : context
                                    .read<ProfileCubit>()
                                    .floorModel
                                      ?.data?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedFloor = context
                              .read<ProfileCubit>()
                              .floorModel
                                ?.data?.data
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
                                      ?.data?.data
                                    ?.isEmpty ??
                                true
                            ? ['No point']
                            : context
                                    .read<ProfileCubit>()
                                    .pointModel
                                      ?.data?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedPoint = context
                              .read<ProfileCubit>()
                              .pointModel
                                ?.data?.data
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
                      if (role != 'Cleaner') ...[
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
                                        ?.data?.data
                                     
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
                                .providersModel
                                ?.data
                                ?.data
                                ?.firstWhere((provider) =>
                                    provider.name ==
                                    context
                                        .read<ProfileCubit>()
                                        .providerController
                                        .text);

                            providerId = selectedProvider!.id;
                          },
                          controller:
                              context.read<ProfileCubit>().providerController,
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                      ],
                      verticalSpace(30),
                      Center(
                        child: DefaultElevatedButton(
                            name: 'Done',
                            onPressed: () {
                              context.read<ProfileCubit>().getAllHistory(
                                    id,
                                    status: statusId,
                                    areaId: areaId,
                                    cityId: cityId,
                                    organizationId: organizationId,
                                    buildingId: buildingId,
                                    floorId: floorId,
                                    pointId: pointId,
                                    providerId: providerId,
                                    shiftId: shiftId,
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
