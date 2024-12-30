import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/features/screens/analytics/ui/widgets/organizations_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/organizations/logic/organizations_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organizations/ui/widgets/organizations_filter_search.dart';

Widget organizationsFilterAndSearchBuild(BuildContext context, OrganizationsCubit cubit) {
  return SizedBox(
    height: 45.h,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: OrganizationsTextFormField(
              controller: cubit.searchController,
              hintText: 'Find organization',
              keyboardType: TextInputType.text,
              readOnly: false),
        ),
        horizontalSpace(10),
        organizationsFilterSearchBuild(),
      ],
    ),
  );
}
