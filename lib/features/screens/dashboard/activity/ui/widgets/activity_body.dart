import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/filter/logic/cubit/filter_dialog_cubit.dart';
import 'package:smart_cleaning_application/core/widgets/filter/ui/screen/filter_dialog_widget.dart';
import 'package:smart_cleaning_application/core/widgets/filter_and_search_build/filter_search_build.dart';
import 'package:smart_cleaning_application/core/widgets/integration_buttons/integrations_buttons.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/activity/logic/activity_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/activity/logic/activity_state.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/activity/ui/widgets/activity_list_details_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ActivityBody extends StatelessWidget {
  const ActivityBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ActivityCubit>();

    return Scaffold(
      appBar: AppBar(
          title: Text(S.of(context).activities), leading: CustomBackButton()),
      body: BlocConsumer<ActivityCubit, ActivityState>(
        listener: (context, state) {
          if (state is ActivityErrorState) {
            toast(text: state.error.toString(), isSuccess: false);
          }
        },
        builder: (context, state) {
          final isLoading = cubit.myActivities == null ||
              (role != 'Cleaner' && cubit.teamActivities == null);

          return Skeletonizer(
            enabled: isLoading,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(10),
                  FilterAndSearchWidget(
                    hintText: S.of(context).findActivity,
                    searchController: cubit.searchController,
                    onSearchChanged: (value) {
                      if (cubit.selectedIndex == 0) {
                        cubit.myCurrentPage = 1;
                        cubit.myActivities = null;
                        cubit.getActivities();
                      } else {
                        cubit.teamCurrentPage = 1;
                        cubit.teamActivities = null;
                        cubit.getTeamActivities();
                      }
                    },
                    onFilterTap: () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return BlocProvider(
                            create: (context) => FilterDialogCubit()
                              ..getRole()
                              ..getUsers(),
                            child: FilterDialogWidget(
                              index: 'A',
                              onPressed: (data) {
                                if (cubit.selectedIndex == 0) {
                                  cubit.filterModel = data;
                                  cubit.myCurrentPage = 1;
                                  cubit.myActivities = null;
                                  cubit.getActivities();
                                } else {
                                  cubit.teamFilterModel = data;
                                  cubit.teamCurrentPage = 1;
                                  cubit.teamActivities = null;
                                  cubit.getTeamActivities();
                                }
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
                    onTap: cubit.changeTap,
                    firstLabel: S.of(context).myActivities,
                    secondLabel: role != 'Cleaner'
                        ? S.of(context).myTeamActivities
                        : null,
                  ),
                  verticalSpace(5),
                  Divider(color: Colors.grey[300]),
                  Expanded(
                    child: ActivityListDetailsBuild(),
                  ),
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
