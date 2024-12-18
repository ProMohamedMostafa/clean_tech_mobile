import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/organizations/logic/organizations_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organizations/ui/widgets/details_bottom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/organizations/ui/widgets/edit_bottom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/organizations/ui/widgets/filter_search.dart';
import 'package:smart_cleaning_application/features/screens/organizations/ui/widgets/organizations_text_form_field.dart';

Widget organizationsDetails(OrganizationsCubit cubit, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      verticalSpace(5),
      SizedBox(
        height: 45.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            filterSearchOrganizationBuild(),
            horizontalSpace(10),
            Expanded(
              flex: 7,
              child: OrganizationsTextFormField(
                  controller: cubit.searchController,
                  hintText: 'Choose Country',
                  suffixIcon: Icons.arrow_forward_ios_rounded,
                  keyboardType: TextInputType.text,
                  readOnly: false),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Divider(),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Country",
            style: TextStyles.font14Primarybold,
          ),
          Text(
            'Egypt',
            style: TextStyles.font14GreyRegular,
          ),
        ],
      ),
      verticalSpace(5),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Area",
            style: TextStyles.font14Primarybold,
          ),
          Text(
            'Cairo',
            style: TextStyles.font14GreyRegular,
          ),
        ],
      ),
      verticalSpace(5),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "City",
            style: TextStyles.font14Primarybold,
          ),
          Text(
            'Nasr city',
            style: TextStyles.font14GreyRegular,
          ),
        ],
      ),
      verticalSpace(5),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Organization",
            style: TextStyles.font14Primarybold,
          ),
          Text(
            'Ai Cloud',
            style: TextStyles.font14GreyRegular,
          ),
        ],
      ),
      verticalSpace(10),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () {
                showCustomDialog(context,
                    'Are You Sure You Want To Remove This Organization ?');
              },
              icon: Icon(
                IconBroken.delete,
                color: AppColor.primaryColor,
              )),
          IconButton(
              onPressed: () {
                EditBottomDialog().showBottomDialog(
                    context, context.read<OrganizationsCubit>());
              },
              icon: Icon(
                Icons.mode_edit_outlined,
                color: AppColor.primaryColor,
              )),
          IconButton(
              onPressed: () {
                DetailsBottomDialog().showBottomDialog(context);
              },
              icon: Icon(
                Icons.edit_note_sharp,
                color: AppColor.primaryColor,
              )),
        ],
      ),
      Divider(
        thickness: 3,
        color: AppColor.primaryColor,
      ),
    ],
  );
}
