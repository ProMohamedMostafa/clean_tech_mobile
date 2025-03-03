import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_date_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_time_picker.dart';
import 'package:smart_cleaning_application/features/screens/shift/edit_shift/logic/edit_shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/shift/edit_shift/logic/edit_shift_state.dart';

class EditShiftBody extends StatefulWidget {
  final int id;
  const EditShiftBody({super.key, required this.id});

  @override
  State<EditShiftBody> createState() => _EditShiftBodyState();
}

class _EditShiftBodyState extends State<EditShiftBody> {
  @override
  void initState() {
    context.read<EditShiftCubit>().getShiftDetails(widget.id);
    context.read<EditShiftCubit>().getShiftLevelDetails(widget.id);
    context.read<EditShiftCubit>().getOrganization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Shift",
          ),
          leading: customBackButton(context),
        ),
        body: BlocConsumer<EditShiftCubit, EditShiftState>(
          listener: (context, state) {
            if (state is EditShiftSuccessState) {
              toast(
                  text: state.editShiftDetailsModel.message!,
                  color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.shiftScreen);
            }
            if (state is EditShiftErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            final cubit = context.read<EditShiftCubit>();
            if (cubit.shiftDetailsModel == null ||
                cubit.shiftLevelDetailsModel == null) {
              return const Center(
                child: CircularProgressIndicator(color: AppColor.primaryColor),
              );
            }

            return SafeArea(
                child: SingleChildScrollView(
                    child: Form(
              key: context.read<EditShiftCubit>().formKey,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Shift Name",
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomTextFormField(
                          onlyRead: false,
                          hint: context
                              .read<EditShiftCubit>()
                              .shiftDetailsModel!
                              .data!
                              .name!,
                          validator: (value) {
                            if (value!.length > 55) {
                              return 'Shift name too long';
                            } else if (value.length < 3) {
                              return 'Shift name too short';
                            }
                            return null;
                          },
                          controller:
                              context.read<EditShiftCubit>().shiftNameController
                                ..text = context
                                    .read<EditShiftCubit>()
                                    .shiftDetailsModel!
                                    .data!
                                    .name!,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Start Date",
                                  style: TextStyles.font16BlackRegular,
                                ),
                                verticalSpace(5),
                                CustomTextFormField(
                                  onlyRead: true,
                                  hint: context
                                      .read<EditShiftCubit>()
                                      .shiftDetailsModel!
                                      .data!
                                      .startDate!,
                                  controller: context
                                      .read<EditShiftCubit>()
                                      .startDateController,
                                  suffixIcon: Icons.calendar_today,
                                  suffixPressed: () async {
                                    final selectedDate =
                                        await CustomDatePicker.show(
                                            context: context);

                                    if (selectedDate != null &&
                                        context.mounted) {
                                      context
                                          .read<EditShiftCubit>()
                                          .startDateController
                                          .text = selectedDate;
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                ),
                              ],
                            )),
                            horizontalSpace(10),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "End Date",
                                  style: TextStyles.font16BlackRegular,
                                ),
                                verticalSpace(5),
                                CustomTextFormField(
                                  onlyRead: true,
                                  hint: context
                                      .read<EditShiftCubit>()
                                      .shiftDetailsModel!
                                      .data!
                                      .endDate!,
                                  controller: context
                                      .read<EditShiftCubit>()
                                      .endDateController,
                                  suffixIcon: Icons.calendar_today,
                                  suffixPressed: () async {
                                    final selectedDate =
                                        await CustomDatePicker.show(
                                            context: context);

                                    if (selectedDate != null &&
                                        context.mounted) {
                                      context
                                          .read<EditShiftCubit>()
                                          .endDateController
                                          .text = selectedDate;
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                ),
                              ],
                            )),
                          ],
                        ),
                        verticalSpace(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Start Time",
                                  style: TextStyles.font16BlackRegular,
                                ),
                                verticalSpace(5),
                                CustomTextFormField(
                                  onlyRead: true,
                                  hint: context
                                      .read<EditShiftCubit>()
                                      .shiftDetailsModel!
                                      .data!
                                      .startTime!,
                                  controller: context
                                      .read<EditShiftCubit>()
                                      .startTimeController,
                                  suffixIcon: Icons.timer_sharp,
                                  suffixPressed: () async {
                                    final selectedTime =
                                        await CustomTimePicker.show(
                                            context: context);

                                    if (selectedTime != null &&
                                        context.mounted) {
                                      context
                                          .read<EditShiftCubit>()
                                          .startTimeController
                                          .text = selectedTime;
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                ),
                              ],
                            )),
                            horizontalSpace(10),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "End Time",
                                  style: TextStyles.font16BlackRegular,
                                ),
                                verticalSpace(5),
                                CustomTextFormField(
                                  onlyRead: true,
                                  hint: context
                                      .read<EditShiftCubit>()
                                      .shiftDetailsModel!
                                      .data!
                                      .endTime!,
                                  controller: context
                                      .read<EditShiftCubit>()
                                      .endTimeController,
                                  suffixIcon: Icons.timer_sharp,
                                  suffixPressed: () async {
                                    final selectedTime =
                                        await CustomTimePicker.show(
                                            context: context);

                                    if (selectedTime != null &&
                                        context.mounted) {
                                      context
                                          .read<EditShiftCubit>()
                                          .endTimeController
                                          .text = selectedTime;
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                ),
                              ],
                            )),
                          ],
                        ),
                        verticalSpace(10),
                        Text(
                          'Organization',
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: context
                                  .read<EditShiftCubit>()
                                  .shiftLevelDetailsModel!
                                  .data
                                  ?.organizations![0]
                                  .name
                                  .toString() ??
                              '',
                          items: context
                                      .read<EditShiftCubit>()
                                      .allOrganizationModel
                                      ?.data
                                      ?.data
                                      ?.isEmpty ??
                                  true
                              ? ['No organizations']
                              : context
                                      .read<EditShiftCubit>()
                                      .allOrganizationModel
                                      ?.data
                                      ?.data
                                      ?.map((e) => e.name ?? 'Unknown')
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedOrganization = context
                                .read<EditShiftCubit>()
                                .allOrganizationModel
                                ?.data
                                ?.data
                                ?.firstWhere((organization) =>
                                    organization.name ==
                                    context
                                        .read<EditShiftCubit>()
                                        .organizationController
                                        .text);

                            context
                                .read<EditShiftCubit>()
                                .getBuilding(selectedOrganization!.id!);
                            context
                                .read<EditShiftCubit>()
                                .organizationIdController
                                .text = selectedOrganization.id!.toString();
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller: context
                              .read<EditShiftCubit>()
                              .organizationController,
                          isRead: false,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(15),
                        Text(
                          'Building',
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: context
                                  .read<EditShiftCubit>()
                                  .shiftLevelDetailsModel!
                                  .data
                                  ?.buildings![0]
                                  .name
                                  .toString() ??
                              '',
                          items: context
                                      .read<EditShiftCubit>()
                                      .buildingModel
                                      ?.data
                                      ?.isEmpty ??
                                  true
                              ? ['No building']
                              : context
                                      .read<EditShiftCubit>()
                                      .buildingModel
                                      ?.data
                                      ?.map((e) => e.name ?? 'Unknown')
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedBuilding = context
                                .read<EditShiftCubit>()
                                .buildingModel
                                ?.data
                                ?.firstWhere((building) =>
                                    building.name ==
                                    context
                                        .read<EditShiftCubit>()
                                        .buildingController
                                        .text);
                            context
                                .read<EditShiftCubit>()
                                .getFloor(selectedBuilding!.id!);
                            context
                                .read<EditShiftCubit>()
                                .buildingIdController
                                .text = selectedBuilding.id!.toString();
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller:
                              context.read<EditShiftCubit>().buildingController,
                          isRead: false,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                        Text(
                          'Floor',
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: context
                                  .read<EditShiftCubit>()
                                  .shiftLevelDetailsModel!
                                  .data
                                  ?.floors![0]
                                  .name
                                  .toString() ??
                              '',
                          items: context
                                      .read<EditShiftCubit>()
                                      .floorModel
                                      ?.data
                                      ?.isEmpty ??
                                  true
                              ? ['No floors']
                              : context
                                      .read<EditShiftCubit>()
                                      .floorModel
                                      ?.data
                                      ?.map((e) => e.name ?? 'Unknown')
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedFloor = context
                                .read<EditShiftCubit>()
                                .floorModel
                                ?.data
                                ?.firstWhere((floor) =>
                                    floor.name ==
                                    context
                                        .read<EditShiftCubit>()
                                        .floorController
                                        .text);

                            context
                                .read<EditShiftCubit>()
                                .getPoints(selectedFloor!.id!);
                            context
                                .read<EditShiftCubit>()
                                .floorIdController
                                .text = selectedFloor.id!.toString();
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller:
                              context.read<EditShiftCubit>().floorController,
                          isRead: false,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                        Text(
                          'Point',
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: context
                                  .read<EditShiftCubit>()
                                  .shiftLevelDetailsModel!
                                  .data
                                  ?.points![0]
                                  .name
                                  .toString() ??
                              '',
                          items: context
                                      .read<EditShiftCubit>()
                                      .pointModel
                                      ?.data
                                      ?.isEmpty ??
                                  true
                              ? ['No point']
                              : context
                                      .read<EditShiftCubit>()
                                      .pointModel
                                      ?.data
                                      ?.map((e) => e.name ?? 'Unknown')
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedPoint = context
                                .read<EditShiftCubit>()
                                .pointModel
                                ?.data
                                ?.firstWhere((point) =>
                                    point.name ==
                                    context
                                        .read<EditShiftCubit>()
                                        .pointController
                                        .text);

                            context
                                .read<EditShiftCubit>()
                                .getPoints(selectedPoint!.id!);
                            context
                                .read<EditShiftCubit>()
                                .pointIdController
                                .text = selectedPoint.id!.toString();
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller:
                              context.read<EditShiftCubit>().pointController,
                          isRead: false,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(20),
                        state is EditShiftLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: AppColor.primaryColor),
                              )
                            : Center(
                                child: DefaultElevatedButton(
                                    name: "Edit",
                                    onPressed: () {
                                      if (context
                                          .read<EditShiftCubit>()
                                          .formKey
                                          .currentState!
                                          .validate()) {
                                        showCustomDialog(context,
                                            "Are you Sure you want save the edit of this shift ?",
                                            () {
                                          context
                                              .read<EditShiftCubit>()
                                              .editShift(widget.id);
                                          context.pop();
                                        });
                                      }
                                    },
                                    color: AppColor.primaryColor,
                                    height: 47,
                                    width: double.infinity,
                                    textStyles:
                                        TextStyles.font20Whitesemimedium),
                              ),
                        verticalSpace(30),
                      ])),
            )));
          },
        ));
  }
}
