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
import 'package:smart_cleaning_application/features/screens/dashboard/shift/shifts_management/logic/shift_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ListShiftItemBuild extends StatelessWidget {
  final int index;
  const ListShiftItemBuild({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShiftCubit>();

    return InkWell(
      borderRadius: BorderRadius.circular(11.r),
      onTap: () async {
        if (cubit.selectedIndex == 0) {
          final result = await context.pushNamed(Routes.shiftDetailsScreen,
              arguments: cubit.allShiftsModel!.data!.data![index].id);

          if (result == true) {
            await cubit.refreshShifts();
          }
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
                  Text(
                    cubit.selectedIndex == 0
                        ? cubit.allShiftsModel!.data!.data![index].name!
                        : cubit.allShiftsDeletedModel!.data![index].name!,
                    style: TextStyles.font16BlackSemiBold,
                  ),
                  Spacer(),
                  role == 'Admin'
                      ? InkWell(
                          onTap: () async {
                            if (cubit.selectedIndex == 0) {
                              final result = await context.pushNamed(
                                Routes.editShiftScreen,
                                arguments: cubit
                                    .allShiftsModel!.data!.data![index].id,
                              );

                              if (result == true) {
                                await cubit.refreshShifts();
                              }
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (dialogContext) {
                                    return PopUpMessage(
                                        title: S.of(context).TitleRestore,
                                        body: S.of(context).shiftBody,
                                        onPressed: () {
                                          cubit.restoreDeletedShift(
                                            cubit.allShiftsDeletedModel!
                                                .data![index].id!,
                                          );
                                        });
                                  });
                            }
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
                                      return PopUpMessage(
                                          title: S.of(context).TitleDelete,
                                          body: S.of(context).shiftBody,
                                          onPressed: () {
                                            cubit.shiftDelete(cubit
                                                .allShiftsModel!
                                                .data!
                                                .data![index]
                                                .id!);
                                          });
                                    })
                                : showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return PopUpMessage(
                                          title: S.of(context).TitleDelete,
                                          body: S.of(context).shiftBody,
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
                              ? cubit.allShiftsModel!.data!.data![index]
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
                                  .allShiftsModel!.data!.data![index].endTime!
                              : cubit
                                  .allShiftsDeletedModel!.data![index].endTime!,
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
                    cubit.selectedIndex == 0
                        ? cubit.allShiftsModel!.data!.data![index].startDate!
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
                        ? cubit.allShiftsModel!.data!.data![index].endDate!
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
