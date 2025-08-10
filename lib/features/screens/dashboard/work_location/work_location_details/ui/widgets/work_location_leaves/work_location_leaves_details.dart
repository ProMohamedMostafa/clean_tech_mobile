import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/logic/cubit/work_location_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/work_location_details/ui/widgets/work_location_leaves/work_location_leaves_list_item_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class WorkLocationLeavesDetails extends StatelessWidget {
  final int selectedIndex;
  const WorkLocationLeavesDetails({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
        
          verticalSpace(10),
          _buildLeavesContent(context, selectedIndex),
        ],
      ),
    );
  }

  

  Widget _buildLeavesContent(BuildContext context, int selectedIndex) {
    final cubit = context.read<WorkLocationDetailsCubit>();

    final attendanceData = selectedIndex == 0
        ? cubit.attendanceLeavesAreaModel?.data?.leaves
        : selectedIndex == 1
            ? cubit.attendanceLeavesCityModel?.data?.leaves
            : selectedIndex == 2
                ? cubit.attendanceLeavesOrganizationModel?.data?.leaves
                : selectedIndex == 3
                    ? cubit.attendanceLeavesBuildingModel?.data?.leaves
                    : selectedIndex == 4
                        ? cubit.attendanceLeavesFloorModel?.data?.leaves
                        : selectedIndex == 4
                            ? cubit.attendanceLeavesSectionModel?.data?.leaves
                            : cubit.attendanceLeavesPointModel?.data?.leaves;
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
          WorkLocationLeavesListItemBuild(
            index: index,
            selectedIndex: selectedIndex,
          ),
        ],
      ),
    );
  }
}
