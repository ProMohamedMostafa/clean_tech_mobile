import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/logic/add_organization_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/logic/add_organization_state.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/ui/widgets/add_organization_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/organization/add_organizations/ui/widgets/organization_text_form_field.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AddOrganizationDetailsScreen extends StatefulWidget {
  const AddOrganizationDetailsScreen({super.key});

  @override
  State<AddOrganizationDetailsScreen> createState() => _AddOrganizationDetailsScreenState();
}

class _AddOrganizationDetailsScreenState extends State<AddOrganizationDetailsScreen> {
  @override
  void initState() {
    context.read<AddOrganizationCubit>().getNationality();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text('Add Organization', style: TextStyles.font16BlackSemiBold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: BlocConsumer<AddOrganizationCubit, AddOrganizationState>(
          listener: (context, state) {
            if (state is CreateOrganizationSuccessState) {
              toast(text: state.message, color: Colors.blue);
              context.pop();
            }
            if (state is CreateOrganizationErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: context.read<AddOrganizationCubit>().formAddKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(20),
                    _buildDetailsField(),
                    verticalSpace(16),
                    _buildContinueButton(state),
                  ],
                ),
              ),
            );
          },
        )),
      ),
    );
  }

  Widget _buildDetailsField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).addUserText12,
          style: TextStyles.font16BlackRegular,
        ),
        OrganizationTextFormField(
          hint: "Select country",
          items: context
                      .read<AddOrganizationCubit>()
                      .nationalityModel
                      ?.data
                      ?.isEmpty ??
                  true
              ? ['No country']
              : context
                      .read<AddOrganizationCubit>()
                      .nationalityModel
                      ?.data
                      ?.map((e) => e.name ?? 'Unknown')
                      .toList() ??
                  [],
          validator: (value) {
            if (value == null || value.isEmpty || value == 'No country') {
              return S.of(context).validationNationality;
            }
          },
          onChanged: (value) {
            context.read<AddOrganizationCubit>().nationalityController.text =
                value!;
            context.read<AddOrganizationCubit>().getArea(value);
          },
          suffixIcon: IconBroken.arrowDown2,
          controller:
              context.read<AddOrganizationCubit>().nationalityController,
          readOnly: false,
          keyboardType: TextInputType.text,
        ),
        verticalSpace(15),
        Text(
          "Area",
          style: TextStyles.font16BlackRegular,
        ),
        OrganizationTextFormField(
          hint: "Select area",
          items:
              context.read<AddOrganizationCubit>().areaModel?.data?.isEmpty ??
                      true
                  ? ['No areas']
                  : context
                          .read<AddOrganizationCubit>()
                          .areaModel
                          ?.data
                          ?.map((e) => e.name ?? 'Unknown')
                          .toList() ??
                      [],
          validator: (value) {
            if (value == null || value.isEmpty || value == 'No areas') {
              return "Area is required";
            }
          },
          onChanged: (value) {
            final selectedArea = context
                .read<AddOrganizationCubit>()
                .areaModel
                ?.data
                ?.firstWhere((area) =>
                    area.name ==
                    context.read<AddOrganizationCubit>().areaController.text);

            context.read<AddOrganizationCubit>().getCity(selectedArea!.id!);
          },
          suffixIcon: IconBroken.arrowDown2,
          controller: context.read<AddOrganizationCubit>().areaController,
          readOnly: false,
          keyboardType: TextInputType.text,
        ),
        verticalSpace(15),
        Text(
          "City",
          style: TextStyles.font16BlackRegular,
        ),
        OrganizationTextFormField(
          hint: "Select city",
          items:
              context.read<AddOrganizationCubit>().cityModel?.data?.isEmpty ??
                      true
                  ? ['No cities']
                  : context
                          .read<AddOrganizationCubit>()
                          .cityModel
                          ?.data
                          ?.map((e) => e.name ?? 'Unknown')
                          .toList() ??
                      [],
          validator: (value) {
            if (value == null || value.isEmpty || value == 'No cities') {
              return "City is required";
            }
          },
          onChanged: (value) {
            final selectedCity = context
                .read<AddOrganizationCubit>()
                .cityModel
                ?.data
                ?.firstWhere((city) =>
                    city.name ==
                    context.read<AddOrganizationCubit>().cityController.text);

            context
                .read<AddOrganizationCubit>()
                .getOrganization(selectedCity!.id!);
          },
          suffixIcon: IconBroken.arrowDown2,
          controller: context.read<AddOrganizationCubit>().cityController,
          readOnly: false,
          keyboardType: TextInputType.text,
        ),
        verticalSpace(15),
        Text(
          "Add organization",
          style: TextStyles.font16BlackRegular,
        ),
        AddOrganizationTextField(
          controller:
              context.read<AddOrganizationCubit>().addOrganizationController,
          obscureText: false,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Organization is required";
            }
          },
        ),
        verticalSpace(15),
      ],
    );
  }

  Widget _buildContinueButton(state) {
    return state is CreateCityLoadingState
        ? const Center(
            child: CircularProgressIndicator(color: AppColor.primaryColor),
          )
        : DefaultElevatedButton(
            name: "Add",
            onPressed: () {
              if (context
                  .read<AddOrganizationCubit>()
                  .formAddKey
                  .currentState!
                  .validate()) {
                final selectedCity = context
                    .read<AddOrganizationCubit>()
                    .cityModel
                    ?.data
                    ?.firstWhere((city) =>
                        city.name ==
                        context
                            .read<AddOrganizationCubit>()
                            .cityController
                            .text);

                context
                    .read<AddOrganizationCubit>()
                    .createOrganization(selectedCity!.id!);
              }
            },
            color: AppColor.primaryColor,
            height: 47.h,
            width: double.infinity,
            textStyles: TextStyles.font20Whitesemimedium,
          );
  }
}
