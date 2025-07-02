import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/filter/logic/cubit/filter_dialog_cubit.dart';
import 'package:smart_cleaning_application/core/widgets/filter/ui/screen/filter_dialog_widget.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/logic/cubit/work_location_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/ui/widgets/work_location_tasks/work_location_task_item.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class WorkLocationTasks extends StatelessWidget {
  final int selectedIndex;
  const WorkLocationTasks({super.key, required this.selectedIndex});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          verticalSpace(5),
          _buildFilterHeader(context),
          verticalSpace(10),
          _buildWorklocationTaskDetails(context),
        ],
      ),
    );
  }

  Widget _buildFilterHeader(BuildContext context) {
    final cubit = context.read<WorkLocationDetailsCubit>();

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
              // showDialog(
              //   context: context,
              //   builder: (dialogContext) {
              //     return BlocProvider(
              //         create: (context) => FilterDialogCubit()
              //           ..getArea()
              //           ..getUsers()
              //           ..getDevices(),
              //         child: FilterDialogWidget(
              //           index: 'TU',
              //           onPressed: (data) {
              //             cubit.taskFilterModel = data;
              //             cubit.getWorklocationTaskDetails(selectedIndex == 0
              //                 ? cubit.areaUsersDetailsModel!.data!.id
              //                 : selectedIndex == 1
              //                     ? cubit.cityUsersDetailsModel!.data!.id
              //                     : selectedIndex == 2
              //                         ? cubit
              //                             .organizationUsersShiftDetailsModel!
              //                             .data!
              //                             .id
              //                         : selectedIndex == 3
              //                             ? cubit
              //                                 .buildingUsersShiftDetailsModel!
              //                                 .data!
              //                                 .id
              //                             : selectedIndex == 4
              //                                 ? cubit
              //                                     .floorUsersShiftDetailsModel!
              //                                     .data!
              //                                     .id
              //                                 : selectedIndex == 5
              //                                     ? cubit
              //                                         .sectionUsersShiftDetailsModel!
              //                                         .data!
              //                                         .id
              //                                     : cubit
              //                                         .pointUsersDetailsModel!
              //                                         .data!
              //                                         .id);
              //           },
              //         ));
              //   },
              // );
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

  Widget _buildWorklocationTaskDetails(BuildContext context) {
    final cubit = context.read<WorkLocationDetailsCubit>();
    final taskModel = selectedIndex == 0
        ? cubit.allAreaTasksModel
        : selectedIndex == 1
            ? cubit.allCityTasksModel
            : selectedIndex == 2
                ? cubit.allOrganizationTasksModel
                : selectedIndex == 3
                    ? cubit.allBuildingTasksModel
                    : selectedIndex == 4
                        ? cubit.allFloorTasksModel
                        : selectedIndex == 5
                            ? cubit.allSectionTasksModel
                            : cubit.allPointTasksModel;

    if (taskModel?.data?.data == null || taskModel!.data!.data!.isEmpty) {
      return Center(
        child: Text(
          S.of(context).noData,
          style: TextStyles.font13Blackmedium,
        ),
      );
    } else {
      return ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: taskModel.data!.data!.length,
        separatorBuilder: (context, index) {
          return verticalSpace(10);
        },
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WorkLocationTaskItem(selectedIndex: selectedIndex, index: index),
            ],
          );
        },
      );
    }
  }
}
