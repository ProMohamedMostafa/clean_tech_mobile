import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/logic/attendance_history_cubit.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_date_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class HistoryFilterDialog {
  static Future<String?> show({
    required BuildContext context,
  }) async {
    return await showDialog(
      context: context,
      builder: (dialogContext) {
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
                        S.of(context).addUserText13,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: 'Select Role',
                        items: context
                                    .read<AttendanceHistoryCubit>()
                                    .roleModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No roles available']
                            : context
                                    .read<AttendanceHistoryCubit>()
                                    .roleModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        controller: context
                            .read<AttendanceHistoryCubit>()
                            .roleController,
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(10),
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
                            context
                                .read<AttendanceHistoryCubit>()
                                .statusIdController
                                .text = selectedIndex.toString();
                          }
                        },
                        hint: 'Select status',
                        items: ['Late', 'Present', 'Completed', 'Absent'],
                        controller: context
                            .read<AttendanceHistoryCubit>()
                            .statusController,
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
                              .read<AttendanceHistoryCubit>()
                              .shiftModel
                              ?.data
                              ?.data!
                              .firstWhere(
                                  (shift) => shift.name == selectedValue)
                              .id
                              ?.toString();

                          if (selectedId != null) {
                            context
                                .read<AttendanceHistoryCubit>()
                                .shiftIdController
                                .text = selectedId;
                          }
                        },
                        hint: 'Select shift',
                        items: context
                                    .read<AttendanceHistoryCubit>()
                                    .shiftModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No shift available']
                            : context
                                    .read<AttendanceHistoryCubit>()
                                    .shiftModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        controller: context
                            .read<AttendanceHistoryCubit>()
                            .shiftController,
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
                                    .read<AttendanceHistoryCubit>()
                                    .startDateController,
                                suffixIcon: Icons.calendar_today,
                                suffixPressed: () async {
                                  final selectedDate =
                                      await CustomDatePicker.show(
                                          context: context);

                                  if (selectedDate != null && context.mounted) {
                                    context
                                        .read<AttendanceHistoryCubit>()
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
                                    .read<AttendanceHistoryCubit>()
                                    .endDateController,
                                suffixIcon: Icons.calendar_today,
                                suffixPressed: () async {
                                  final selectedDate =
                                      await CustomDatePicker.show(
                                          context: context);

                                  if (selectedDate != null && context.mounted) {
                                    context
                                        .read<AttendanceHistoryCubit>()
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
                      verticalSpace(30),
                      Center(
                        child: DefaultElevatedButton(
                            name: 'Done',
                            onPressed: () {
                              context
                                  .read<AttendanceHistoryCubit>()
                                  .getAllHistory();
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
