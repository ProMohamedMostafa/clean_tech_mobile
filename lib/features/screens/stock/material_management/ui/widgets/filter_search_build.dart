import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/logic/material_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/ui/widgets/filter_dialog_.dart';

Widget filterAndSearchBuild(
    BuildContext context, MaterialManagementCubit cubit) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: CustomTextFormField(
          color: AppColor.secondaryColor,
          perfixIcon: Icon(IconBroken.search),
          controller: cubit.searchController,
          hint: 'Find someone',
          keyboardType: TextInputType.text,
          onlyRead: false,
          onChanged: (searchedCharacter) {
            cubit.getMaterialList();
          },
        ),
      ),
      horizontalSpace(10),
      InkWell(
        borderRadius: BorderRadius.circular(10.r),
        onTap: () {
          cubit.unitController.clear();
          cubit.unitIdController.clear();
          cubit.categoryController.clear();
          cubit.categoryIdController.clear();
          CustomFilterMaterialDialog.show(
            context: context,
          );
        },
        child: Container(
          height: 49.h,
          width: 49.w,
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
