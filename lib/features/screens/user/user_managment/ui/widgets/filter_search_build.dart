import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/ui/widgets/filter_search.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/ui/widgets/user_management_text_form_field.dart';

Widget filterAndSearchBuild(BuildContext context, UserManagementCubit cubit) {
  return SizedBox(
    height: 45.h,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: UserManagementTextFormField(
              controller: cubit.searchController,
              hintText: 'Find someone',
              keyboardType: TextInputType.text,
              readOnly: false),
        ),
        horizontalSpace(10),
        filterSearchUserManagmentBuild(),
      ],
    ),
  );
}
