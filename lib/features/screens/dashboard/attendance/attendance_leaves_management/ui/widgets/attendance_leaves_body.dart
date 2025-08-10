import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/filter/logic/cubit/filter_dialog_cubit.dart';
import 'package:smart_cleaning_application/core/widgets/filter/ui/screen/filter_dialog_widget.dart';
import 'package:smart_cleaning_application/core/widgets/filter_and_search_build/filter_search_build.dart';
import 'package:smart_cleaning_application/core/widgets/floating_action_button/floating_action_button.dart';
import 'package:smart_cleaning_application/core/widgets/integration_buttons/integrations_buttons.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_leaves_management/logic/attendance_leaves_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_leaves_management/logic/attendance_leaves_state.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_leaves_management/ui/widgets/attendance_leaves_list_build.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_leaves_management/ui/widgets/pdf.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AttendanceLeavesBody extends StatelessWidget {
  const AttendanceLeavesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AttendanceLeavesCubit>();

    return Scaffold(
      appBar: AppBar(
          title: Text(S.of(context).leaves), leading: CustomBackButton(), actions: [
            IconButton(
              onPressed: () {
                createLeavesPDF(context);
              },
              icon: Icon(
                CupertinoIcons.tray_arrow_down,
                color: Colors.red,
                size: 22.sp,
              ),
            ),
            horizontalSpace(10)
          ]),
      floatingActionButton: floatingActionButton(
          icon: Icons.assignment_add,
          onPressed: () async {
            final result = await context.pushNamed(Routes.createleavesScreen);

            if (result == true) {
              cubit.refreshLeaves();
            }
          }),
      body: BlocConsumer<AttendanceLeavesCubit, AttendanceLeavesState>(
        listener: (context, state) {
          if (state is LeavesErrorState || state is LeavesDeleteErrorState) {
            final errorMessage = state is LeavesErrorState
                ? state.error
                : (state as LeavesDeleteErrorState).error;
            toast(text: errorMessage, isSuccess: false);
          }

          if (state is LeavesDeleteSuccessState) {
            toast(text: state.message, isSuccess: true);
            cubit.getAllLeaves();
          }
        },
        builder: (context, state) {
          final isLoading = cubit.allLeaves == null ||
              cubit.pendingLeaves == null ||
              cubit.rejectedLeaves == null ||
              cubit.approvedLeaves == null;
          return Skeletonizer(
            enabled: isLoading,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(10),
                  FilterAndSearchWidget(
                    hintText: S.of(context).findLeaves,
                    searchController: cubit.searchController,
                    onSearchChanged: (value) {
                      cubit.getAllLeaves();
                    },
                    onFilterTap: () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return BlocProvider(
                            create: (context) => FilterDialogCubit()
                              ..getArea()
                              ..getRole()
                              ..getProviders()
                              ..getUsers(),
                            child: FilterDialogWidget(
                              index: 'A-l',
                              onPressed: (data) {
                                cubit.filterModel = data;
                                cubit.getAllLeaves();
                              },
                            ),
                          );
                        },
                      );
                    },isFilterActive: cubit.filterModel != null,
                    onClearFilter: () {
                      cubit.filterModel = null;
                      cubit.searchController.clear();
                      cubit.getAllLeaves();
                    },
                  ),
                  verticalSpace(10),
                  integrationsButtons(
                    selectedIndex: cubit.selectedIndex,
                    onTap: (index) => cubit.changeTap(index),
                    firstLabel: S.of(context).all,
                    firstCount: cubit.allLeaves?.data?.totalCount ?? 0,
                    secondLabel: S.of(context).pending,
                    secondCount: cubit.pendingLeaves?.data?.totalCount ?? 0,
                    thirdLabel: S.of(context).reject,
                    thirdCount: cubit.rejectedLeaves?.data?.totalCount ?? 0,
                    fourthLabel: S.of(context).approved,
                    fourthCount: cubit.approvedLeaves?.data?.totalCount ?? 0,
                  ),
                  verticalSpace(10),
                  Divider(color: Colors.grey[300], height: 0),
                  verticalSpace(10),
                  Expanded(child: LeavesListBuild()),
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
