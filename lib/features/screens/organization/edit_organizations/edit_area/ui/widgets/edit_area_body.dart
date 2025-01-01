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
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_area/logic/edit_area_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_area/logic/edit_area_state.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_area/ui/widgets/edit_area_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/organization/edit_organizations/edit_area/ui/widgets/edit_list_area_text_form_field.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EditAreaBody extends StatefulWidget {
  final int id;
  const EditAreaBody({super.key, required this.id});

  @override
  State<EditAreaBody> createState() => _EditAreaBodyState();
}

class _EditAreaBodyState extends State<EditAreaBody> {
  @override
  void initState() {
    context.read<EditAreaCubit>().getAreaDetailsInEdit(widget.id);
    context.read<EditAreaCubit>().getNationality();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text('Edit Area', style: TextStyles.font16BlackSemiBold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<EditAreaCubit, EditAreaState>(
          listener: (context, state) {
            if (state is EditAreaSuccessState) {
              toast(text: state.editAreaModel.message!, color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.organizationsScreen);
            }
            if (state is EditAreaErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            final cubit = context.read<EditAreaCubit>();
            if (state is GetAreaDetailsLoadingState ||
                cubit.areaDetailsInEditModel == null) {
              // Show loading indicator
              return const Center(
                child: CircularProgressIndicator(color: AppColor.primaryColor),
              );
            }

            // Ensure data is non-null before building the UI
            final areaDetails = cubit.areaDetailsInEditModel?.data;

            if (areaDetails == null) {
              // Handle case where data fetching fails
              return const Center(
                child: Text("Failed to load area details."),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: context.read<EditAreaCubit>().formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(20),
                      Text(
                        S.of(context).addUserText12,
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditListAreaTextFormField(
                        hint: context
                            .read<EditAreaCubit>()
                            .areaDetailsInEditModel!
                            .data!
                            .countryName!,
                        items: context
                                    .read<EditAreaCubit>()
                                    .nationalityModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No country']
                            : context
                                    .read<EditAreaCubit>()
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
                              .read<EditAreaCubit>()
                              .nationalityController
                              .text = value!;
                          context.read<EditAreaCubit>().getArea(value);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditAreaCubit>().nationalityController,
                        readOnly: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(15),
                      Text(
                        "Edit area",
                        style: TextStyles.font16BlackRegular,
                      ),
                      EditAreaTextField(
                        hint: context
                            .read<EditAreaCubit>()
                            .areaDetailsInEditModel!
                            .data!
                            .name!,
                        controller:
                            context.read<EditAreaCubit>().areaController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Area is required";
                          }
                        },
                        obscureText: false,
                      ),
                      verticalSpace(15),
                      verticalSpace(16),
                      state is EditAreaLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: AppColor.primaryColor),
                            )
                          : DefaultElevatedButton(
                              name: "Edit",
                              onPressed: () {
                                showCustomDialog(context,
                                    "Are you Sure you want save the edit of this area ?",
                                    () {
                                  context
                                      .read<EditAreaCubit>()
                                      .editArea(widget.id);
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
