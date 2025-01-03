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
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_building/logic/edit_building_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_building/logic/edit_building_state.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_building/ui/widgets/edit_building_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_building/ui/widgets/edit_list_building_text_form_field.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EditBuildingBody extends StatefulWidget {
  final int id;
  const EditBuildingBody({super.key, required this.id});

  @override
  State<EditBuildingBody> createState() => _EditBuildingBodyState();
}

class _EditBuildingBodyState extends State<EditBuildingBody> {
  int? areaId;
  int? cityId;
  int? organizationId;
  @override
  void initState() {
    context.read<EditBuildingCubit>().getBuildingDetailsInEdit(widget.id);
    context.read<EditBuildingCubit>().getNationality();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text('Edit Building', style: TextStyles.font16BlackSemiBold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<EditBuildingCubit, EditBuildingState>(
          listener: (context, state) {
            if (state is EditBuildingSuccessState) {
              toast(text: state.buildingEditModel.message!, color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.organizationsScreen);
            }
            if (state is EditBuildingErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            final cubit = context.read<EditBuildingCubit>();
            if (state is GetBuildingDetailsLoadingState ||
                cubit.buildingDetailsInEditModel == null) {
              // Show loading indicator
              return const Center(
                child: CircularProgressIndicator(color: AppColor.primaryColor),
              );
            }

            // Ensure data is non-null before building the UI
            final buildingDetails = cubit.buildingDetailsInEditModel?.data;

            if (buildingDetails == null) {
              // Handle case where data fetching fails
              return const Center(
                child: Text("Failed to load building details."),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: context.read<EditBuildingCubit>().formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(20),
                      Text(
                        S.of(context).addUserText12,
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditListBuildingTextFormField(
                        hint: context
                            .read<EditBuildingCubit>()
                            .buildingDetailsInEditModel!
                            .data!
                            .countryName!,
                        items: context
                                    .read<EditBuildingCubit>()
                                    .nationalityModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No country']
                            : context
                                    .read<EditBuildingCubit>()
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
                              .read<EditBuildingCubit>()
                              .nationalityController
                              .text = value!;
                          context.read<EditBuildingCubit>().getArea(value);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<EditBuildingCubit>()
                            .nationalityController,
                        readOnly: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(15),
                      Text(
                        "Area",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditListBuildingTextFormField(
                        hint: context
                            .read<EditBuildingCubit>()
                            .buildingDetailsInEditModel!
                            .data!
                            .areaName!,
                        items: context
                                    .read<EditBuildingCubit>()
                                    .areaModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No areas']
                            : context
                                    .read<EditBuildingCubit>()
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
                              .read<EditBuildingCubit>()
                              .areaModel
                              ?.data
                              ?.firstWhere((area) =>
                                  area.name ==
                                  context
                                      .read<EditBuildingCubit>()
                                      .areaController
                                      .text);

                          context
                              .read<EditBuildingCubit>()
                              .getCity(selectedArea!.id!);
                          areaId = selectedArea.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditBuildingCubit>().areaController,
                        readOnly: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(15),
                      Text(
                        "City",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditListBuildingTextFormField(
                        hint: context
                            .read<EditBuildingCubit>()
                            .buildingDetailsInEditModel!
                            .data!
                            .cityName!,
                        items: context
                                    .read<EditBuildingCubit>()
                                    .cityModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No cities']
                            : context
                                    .read<EditBuildingCubit>()
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
                              .read<EditBuildingCubit>()
                              .cityModel
                              ?.data
                              ?.firstWhere((city) =>
                                  city.name ==
                                  context
                                      .read<EditBuildingCubit>()
                                      .cityController
                                      .text);

                          context
                              .read<EditBuildingCubit>()
                              .getOrganization(selectedCity!.id!);
                          cityId = selectedCity.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditBuildingCubit>().cityController,
                        readOnly: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(15),
                      Text(
                        "Organization",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditListBuildingTextFormField(
                        hint: context
                            .read<EditBuildingCubit>()
                            .buildingDetailsInEditModel!
                            .data!
                            .organizationName!,
                        items: context
                                    .read<EditBuildingCubit>()
                                    .organizationModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No organizations']
                            : context
                                    .read<EditBuildingCubit>()
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
                              .read<EditBuildingCubit>()
                              .organizationModel
                              ?.data
                              ?.firstWhere((organization) =>
                                  organization.name ==
                                  context
                                      .read<EditBuildingCubit>()
                                      .organizationController
                                      .text);

                          context
                              .read<EditBuildingCubit>()
                              .getBuilding(selectedOrganization!.id!);
                          organizationId = selectedOrganization.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<EditBuildingCubit>()
                            .organizationController,
                        readOnly: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(15),
                      Text(
                        "Edit building Name",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditBuildingTextField(
                        hint: context
                            .read<EditBuildingCubit>()
                            .buildingDetailsInEditModel!
                            .data!
                            .name!,
                        controller: context
                            .read<EditBuildingCubit>()
                            .buildingController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Building is required";
                          }
                        },
                        obscureText: false,
                      ),
                      verticalSpace(15),
                      Text(
                        "Add building Number",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditBuildingTextField(
                        hint: context
                            .read<EditBuildingCubit>()
                            .buildingDetailsInEditModel!
                            .data!
                            .number!,
                        controller: context
                            .read<EditBuildingCubit>()
                            .buildingNumberController,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Building number is required";
                          }
                        },
                      ),
                      verticalSpace(15),
                      Text(
                        "Add building description",
                        style: TextStyles.font16BlackRegular,
                      ),
                      SizedBox(
                        height: 150.h,
                        width: double.infinity,
                        child: TextFormField(
                          controller: context
                              .read<EditBuildingCubit>()
                              .buildingDescriptionController,
                          textAlignVertical: TextAlignVertical.top,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          expands: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Building description is required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(5),
                              hintText: context
                                  .read<EditBuildingCubit>()
                                  .buildingDetailsInEditModel!
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
                      state is EditBuildingLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: AppColor.primaryColor),
                            )
                          : DefaultElevatedButton(
                              name: "Edit",
                              onPressed: () {
                                showCustomDialog(context,
                                    "Are you Sure you want save the edit of this building ?",
                                    () {
                                  context
                                      .read<EditBuildingCubit>()
                                      .editBuilding(widget.id, areaId, cityId,
                                          organizationId);
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
