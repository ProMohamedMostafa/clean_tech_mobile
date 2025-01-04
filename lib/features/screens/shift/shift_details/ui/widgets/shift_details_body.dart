import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/ui/widgets/row_details_build.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shift details",
          style: TextStyles.font16BlackSemiBold,
        ),
        centerTitle: true,
        leading: customBackButton(context),
        actions: [
          IconButton(
              onPressed: () {
                // context.pushNamed(Routes.editUserScreen, arguments: widget.id);
              },
              icon: Icon(
                Icons.edit,
                color: AppColor.primaryColor,
              ))
        ],
      ),
      body: BlocConsumer<ShiftCubit, ShiftState>(
        listener: (context, state) {
          // if (state is UserDeleteInDetailsSuccessState) {
          //   toast(
          //       text: state.deleteUserDetailsModel.message!,
          //       color: Colors.blue);
          //   context.pushNamedAndRemoveLastTwo(Routes.userManagmentScreen);
          // }
          // if (state is UserDeleteInDetailsErrorState) {
          //   toast(text: state.error, color: Colors.red);
          // }
        },
        builder: (context, state) {
          final cubit = context.read<ShiftCubit>();
          if (state is ShiftDetailsLoadingState ||
              cubit.shiftDetailsModel == null) {
            // Show loading indicator
            return const Center(
              child: CircularProgressIndicator(color: AppColor.primaryColor),
            );
          }

          // Ensure data is non-null before building the UI
          final shiftDetails = cubit.shiftDetailsModel?.data;

          if (shiftDetails == null) {
            // Handle case where data fetching fails
            return const Center(
              child: Text("Failed to load organization details."),
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
                      rowShiftDetailsBuild(
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
                      rowShiftDetailsBuild(
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
                      rowShiftDetailsBuild(
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
                      rowShiftDetailsBuild(
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
                      rowShiftDetailsBuild(
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
                      rowShiftDetailsBuild(context, "Organization", "Ai cloud"),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      rowShiftDetailsBuild(context, "Building", "Building 3"),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      rowShiftDetailsBuild(context, "Floor", "2"),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      rowShiftDetailsBuild(context, "Point", "meeting room"),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      rowShiftDetailsBuild(context, "Manager", "Eng.Mohamed"),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      rowShiftDetailsBuild(context, "Supervisor", "Mr.Amr"),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      rowShiftDetailsBuild(context, "Cleaner", "Om yousef"),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      DefaultElevatedButton(
                          name: S.of(context).deleteButton,
                          onPressed: () {
                            showCustomDialog(
                                context, S.of(context).deleteMessage, () {
                              // context
                              //     .read<UserManagementCubit>()
                              //     .userDeleteInDetails(widget.id);
                            });
                          },
                          color: AppColor.primaryColor,
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
