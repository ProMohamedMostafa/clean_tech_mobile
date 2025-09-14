import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/custom_drop_down_list/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/custom_text_form_field.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/edit_feedback_audit/logic/cubit/edit_feedback_audit_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/edit_feedback_audit/logic/cubit/edit_feedback_audit_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EditFeedbackAuditBody extends StatelessWidget {
  final int selectIndex;
  final int id;
  const EditFeedbackAuditBody(
      {super.key, required this.selectIndex, required this.id});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditFeedbackAuditCubit>();
    return Scaffold(
      appBar: AppBar(
          leading: CustomBackButton(),
          title: Text("${S.of(context).editButton} ${selectIndex == 0 ? S.of(context).feedback : S.of(context).audit}")),
      body: BlocConsumer<EditFeedbackAuditCubit, EditFeedbackAuditState>(
        listener: (context, state) {
          if (state is EditFeedbackAuditSuccessState) {
            toast(text: state.message, isSuccess: true);
            context.popWithTrueResult();
          }
          if (state is EditFeedbackAuditErrorState) {
            toast(text: state.error, isSuccess: false);
          }
        },
        builder: (context, state) {
          if (cubit.organizationBasicModel?.data! == null ||
              cubit.feedbackAuditDetailsModel?.data! == null) {
            return Loading();
          }
          return CustomScrollView(slivers: [
            SliverFillRemaining(
                hasScrollBody: false,
                child: SafeArea(
                    child: Form(
                        key: cubit.formKey,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${selectIndex == 0 ? S.of(context).feedback : S.of(context).audit} ${S.of(context).name}",
                                        style: TextStyles.font16BlackRegular,
                                      ),
                                      verticalSpace(5),
                                      CustomTextFormField(
                                        onlyRead: false,
                                        hint: S.of(context).name,
                                        controller: cubit.nameController
                                          ..text = cubit
                                              .feedbackAuditDetailsModel!
                                              .data!
                                              .name!,
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return S.of(context).nameRequired;
                                          } else if (value.length > 55) {
                                            return S.of(context).nameTooLong;
                                          } else if (value.length < 3) {
                                            return S.of(context).nameTooShort;
                                          }
                                          return null;
                                        },
                                      ),
                                      verticalSpace(10),
                                      Text(
                                        S.of(context).Organization,
                                        style: TextStyles.font16BlackRegular,
                                      ),
                                      verticalSpace(5),
                                      CustomDropDownList(
                                        hint: cubit.feedbackAuditDetailsModel!
                                                .data!.organizationName ??
                                            S.of(context).selectOrganization,
                                        controller:
                                            cubit.organizationController,
                                        items: cubit
                                            .organizationBasicModel!.data!
                                            .map((e) => e.name ?? 'Unknown')
                                            .toList(),
                                        onChanged: (value) {
                                          final selectedOrganization = cubit
                                              .organizationBasicModel?.data
                                              ?.firstWhere((org) =>
                                                  org.name ==
                                                  cubit.organizationController
                                                      .text)
                                              .id
                                              ?.toString();

                                          if (selectedOrganization != null) {
                                            cubit.organizationIdController
                                                .text = selectedOrganization;
                                          }
                                          cubit.getBuilding();
                                        },
                                        suffixIcon: IconBroken.arrowDown2,
                                        keyboardType: TextInputType.text,
                                      ),
                                      verticalSpace(10),
                                      Text(
                                        S.of(context).Building,
                                        style: TextStyles.font16BlackRegular,
                                      ),
                                      verticalSpace(5),
                                      CustomDropDownList(
                                        hint: cubit.feedbackAuditDetailsModel!
                                                .data!.buildingName ??
                                            S.of(context).selectBuilding,
                                        controller: cubit.buildingController,
                                        items: cubit.buildingItem
                                            .map((e) => e.name ?? 'Unknown')
                                            .toList(),
                                        onChanged: (value) {
                                          final selectedBuilding = cubit
                                              .buildingModel?.data?.data
                                              ?.firstWhere((bld) =>
                                                  bld.name ==
                                                  cubit.buildingController.text)
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
                                      Text(
                                        S.of(context).Floor,
                                        style: TextStyles.font16BlackRegular,
                                      ),
                                      verticalSpace(5),
                                      CustomDropDownList(
                                        hint: cubit.feedbackAuditDetailsModel!
                                                .data!.floorName ??
                                            S.of(context).selectFloor,
                                        controller: cubit.floorController,
                                        items: cubit.floorItem
                                            .map((e) => e.name ?? 'Unknown')
                                            .toList(),
                                        onChanged: (value) {
                                          final selectedFloor = cubit
                                              .floorModel?.data?.data
                                              ?.firstWhere((floor) =>
                                                  floor.name ==
                                                  cubit.floorController.text)
                                              .id
                                              ?.toString();

                                          if (selectedFloor != null) {
                                            cubit.floorIdController.text =
                                                selectedFloor;
                                          }
                                          cubit.getSection();
                                        },
                                        suffixIcon: IconBroken.arrowDown2,
                                        keyboardType: TextInputType.text,
                                      ),
                                      verticalSpace(10),
                                      Text(
                                        S.of(context).Section,
                                        style: TextStyles.font16BlackRegular,
                                      ),
                                      verticalSpace(5),
                                      CustomDropDownList(
                                        hint: cubit.feedbackAuditDetailsModel!
                                                .data!.sectionName ??
                                            S.of(context).selectSection,
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
                                            cubit.sectionIdController.text =
                                                selectedSection;
                                          }
                                        },
                                        validator: (value) {
                                          if ((cubit
                                                      .feedbackAuditDetailsModel
                                                      ?.data
                                                      ?.sectionName
                                                      ?.isNotEmpty ??
                                                  false) ||
                                              cubit.sectionController.text
                                                  .isNotEmpty) {
                                            return null;
                                          }

                                          if (value == null || value.isEmpty) {
                                            return S
                                                .of(context)
                                                .sectionNameRequired;
                                          }

                                          return null;
                                        },
                                        suffixIcon: IconBroken.arrowDown2,
                                        keyboardType: TextInputType.text,
                                      ),
                                      if (selectIndex == 0) ...[
                                        verticalSpace(10),
                                        RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: S.of(context).device,
                                                style: TextStyles
                                                    .font16BlackRegular,
                                              ),
                                              TextSpan(
                                                text:
                                                    S.of(context).labelOptional,
                                                style: TextStyles
                                                    .font14GreyRegular,
                                              ),
                                            ],
                                          ),
                                        ),
                                        verticalSpace(5),
                                        CustomDropDownList(
                                          hint: cubit.feedbackAuditDetailsModel!
                                                  .data!.feedbackDeviceName ??
                                              S.of(context).select_device,
                                          controller: cubit.deviceController,
                                          items: cubit.deviceData
                                              .map((e) => e.name ?? 'Unknown')
                                              .toList(),
                                          onChanged: (value) {
                                            final selectedDevice = cubit
                                                .devicesModel?.data?.data
                                                ?.firstWhere((device) =>
                                                    device.name ==
                                                    cubit.deviceController.text)
                                                .id
                                                ?.toString();

                                            if (selectedDevice != null) {
                                              cubit.deviceIdController.text =
                                                  selectedDevice;
                                            }
                                          },
                                          suffixIcon: IconBroken.arrowDown2,
                                          keyboardType: TextInputType.text,
                                        )
                                      ]
                                    ],
                                  )),
                                  verticalSpace(20),
                                  state is EditFeedbackAuditLoadingState
                                      ? Loading()
                                      : Center(
                                          child: DefaultElevatedButton(
                                              name: S.of(context).editButton,
                                              onPressed: () {
                                                if (cubit.formKey.currentState!
                                                    .validate()) {
                                                  cubit.editFeedbackAudit(
                                                      selectIndex, id);
                                                }
                                              },
                                              color: AppColor.primaryColor,
                                              textStyles: TextStyles
                                                  .font16WhiteSemiBold),
                                        ),
                                  verticalSpace(20),
                                ])))))
          ]);
        },
      ),
    );
  }
}
