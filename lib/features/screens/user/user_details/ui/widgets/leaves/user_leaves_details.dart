import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/filter/logic/cubit/filter_dialog_cubit.dart';
import 'package:smart_cleaning_application/core/widgets/filter/ui/screen/filter_dialog_widget.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/logic/cubit/user_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/leaves/leaves_list_item_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class UserLeavesDetails extends StatelessWidget {
  const UserLeavesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          verticalSpace(5),
          _buildFilterHeader(context),
          verticalSpace(10),
          _buildLeavesContent(context),
        ],
      ),
    );
  }

  Widget _buildFilterHeader(BuildContext context) {
    final cubit = context.read<UserDetailsCubit>();
    return SizedBox(
      height: 45.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).Filter,
            style: TextStyles.font16BlackSemiBold,
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return BlocProvider(
                    create: (context) => FilterDialogCubit()..getArea(),
                    child: FilterDialogWidget(
                      index: 'A-lU',
                      onPressed: (data) {
                        cubit.leavesFilterModel = data;
                        cubit.getAllLeaves(cubit.userDetailsModel!.data!.id);
                      },
                    ),
                  );
                },
              );
            },
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColor.secondaryColor),
              ),
              child: Icon(
                Icons.tune,
                color: AppColor.primaryColor,
                size: 25.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeavesContent(BuildContext context) {
    final attendanceData =
        context.read<UserDetailsCubit>().attendanceLeavesModel?.data?.leaves;
    if (attendanceData == null || attendanceData.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Text(
            S.of(context).noData,
            style: TextStyles.font13Blackmedium,
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: attendanceData.length,
      separatorBuilder: (context, index) => verticalSpace(10),
      itemBuilder: (context, index) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BuildLeavesCardItem(index: index),
        ],
      ),
    );
  }
}
