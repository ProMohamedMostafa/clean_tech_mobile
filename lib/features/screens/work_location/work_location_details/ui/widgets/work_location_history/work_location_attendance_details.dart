import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/filter/logic/cubit/filter_dialog_cubit.dart';
import 'package:smart_cleaning_application/core/widgets/filter/ui/screen/filter_dialog_widget.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/logic/cubit/work_location_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/ui/widgets/work_location_history/work_location_attendance_list_item_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class WorkLocationAttendanceDetails extends StatelessWidget {
  final int selectedIndex;
  const WorkLocationAttendanceDetails({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          verticalSpace(5),
          _buildFilterHeader(context),
          verticalSpace(10),
          _buildAttendanceList(context, selectedIndex),
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
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return BlocProvider(
                    create: (context) => FilterDialogCubit()
                      ..getArea()
                      ..getShifts(),
                    child: FilterDialogWidget(
                      index: 'A-hU',
                      onPressed: (data) {
                        // cubit.attendanceFilterModel = data;
                        // cubit.getAllHistory(selectedIndex == 0
                        //     ? cubit.areaUsersDetailsModel!.data!.id
                        //     : selectedIndex == 1
                        //         ? cubit.cityUsersDetailsModel!.data!.id
                        //         : selectedIndex == 2
                        //             ? cubit.organizationUsersShiftDetailsModel!
                        //                 .data!.id
                        //             : selectedIndex == 3
                        //                 ? cubit.buildingUsersShiftDetailsModel!
                        //                     .data!.id
                        //                 : selectedIndex == 4
                        //                     ? cubit.floorUsersShiftDetailsModel!
                        //                         .data!.id
                        //                     : selectedIndex == 5
                        //                         ? cubit
                        //                             .sectionUsersShiftDetailsModel!
                        //                             .data!
                        //                             .id
                        //                         : cubit.pointUsersDetailsModel!
                        //                             .data!.id);
                      },
                    ),
                  );
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

  Widget _buildAttendanceList(BuildContext context, int selectedIndex) {
    final cubit = context.read<WorkLocationDetailsCubit>();
    final attendanceData = selectedIndex == 0
        ? cubit.attendanceHistoryAreaModel?.data?.data
        : selectedIndex == 1
            ? cubit.attendanceHistoryCityModel?.data?.data
            : selectedIndex == 2
                ? cubit.attendanceHistoryOrganizationModel?.data?.data
                : selectedIndex == 3
                    ? cubit.attendanceHistoryBuildingModel?.data?.data
                    : selectedIndex == 4
                        ? cubit.attendanceHistoryFloorModel?.data?.data
                        : selectedIndex == 5
                            ? cubit.attendanceHistorySectionModel?.data?.data
                            : cubit.attendanceHistoryPointModel?.data?.data;

    if (attendanceData == null || attendanceData.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Text(
            S.of(context).noData,
            style: TextStyles.font13Blackmedium,
          ),
        ),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: attendanceData.length,
      separatorBuilder: (context, index) => verticalSpace(10),
      itemBuilder: (context, index) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          WorkLocationAttendanceListItemBuild(selectedIndex:selectedIndex, index: index),
        ],
      ),
    );
  }
}
