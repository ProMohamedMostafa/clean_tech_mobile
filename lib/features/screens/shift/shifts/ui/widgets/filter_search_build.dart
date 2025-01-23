import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/logic/shift_cubit.dart';

Widget filterAndSearchBuild(BuildContext context, ShiftCubit cubit) {
  return SizedBox(
    height: 45.h,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: CustomDropDownList(
            perfixIcon: IconBroken.search,
            controller: cubit.searchController,
            hint: 'Find shift',
            color: AppColor.secondaryColor,
            keyboardType: TextInputType.text,
            isRead: false,
            items:
                // cubit.usersModel?.data?.users?.isEmpty ?? true
                //     ? ['No users available']
                //     : cubit.usersModel?.data?.users
                //             ?.map((e) => e.userName ?? 'Unknown')
                //             .toList() ??
                [],
          ),
        ),
        horizontalSpace(10),
        Container(
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
      ],
    ),
  );
}
