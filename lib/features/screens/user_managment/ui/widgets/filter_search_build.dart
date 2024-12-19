import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/features/screens/organizations/ui/widgets/organizations_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/logic/user_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/ui/widgets/adding_build.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/ui/widgets/filter_search.dart';

Widget filterAndSearchBuild(BuildContext context, UserManagementCubit cubit) {
  return SizedBox(
    height: 45.h,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        addingBuild(context),
        horizontalSpace(10),
        filterSearchUserManagmentBuild(),
        horizontalSpace(10),
        Expanded(
          child: OrganizationsTextFormField(
              controller: cubit.searchController,
              hintText: 'Searching for user',
              keyboardType: TextInputType.text,
              readOnly: false),
        ),
      ],
    ),
  );
}
