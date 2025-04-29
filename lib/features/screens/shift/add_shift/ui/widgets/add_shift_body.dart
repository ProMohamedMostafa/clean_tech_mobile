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
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_date_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_time_picker.dart';
import 'package:smart_cleaning_application/features/screens/shift/add_shift/logic/add_shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/shift/add_shift/logic/add_shift_state.dart';

class AddShiftBody extends StatefulWidget {
  const AddShiftBody({super.key});

  @override
  State<AddShiftBody> createState() => _AddShiftBodyState();
}

class _AddShiftBodyState extends State<AddShiftBody> {
  @override
  void initState() {
    context.read<AddShiftCubit>().getOrganization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Create Shift",
            style: TextStyles.font16BlackSemiBold,
          ),
          centerTitle: true,
          leading: customBackButton(context),
        ),
        body: BlocConsumer<AddShiftCubit, AddShiftState>(
          listener: (context, state) {
            if (state is AddShiftSuccessState) {
              toast(text: state.createShiftModel.message!, color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.shiftScreen);
            }
            if (state is AddShiftErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            return SafeArea(
                child: SingleChildScrollView(
                    child: Form(
              key: context.read<AddShiftCubit>().formKey,
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
                          hint: "Enter Shift",
                          controller:
                              context.read<AddShiftCubit>().shiftNameController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Shift Name is Required";
                            } else if (value.length > 55) {
                              return 'Shift name too long';
                            } else if (value.length < 3) {
                              return 'Shift name too short';
                            }
                            return null;
                          },
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
                                  hint: "--/--/---",
                                  controller: context
                                      .read<AddShiftCubit>()
                                      .startDateController,
                                  suffixIcon: Icons.calendar_today,
                                  suffixPressed: () async {
                                    final selectedDate =
                                        await CustomDatePicker.show(
                                            context: context);

                                    if (selectedDate != null &&
                                        context.mounted) {
                                      context
                                          .read<AddShiftCubit>()
                                          .startDateController
                                          .text = selectedDate;
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Start date is required";
                                    }
                                    return null;
                                  },
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
                                  hint: "--/--/---",
                                  controller: context
                                      .read<AddShiftCubit>()
                                      .endDateController,
                                  suffixIcon: Icons.calendar_today,
                                  suffixPressed: () async {
                                    final selectedDate =
                                        await CustomDatePicker.show(
                                            context: context);

                                    if (selectedDate != null &&
                                        context.mounted) {
                                      context
                                          .read<AddShiftCubit>()
                                          .endDateController
                                          .text = selectedDate;
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Start date is required";
                                    }
                                    return null;
                                  },
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
                                  hint: '00:00 AM',
                                  controller: context
                                      .read<AddShiftCubit>()
                                      .startTimeController,
                                  suffixIcon: Icons.timer_sharp,
                                  suffixPressed: () async {
                                    final selectedTime =
                                        await CustomTimePicker.show(
                                            context: context);

                                    if (selectedTime != null &&
                                        context.mounted) {
                                      context
                                          .read<AddShiftCubit>()
                                          .startTimeController
                                          .text = selectedTime;
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Start time is required";
                                    }
                                    return null;
                                  },
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
                                  hint: "09:30 PM",
                                  controller: context
                                      .read<AddShiftCubit>()
                                      .endTimeController,
                                  suffixIcon: Icons.timer_sharp,
                                  suffixPressed: () async {
                                    final selectedTime =
                                        await CustomTimePicker.show(
                                            context: context);

                                    if (selectedTime != null &&
                                        context.mounted) {
                                      context
                                          .read<AddShiftCubit>()
                                          .endTimeController
                                          .text = selectedTime;
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Start date is required";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            )),
                          ],
                        ),
                        verticalSpace(10),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Organization',
                                style: TextStyles.font16BlackRegular,
                              ),
                              TextSpan(
                                text: ' (Optional)',
                                style: TextStyles.font14GreyRegular,
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: 'Select organizations',
                          controller: context
                              .read<AddShiftCubit>()
                              .organizationController,
                          items: context
                              .read<AddShiftCubit>()
                              .organizationItem
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          onChanged: (value) {
                            final selectedOrganization = context
                                .read<AddShiftCubit>()
                                .organizationModel
                                ?.data
                                ?.data
                                ?.firstWhere((org) =>
                                    org.name ==
                                    context
                                        .read<AddShiftCubit>()
                                        .organizationController
                                        .text)
                                .id
                                ?.toString();

                            if (selectedOrganization != null) {
                              context
                                  .read<AddShiftCubit>()
                                  .organizationIdController
                                  .text = selectedOrganization;
                            }
                            context.read<AddShiftCubit>().getBuilding();
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Building',
                                style: TextStyles.font16BlackRegular,
                              ),
                              TextSpan(
                                text: ' (Optional)',
                                style: TextStyles.font14GreyRegular,
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: 'Select building',
                          controller:
                              context.read<AddShiftCubit>().buildingController,
                          items: context
                              .read<AddShiftCubit>()
                              .buildingItem
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          onChanged: (value) {
                            final selectedBuilding = context
                                .read<AddShiftCubit>()
                                .buildingModel
                                ?.data
                                ?.data
                                ?.firstWhere((bld) =>
                                    bld.name ==
                                    context
                                        .read<AddShiftCubit>()
                                        .buildingController
                                        .text)
                                .id
                                ?.toString();

                            if (selectedBuilding != null) {
                              context
                                  .read<AddShiftCubit>()
                                  .buildingIdController
                                  .text = selectedBuilding;
                            }
                            context.read<AddShiftCubit>().getFloor();
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Floor',
                                style: TextStyles.font16BlackRegular,
                              ),
                              TextSpan(
                                text: ' (Optional)',
                                style: TextStyles.font14GreyRegular,
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: 'Select floor',
                          controller:
                              context.read<AddShiftCubit>().floorController,
                          items: context
                              .read<AddShiftCubit>()
                              .floorItem
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          onChanged: (value) {
                            final selectedFloor = context
                                .read<AddShiftCubit>()
                                .floorModel
                                ?.data
                                ?.data
                                ?.firstWhere((floor) =>
                                    floor.name ==
                                    context
                                        .read<AddShiftCubit>()
                                        .floorController
                                        .text)
                                .id
                                ?.toString();

                            if (selectedFloor != null) {
                              context
                                  .read<AddShiftCubit>()
                                  .floorIdController
                                  .text = selectedFloor;
                            }
                            context.read<AddShiftCubit>().getSection();
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Section',
                                style: TextStyles.font16BlackRegular,
                              ),
                              TextSpan(
                                text: ' (Optional)',
                                style: TextStyles.font14GreyRegular,
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: 'Select section',
                          controller:
                              context.read<AddShiftCubit>().sectionController,
                          items: context
                              .read<AddShiftCubit>()
                              .sectionItem
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          onChanged: (value) {
                            final selectedSection = context
                                .read<AddShiftCubit>()
                                .sectionModel
                                ?.data
                                ?.data
                                ?.firstWhere((section) =>
                                    section.name ==
                                    context
                                        .read<AddShiftCubit>()
                                        .sectionController
                                        .text)
                                .id
                                ?.toString();

                            if (selectedSection != null) {
                              context
                                  .read<AddShiftCubit>()
                                  .sectionIdController
                                  .text = selectedSection;
                            }
                            context.read<AddShiftCubit>().getPoint();
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Point',
                                style: TextStyles.font16BlackRegular,
                              ),
                              TextSpan(
                                text: ' (Optional)',
                                style: TextStyles.font14GreyRegular,
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: 'Select point',
                          controller:
                              context.read<AddShiftCubit>().pointController,
                          items: context
                              .read<AddShiftCubit>()
                              .pointItem
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          onChanged: (value) {
                            final selectedPoint = context
                                .read<AddShiftCubit>()
                                .pointModel
                                ?.data
                                ?.data
                                ?.firstWhere((point) =>
                                    point.name ==
                                    context
                                        .read<AddShiftCubit>()
                                        .pointController
                                        .text)
                                .id
                                ?.toString();

                            if (selectedPoint != null) {
                              context
                                  .read<AddShiftCubit>()
                                  .pointIdController
                                  .text = selectedPoint;
                            }
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(20),
                        state is AddShiftLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: AppColor.primaryColor),
                              )
                            : Center(
                                child: DefaultElevatedButton(
                                    name: "Create",
                                    onPressed: () {
                                      if (context
                                          .read<AddShiftCubit>()
                                          .formKey
                                          .currentState!
                                          .validate()) {
                                        context
                                            .read<AddShiftCubit>()
                                            .addShift();
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
