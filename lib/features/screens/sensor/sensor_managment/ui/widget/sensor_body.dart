import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/two_buttons_in_integreat_screen/two_buttons_in_integration_screen.dart';
import 'package:smart_cleaning_application/features/screens/sensor/sensor_managment/logic/cubit/sensor_cubit.dart';
import 'package:smart_cleaning_application/features/screens/sensor/sensor_managment/ui/widget/filter_search_build.dart';
import 'package:smart_cleaning_application/features/screens/sensor/sensor_managment/ui/widget/sensor_list_build.dart';

class SensorBody extends StatelessWidget {
  const SensorBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SensorCubit>();
    return Scaffold(
      appBar: AppBar(title: Text('Sensor'), leading: customBackButton(context)),
      body: BlocConsumer<SensorCubit, SensorState>(
        listener: (context, state) {
          if (state is RestoreSensorSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }
          if (state is RestoreSensorErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          return Skeletonizer(
            enabled: (cubit.sensorModel == null &&
                cubit.deletedSensorListModel == null),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(10),
                  SensorFilterAndSearchWidget(),
                  verticalSpace(10),
                  twoButtonsIntegration(
                    selectedIndex: cubit.selectedIndex,
                    onTap: (index) => cubit.changeTap(index),
                    firstCount: cubit.sensorModel?.data?.totalCount ?? 0,
                    firstLabel: 'All sensors',
                    secondCount:
                        cubit.deletedSensorListModel?.data?.length ?? 0,
                    secondLabel: 'Deleted sensors',
                  ),
                  verticalSpace(10),
                  Divider(
                    color: Colors.grey[300],
                    height: 0,
                  ),
                  verticalSpace(10),
                  Expanded(child: SensorListBuild()),
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
