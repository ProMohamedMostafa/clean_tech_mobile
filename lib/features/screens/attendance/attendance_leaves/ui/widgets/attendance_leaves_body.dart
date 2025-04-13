import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
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
  @override
  void initState() {
    context.read<AttendanceLeavesCubit>().initialize();

    context.read<AttendanceLeavesCubit>()
      ..getAllLeaves()
      ..getRole()
      ..getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttendanceLeavesCubit, AttendanceLeavesState>(
      listener: (context, state) {
        if (state is LeavesDeleteSuccessState) {
          toast(text: state.message, color: Colors.blue);
          context.read<AttendanceLeavesCubit>()
            ..getAllLeaves()
            ..getRole();
        }
        if (state is LeavesDeleteErrorState) {
          toast(text: state.error, color: Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Leaves'),
            leading: customBackButton(context),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: SizedBox(
              height: 57.h,
              width: 57.w,
              child: ElevatedButton(
                onPressed: () {
                  context.pushNamed(Routes.createleavesScreen);
                },
                style: ElevatedButton.styleFrom(
                  padding: REdgeInsets.all(0),
                  backgroundColor: AppColor.primaryColor,
                  shape: CircleBorder(),
                  side: BorderSide(
                    color: AppColor.secondaryColor,
                    width: 1.w,
                  ),
                ),
                child: Icon(
                  Icons.assignment_add,
                  color: Colors.white,
                  size: 28.sp,
                ),
              ),
            ),
          ),
          body: BlocConsumer<AttendanceLeavesCubit, AttendanceLeavesState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Skeletonizer(
                enabled: context
                        .read<AttendanceLeavesCubit>()
                        .attendanceLeavesModel ==
                    null,
                child: SafeArea(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: attendanceLeavesFilterAndSearchBuild(
                          context, context.read<AttendanceLeavesCubit>()),
                    ),
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
                )),
              );
            },
          ),
        );
      },
    );
  }
}
