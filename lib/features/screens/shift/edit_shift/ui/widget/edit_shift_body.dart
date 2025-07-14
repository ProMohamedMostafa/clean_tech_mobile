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
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_date_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_time_picker.dart';
import 'package:smart_cleaning_application/features/screens/shift/edit_shift/logic/edit_shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/shift/edit_shift/logic/edit_shift_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EditShiftBody extends StatelessWidget {
  final int id;
  const EditShiftBody({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditShiftCubit>();
    return Scaffold(
        appBar: AppBar(
            title: Text(S.of(context).editShift), leading: CustomBackButton()),
        body: BlocConsumer<EditShiftCubit, EditShiftState>(
          listener: (context, state) {
            if (state is EditShiftSuccessState) {
              toast(
                  text: state.editShiftDetailsModel.message!, isSuccess: true);
              context.popWithTrueResult();
            }
            if (state is EditShiftErrorState) {
              toast(text: state.error, isSuccess: false);
            }
          },
          builder: (context, state) {
            if (cubit.shiftDetailsModel == null ||
                cubit.organizationModel == null) {
              return Loading();
            }

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
                          hint: cubit.shiftDetailsModel!.data!.name!,
                          validator: (value) {
                            if (value!.length > 55) {
                              return S.of(context).shiftNameTooLongValidation;
                            } else if (value.length < 3) {
                              return S.of(context).shiftNameTooShortValidation;
                            }
                            return null;
                          },
                          controller: cubit.shiftNameController
                            ..text = cubit.shiftDetailsModel!.data!.name!,
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
                                  S.of(context).startDate,
                                  style: TextStyles.font16BlackRegular,
                                ),
                                verticalSpace(5),
                                CustomTextFormField(
                                  onlyRead: true,
                                  hint:
                                      cubit.shiftDetailsModel!.data!.startDate!,
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
                                  hint: cubit.shiftDetailsModel!.data!.endDate!,
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
                                  hint:
                                      cubit.shiftDetailsModel!.data!.startTime!,
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
                                  hint: cubit.shiftDetailsModel!.data!.endTime!,
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
                                ),
                              ],
                            )),
                          ],
                        ),
                        verticalSpace(10),
                        Text(
                          S.of(context).Organization,
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: cubit.shiftDetailsModel!.data!.organizations
                                  ?.map((e) => e.name)
                                  .join(', ') ??
                              '',
                          items: cubit.organizationItem
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          onChanged: (value) {
                            final selectedOrganization = cubit
                                .organizationModel?.data?.data
                                ?.firstWhere((org) =>
                                    org.name ==
                                    cubit.organizationController.text)
                                .id;

                            if (selectedOrganization != null) {
                              cubit.organizationIdController.text =
                                  selectedOrganization.toString();
                            }

                            cubit.getBuilding();
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller: cubit.organizationController,
                          isRead: false,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(15),
                        Text(
                          S.of(context).Building,
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: cubit.shiftDetailsModel!.data!.building
                                  ?.map((e) => e.name)
                                  .join(', ') ??
                              '',
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
                          controller: cubit.buildingController,
                          isRead: false,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                        Text(
                          S.of(context).Floor,
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: cubit.shiftDetailsModel!.data!.floors
                                  ?.map((e) => e.name)
                                  .join(', ') ??
                              '',
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
                          controller: cubit.floorController,
                          isRead: false,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                        Text(
                          S.of(context).Section,
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: cubit.shiftDetailsModel!.data!.sections
                                  ?.map((e) => e.name)
                                  .join(', ') ??
                              '',
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
                          controller: cubit.sectionController,
                          isRead: false,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(20),
                        state is EditShiftLoadingState
                            ? Loading()
                            : Center(
                                child: DefaultElevatedButton(
                                    name: S.of(context).editButton,
                                    onPressed: () {
                                      if (cubit.formKey.currentState!
                                          .validate()) {
                                        showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return PopUpMessage(
                                                  title:
                                                      S.of(context).TitleEdit,
                                                  body: S.of(context).shiftBody,
                                                  onPressed: () {
                                                    context
                                                        .read<EditShiftCubit>()
                                                        .editShift(id);
                                                  });
                                            });
                                      }
                                    },
                                    color: AppColor.primaryColor,
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
