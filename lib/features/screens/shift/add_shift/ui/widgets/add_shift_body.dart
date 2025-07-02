import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_date_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_time_picker.dart';
import 'package:smart_cleaning_application/features/screens/shift/add_shift/logic/add_shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/shift/add_shift/logic/add_shift_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AddShiftBody extends StatelessWidget {
  const AddShiftBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddShiftCubit>();
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).createShift),
          leading: CustomBackButton(),
        ),
        body: BlocConsumer<AddShiftCubit, AddShiftState>(
          listener: (context, state) {
            if (state is AddShiftSuccessState) {
              toast(text: state.createShiftModel.message!, color: Colors.blue);
              context.popWithTrueResult();
            }
            if (state is AddShiftErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
                child: Form(
              key: cubit.formKey,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).shiftName,
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomTextFormField(
                          onlyRead: false,
                          hint: S.of(context).enterShift,
                          controller: cubit.shiftNameController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).shiftNameRequiredValidation;
                            } else if (value.length > 55) {
                              return S.of(context).shiftNameTooLongValidation;
                            } else if (value.length < 3) {
                              return S.of(context).shiftNameTooShortValidation;
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
                                  S.of(context).startDate,
                                  style: TextStyles.font16BlackRegular,
                                ),
                                verticalSpace(5),
                                CustomTextFormField(
                                  onlyRead: true,
                                  hint: "--/--/---",
                                  controller: cubit.startDateController,
                                  suffixIcon: Icons.calendar_today,
                                  suffixPressed: () async {
                                    final selectedDate =
                                        await CustomDatePicker.show(
                                            context: context);

                                    if (selectedDate != null &&
                                        context.mounted) {
                                      cubit.startDateController.text =
                                          selectedDate;
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return S
                                          .of(context)
                                          .startDateRequiredValidation;
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
                                  S.of(context).endDate,
                                  style: TextStyles.font16BlackRegular,
                                ),
                                verticalSpace(5),
                                CustomTextFormField(
                                  onlyRead: true,
                                  hint: "--/--/---",
                                  controller: cubit.endDateController,
                                  suffixIcon: Icons.calendar_today,
                                  suffixPressed: () async {
                                    final selectedDate =
                                        await CustomDatePicker.show(
                                            context: context);

                                    if (selectedDate != null &&
                                        context.mounted) {
                                      cubit.endDateController.text =
                                          selectedDate;
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return S
                                          .of(context)
                                          .endDateRequiredValidation;
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
                                  S.of(context).startTime,
                                  style: TextStyles.font16BlackRegular,
                                ),
                                verticalSpace(5),
                                CustomTextFormField(
                                  onlyRead: true,
                                  hint: '00:00 AM',
                                  controller: cubit.startTimeController,
                                  suffixIcon: Icons.timer_sharp,
                                  suffixPressed: () async {
                                    final selectedTime =
                                        await CustomTimePicker.show(
                                            context: context);

                                    if (selectedTime != null &&
                                        context.mounted) {
                                      cubit.startTimeController.text =
                                          selectedTime;
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return S
                                          .of(context)
                                          .startTimeRequiredValidation;
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
                                  S.of(context).endTime,
                                  style: TextStyles.font16BlackRegular,
                                ),
                                verticalSpace(5),
                                CustomTextFormField(
                                  onlyRead: true,
                                  hint: "09:30 PM",
                                  controller: cubit.endTimeController,
                                  suffixIcon: Icons.timer_sharp,
                                  suffixPressed: () async {
                                    final selectedTime =
                                        await CustomTimePicker.show(
                                            context: context);

                                    if (selectedTime != null &&
                                        context.mounted) {
                                      cubit.endTimeController.text =
                                          selectedTime;
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return S
                                          .of(context)
                                          .endTimeRequiredValidation;
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
                                text: S.of(context).Organization,
                                style: TextStyles.font16BlackRegular,
                              ),
                              TextSpan(
                                text: S.of(context).labelOptional,
                                style: TextStyles.font14GreyRegular,
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: S.of(context).selectOrganization,
                          controller: cubit.organizationController,
                          items: cubit.organizationItem
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          onChanged: (value) {
                            final selectedOrganization = cubit
                                .organizationModel?.data?.data
                                ?.firstWhere((org) =>
                                    org.name ==
                                    cubit.organizationController.text)
                                .id
                                ?.toString();

                            if (selectedOrganization != null) {
                              cubit.organizationIdController.text =
                                  selectedOrganization;
                            }
                            cubit.getBuilding();
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
                                text: S.of(context).Building,
                                style: TextStyles.font16BlackRegular,
                              ),
                              TextSpan(
                                text: S.of(context).labelOptional,
                                style: TextStyles.font14GreyRegular,
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: S.of(context).selectBuilding,
                          controller: cubit.buildingController,
                          items: cubit.buildingItem
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          onChanged: (value) {
                            final selectedBuilding = cubit
                                .buildingModel?.data?.data
                                ?.firstWhere((bld) =>
                                    bld.name == cubit.buildingController.text)
                                .id
                                ?.toString();

                            if (selectedBuilding != null) {
                              cubit.buildingIdController.text =
                                  selectedBuilding;
                            }
                            cubit.getFloor();
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
                                text: S.of(context).Floor,
                                style: TextStyles.font16BlackRegular,
                              ),
                              TextSpan(
                                text: S.of(context).labelOptional,
                                style: TextStyles.font14GreyRegular,
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: S.of(context).selectFloor,
                          controller: cubit.floorController,
                          items: cubit.floorItem
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          onChanged: (value) {
                            final selectedFloor = cubit.floorModel?.data?.data
                                ?.firstWhere((floor) =>
                                    floor.name == cubit.floorController.text)
                                .id
                                ?.toString();

                            if (selectedFloor != null) {
                              cubit.floorIdController.text = selectedFloor;
                            }
                            cubit.getSection();
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
                                text: S.of(context).Section,
                                style: TextStyles.font16BlackRegular,
                              ),
                              TextSpan(
                                text: S.of(context).labelOptional,
                                style: TextStyles.font14GreyRegular,
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: S.of(context).selectSection,
                          controller: cubit.sectionController,
                          items: cubit.sectionItem
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          onChanged: (value) {
                            final selectedSection = cubit
                                .sectionModel?.data?.data
                                ?.firstWhere((section) =>
                                    section.name ==
                                    cubit.sectionController.text)
                                .id
                                ?.toString();

                            if (selectedSection != null) {
                              cubit.sectionIdController.text = selectedSection;
                            }
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(20),
                        state is AddShiftLoadingState
                            ? Loading()
                            : Center(
                                child: DefaultElevatedButton(
                                    name: S.of(context).createButton,
                                    onPressed: () {
                                      if (cubit.formKey.currentState!
                                          .validate()) {
                                        cubit.addShift();
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
            ));
          },
        ));
  }
}
