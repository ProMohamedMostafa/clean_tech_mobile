import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/logic/shift_cubit.dart';

Widget listPointItemBuild(BuildContext context, index) {
  return InkWell(
    borderRadius: BorderRadius.circular(11.r),
    onTap: () {
      context.pushNamed(Routes.workLocationDetailsScreen, arguments: {
        'id': context
            .read<ShiftCubit>()
            .shiftSectionDetailsModel!
            .data![index]
            .id!
            .toInt(),
        'selectedIndex': 5
      });
    },
    child: Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.r),
          side: BorderSide(color: AppColor.secondaryColor)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        minTileHeight: 72.h,
        title: Text(
          context
                  .read<ShiftCubit>()
                  .shiftSectionDetailsModel!
                  .data![index]
                  .name ??
              '',
          style: TextStyles.font14BlackSemiBold,
        ),
        subtitle: Text(
          context
                  .read<ShiftCubit>()
                  .shiftSectionDetailsModel!
                  .data![index]
                  .floorName ??
              '',
          style: TextStyles.font12GreyRegular,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColor.thirdColor,
        ),
      ),
    ),
  );
}
