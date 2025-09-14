import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/devices_management/logic/cubit/devices_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/devices_management/ui/widgets/devices_list_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class DevicesBody extends StatelessWidget {
  const DevicesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DevicesCubit>();

    return Scaffold(
        appBar: AppBar(
          leading: CustomBackButton(),
          title: Text(S.of(context).devices),
        ),
        floatingActionButton: floatingActionButton(
          icon: Icons.add_to_queue_rounded,
          onPressed: () async {
            final result = await context.pushNamed(Routes.addDevicesScreen);

            if (result == true) {
              cubit.refresh();
            }
          },
        ),
        body: BlocConsumer<DevicesCubit, DevicesState>(
          listener: (context, state) {
            if (state is ForceDeleteDeviceSuccessState) {
              toast(text: state.message, isSuccess: true);
              cubit.refresh();
            }
            if (state is ForceDeleteDeviceErrorState) {
              toast(text: state.error, isSuccess: false);
            }
          },
          builder: (context, state) {
            return Skeletonizer(
              enabled: cubit.devicesModel == null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FilterAndSearchWidget(
                      hintText: S.of(context).find_device,
                      searchController: cubit.searchController,
                      onSearchChanged: (value) {
                        cubit.getDevices();
                      },
                      onFilterTap: () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return BlocProvider(
                              create: (context) =>
                                  FilterDialogCubit()..getSection(),
                              child: FilterDialogWidget(
                                index: 'De',
                                onPressed: (data) {
                                  cubit.filterModel = data;
                                  cubit.getDevices();
                                },
                              ),
                            );
                          },
                        );
                      },
                      isFilterActive: cubit.filterModel != null,
                      onClearFilter: () {
                        cubit.filterModel = null;
                        cubit.searchController.clear();
                        cubit.getDevices();
                      },
                    ),
                  ),
                  verticalSpace(10),
                  Expanded(child: DeviceListBuild()),
                  verticalSpace(10),
                ],
              ),
            );
          },
        ));
  }
}
