import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/logic/attendance_history_cubit.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/ui/widgets/history_filter_dialog.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';

Widget attendanceHistoryFilterAndSearchBuild(
    BuildContext context, AttendanceHistoryCubit cubit) {
  return SizedBox(
    height: 45.h,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: CustomTextFormField(
              color: AppColor.secondaryColor,
              perfixIcon: Icon(IconBroken.search),
              controller: cubit.searchController,
              hint: 'Find history attendance',
              keyboardType: TextInputType.text,
              onlyRead: false),
        ),
        horizontalSpace(10),
        InkWell(
          onTap: () {
            cubit.searchController.clear();
            cubit.roleController.clear();
            cubit.statusController.clear();
            cubit.startDateController.clear();
            cubit.endDateController.clear();
            cubit.shiftController.clear();

            HistoryFilterDialog.show(
              context: context,
            );
          },
          child: Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColor.secondaryColor)),
            child: Icon(
              Icons.tune,
              color: AppColor.primaryColor,
              size: 25.sp,
            ),
          ),
        ),
      ],
    ),
  );
}
