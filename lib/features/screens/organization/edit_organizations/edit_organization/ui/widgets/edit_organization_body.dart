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
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_organization/logic/edit_organization_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_organization/logic/edit_organization_state.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_organization/ui/widgets/edit_list_organization_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_organization/ui/widgets/edit_organization_text_form_field.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EditOrganizationBody extends StatefulWidget {
  final int id;
  const EditOrganizationBody({super.key, required this.id});

  @override
  State<EditOrganizationBody> createState() => _EditOrganizationBodyState();
}

class _EditOrganizationBodyState extends State<EditOrganizationBody> {
  int? areaId;
  int? cityId;
  @override
  void initState() {
    context
        .read<EditOrganizationCubit>()
        .getOrganizationDetailsInEdit(widget.id);
    context.read<EditOrganizationCubit>().getNationality();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text('Edit Organization', style: TextStyles.font16BlackSemiBold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<EditOrganizationCubit, EditOrganizationState>(
          listener: (context, state) {
            if (state is EditOrganizationSuccessState) {
              toast(
                  text: state.editOrganizationModel.message!,
                  color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.organizationsScreen);
            }
            if (state is EditOrganizationErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            final cubit = context.read<EditOrganizationCubit>();
            if (state is GetOrganizationDetailsLoadingState ||
                cubit.organizationDetailsInEditModel == null) {
              // Show loading indicator
              return const Center(
                child: CircularProgressIndicator(color: AppColor.primaryColor),
              );
            }

            // Ensure data is non-null before building the UI
            final organizationDetails =
                cubit.organizationDetailsInEditModel?.data;

            if (organizationDetails == null) {
              // Handle case where data fetching fails
              return const Center(
                child: Text("Failed to load organization details."),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: context.read<EditOrganizationCubit>().formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(20),
                      Text(
                        S.of(context).addUserText12,
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditListOrganizationTextFormField(
                        hint: context
                            .read<EditOrganizationCubit>()
                            .organizationDetailsInEditModel!
                            .data!
                            .countryName!,
                        items: context
                                    .read<EditOrganizationCubit>()
                                    .nationalityModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No country']
                            : context
                                    .read<EditOrganizationCubit>()
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
                              .read<EditOrganizationCubit>()
                              .nationalityController
                              .text = value!;
                          context.read<EditOrganizationCubit>().getArea(value);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<EditOrganizationCubit>()
                            .nationalityController,
                        readOnly: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(15),
                      Text(
                        "Area",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditListOrganizationTextFormField(
                        hint: context
                            .read<EditOrganizationCubit>()
                            .organizationDetailsInEditModel!
                            .data!
                            .areaName!,
                        items: context
                                    .read<EditOrganizationCubit>()
                                    .areaModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No areas']
                            : context
                                    .read<EditOrganizationCubit>()
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
                              .read<EditOrganizationCubit>()
                              .areaModel
                              ?.data
                              ?.firstWhere((area) =>
                                  area.name ==
                                  context
                                      .read<EditOrganizationCubit>()
                                      .areaController
                                      .text);

                          context
                              .read<EditOrganizationCubit>()
                              .getCity(selectedArea!.id!);
                          areaId = selectedArea.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<EditOrganizationCubit>()
                            .areaController,
                        readOnly: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(15),
                      Text(
                        "City",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditListOrganizationTextFormField(
                        hint: context
                            .read<EditOrganizationCubit>()
                            .organizationDetailsInEditModel!
                            .data!
                            .cityName!,
                        items: context
                                    .read<EditOrganizationCubit>()
                                    .cityModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No cities']
                            : context
                                    .read<EditOrganizationCubit>()
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
                              .read<EditOrganizationCubit>()
                              .cityModel
                              ?.data
                              ?.firstWhere((city) =>
                                  city.name ==
                                  context
                                      .read<EditOrganizationCubit>()
                                      .cityController
                                      .text);

                          context
                              .read<EditOrganizationCubit>()
                              .getOrganization(selectedCity!.id!);
                          cityId = selectedCity.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<EditOrganizationCubit>()
                            .cityController,
                        readOnly: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(15),
                      Text(
                        "Edit organization",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditOrganizationTextField(
                        hint: context
                            .read<EditOrganizationCubit>()
                            .organizationDetailsInEditModel!
                            .data!
                            .name!,
                        controller: context
                            .read<EditOrganizationCubit>()
                            .organizationController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Organization is required";
                          }
                        },
                        obscureText: false,
                      ),
                      verticalSpace(15),
                   
                      state is EditOrganizationLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: AppColor.primaryColor),
                            )
                          : DefaultElevatedButton(
                              name: "Edit",
                              onPressed: () {
                                showCustomDialog(context,
                                    "Are you Sure you want save the edit of this organization ?",
                                    () {
                                  context
                                      .read<EditOrganizationCubit>()
                                      .editOrganization(
                                          widget.id, cityId, areaId);
                                  context.pop();
                                });
                              },
                              color: AppColor.primaryColor,
                              height: 48.h,
                              width: double.infinity,
                              textStyles: TextStyles.font20Whitesemimedium,
                            ),
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
