import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/filter/logic/cubit/filter_dialog_cubit.dart';
import 'package:smart_cleaning_application/core/widgets/filter/ui/screen/filter_dialog_widget.dart';
import 'package:smart_cleaning_application/features/screens/profile/logic/profile_cubit.dart';
import 'package:smart_cleaning_application/features/screens/profile/ui/widgets/tasks/task_list_item_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class UserTasksDetails extends StatelessWidget {
  const UserTasksDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          verticalSpace(5),
          _buildFilterHeader(context),
          verticalSpace(10),
          _buildUserTaskDetails(context),
        ],
      ),
    );
  }

  Widget _buildFilterHeader(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

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
                      create: (context) => FilterDialogCubit()
                        ..getArea()
                        ..getUsers()
                        ..getDevices(),
                      child: FilterDialogWidget(
                        index: 'TU',
                        onPressed: (data) {
                          cubit.taskFilterModel = data;
                          cubit.getUserTaskDetails();
                        },
                      ));
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

  Widget _buildUserTaskDetails(BuildContext context) {
    final taskModel = context.read<ProfileCubit>().userTaskDetailsModel!;

    if (taskModel.data!.data == null || taskModel.data!.data!.isEmpty) {
      return Center(
        child: Text(
          S.of(context).noData,
          style: TextStyles.font13Blackmedium,
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: taskModel.data!.data!.length,
      separatorBuilder: (context, index) {
        return verticalSpace(10);
      },
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TaskCardItem(index: index),
          ],
        );
      },
    );
  }
}
