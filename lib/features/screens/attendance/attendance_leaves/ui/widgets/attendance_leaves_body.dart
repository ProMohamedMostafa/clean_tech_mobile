import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/logic/attendance_leaves_cubit.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/logic/attendance_leaves_state.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/ui/widgets/attendance_leaves_filter_search_build.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/ui/widgets/attendance_leaves_list_details_build.dart';

class AttendanceLeavesBody extends StatefulWidget {
  const AttendanceLeavesBody({super.key});

  @override
  State<AttendanceLeavesBody> createState() => _AttendanceLeavesBodyState();
}

class _AttendanceLeavesBodyState extends State<AttendanceLeavesBody> {
  //  @override
  // void initState() {
  //   context.read<AttendanceLeavesCubit>()
  //     ..getAllHistory()
  //     ..getRole();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaves'),
        leading: customBackButton(context),
      ),
      body: BlocConsumer<AttendanceLeavesCubit, AttendanceLeavesState>(
        listener: (context, state) {},
        builder: (context, state) {
          //  if (context
          //         .read<AttendanceLeavesCubit>()
          //         .attendanceHistoryModel
          //         ?.data ==
          //     null) {
          //   return Center(
          //     child: CircularProgressIndicator(
          //       color: AppColor.primaryColor,
          //     ),
          //   );
          // }
          return SafeArea(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: attendanceLeavesFilterAndSearchBuild(
                      context, context.read<AttendanceLeavesCubit>()),
                ),
                verticalSpace(15),
                attendanceLeavesListDetailsBuild(context),
                verticalSpace(30)
              ],
            ),
          ));
        },
      ),
    );
  }
}
