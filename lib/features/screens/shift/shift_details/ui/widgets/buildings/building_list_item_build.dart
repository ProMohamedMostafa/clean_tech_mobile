import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/logic/cubit/shift_details_cubit.dart';

class BuildingItemListBuild extends StatelessWidget {
  final int index;
  const BuildingItemListBuild({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(11.r),
      onTap: () {
        context.pushNamed(Routes.workLocationDetailsScreen, arguments: {
          'id': context
              .read<ShiftDetailsCubit>()
              .shiftDetailsModel!
              .data!
              .building![index]
              .id!
              .toInt(),
          'selectedIndex': 3
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
                    .read<ShiftDetailsCubit>()
                    .shiftDetailsModel!
                    .data!
                    .building![index]
                    .name ??
                '',
            style: TextStyles.font14BlackSemiBold,
          ),
          subtitle: Text(
            context
                    .read<ShiftDetailsCubit>()
                    .shiftDetailsModel!
                    .data!
                    .building![index]
                    .name ??
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
}
