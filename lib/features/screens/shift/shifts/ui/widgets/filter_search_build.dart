import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/logic/shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/ui/widgets/filter_search.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/ui/widgets/user_management_text_form_field.dart';

Widget filterAndSearchBuild(BuildContext context, ShiftCubit cubit) {
  return SizedBox(
    height: 45.h,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: UserManagementTextFormField(
              controller: cubit.searchController,
              hintText: 'Find shift',
              keyboardType: TextInputType.text,
              readOnly: false),
        ),
        horizontalSpace(10),
        filterSearchUserManagmentBuild(),
      ],
    ),
  );
}
