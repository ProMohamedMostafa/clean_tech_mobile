import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history_management/logic/attendance_history_cubit.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history_management/logic/attendance_history_state.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history_management/ui/widgets/attendance_history_filter_search_build.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history_management/ui/widgets/attendance_history_list_details_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AttendanceHistoryBody extends StatelessWidget {
  const AttendanceHistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AttendanceHistoryCubit>();
    return Scaffold(
      appBar: AppBar(
          title: Text(S.of(context).history), leading: CustomBackButton()),
      body: BlocBuilder<AttendanceHistoryCubit, AttendanceHistoryState>(
        builder: (context, state) {
          return Skeletonizer(
            enabled: cubit.attendanceHistoryModel == null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(10),
                  FilterAndSearchWidget(),
                  verticalSpace(5),
                  Divider(color: Colors.grey[300]),
                  verticalSpace(5),
                  Expanded(child: AttendanceHistoryListBuild()),
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
