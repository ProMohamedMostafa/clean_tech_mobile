import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/floating_action_button/floating_action_button.dart';
import 'package:smart_cleaning_application/core/widgets/two_buttons_in_integreat_screen/two_buttons_in_integration_screen.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/logic/shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/logic/shift_state.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/ui/widgets/filter_search_build.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/ui/widgets/shift_list_details_build.dart';

class ShiftBody extends StatelessWidget {
  const ShiftBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ShiftCubit cubit = context.read<ShiftCubit>();
    return Scaffold(
        appBar:
            AppBar(title: Text('Shifts'), leading: CustomBackButton()),
        floatingActionButton: role == 'Admin'
            ? floatingActionButton(
                icon: Icons.post_add_outlined,
                onPressed: () {
                  context.pushNamed(Routes.addShiftScreen);
                })
            : SizedBox.shrink(),
        body: BlocConsumer<ShiftCubit, ShiftState>(
          listener: (context, state) {
            if (state is ShiftDeleteSuccessState) {
              toast(text: state.deleteShiftModel.message!, color: Colors.blue);
              cubit.getAllDeletedShifts();
            }
            if (state is ShiftDeleteErrorState) {
              toast(text: state.error, color: Colors.red);
            }
            if (state is RestoreShiftSuccessState) {
              toast(text: state.message, color: Colors.blue);
            }
            if (state is RestoreShiftErrorState) {
              toast(text: state.error, color: Colors.red);
            }
            if (state is ForceDeleteShiftSuccessState) {
              toast(text: state.message, color: Colors.blue);
              cubit.getAllShifts();
              cubit.getAllDeletedShifts();
            }
          },
          builder: (context, state) {
            return Skeletonizer(
              enabled: cubit.allShiftsModel == null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(10),
                    FilterAndSearchBuild(),
                    verticalSpace(10),
                    twoButtonsIntegration(
                      selectedIndex: cubit.selectedIndex,
                      onTap: (index) => cubit.changeTap(index),
                      firstCount: cubit.allShiftsModel?.data?.totalCount ?? 0,
                      firstLabel: 'Total Shifts',
                      secondCount: role == 'Admin'
                          ? cubit.allShiftsDeletedModel?.data?.length ?? 0
                          : null,
                      secondLabel: role == 'Admin' ? 'Deleted Shifts' : null,
                    ),
                    verticalSpace(10),
                    Divider(color: Colors.grey[300], height: 0),
                    verticalSpace(10),
                    Expanded(child: ShiftListDetailsBuild()),
                    verticalSpace(10),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
