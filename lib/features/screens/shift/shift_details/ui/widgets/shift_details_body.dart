import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/row_details_build.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/logic/shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/logic/shift_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ShiftDetailsBody extends StatefulWidget {
  final int id;
  const ShiftDetailsBody({super.key, required this.id});

  @override
  State<ShiftDetailsBody> createState() => _ShiftDetailsBodyState();
}

class _ShiftDetailsBodyState extends State<ShiftDetailsBody> {
  @override
  void initState() {
    context.read<ShiftCubit>().getShiftDetails(widget.id);
    context.read<ShiftCubit>().getShiftOrganizations(widget.id);
    context.read<ShiftCubit>().getShiftBuildings(widget.id);
    context.read<ShiftCubit>().getShiftFloors(widget.id);
    context.read<ShiftCubit>().getShiftPoints(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shift details",
        ),
        leading: customBackButton(context),
        actions: [
          IconButton(
              onPressed: () {
                context.pushNamed(Routes.editShiftScreen, arguments: widget.id);
              },
              icon: Icon(
                Icons.edit,
                color: AppColor.primaryColor,
              ))
        ],
      ),
      body: BlocConsumer<ShiftCubit, ShiftState>(
        listener: (context, state) {
          if (state is ShiftDeleteSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.pushNamedAndRemoveLastTwo(Routes.shiftScreen);
          }
          if (state is ShiftDeleteErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          final cubit = context.read<ShiftCubit>();
          if (cubit.shiftDetailsModel == null) {
            return const Center(
              child: CircularProgressIndicator(color: AppColor.primaryColor),
            );
          }

          return SafeArea(
              child: SingleChildScrollView(
            child: BlocConsumer<ShiftCubit, ShiftState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      rowDetailsBuild(
                          context,
                          "Name Shift",
                          context
                              .read<ShiftCubit>()
                              .shiftDetailsModel!
                              .data!
                              .name!),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      rowDetailsBuild(
                          context,
                          "Start Date",
                          context
                              .read<ShiftCubit>()
                              .shiftDetailsModel!
                              .data!
                              .startDate!),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      rowDetailsBuild(
                          context,
                          "End Date",
                          context
                              .read<ShiftCubit>()
                              .shiftDetailsModel!
                              .data!
                              .endDate!),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      rowDetailsBuild(
                          context,
                          "Start Time",
                          context
                              .read<ShiftCubit>()
                              .shiftDetailsModel!
                              .data!
                              .startTime!),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      rowDetailsBuild(
                          context,
                          "End Time",
                          context
                              .read<ShiftCubit>()
                              .shiftDetailsModel!
                              .data!
                              .endTime!),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Organization",
                            style: TextStyles.font14GreyRegular,
                          ),
                          context
                                  .read<ShiftCubit>()
                                  .shiftOrganizationsModel!
                                  .data!
                                  .isEmpty
                              ? Text("No Organization")
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: context
                                      .read<ShiftCubit>()
                                      .shiftOrganizationsModel!
                                      .data!
                                      .map((organization) =>
                                          Text(organization.name ?? ""))
                                      .toList(),
                                ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Building",
                            style: TextStyles.font14GreyRegular,
                          ),
                          context
                                  .read<ShiftCubit>()
                                  .shiftBuildingsModel!
                                  .data!
                                  .isEmpty
                              ? Text("No Building")
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: context
                                      .read<ShiftCubit>()
                                      .shiftBuildingsModel!
                                      .data!
                                      .map((building) =>
                                          Text(building.name ?? ""))
                                      .toList(),
                                ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Floor",
                            style: TextStyles.font14GreyRegular,
                          ),
                          context
                                  .read<ShiftCubit>()
                                  .shiftFloorsModel!
                                  .data!
                                  .isEmpty
                              ? Text("No Floor")
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: context
                                      .read<ShiftCubit>()
                                      .shiftFloorsModel!
                                      .data!
                                      .map((floor) => Text(floor.name ?? ""))
                                      .toList(),
                                ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Points",
                            style: TextStyles.font14GreyRegular,
                          ),
                          context
                                  .read<ShiftCubit>()
                                  .shiftPointsModel!
                                  .data!
                                  .isEmpty
                              ? Text("No Points")
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: context
                                      .read<ShiftCubit>()
                                      .shiftPointsModel!
                                      .data!
                                      .map((point) => Text(point.name ?? ""))
                                      .toList(),
                                ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      rowDetailsBuild(context, "Manager", "Eng.Mohamed"),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      rowDetailsBuild(context, "Supervisor", "Mr.Amr"),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      rowDetailsBuild(context, "Cleaner", "Om yousef"),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      state is ShiftDeleteLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: AppColor.primaryColor),
                            )
                          : DefaultElevatedButton(
                              name: S.of(context).deleteButton,
                              onPressed: () {
                                showCustomDialog(
                                    context, S.of(context).deleteMessage, () {
                                  context
                                      .read<ShiftCubit>()
                                      .shiftDelete(widget.id);
                                });
                              },
                              color: Colors.red,
                              height: 48,
                              width: double.infinity,
                              textStyles: TextStyles.font20Whitesemimedium),
                    ],
                  ),
                );
              },
            ),
          ));
        },
      ),
    );
  }
}
