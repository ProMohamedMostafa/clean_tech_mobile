import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/logic/attendance_history_cubit.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/logic/attendance_history_state.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/ui/widgets/attendance_history_filter_search_build.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_history/ui/widgets/attendance_history_list_details_build.dart';

class AttendanceHistoryBody extends StatefulWidget {
  const AttendanceHistoryBody({super.key});

  @override
  State<AttendanceHistoryBody> createState() => _AttendanceHistoryBodyState();
}

class _AttendanceHistoryBodyState extends State<AttendanceHistoryBody> {
  @override
  void initState() {
    context.read<AttendanceHistoryCubit>().getAllHistory();
    context.read<AttendanceHistoryCubit>().getAllArea();
    context.read<AttendanceHistoryCubit>().getProviders();
    context.read<AttendanceHistoryCubit>().getRole();
    context.read<AttendanceHistoryCubit>().getShifts();
    context.read<AttendanceHistoryCubit>().getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        leading: customBackButton(context),
      ),
      body: BlocBuilder<AttendanceHistoryCubit, AttendanceHistoryState>(
        builder: (context, state) {
          if (context
                  .read<AttendanceHistoryCubit>()
                  .attendanceHistoryModel
                  ?.data ==
              null) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ),
            );
          }
          return SafeArea(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: attendanceHistoryFilterAndSearchBuild(
                      context, context.read<AttendanceHistoryCubit>()),
                ),
                verticalSpace(15),
                attendanceHistoryListDetailsBuild(context),
                verticalSpace(30)
              ],
            ),
          ));
        },
      ),
    );
  }
}
