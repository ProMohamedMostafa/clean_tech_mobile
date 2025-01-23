import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/ui/widgets/filter_dialog_.dart';

Widget filterAndSearchBuild(BuildContext context, UserManagementCubit cubit) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: CustomTextFormField(
          perfixIcon: Icon(IconBroken.search),
          controller: cubit.searchController,
          hint: 'Find someone',
          keyboardType: TextInputType.text,
          onlyRead: false,
          onChanged: (searchedCharacter) {
            cubit.getAllUsersInUserManage();
          },
        ),
      ),
      horizontalSpace(10),
      InkWell(
        onTap: () {
          cubit.countryController.clear();
          cubit.organizationController.clear();
          cubit.buildingController.clear();
          cubit.floorController.clear();
          cubit.buildingController.clear();
          cubit.pointController.clear();
          cubit.roleController.clear();
          CustomFilterUserDialog.show(
            context: context,
          );
        },
        child: Container(
          height: 49,
          width: 49,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: AppColor.secondaryColor)),
          child: Icon(
            Icons.tune,
            color: AppColor.primaryColor,
            size: 25.sp,
          ),
        ),
      ),
    ],
  );
}
