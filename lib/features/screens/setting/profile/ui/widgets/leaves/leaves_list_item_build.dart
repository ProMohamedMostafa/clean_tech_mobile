import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/setting/profile/logic/profile_cubit.dart';

class BuildLeavesCardItem extends StatelessWidget {
  final int index;
  const BuildLeavesCardItem({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return InkWell(
      borderRadius: BorderRadius.circular(11.r),
      onTap: () async {
        final result = await context.pushNamed(
          Routes.leavesDetailsScreen,
          arguments: {
            'id': cubit.attendanceLeavesModel!.data!.leaves![index].id!,
            'isProfile': true,
          },
        );

        if (result == true) {
          cubit.getAllLeaves();
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
              Row(
                children: [
                  Container(
                    height: 23.h,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Color(0xffF6DCDF),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Center(
                      child: Text(
                        cubit.attendanceLeavesModel!.data!.leaves![index].type!,
                        style: TextStyles.font11WhiteSemiBold.copyWith(
                          color: Color(0xffD25260),
                        ),
                      ),
                    ),
                  ),
                  horizontalSpace(5),
                  Container(
                    height: 23.h,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Center(
                      child: Text(
                        cubit.attendanceLeavesModel!.data!.leaves![index]
                            .userName!,
                        style: TextStyles.font11WhiteSemiBold
                            .copyWith(color: AppColor.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(5),
              Text(
                cubit.attendanceLeavesModel!.data!.leaves![index].userName!,
                style: TextStyles.font16BlackSemiBold,
              ),
              verticalSpace(10),
              Text(
                cubit.attendanceLeavesModel!.data!.leaves![index].reason!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyles.font11GreyMedium,
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
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: cubit.attendanceLeavesModel!.data!
                                  .leaves![index].startDate ??
                              '',
                          style: TextStyles.font11WhiteSemiBold
                              .copyWith(color: AppColor.primaryColor),
                        ),
                        TextSpan(
                          text: '  :  ',
                          style: TextStyles.font14GreyRegular,
                        ),
                        TextSpan(
                          text: cubit.attendanceLeavesModel!.data!
                                  .leaves![index].endDate ??
                              '',
                          style: TextStyles.font11WhiteSemiBold
                              .copyWith(color: AppColor.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 30.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.network(
                        cubit.attendanceLeavesModel!.data!.leaves![index]
                                .image ??
                            '',
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/person.png',
                            fit: BoxFit.fill,
                          );
                        },
                      ),
                    ),
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
