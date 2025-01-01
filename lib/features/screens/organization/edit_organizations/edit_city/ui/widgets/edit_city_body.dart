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
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_city/logic/edit_city_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_city/logic/edit_city_state.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_city/ui/widgets/edit_city_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_city/ui/widgets/edit_list_city_text_form_field.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EditCityBody extends StatefulWidget {
  final int id;
  const EditCityBody({super.key, required this.id});

  @override
  State<EditCityBody> createState() => _EditCityBodyState();
}

class _EditCityBodyState extends State<EditCityBody> {
  int? areaId;
  @override
  void initState() {
    context.read<EditCityCubit>().getCityDetailsInEdit(widget.id);
    context.read<EditCityCubit>().getNationality();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text('Edit City', style: TextStyles.font16BlackSemiBold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<EditCityCubit, EditCityState>(
          listener: (context, state) {
            if (state is EditCitySuccessState) {
              toast(text: state.editCityModel.message!, color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.organizationsScreen);
            }
            if (state is EditCityErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            final cubit = context.read<EditCityCubit>();
            if (state is GetCityDetailsLoadingState ||
                cubit.cityDetailsInEditModel == null) {
              // Show loading indicator
              return const Center(
                child: CircularProgressIndicator(color: AppColor.primaryColor),
              );
            }

            // Ensure data is non-null before building the UI
            final cityDetails = cubit.cityDetailsInEditModel?.data;

            if (cityDetails == null) {
              // Handle case where data fetching fails
              return const Center(
                child: Text("Failed to load city details."),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: context.read<EditCityCubit>().formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(20),
                      Text(
                        S.of(context).addUserText12,
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditListCityTextFormField(
                        hint: context
                            .read<EditCityCubit>()
                            .cityDetailsInEditModel!
                            .data!
                            .countryName!,
                        items: context
                                    .read<EditCityCubit>()
                                    .nationalityModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No country']
                            : context
                                    .read<EditCityCubit>()
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
                              .read<EditCityCubit>()
                              .nationalityController
                              .text = value!;
                          context.read<EditCityCubit>().getArea(value);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditCityCubit>().nationalityController,
                        readOnly: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(15),
                      Text(
                        "Area",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditListCityTextFormField(
                        hint: context
                            .read<EditCityCubit>()
                            .cityDetailsInEditModel!
                            .data!
                            .areaName!,
                        items: context
                                    .read<EditCityCubit>()
                                    .areaModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No areas']
                            : context
                                    .read<EditCityCubit>()
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
                              .read<EditCityCubit>()
                              .areaModel
                              ?.data
                              ?.firstWhere((area) =>
                                  area.name ==
                                  context
                                      .read<EditCityCubit>()
                                      .areaController
                                      .text);

                          context
                              .read<EditCityCubit>()
                              .getCity(selectedArea!.id!);
                          areaId = selectedArea.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditCityCubit>().areaController,
                        readOnly: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(15),
                      Text(
                        "Edit city",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditCityTextField(
                        hint: context
                            .read<EditCityCubit>()
                            .cityDetailsInEditModel!
                            .data!
                            .name!,
                        controller:
                            context.read<EditCityCubit>().cityController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "City is required";
                          }
                        },
                        obscureText: false,
                      ),
                      verticalSpace(15),
                      state is EditCityLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: AppColor.primaryColor),
                            )
                          : DefaultElevatedButton(
                              name: "Edit",
                              onPressed: () {
                                showCustomDialog(context,
                                    "Are you Sure you want save the edit of this city ?",
                                    () {
                                  context
                                      .read<EditCityCubit>()
                                      .editCity(widget.id, areaId);
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
