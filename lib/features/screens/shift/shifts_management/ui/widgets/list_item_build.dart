import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/logic/shift_cubit.dart';

class ListShiftItemBuild extends StatelessWidget {
  final int index;
  const ListShiftItemBuild({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShiftCubit>();

    return InkWell(
      borderRadius: BorderRadius.circular(11.r),
      onTap: () {
        if (cubit.selectedIndex == 0) {
          context.pushNamed(Routes.shiftDetailsScreen,
              arguments: cubit.allShiftsModel!.data!.shifts![index].id);
        }
      },
      child: Card(
        elevation: 1,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.r),
        ),
        child: Container(
          constraints: BoxConstraints(
            minHeight: 125.h,
          ),
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  Text(
                    cubit.selectedIndex == 0
                        ? cubit.allShiftsModel!.data!.shifts![index].name!
                        : cubit.allShiftsDeletedModel!.data![index].name!,
                    style: TextStyles.font16BlackSemiBold,
                  ),
                  Spacer(),
                  role == 'Admin'
                      ? InkWell(
                          onTap: () {
                            cubit.selectedIndex == 0
                                ? context.pushNamed(
                                    Routes.editShiftScreen,
                                    arguments: cubit.allShiftsModel!.data!
                                        .shifts![index].id,
                                  )
                                : showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return PopUpMeassage(
                                          title: 'restore',
                                          body: 'shift',
                                          onPressed: () {
                                            cubit.restoreDeletedShift(
                                              cubit.allShiftsDeletedModel!
                                                  .data![index].id!,
                                            );
                                          });
                                    });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Icon(
                              cubit.selectedIndex == 0
                                  ? Icons.mode_edit_outlined
                                  : Icons.replay_outlined,
                              color: AppColor.primaryColor,
                            ),
                          ))
                      : SizedBox.shrink(),
                  role == 'Admin'
                      ? InkWell(
                          onTap: () {
                            cubit.selectedIndex == 0
                                ? showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return PopUpMeassage(
                                          title: 'delete',
                                          body: 'shift',
                                          onPressed: () {
                                            cubit.shiftDelete(cubit
                                                .allShiftsModel!
                                                .data!
                                                .shifts![index]
                                                .id!);
                                          });
                                    })
                                : showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return PopUpMeassage(
                                          title: 'delete',
                                          body: 'shift',
                                          onPressed: () {
                                            cubit.forcedDeletedShift(cubit
                                                .allShiftsDeletedModel!
                                                .data![index]
                                                .id!);
                                          });
                                    });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Icon(
                              IconBroken.delete,
                              color: Colors.red,
                            ),
                          ))
                      : SizedBox.shrink(),
                ],
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
                          text: cubit.selectedIndex == 0
                              ? cubit.allShiftsModel!.data!.shifts![index]
                                  .startTime!
                              : cubit.allShiftsDeletedModel!.data![index]
                                  .startTime!,
                          style: TextStyles.font12GreyRegular,
                        ),
                        TextSpan(
                          text: '  -  ',
                          style: TextStyles.font12GreyRegular,
                        ),
                        TextSpan(
                          text: cubit.selectedIndex == 0
                              ? cubit
                                  .allShiftsModel!.data!.shifts![index].endTime!
                              : cubit
                                  .allShiftsDeletedModel!.data![index].endTime!,
                          style: TextStyles.font12GreyRegular,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              verticalSpace(20),
              Row(
                children: [
                  Icon(
                    IconBroken.calendar,
                    color: AppColor.primaryColor,
                    size: 22.sp,
                  ),
                  horizontalSpace(5),
                  Text(
                    cubit.selectedIndex == 0
                        ? cubit.allShiftsModel!.data!.shifts![index].startDate!
                        : cubit.allShiftsDeletedModel!.data![index].startDate!,
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
                    cubit.selectedIndex == 0
                        ? cubit.allShiftsModel!.data!.shifts![index].endDate!
                        : cubit.allShiftsDeletedModel!.data![index].endDate!,
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
