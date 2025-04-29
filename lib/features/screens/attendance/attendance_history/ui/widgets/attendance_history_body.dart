import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/logic/attendance_history_cubit.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/logic/attendance_history_state.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/ui/widgets/attendance_history_filter_search_build.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/ui/widgets/attendance_history_list_details_build.dart';

class AttendanceHistoryBody extends StatelessWidget {
  const AttendanceHistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        leading: customBackButton(context),
      ),
      body: BlocBuilder<AttendanceHistoryCubit, AttendanceHistoryState>(
        builder: (context, state) {
          return Skeletonizer(
            enabled: context
                    .read<AttendanceHistoryCubit>()
                    .attendanceHistoryModel
                    ?.data ==
                null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(10),
                  FilterAndSearchWidget(),
                  verticalSpace(10),
                  Divider(color: Colors.grey[300]),
                  Expanded(
                    child: state is HistoryLoadingState &&
                            (context
                                    .read<AttendanceHistoryCubit>()
                                    .attendanceHistoryModel ==
                                null)
                        ? Center(
                            child: CircularProgressIndicator(
                                color: AppColor.primaryColor))
                        : attendanceHistoryListDetailsBuild(context),
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
