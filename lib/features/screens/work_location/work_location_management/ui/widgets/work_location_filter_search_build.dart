import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/ui/widgets/filter_dialog_.dart';

Widget organizationsFilterAndDeleteBuild(
    BuildContext context, WorkLocationCubit cubit, selectedIndex) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: CustomTextFormField(
          color: AppColor.secondaryColor,
          perfixIcon: Icon(IconBroken.search),
          controller: cubit.searchController,
          hint: 'Find work location',
          keyboardType: TextInputType.text,
          onlyRead: false,
          onChanged: (searchedCharacter) {
            selectedIndex == 0
                ? cubit.getArea()
                : selectedIndex == 1
                    ? cubit.getCity()
                    : selectedIndex == 2
                        ? cubit.getOrganization()
                        : selectedIndex == 3
                            ? cubit.getBuilding()
                            : selectedIndex == 4
                                ? cubit.getFloor()
                                : cubit.getPoint();
          },
        ),
      ),
      horizontalSpace(10),
      InkWell(
        borderRadius: BorderRadius.circular(10.r),
        onTap: () {
          cubit.countryController.clear();
          cubit.organizationController.clear();
          cubit.buildingController.clear();
          cubit.floorController.clear();
          cubit.buildingController.clear();
          cubit.pointController.clear();
       
          CustomFilterWorkLocationDialog.show(
            context: context,
            selectedIndex: selectedIndex
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
