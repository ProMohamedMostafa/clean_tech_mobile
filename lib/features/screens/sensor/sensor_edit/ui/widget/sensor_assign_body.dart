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
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/sensor/sensor_edit/logic/cubit/edit_sensor_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class SensorEditBody extends StatelessWidget {
  final int id;
  const SensorEditBody({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditSensorCubit>();
    return Scaffold(
      appBar: AppBar(
          title: Text(S.of(context).editLocation), leading: CustomBackButton()),
      body: BlocConsumer<EditSensorCubit, EditSensorState>(
        listener: (context, state) {
          if (state is EditSensorSuccessState) {
            toast(text: state.editSensorModel.message!, isSuccess: true);
            context.popWithTrueResult();
          }
          if (state is EditSensorErrorState) {
            toast(text: state.error, isSuccess: false);
          }
        },
        builder: (context, state) {
          if (cubit.sensorDetailsModel == null ||
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
                    S.of(context).name,
                    style: TextStyles.font16BlackRegular,
                  ),
                  CustomTextFormField(
                    controller: cubit.nameController
                      ..text = cubit.sensorDetailsModel!.data!.name!,
                    onlyRead: false,
                    hint: cubit.sensorDetailsModel!.data!.name ?? '',
                    keyboardType: TextInputType.text,
                  ),
                  verticalSpace(10),
                  Text(
                    S.of(context).Organization,
                    style: TextStyles.font16BlackRegular,
                  ),
                  verticalSpace(5),
                  CustomDropDownList(
                    hint:
                        cubit.sensorDetailsModel!.data!.organizationName ?? '',
                    items: cubit.organizationItem
                        .map((e) => e.name ?? 'Unknown')
                        .toList(),
                    onChanged: (value) {
                      final selectedOrganization = cubit
                          .organizationModel?.data?.data
                          ?.firstWhere((org) =>
                              org.name == cubit.organizationController.text)
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
                  verticalSpace(10),
                  Text(
                    S.of(context).Building,
                    style: TextStyles.font16BlackRegular,
                  ),
                  verticalSpace(5),
                  CustomDropDownList(
                    hint: cubit.sensorDetailsModel!.data!.buildingName ?? '',
                    items: cubit.buildingItem
                        .map((e) => e.name ?? 'Unknown')
                        .toList(),
                    onChanged: (value) {
                      final selectedBuilding = cubit.buildingModel?.data?.data
                          ?.firstWhere((bld) =>
                              bld.name == cubit.buildingController.text)
                          .id
                          ?.toString();

                      if (selectedBuilding != null) {
                        cubit.buildingIdController.text = selectedBuilding;
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
                    hint: cubit.sensorDetailsModel!.data!.floorName ?? '',
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
                    hint: cubit.sensorDetailsModel!.data!.sectionName ?? '',
                    items: cubit.sectionItem
                        .map((e) => e.name ?? 'Unknown')
                        .toList(),
                    onChanged: (value) {
                      final selectedSection = cubit.sectionModel?.data?.data
                          ?.firstWhere((section) =>
                              section.name == cubit.sectionController.text)
                          .id
                          ?.toString();

                      if (selectedSection != null) {
                        cubit.sectionIdController.text = selectedSection;
                      }
                      cubit.getPoint();
                    },
                    suffixIcon: IconBroken.arrowDown2,
                    controller: cubit.sectionController,
                    isRead: false,
                    keyboardType: TextInputType.text,
                  ),
                  verticalSpace(10),
                  Text(
                    S.of(context).Point,
                    style: TextStyles.font16BlackRegular,
                  ),
                  verticalSpace(5),
                  CustomDropDownList(
                    hint: cubit.sensorDetailsModel!.data!.pointName ?? '',
                    controller: cubit.pointController,
                    items: cubit.pointItem
                        .map((e) => e.name ?? 'Unknown')
                        .toList(),
                    onChanged: (value) {
                      final selectedPoint = cubit.pointModel?.data?.data
                          ?.firstWhere((point) =>
                              point.name == cubit.pointController.text)
                          .id
                          ?.toString();

                      if (selectedPoint != null) {
                        cubit.pointIdController.text = selectedPoint;
                      }
                    },
                    suffixIcon: IconBroken.arrowDown2,
                    keyboardType: TextInputType.text,
                  ),
                  verticalSpace(10),
                  Text(
                    S.of(context).discription,
                    style: TextStyles.font16BlackRegular,
                  ),
                  verticalSpace(10),
                  CustomDescriptionTextFormField(
                    controller: cubit.discriptionController
                      ..text = cubit.sensorDetailsModel!.data!.description!,
                    hint: cubit.sensorDetailsModel!.data!.description ?? '',
                  ),
                  verticalSpace(20),
                  state is EditSensorLoadingState
                      ? Loading()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: DefaultElevatedButton(
                                name: S.of(context).editButton,
                                onPressed: () {
                                  if (cubit.formKey.currentState!.validate()) {
                                    showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return PopUpMessage(
                                              title: S.of(context).TitleEdit,
                                              body: S.of(context).sensorBody,
                                              onPressed: () {
                                                cubit.editSensor(id);
                                              });
                                        });
                                  }
                                },
                                color: AppColor.primaryColor,
                                textStyles: TextStyles.font20Whitesemimedium,
                              ),
                            ),
                            if (cubit.sensorDetailsModel?.data?.pointId !=
                                null) ...[
                              horizontalSpace(10),
                              Expanded(
                                child: DefaultElevatedButton(
                                  name: S.of(context).RemoveLocationButton,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return PopUpMessage(
                                              title: S.of(context).TitleRemove,
                                              body: S.of(context).sensorBody,
                                              onPressed: () {
                                                cubit.pointIdController.text =
                                                    '';
                                                cubit.editSensor(id,
                                                    removeLocation: true);
                                              });
                                        });
                                  },
                                  color: Colors.red,
                                  textStyles: TextStyles.font20Whitesemimedium,
                                ),
                              ),
                            ]
                          ],
                        ),
                  verticalSpace(30),
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
