import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/logic/shift_cubit.dart';

Widget listItemBuild(BuildContext context, selectedIndex, index) {
  return InkWell(
    onTap: () {
      context.pushNamed(Routes.shiftDetailsScreen,
          arguments: context
              .read<ShiftCubit>()
              .allShiftsModel!
              .data!
              .shifts![index]
              .id);
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
                  selectedIndex == 0
                      ? context
                          .read<ShiftCubit>()
                          .allShiftsModel!
                          .data!
                          .shifts![index]
                          .name!
                      : context
                          .read<ShiftCubit>()
                          .allShiftsDeletedModel!
                          .data![index]
                          .name!,
                  style: TextStyles.font16BlackSemiBold,
                ),
                Spacer(),
                InkWell(
                    onTap: () {
                      selectedIndex == 0
                          ? context.pushNamed(
                              Routes.editShiftScreen,
                              arguments: context
                                  .read<ShiftCubit>()
                                  .allShiftsModel!
                                  .data!
                                  .shifts![index]
                                  .id,
                            )
                          : showCustomDialog(
                              context, "Are you Sure to restore this shift ?",
                              () {
                              context.read<ShiftCubit>().restoreDeletedShift(
                                    context
                                        .read<ShiftCubit>()
                                        .allShiftsDeletedModel!
                                        .data![index]
                                        .id!,
                                  );
                              context.pop();
                            });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Icon(
                        selectedIndex == 0
                            ? Icons.mode_edit_outlined
                            : Icons.replay_outlined,
                        color: AppColor.thirdColor,
                      ),
                    )),
                InkWell(
                    onTap: () {
                      selectedIndex == 0
                          ? showCustomDialog(
                              context, "Are you Sure to delete this shift ?",
                              () {
                              context.read<ShiftCubit>().shiftDelete(context
                                  .read<ShiftCubit>()
                                  .allShiftsModel!
                                  .data!
                                  .shifts![index]
                                  .id!);
                              context.pop();
                            })
                          : showCustomDialog(
                              context, "Forced Delete this shift", () {
                              context.read<ShiftCubit>().forcedDeletedShift(
                                  context
                                      .read<ShiftCubit>()
                                      .allShiftsDeletedModel!
                                      .data![index]
                                      .id!);
                              context.pop();
                            });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Icon(
                        IconBroken.delete,
                        color: AppColor.thirdColor,
                      ),
                    )),
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
                        text: selectedIndex == 0
                            ? context
                                .read<ShiftCubit>()
                                .allShiftsModel!
                                .data!
                                .shifts![index]
                                .startTime!
                            : context
                                .read<ShiftCubit>()
                                .allShiftsDeletedModel!
                                .data![index]
                                .startTime!,
                        style: TextStyles.font12GreyRegular,
                      ),
                      TextSpan(
                        text: '  -  ',
                        style: TextStyles.font12GreyRegular,
                      ),
                      TextSpan(
                        text: selectedIndex == 0
                            ? context
                                .read<ShiftCubit>()
                                .allShiftsModel!
                                .data!
                                .shifts![index]
                                .endTime!
                            : context
                                .read<ShiftCubit>()
                                .allShiftsDeletedModel!
                                .data![index]
                                .endTime!,
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
                  selectedIndex == 0
                      ? context
                          .read<ShiftCubit>()
                          .allShiftsModel!
                          .data!
                          .shifts![index]
                          .startDate!
                      : context
                          .read<ShiftCubit>()
                          .allShiftsDeletedModel!
                          .data![index]
                          .startDate!,
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
                  selectedIndex == 0
                      ? context
                          .read<ShiftCubit>()
                          .allShiftsModel!
                          .data!
                          .shifts![index]
                          .endDate!
                      : context
                          .read<ShiftCubit>()
                          .allShiftsDeletedModel!
                          .data![index]
                          .endDate!,
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
