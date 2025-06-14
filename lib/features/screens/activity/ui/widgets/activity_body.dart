import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/two_buttons_in_integreat_screen/two_buttons_in_integration_screen.dart';
import 'package:smart_cleaning_application/features/screens/activity/logic/activity_cubit.dart';
import 'package:smart_cleaning_application/features/screens/activity/logic/activity_state.dart';
import 'package:smart_cleaning_application/features/screens/activity/ui/widgets/activity_list_details_build.dart';
import 'package:smart_cleaning_application/features/screens/activity/ui/widgets/filter_search_build.dart';

class ActivityBody extends StatelessWidget {
  const ActivityBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ActivityCubit>();

    return Scaffold(
      appBar: AppBar(
          title: const Text('Activity'), leading: CustomBackButton()),
      body: BlocConsumer<ActivityCubit, ActivityState>(
        listener: (context, state) {
          if (state is ActivityErrorState) {
            toast(text: state.error.toString(), color: Colors.red);
          }
        },
        builder: (context, state) {
          final isLoading = state is ActivityLoadingState &&
              cubit.myActivities == null &&
              cubit.teamActivities == null;

          return Skeletonizer(
            enabled: isLoading,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(10),
                  const FilterAndSearchWidget(),
                  verticalSpace(10),
                  twoButtonsIntegration(
                    selectedIndex: cubit.selectedIndex,
                    onTap: cubit.changeTap,
                    firstCount: cubit.myActivities?.data?.totalCount ?? 0,
                    firstLabel: 'My Activity',
                    secondCount: role != 'Cleaner'
                        ? cubit.teamActivities?.data?.totalCount ?? 0
                        : null,
                    secondLabel: role != 'Cleaner' ? 'My Team Activity' : null,
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
