import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/features/screens/analytics/ui/widgets/organizations_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/logic/organizations_cubit.dart';

Widget organizationsFilterAndDeleteBuild(
    BuildContext context, OrganizationsCubit cubit) {
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
        InkWell(
          onTap: () {},
          child: Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AppColor.secondaryColor)),
            child: Icon(
              IconBroken.delete,
              color: Colors.red,
              size: 25.sp,
            ),
          ),
        ),
      ],
    ),
  );
}
