import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_details/logic/cubit/user_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_details/ui/widgets/tasks/task_list_item_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class UserTasksDetails extends StatelessWidget {
  const UserTasksDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(10),
        Expanded(child: _buildUserTaskDetails(context)),
      ],
    );
  }

  Widget _buildUserTaskDetails(BuildContext context) {
    final cubit = context.read<UserDetailsCubit>();
    final taskModel = cubit.userTaskDetailsModel;

    if (taskModel == null ||
        taskModel.data?.data == null ||
        taskModel.data!.data!.isEmpty) {
      return Center(
        child: Text(
          S.of(context).noData,
          style: TextStyles.font13Blackmedium,
        ),
      );
    }

    return ListView.separated(
      controller: cubit.scrollController,
      physics: const BouncingScrollPhysics(),
      itemCount: taskModel.data!.data!.length,
      separatorBuilder: (context, index) => verticalSpace(10),
      itemBuilder: (context, index) {
        return TaskCardItem(index: index);
      },
    );
  }
}
