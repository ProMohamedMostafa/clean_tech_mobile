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
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/create_devices/logic/cubit/add_device_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AddDeviceBody extends StatelessWidget {
  const AddDeviceBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddDeviceCubit>();
    return Scaffold(
      appBar: AppBar(leading: CustomBackButton(), title: Text(S.of(context).create_device)),
      body: BlocConsumer<AddDeviceCubit, AddDeviceState>(
        listener: (context, state) {
          if (state is AddDeviceSuccessState) {
            toast(text: state.message, isSuccess: true);
            context.popWithTrueResult();
          }
          if (state is AddDeviceErrorState) {
            toast(text: state.error, isSuccess: false);
          }
        },
        builder: (context, state) {
          if (cubit.buildingModel?.data == null) {
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
                                        S.of(context).device_name,
                                        style: TextStyles.font16BlackRegular,
                                      ),
                                      verticalSpace(5),
                                      CustomTextFormField(
                                        onlyRead: false,
                                        hint: S.of(context).name,
                                        controller: cubit.nameController,
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
                                        S.of(context).Building,
                                        style: TextStyles.font16BlackRegular,
                                      ),
                                      verticalSpace(5),
                                      CustomDropDownList(
                                        hint: S.of(context).selectBuilding,
                                        controller: cubit.buildingController,
                                        items: cubit.buildingModel!.data!
                                            .map((e) => e.name ?? 'Unknown')
                                            .toList(),
                                        onChanged: (value) {
                                          final selectedBuilding = cubit
                                              .buildingModel?.data
                                              ?.firstWhere((org) =>
                                                  org.name ==
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
                                        hint: S.of(context).selectFloor,
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
                                            cubit.sectionIdController.text =
                                                selectedSection;
                                          }
                                        },
                                        validator: (value) {
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
                                    ],
                                  )),
                                  verticalSpace(20),
                                  state is AddDeviceLoadingState
                                      ? Loading()
                                      : Center(
                                          child: DefaultElevatedButton(
                                              name: S.of(context).createButton,
                                              onPressed: () {
                                                if (cubit.formKey.currentState!
                                                    .validate()) {
                                                  cubit.addDevice();
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
