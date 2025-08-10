import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/filter/logic/cubit/filter_dialog_cubit.dart';
import 'package:smart_cleaning_application/core/widgets/filter/ui/screen/filter_dialog_widget.dart';
import 'package:smart_cleaning_application/core/widgets/filter_and_search_build/filter_search_build.dart';
import 'package:smart_cleaning_application/core/widgets/floating_action_button/floating_action_button.dart';
import 'package:smart_cleaning_application/core/widgets/integration_buttons/integrations_buttons.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/shifts_management/logic/shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/shifts_management/logic/shift_state.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/shifts_management/ui/widgets/pdf.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/shifts_management/ui/widgets/shift_list_details_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ShiftBody extends StatelessWidget {
  const ShiftBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShiftCubit>();
    return Scaffold(
        appBar: AppBar(
            title: Text(S.of(context).integ4), leading: CustomBackButton(),actions: [
            IconButton(
              onPressed: () {
                createShiftPDF(context);
              },
              icon: Icon(
                CupertinoIcons.tray_arrow_down,
                color: Colors.red,
                size: 22.sp,
              ),
            ),
            horizontalSpace(10)
          ]),
        floatingActionButton: role == 'Admin'
            ? floatingActionButton(
                icon: Icons.post_add_outlined,
                onPressed: () async {
                  final result = await context.pushNamed(Routes.addShiftScreen);

                  if (result == true) {
                    cubit.refreshShifts();
                  }
                },
              )
            : SizedBox.shrink(),
        body: BlocConsumer<ShiftCubit, ShiftState>(
          listener: (context, state) {
            if (state is ShiftDeleteSuccessState) {
              toast(text: state.deleteShiftModel.message!, isSuccess: true);
              cubit.getAllDeletedShifts();
            }
            if (state is ShiftDeleteErrorState) {
              toast(text: state.error, isSuccess: false);
            }
            if (state is RestoreShiftSuccessState) {
              toast(text: state.message, isSuccess: true);
            }
            if (state is RestoreShiftErrorState) {
              toast(text: state.error, isSuccess: false);
            }
            if (state is ForceDeleteShiftSuccessState) {
              toast(text: state.message, isSuccess: true);
              cubit.getAllShifts();
              cubit.getAllDeletedShifts();
            }
            if (state is ForceDeleteShiftErrorState) {
              toast(text: state.error, isSuccess: false);
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
                    FilterAndSearchWidget(
                      hintText: S.of(context).findShift,
                      searchController: cubit.searchController,
                      onSearchChanged: (value) {
                        cubit.getAllShifts();
                      },
                      onFilterTap: () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return BlocProvider(
                              create: (context) =>
                                  FilterDialogCubit()..getArea(),
                              child: FilterDialogWidget(
                                index: 'S',
                                onPressed: (data) {
                                  cubit.filterModel = data;
                                  cubit.getAllShifts();
                                },
                              ),
                            );
                          },
                        );
                      },isFilterActive: cubit.filterModel != null,
                    onClearFilter: () {
                      cubit.filterModel = null;
                      cubit.searchController.clear();
                      cubit.getAllShifts();
                    },
                    ),
                    verticalSpace(10),
                    integrationsButtons(
                      selectedIndex: cubit.selectedIndex,
                      onTap: (index) => cubit.changeTap(index),
                      firstCount: cubit.allShiftsModel?.data?.totalCount ?? 0,
                      firstLabel: S.of(context).totalShiftss,
                      secondCount: role == 'Admin'
                          ? cubit.allShiftsDeletedModel?.data?.length ?? 0
                          : null,
                      secondLabel:
                          role == 'Admin' ? S.of(context).deletedShifts : null,
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
