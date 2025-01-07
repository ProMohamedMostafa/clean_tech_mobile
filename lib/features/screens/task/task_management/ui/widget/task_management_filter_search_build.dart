import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/logic/task_management_cubit.dart';
import 'package:smart_cleaning_application/features/screens/task/task_management/ui/widget/task_management_text_form_field.dart';

Widget taskManagementFilterAndDeleteBuild(
    BuildContext context, TaskManagementCubit cubit, selectedIndex) {
  return SizedBox(
    height: 45.h,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: TaskManagementTextFormField(
              controller: cubit.searchController,
              hintText: 'Find task',
              keyboardType: TextInputType.text,
              readOnly: false),
        ),
        horizontalSpace(10),
        InkWell(
          onTap: () {
            // context.pushNamed(Routes.deleteOrganizationScreen,
            //     arguments: selectedIndex);
          },
          child: Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AppColor.secondaryColor)),
            child: Icon(
              IconBroken.delete,
              color: AppColor.primaryColor,
              size: 25.sp,
            ),
          ),
        ),
      ],
    ),
  );
}
