import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_leaves_management/logic/attendance_leaves_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_leaves_management/ui/widgets/pop_up_dialog.dart';

class LeavesListItemBuild extends StatelessWidget {
  final int index;
  const LeavesListItemBuild({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AttendanceLeavesCubit>();

    final leavesList = cubit.selectedIndex == 0
        ? cubit.allLeaves?.data?.leaves
        : cubit.selectedIndex == 1
            ? cubit.pendingLeaves?.data?.leaves
            : cubit.selectedIndex == 2
                ? cubit.rejectedLeaves?.data?.leaves
                : cubit.approvedLeaves?.data?.leaves;

    if (leavesList == null || index >= leavesList.length) {
      return const SizedBox();
    }

    final item = leavesList[index];

    return InkWell(
      onTap: () async {
        final result = await context.pushNamed(
          Routes.leavesDetailsScreen,
          arguments: item.id!,
        );
        if (result == true) {
          await cubit.refreshLeaves();
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
          padding: EdgeInsets.fromLTRB(10, 0, 5, 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(11.r),
            border: Border.all(color: AppColor.secondaryColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _statusChip(
                      text: item.type!,
                      color: Color(0xffF6DCDF),
                      textColor: Colors.red),
                  horizontalSpace(5),
                  if (item.status != null)
                    _statusChip(
                        text: item.status!,
                        color: Colors.grey[300]!,
                        textColor: AppColor.primaryColor),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      PopUpDialog.show(
                        context: context,
                        id: item.id!,
                      );
                    },
                    icon: Icon(Icons.more_horiz_rounded, size: 22.sp),
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: item.userName!,
                        style: TextStyles.font16BlackSemiBold),
                    TextSpan(
                        text: ' ( ${item.role} )',
                        style: TextStyles.font12PrimSemi),
                  ],
                ),
              ),
              verticalSpace(10),
              Text(
                item.reason ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyles.font11GreyMedium,
              ),
              verticalSpace(10),
              Row(
                children: [
                  Icon(IconBroken.calendar,
                      color: AppColor.primaryColor, size: 22.sp),
                  horizontalSpace(5),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: item.startDate ?? '',
                          style: TextStyles.font11WhiteSemiBold
                              .copyWith(color: AppColor.primaryColor),
                        ),
                        TextSpan(
                            text: '  :  ', style: TextStyles.font14GreyRegular),
                        TextSpan(
                          text: item.endDate ?? '',
                          style: TextStyles.font11WhiteSemiBold
                              .copyWith(color: AppColor.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  CircleAvatar(
                    radius: 15.r,
                    backgroundImage:
                        item.image != null && item.image!.isNotEmpty
                            ? NetworkImage(item.image!)
                            : AssetImage('assets/images/person.png')
                                as ImageProvider,
                  ),
                  horizontalSpace(5),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusChip(
      {required String text, required Color color, required Color textColor}) {
    return Container(
      height: 23.h,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyles.font11WhiteSemiBold.copyWith(color: textColor),
        ),
      ),
    );
  }
}
