import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/logic/cubit/user_details_cubit.dart';

class ShiftItemBuild extends StatelessWidget {
  final int index;
  const ShiftItemBuild({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserDetailsCubit>();
    return InkWell(
      borderRadius: BorderRadius.circular(11.r),
      onTap: () async {
        final result = await context.pushNamed(Routes.shiftDetailsScreen,
            arguments: cubit.userShiftDetailsModel!.data![index].id);

        if (result == true) {
          cubit.getUserShiftDetails(cubit.userDetailsModel!.data!.id);
        }
      },
      child: Card(
        elevation: 1,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.r),
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(11.r),
            border: Border.all(color: AppColor.secondaryColor),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cubit.userShiftDetailsModel!.data![index].name!,
                style: TextStyles.font16BlackSemiBold,
              ),
              verticalSpace(10),
              Row(
                children: [
                  Icon(
                    IconBroken.timeCircle,
                    color: AppColor.thirdColor,
                    size: 18.sp,
                  ),
                  horizontalSpace(5),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: cubit
                              .userShiftDetailsModel!.data![index].startTime!,
                          style: TextStyles.font12GreyRegular,
                        ),
                        TextSpan(
                          text: '  -  ',
                          style: TextStyles.font12GreyRegular,
                        ),
                        TextSpan(
                          text: cubit
                              .userShiftDetailsModel!.data![index].endTime!,
                          style: TextStyles.font12GreyRegular,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              verticalSpace(10),
              Row(
                children: [
                  Icon(
                    IconBroken.calendar,
                    color: AppColor.primaryColor,
                    size: 22.sp,
                  ),
                  horizontalSpace(5),
                  Text(
                    cubit.userShiftDetailsModel!.data![index].startDate!,
                    style: TextStyles.font11WhiteSemiBold
                        .copyWith(color: AppColor.primaryColor),
                  ),
                  Spacer(),
                  Icon(
                    IconBroken.calendar,
                    color: AppColor.primaryColor,
                    size: 22.sp,
                  ),
                  horizontalSpace(5),
                  Text(
                    cubit.userShiftDetailsModel!.data![index].endDate!,
                    style: TextStyles.font11WhiteSemiBold
                        .copyWith(color: AppColor.primaryColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
