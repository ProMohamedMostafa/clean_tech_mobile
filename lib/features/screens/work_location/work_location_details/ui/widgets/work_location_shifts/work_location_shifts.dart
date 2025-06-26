import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/logic/cubit/work_location_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/ui/widgets/work_location_shifts/work_location_list_item_shift.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class WorkLocationShifts extends StatelessWidget {
  final int selectedIndex;
  const WorkLocationShifts({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkLocationDetailsCubit>();
    final shiftsData = selectedIndex == 0
        ? null
        : selectedIndex == 1
            ? null
            : selectedIndex == 2
                ? cubit.organizationUsersShiftDetailsModel!.data!.shifts
                : selectedIndex == 3
                    ? cubit.buildingUsersShiftDetailsModel!.data!.shifts
                    : selectedIndex == 4
                        ? cubit.floorUsersShiftDetailsModel!.data!.shifts
                        : selectedIndex == 5
                            ? cubit.sectionUsersShiftDetailsModel!.data!.shifts
                            : null;

    if (shiftsData == null || shiftsData.isEmpty) {
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
        itemCount: shiftsData.length,
        separatorBuilder: (context, index) {
          return verticalSpace(10);
        },
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WorkLocationListItemShift(
                  selectedIndex: selectedIndex, index: index),
            ],
          );
        },
      );
    }
  }
}
