import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/filter/logic/cubit/filter_dialog_cubit.dart';
import 'package:smart_cleaning_application/core/widgets/filter/ui/screen/filter_dialog_widget.dart';
import 'package:smart_cleaning_application/core/widgets/filter_and_search_build/filter_search_build.dart';
import 'package:smart_cleaning_application/core/widgets/integration_buttons/integrations_buttons.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/sensor/sensor_managment/logic/cubit/sensor_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/sensor/sensor_managment/ui/widget/sensor_list_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class SensorBody extends StatelessWidget {
  const SensorBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SensorCubit>();
    return Scaffold(
      appBar: AppBar(
          title: Text(S.of(context).integ9), leading: CustomBackButton()),
      body: BlocConsumer<SensorCubit, SensorState>(
        listener: (context, state) {
          if (state is RestoreSensorSuccessState) {
            toast(text: state.message, isSuccess: true);
          }
          if (state is RestoreSensorErrorState) {
            toast(text: state.error, isSuccess: false);
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
                  FilterAndSearchWidget(
                    hintText: S.of(context).sensorHint,
                    searchController: cubit.searchController,
                    onSearchChanged: (value) {
                      cubit.getSensorsData();
                    },
                    onFilterTap: () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return BlocProvider(
                            create: (context) => FilterDialogCubit()
                              ..getCity()
                              ..getActivityType(),
                            child: FilterDialogWidget(
                              index: 'Se',
                              onPressed: (data) {
                                cubit.filterModel = data;
                                cubit.getSensorsData();
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                  verticalSpace(10),
                  integrationsButtons(
                    selectedIndex: cubit.selectedIndex,
                    onTap: (index) => cubit.changeTap(index),
                    firstCount: cubit.sensorModel?.data?.totalCount ?? 0,
                    firstLabel: S.of(context).sensorFirstLabel,
                    secondCount:
                        cubit.deletedSensorListModel?.data?.length ?? 0,
                    secondLabel: S.of(context).sensorSecondLabel,
                  ),
                  verticalSpace(10),
                  Divider(color: Colors.grey[300], height: 0),
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
