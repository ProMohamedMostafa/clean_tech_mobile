import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/custom_multi_dropdown/custom_multi_dropdown.dart';
import 'package:smart_cleaning_application/core/widgets/custom_time_picker/custom_time_picker.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/building_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/floor_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/organization_list_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/section_list_model.dart';
import 'package:smart_cleaning_application/core/widgets/custom_date_picker/custom_date_picker.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/add_shift/logic/add_shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/shift/add_shift/logic/add_shift_state.dart';
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
              toast(text: state.createShiftModel.message!, isSuccess: true);
              context.popWithTrueResult();
            }
            if (state is AddShiftErrorState) {
              toast(text: state.error, isSuccess: false);
            }
          },
          builder: (context, state) {
            if (cubit.organizationModel == null ||
                cubit.buildingModel == null ||
                cubit.floorModel == null ||
                cubit.sectionModel == null) {
              return Loading();
            }

            return SingleChildScrollView(
                child: SafeArea(
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
                  
                          CustomMultiDropdown(
                            hint: S.of(context).selectOrganization,
                            controller: cubit.allOrganizationsController,
                            items: cubit.organizationItem
                                .map((e) => DropdownItem<OrganizationItem>(
                                      value: e,
                                      label: e.name ?? 'Unknown',
                                    ))
                                .toList(),
                            onSelectionChange: (selectedItems) {
                              cubit.selectedOrganizationsIds =
                                  selectedItems.map((item) => item.id!).toList();
                            },
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
                          CustomMultiDropdown(
                            hint: S.of(context).selectBuilding,
                            controller: cubit.allBuildingsController,
                            items: cubit.buildingItem
                                .map((e) => DropdownItem<BuildingItem>(
                                      value: e,
                                      label: e.name ?? 'Unknown',
                                    ))
                                .toList(),
                            onSelectionChange: (selectedItems) {
                              cubit.selectedBuildingsIds =
                                  selectedItems.map((item) => item.id!).toList();
                            },
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
                          CustomMultiDropdown(
                            hint: S.of(context).selectFloor,
                            controller: cubit.allFloorsController,
                            items: cubit.floorItem
                                .map((e) => DropdownItem<FloorItem>(
                                      value: e,
                                      label: e.name ?? 'Unknown',
                                    ))
                                .toList(),
                            onSelectionChange: (selectedItems) {
                              cubit.selectedFloorsIds =
                                  selectedItems.map((item) => item.id!).toList();
                            },
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
                          CustomMultiDropdown(
                            hint: S.of(context).selectSection,
                            controller: cubit.allSectionsController,
                            items: cubit.sectionItem
                                .map((e) => DropdownItem<SectionItem>(
                                      value: e,
                                      label: e.name ?? 'Unknown',
                                    ))
                                .toList(),
                            onSelectionChange: (selectedItems) {
                              cubit.selectedSectionsIds =
                                  selectedItems.map((item) => item.id!).toList();
                            },
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
                                      textStyles:
                                          TextStyles.font20Whitesemimedium),
                                ),
                          verticalSpace(30),
                        ])),
                              ),
                ));
          },
        ));
  }
}
