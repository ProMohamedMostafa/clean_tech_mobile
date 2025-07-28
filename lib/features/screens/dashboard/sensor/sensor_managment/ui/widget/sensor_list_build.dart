import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/sensor/sensor_managment/logic/cubit/sensor_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/sensor/sensor_managment/ui/widget/build_sensor_item_list.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class SensorListBuild extends StatelessWidget {
  const SensorListBuild({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SensorCubit>();
    final sensorData = cubit.selectedIndex == 0
        ? cubit.sensorModel?.data?.data
        : cubit.deletedSensorListModel?.data;

    if (sensorData == null || sensorData.isEmpty) {
      return Center(
        child: Text(
          S.of(context).noData,
          style: TextStyles.font13Blackmedium,
        ),
      );
    } else {
      return ListView.separated(
        controller: cubit.selectedIndex == 0 ? cubit.scrollController : null,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: sensorData.length,
        separatorBuilder: (context, index) {
          return verticalSpace(10);
        },
        itemBuilder: (context, index) {
          return BuildSensorItemList(index: index);
        },
      );
    }
  }
}
