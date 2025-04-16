import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/filter_top_widget/filter_top_widget.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/logic/attendance_leaves_cubit.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_date_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class LeavesFilterDialog {
  static Future<String?> show({required BuildContext context}) async {
    return await showDialog(
      context: context,
      builder: (dialogContext) {
        int? areaId;
        int? cityId;
        int? organizationId;
        int? buildingId;
        int? floorId;
        int? sectionId;
        int? pointId;
        int? providerId;
        int? userId;
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
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildHeader(context),
                      Text(
                        S.of(context).addUserText13,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: 'Select Role',
                        items: context
                                    .read<AttendanceLeavesCubit>()
                                    .roleModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No roles available']
                            : context
                                    .read<AttendanceLeavesCubit>()
                                    .roleModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        controller: context
                            .read<AttendanceLeavesCubit>()
                            .roleController,
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(10),
                      Text(
                        'Type',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        onPressed: (selectedValue) {
                          final items = ['Sick', 'Annual', 'Ordinary'];
                          final selectedIndex = items.indexOf(selectedValue);
                          if (selectedIndex != -1) {
                            context
                                .read<AttendanceLeavesCubit>()
                                .typeIdController
                                .text = selectedIndex.toString();
                          }
                        },
                        hint: 'Select type',
                        items: ['Sick', 'Annual', 'Ordinary'],
                        controller: context
                            .read<AttendanceLeavesCubit>()
                            .typeController,
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
                                    .read<AttendanceLeavesCubit>()
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
                                        .read<AttendanceLeavesCubit>()
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
                                    .read<AttendanceLeavesCubit>()
                                    .endDateController,
                                suffixIcon: Icons.calendar_today,
                                suffixPressed: () async {
                                  final selectedDate =
                                      await CustomDatePicker.show(
                                          context: context);

                                  if (selectedDate != null && context.mounted) {
                                    context
                                        .read<AttendanceLeavesCubit>()
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
                        'User',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: 'Select Users',
                        items: context
                                    .read<AttendanceLeavesCubit>()
                                    .usersModel
                                    ?.data
                                    ?.users
                                    ?.isEmpty ??
                                true
                            ? ['No users available']
                            : context
                                    .read<AttendanceLeavesCubit>()
                                    .usersModel
                                    ?.data
                                    ?.users
                                    ?.map((e) => e.userName ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedUser = context
                              .read<AttendanceLeavesCubit>()
                              .usersModel
                              ?.data
                              ?.users
                              ?.firstWhere((user) =>
                                  user.userName ==
                                  context
                                      .read<AttendanceLeavesCubit>()
                                      .userController
                                      .text);

                          context
                              .read<AttendanceLeavesCubit>()
                              .getCity(selectedUser!.id!);
                          userId = selectedUser.id;
                        },
                        controller: context
                            .read<AttendanceLeavesCubit>()
                            .userController,
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(10),
                      Text(
                        'Area',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: "Select area",
                        items: context
                                    .read<AttendanceLeavesCubit>()
                                    .allAreaModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No organizations']
                            : context
                                    .read<AttendanceLeavesCubit>()
                                    .allAreaModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedArea = context
                              .read<AttendanceLeavesCubit>()
                              .allAreaModel
                              ?.data
                              ?.data
                              ?.firstWhere((area) =>
                                  area.name ==
                                  context
                                      .read<AttendanceLeavesCubit>()
                                      .areaController
                                      .text);

                          context
                              .read<AttendanceLeavesCubit>()
                              .getCity(selectedArea!.id!);
                          areaId = selectedArea.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<AttendanceLeavesCubit>()
                            .areaController,
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
                                    .read<AttendanceLeavesCubit>()
                                    .cityModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No cities']
                            : context
                                    .read<AttendanceLeavesCubit>()
                                    .cityModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedCity = context
                              .read<AttendanceLeavesCubit>()
                              .cityModel
                              ?.data
                              ?.data
                              ?.firstWhere((city) =>
                                  city.name ==
                                  context
                                      .read<AttendanceLeavesCubit>()
                                      .cityController
                                      .text);
                          context
                              .read<AttendanceLeavesCubit>()
                              .getOrganization(selectedCity!.id!);
                          cityId = selectedCity.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<AttendanceLeavesCubit>()
                            .cityController,
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
                                    .read<AttendanceLeavesCubit>()
                                    .organizationModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No organizations']
                            : context
                                    .read<AttendanceLeavesCubit>()
                                    .organizationModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedOrganization = context
                              .read<AttendanceLeavesCubit>()
                              .organizationModel
                              ?.data
                              ?.data
                              ?.firstWhere((organization) =>
                                  organization.name ==
                                  context
                                      .read<AttendanceLeavesCubit>()
                                      .organizationController
                                      .text);

                          context
                              .read<AttendanceLeavesCubit>()
                              .getBuilding(selectedOrganization!.id!);
                          organizationId = selectedOrganization.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<AttendanceLeavesCubit>()
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
                                    .read<AttendanceLeavesCubit>()
                                    .buildingModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No building']
                            : context
                                    .read<AttendanceLeavesCubit>()
                                    .buildingModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedBuilding = context
                              .read<AttendanceLeavesCubit>()
                              .buildingModel
                              ?.data
                              ?.data
                              ?.firstWhere((building) =>
                                  building.name ==
                                  context
                                      .read<AttendanceLeavesCubit>()
                                      .buildingController
                                      .text);

                          context
                              .read<AttendanceLeavesCubit>()
                              .getFloor(selectedBuilding!.id!);
                          buildingId = selectedBuilding.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<AttendanceLeavesCubit>()
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
                                    .read<AttendanceLeavesCubit>()
                                    .floorModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No floors']
                            : context
                                    .read<AttendanceLeavesCubit>()
                                    .floorModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedFloor = context
                              .read<AttendanceLeavesCubit>()
                              .floorModel
                              ?.data
                              ?.data
                              ?.firstWhere((floor) =>
                                  floor.name ==
                                  context
                                      .read<AttendanceLeavesCubit>()
                                      .floorController
                                      .text);

                          context
                              .read<AttendanceLeavesCubit>()
                              .getPoint(selectedFloor!.id!);
                          floorId = selectedFloor.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<AttendanceLeavesCubit>()
                            .floorController,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        'Section',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: "Select section",
                        items: context
                                    .read<AttendanceLeavesCubit>()
                                    .sectionModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No sections']
                            : context
                                    .read<AttendanceLeavesCubit>()
                                    .sectionModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedSection = context
                              .read<AttendanceLeavesCubit>()
                              .sectionModel
                              ?.data
                              ?.data
                              ?.firstWhere((section) =>
                                  section.name ==
                                  context
                                      .read<AttendanceLeavesCubit>()
                                      .sectionController
                                      .text);

                          context
                              .read<AttendanceLeavesCubit>()
                              .getPoint(selectedSection!.id!);
                          sectionId = selectedSection.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<AttendanceLeavesCubit>()
                            .sectionController,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        'Point',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: "Select point",
                        items: context
                                    .read<AttendanceLeavesCubit>()
                                    .pointModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No point']
                            : context
                                    .read<AttendanceLeavesCubit>()
                                    .pointModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedPoint = context
                              .read<AttendanceLeavesCubit>()
                              .pointModel
                              ?.data
                              ?.data
                              ?.firstWhere((point) =>
                                  point.name ==
                                  context
                                      .read<AttendanceLeavesCubit>()
                                      .pointController
                                      .text);

                          context
                              .read<AttendanceLeavesCubit>()
                              .getPoint(selectedPoint!.id!);
                          pointId = selectedPoint.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<AttendanceLeavesCubit>()
                            .pointController,
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
                                    .read<AttendanceLeavesCubit>()
                                    .providersModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No providers available']
                            : context
                                    .read<AttendanceLeavesCubit>()
                                    .providersModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedProvider = context
                              .read<AttendanceLeavesCubit>()
                              .providersModel
                              ?.data
                              ?.data
                              ?.firstWhere((provider) =>
                                  provider.name ==
                                  context
                                      .read<AttendanceLeavesCubit>()
                                      .providerController
                                      .text);

                          providerId = selectedProvider!.id;
                        },
                        controller: context
                            .read<AttendanceLeavesCubit>()
                            .providerController,
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(20),
                      Center(
                        child: DefaultElevatedButton(
                            name: 'Done',
                            onPressed: () {
                              context
                                  .read<AttendanceLeavesCubit>()
                                  .getAllLeaves(
                                      areaId: areaId,
                                      cityId: cityId,
                                      organizationId: organizationId,
                                      buildingId: buildingId,
                                      floorId: floorId,
                                      sectionId: sectionId,
                                      pointId: pointId,
                                      providerId: providerId,
                                      userId: userId);

                              context.pop();
                            },
                            color: AppColor.primaryColor,
                            height: 47,
                            width: double.infinity,
                            textStyles: TextStyles.font20Whitesemimedium),
                      ),
                             verticalSpace(10),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
