import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_floor/logic/edit_floor_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_floor/logic/edit_floor_state.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_floor/ui/widgets/edit_floor_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_floor/ui/widgets/edit_list_floor_text_form_field.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EditFloorBody extends StatefulWidget {
  final int id;
  const EditFloorBody({super.key, required this.id});

  @override
  State<EditFloorBody> createState() => _EditFloorBodyState();
}

class _EditFloorBodyState extends State<EditFloorBody> {
  int? areaId;
  int? cityId;
  int? organizationId;
  int? buildingId;
  @override
  void initState() {
    context.read<EditFloorCubit>().getFloorDetailsInEdit(widget.id);
    context.read<EditFloorCubit>().getNationality();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text('Edit Floor', style: TextStyles.font16BlackSemiBold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<EditFloorCubit, EditFloorState>(
          listener: (context, state) {
            if (state is EditFloorSuccessState) {
              toast(text: state.floorEditModel.message!, color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.organizationsScreen);
            }
            if (state is EditFloorErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            final cubit = context.read<EditFloorCubit>();
            if (state is GetFloorDetailsLoadingState ||
                cubit.floorDetailsInEditModel == null) {
              // Show loading indicator
              return const Center(
                child: CircularProgressIndicator(color: AppColor.primaryColor),
              );
            }

            final floorDetails = cubit.floorDetailsInEditModel?.data;

            if (floorDetails == null) {
              return const Center(
                child: Text("Failed to load floor details."),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: context.read<EditFloorCubit>().formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(20),
                      Text(
                        S.of(context).addUserText12,
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditListFloorTextFormField(
                        hint: context
                            .read<EditFloorCubit>()
                            .floorDetailsInEditModel!
                            .data!
                            .countryName!,
                        items: context
                                    .read<EditFloorCubit>()
                                    .nationalityModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No country']
                            : context
                                    .read<EditFloorCubit>()
                                    .nationalityModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value == 'No country') {
                            return S.of(context).validationNationality;
                          }
                        },
                        onChanged: (value) {
                          context
                              .read<EditFloorCubit>()
                              .nationalityController
                              .text = value!;
                          context.read<EditFloorCubit>().getArea(value);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<EditFloorCubit>()
                            .nationalityController,
                        readOnly: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(15),
                      Text(
                        "Area",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditListFloorTextFormField(
                        hint: context
                            .read<EditFloorCubit>()
                            .floorDetailsInEditModel!
                            .data!
                            .areaName!,
                        items: context
                                    .read<EditFloorCubit>()
                                    .areaModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No areas']
                            : context
                                    .read<EditFloorCubit>()
                                    .areaModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value == 'No areas') {
                            return "Area is required";
                          }
                        },
                        onChanged: (value) {
                          final selectedArea = context
                              .read<EditFloorCubit>()
                              .areaModel
                              ?.data
                              ?.firstWhere((area) =>
                                  area.name ==
                                  context
                                      .read<EditFloorCubit>()
                                      .areaController
                                      .text);

                          context
                              .read<EditFloorCubit>()
                              .getCity(selectedArea!.id!);
                          areaId = selectedArea.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditFloorCubit>().areaController,
                        readOnly: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(15),
                      Text(
                        "City",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditListFloorTextFormField(
                        hint: context
                            .read<EditFloorCubit>()
                            .floorDetailsInEditModel!
                            .data!
                            .cityName!,
                        items: context
                                    .read<EditFloorCubit>()
                                    .cityModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No cities']
                            : context
                                    .read<EditFloorCubit>()
                                    .cityModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value == 'No cities') {
                            return "City is required";
                          }
                        },
                        onChanged: (value) {
                          final selectedCity = context
                              .read<EditFloorCubit>()
                              .cityModel
                              ?.data
                              ?.firstWhere((city) =>
                                  city.name ==
                                  context
                                      .read<EditFloorCubit>()
                                      .cityController
                                      .text);

                          context
                              .read<EditFloorCubit>()
                              .getOrganization(selectedCity!.id!);
                          cityId = selectedCity.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditFloorCubit>().cityController,
                        readOnly: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(15),
                      Text(
                        "Organization",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditListFloorTextFormField(
                        hint: context
                            .read<EditFloorCubit>()
                            .floorDetailsInEditModel!
                            .data!
                            .organizationName!,
                        items: context
                                    .read<EditFloorCubit>()
                                    .organizationModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No organizations']
                            : context
                                    .read<EditFloorCubit>()
                                    .organizationModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value == 'No organizations') {
                            return "Organizations is required";
                          }
                        },
                        onChanged: (value) {
                          final selectedOrganization = context
                              .read<EditFloorCubit>()
                              .organizationModel
                              ?.data
                              ?.firstWhere((organization) =>
                                  organization.name ==
                                  context
                                      .read<EditFloorCubit>()
                                      .organizationController
                                      .text);

                          context
                              .read<EditFloorCubit>()
                              .getBuilding(selectedOrganization!.id!);
                          organizationId = selectedOrganization.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<EditFloorCubit>()
                            .organizationController,
                        readOnly: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(15),
                      Text(
                        "Building",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditListFloorTextFormField(
                        hint: context
                            .read<EditFloorCubit>()
                            .floorDetailsInEditModel!
                            .data!
                            .buildingName!,
                        items: context
                                    .read<EditFloorCubit>()
                                    .buildingModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No building']
                            : context
                                    .read<EditFloorCubit>()
                                    .buildingModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value == 'No building') {
                            return "Building is required";
                          }
                        },
                        onChanged: (value) {
                          final selectedBuilding = context
                              .read<EditFloorCubit>()
                              .buildingModel
                              ?.data
                              ?.firstWhere((building) =>
                                  building.name ==
                                  context
                                      .read<EditFloorCubit>()
                                      .buildingController
                                      .text);

                          context
                              .read<EditFloorCubit>()
                              .getFloor(selectedBuilding!.id!);
                          buildingId = selectedBuilding.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditFloorCubit>().buildingController,
                        readOnly: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(15),
                      Text(
                        "Edit Floor Name",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditFloorTextField(
                        hint: context
                            .read<EditFloorCubit>()
                            .floorDetailsInEditModel!
                            .data!
                            .name!,
                        controller:
                            context.read<EditFloorCubit>().floorController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Floor is required";
                          }
                        },
                        obscureText: false,
                      ),
                      verticalSpace(15),
                      Text(
                        "Add floor Number",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditFloorTextField(
                        hint: context
                            .read<EditFloorCubit>()
                            .floorDetailsInEditModel!
                            .data!
                            .number!,
                        controller: context
                            .read<EditFloorCubit>()
                            .floorNumberController,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Floor number is required";
                          }
                        },
                      ),
                      verticalSpace(15),
                      Text(
                        "Add Floor description",
                        style: TextStyles.font16BlackRegular,
                      ),
                      SizedBox(
                        height: 150.h,
                        width: double.infinity,
                        child: TextFormField(
                          controller: context
                              .read<EditFloorCubit>()
                              .floorDescriptionController,
                          textAlignVertical: TextAlignVertical.top,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          expands: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Floor description is required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(5),
                              hintText: context
                                  .read<EditFloorCubit>()
                                  .floorDetailsInEditModel!
                                  .data!
                                  .description!,
                              hintStyle: TextStyle(
                                  color: AppColor.thirdColor, fontSize: 14.sp),
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                      ),
                      verticalSpace(15),
                      state is EditFloorLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: AppColor.primaryColor),
                            )
                          : DefaultElevatedButton(
                              name: "Edit",
                              onPressed: () {
                                showCustomDialog(context,
                                    "Are you Sure you want save the edit of this Floor ?",
                                    () {
                                  context.read<EditFloorCubit>().editFloor(
                                      widget.id,
                                      areaId,
                                      cityId,
                                      organizationId,
                                      buildingId);
                                  context.pop();
                                });
                              },
                              color: AppColor.primaryColor,
                              height: 48.h,
                              width: double.infinity,
                              textStyles: TextStyles.font20Whitesemimedium,
                            ),
                      verticalSpace(20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
