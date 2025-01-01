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
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_point/logic/edit_point_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_point/logic/edit_point_state.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_point/ui/widgets/edit_list_point_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_point/ui/widgets/edit_point_text_form_field.dart';

import 'package:smart_cleaning_application/generated/l10n.dart';

class EditPointBody extends StatefulWidget {
  final int id;
  const EditPointBody({super.key, required this.id});

  @override
  State<EditPointBody> createState() => _EditPointBodyState();
}

class _EditPointBodyState extends State<EditPointBody> {
  int? areaId;
  int? cityId;
  int? organizationId;
  int? buildingId;
  int? floorId;
  @override
  void initState() {
    context.read<EditPointCubit>().getPointDetailsInEdit(widget.id);
    context.read<EditPointCubit>().getNationality();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text('Edit Point', style: TextStyles.font16BlackSemiBold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<EditPointCubit, EditPointState>(
          listener: (context, state) {
            if (state is EditPointSuccessState) {
              toast(text: state.pointEditModel.message!, color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.organizationsScreen);
            }
            if (state is EditPointErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            final cubit = context.read<EditPointCubit>();
            if (state is GetPointDetailsLoadingState ||
                cubit.pointDetailsInEditModel == null) {
              // Show loading indicator
              return const Center(
                child: CircularProgressIndicator(color: AppColor.primaryColor),
              );
            }

            final pointDetails = cubit.pointDetailsInEditModel?.data;

            if (pointDetails == null) {
              return const Center(
                child: Text("Failed to load point details."),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: context.read<EditPointCubit>().formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(20),
                      Text(
                        S.of(context).addUserText12,
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditListPointTextFormField(
                        hint: context
                            .read<EditPointCubit>()
                            .pointDetailsInEditModel!
                            .data!
                            .countryName!,
                        items: context
                                    .read<EditPointCubit>()
                                    .nationalityModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No country']
                            : context
                                    .read<EditPointCubit>()
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
                              .read<EditPointCubit>()
                              .nationalityController
                              .text = value!;
                          context.read<EditPointCubit>().getArea(value);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<EditPointCubit>()
                            .nationalityController,
                        readOnly: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(15),
                      Text(
                        "Area",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditListPointTextFormField(
                        hint: context
                            .read<EditPointCubit>()
                            .pointDetailsInEditModel!
                            .data!
                            .areaName!,
                        items: context
                                    .read<EditPointCubit>()
                                    .areaModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No areas']
                            : context
                                    .read<EditPointCubit>()
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
                              .read<EditPointCubit>()
                              .areaModel
                              ?.data
                              ?.firstWhere((area) =>
                                  area.name ==
                                  context
                                      .read<EditPointCubit>()
                                      .areaController
                                      .text);

                          context
                              .read<EditPointCubit>()
                              .getCity(selectedArea!.id!);
                          areaId = selectedArea.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditPointCubit>().areaController,
                        readOnly: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(15),
                      Text(
                        "City",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditListPointTextFormField(
                        hint: context
                            .read<EditPointCubit>()
                            .pointDetailsInEditModel!
                            .data!
                            .cityName!,
                        items: context
                                    .read<EditPointCubit>()
                                    .cityModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No cities']
                            : context
                                    .read<EditPointCubit>()
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
                              .read<EditPointCubit>()
                              .cityModel
                              ?.data
                              ?.firstWhere((city) =>
                                  city.name ==
                                  context
                                      .read<EditPointCubit>()
                                      .cityController
                                      .text);

                          context
                              .read<EditPointCubit>()
                              .getOrganization(selectedCity!.id!);
                          cityId = selectedCity.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditPointCubit>().cityController,
                        readOnly: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(15),
                      Text(
                        "Organization",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditListPointTextFormField(
                        hint: context
                            .read<EditPointCubit>()
                            .pointDetailsInEditModel!
                            .data!
                            .organizationName!,
                        items: context
                                    .read<EditPointCubit>()
                                    .organizationModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No organizations']
                            : context
                                    .read<EditPointCubit>()
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
                              .read<EditPointCubit>()
                              .organizationModel
                              ?.data
                              ?.firstWhere((organization) =>
                                  organization.name ==
                                  context
                                      .read<EditPointCubit>()
                                      .organizationController
                                      .text);

                          context
                              .read<EditPointCubit>()
                              .getBuilding(selectedOrganization!.id!);
                          organizationId = selectedOrganization.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<EditPointCubit>()
                            .organizationController,
                        readOnly: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(15),
                      Text(
                        "Building",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditListPointTextFormField(
                        hint: context
                            .read<EditPointCubit>()
                            .pointDetailsInEditModel!
                            .data!
                            .buildingName!,
                        items: context
                                    .read<EditPointCubit>()
                                    .buildingModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No building']
                            : context
                                    .read<EditPointCubit>()
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
                              .read<EditPointCubit>()
                              .buildingModel
                              ?.data
                              ?.firstWhere((building) =>
                                  building.name ==
                                  context
                                      .read<EditPointCubit>()
                                      .buildingController
                                      .text);

                          context
                              .read<EditPointCubit>()
                              .getFloor(selectedBuilding!.id!);
                          buildingId = selectedBuilding.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditPointCubit>().buildingController,
                        readOnly: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(15),
                      Text(
                        "Floor",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditListPointTextFormField(
                        hint: context
                            .read<EditPointCubit>()
                            .pointDetailsInEditModel!
                            .data!
                            .floorName!,
                        items: context
                                    .read<EditPointCubit>()
                                    .floorModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No floor']
                            : context
                                    .read<EditPointCubit>()
                                    .floorModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value == 'No floor') {
                            return "Floor is required";
                          }
                        },
                        onChanged: (value) {
                          final selectedFloor = context
                              .read<EditPointCubit>()
                              .floorModel
                              ?.data
                              ?.firstWhere((floor) =>
                                  floor.name ==
                                  context
                                      .read<EditPointCubit>()
                                      .floorController
                                      .text);

                          context
                              .read<EditPointCubit>()
                              .getPoints(selectedFloor!.id!);
                          floorId = selectedFloor.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditPointCubit>().floorController,
                        readOnly: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(15),
                      Text(
                        "Edit Point Name",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditPointTextField(
                        hint: context
                            .read<EditPointCubit>()
                            .pointDetailsInEditModel!
                            .data!
                            .name!,
                        controller:
                            context.read<EditPointCubit>().pointController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Point is required";
                          }
                        },
                        obscureText: false,
                      ),
                      verticalSpace(15),
                      Text(
                        "Add point Number",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditPointTextField(
                        hint: context
                            .read<EditPointCubit>()
                            .pointDetailsInEditModel!
                            .data!
                            .number!,
                        controller: context
                            .read<EditPointCubit>()
                            .pointNumberController,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Point number is required";
                          }
                        },
                      ),
                      verticalSpace(15),
                      Text(
                        "Add point description",
                        style: TextStyles.font16BlackRegular,
                      ),
                      SizedBox(
                        height: 150.h,
                        width: double.infinity,
                        child: TextFormField(
                          controller: context
                              .read<EditPointCubit>()
                              .pointDescriptionController,
                          textAlignVertical: TextAlignVertical.top,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          expands: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Point description is required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(5),
                              hintText: context
                                  .read<EditPointCubit>()
                                  .pointDetailsInEditModel!
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
                      state is EditPointLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: AppColor.primaryColor),
                            )
                          : DefaultElevatedButton(
                              name: "Edit",
                              onPressed: () {
                                showCustomDialog(context,
                                    "Are you Sure you want save the edit of this Point ?",
                                    () {
                                  context.read<EditPointCubit>().editPoint(
                                      widget.id,
                                      areaId,
                                      cityId,
                                      organizationId,
                                      buildingId,
                                      floorId);
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
