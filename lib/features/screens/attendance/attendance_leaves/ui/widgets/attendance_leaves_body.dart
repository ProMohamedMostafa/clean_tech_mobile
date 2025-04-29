import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/floating_action_button/floating_action_button.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/logic/attendance_leaves_cubit.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/logic/attendance_leaves_state.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/ui/widgets/attendance_leaves_filter_search_build.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/ui/widgets/attendance_leaves_list_details_build.dart';

class AttendanceLeavesBody extends StatelessWidget {
  const AttendanceLeavesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final AttendanceLeavesCubit cubit = context.read<AttendanceLeavesCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Leaves'),
        leading: customBackButton(context),
      ),
      floatingActionButton: floatingActionButton(
        icon: Icons.assignment_add,
        onPressed: () {
          context.pushNamed(Routes.createleavesScreen);
        },
      ),
      body: BlocConsumer<AttendanceLeavesCubit, AttendanceLeavesState>(
        listener: (context, state) {
          if (state is LeavesErrorState || state is LeavesDeleteErrorState) {
            final errorMessage = state is LeavesErrorState
                ? state.error
                : (state as LeavesDeleteErrorState).error;
            toast(text: errorMessage, color: Colors.red);
          }

          if (state is LeavesDeleteSuccessState) {
            toast(text: state.message, color: Colors.blue);
            cubit.getAllLeaves();
          }
        },
        builder: (context, state) {
          return Skeletonizer(
            enabled: cubit.attendanceLeavesModel == null,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(10),
                  FilterAndSearchWidget(),
                  verticalSpace(10),
                  Divider(color: Colors.grey[300]),
                  Expanded(
                    child: state is LeavesLoadingState &&
                            (context
                                    .read<AttendanceLeavesCubit>()
                                    .attendanceLeavesModel ==
                                null)
                        ? Center(
                            child: CircularProgressIndicator(
                                color: AppColor.primaryColor))
                        : attendanceLeavesListDetailsBuild(context),
                  ),
                  verticalSpace(10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
