import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
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
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/area_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_area/logic/edit_area_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_area/logic/edit_area_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EditAreaBody extends StatefulWidget {
  final int id;
  const EditAreaBody({super.key, required this.id});

  @override
  State<EditAreaBody> createState() => _EditAreaBodyState();
}

class _EditAreaBodyState extends State<EditAreaBody> {
  List<int> selectedManagersIds = [];
  List<int> selectedSupervisorsIds = [];
  List<int> selectedCleanersIds = [];
  @override
  void initState() {
    context.read<EditAreaCubit>().getAreaDetailsInEdit(widget.id);
    context.read<EditAreaCubit>().getAreaManagersDetails(widget.id);
    context.read<EditAreaCubit>().getNationality();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text('Edit Area'),
      ),
      body: SafeArea(
        child: BlocConsumer<EditAreaCubit, EditAreaState>(
          listener: (context, state) {
            if (state is EditAreaSuccessState) {
              toast(text: state.editAreaModel.message!, color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.workLocationScreen,
                  arguments: 0);
            }
            if (state is EditAreaErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            final cubit = context.read<EditAreaCubit>();
            if (cubit.areaDetailsInEditModel == null) {
              return const Center(
                child: CircularProgressIndicator(color: AppColor.primaryColor),
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
                        Text(
                          S.of(context).addUserText12,
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
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
                          onPressed: (value) {
                            context
                                .read<EditAreaCubit>()
                                .nationalityController
                                .text = value;
                            context.read<EditAreaCubit>().getAreas(value);
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller: context
                              .read<EditAreaCubit>()
                              .nationalityController,
                          isRead: false,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                        Text(
                          "Area Name",
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomTextFormField(
                          controller:
                              context.read<EditAreaCubit>().areaController
                                ..text = context
                                    .read<EditAreaCubit>()
                                    .areaDetailsInEditModel!
                                    .data!
                                    .name!,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Area name is required";
                            } else if (value.length > 55) {
                              return 'Area name too long';
                            } else if (value.length < 3) {
                              return 'Area name too short';
                            }
                            return null;
                          },
                          hint: context
                              .read<EditAreaCubit>()
                              .areaDetailsInEditModel!
                              .data!
                              .name!,
                          onlyRead: false,
                        ),
                        verticalSpace(10),
                        context
                                    .read<EditAreaCubit>()
                                    .areaUsersDetailsModel
                                    ?.data ==
                                null
                            ? SizedBox.shrink()
                            : RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Managers',
                                      style: TextStyles.font16BlackRegular,
                                    ),
                                    TextSpan(
                                      text: ' (Optional)',
                                      style: TextStyles.font14GreyRegular,
                                    ),
                                  ],
                                ),
                              ),
                        context
                                    .read<EditAreaCubit>()
                                    .areaUsersDetailsModel
                                    ?.data ==
                                null
                            ? SizedBox.shrink()
                            : MultiDropdown<Users>(
                                items: context
                                        .read<EditAreaCubit>()
                                        .areaUsersDetailsModel!
                                        .data!
                                        .users!
                                        .where((user) => user.role == 'Manager')
                                        .isEmpty
                                    ? [
                                        DropdownItem(
                                          label: 'No managers available',
                                          value: Users(
                                              id: null,
                                              userName:
                                                  'No managers available'),
                                        )
                                      ]
                                    : context
                                        .read<EditAreaCubit>()
                                        .areaUsersDetailsModel!
                                        .data!
                                        .users!
                                        .where((user) => user.role == 'Manager')
                                        .map((manager) => DropdownItem(
                                              label: manager.userName!,
                                              value: manager,
                                            ))
                                        .toList(),
                                controller: context
                                    .read<EditAreaCubit>()
                                    .allmanagersController,
                                enabled: true,
                                chipDecoration: ChipDecoration(
                                  backgroundColor: Colors.grey[300],
                                  wrap: true,
                                  runSpacing: 5,
                                  spacing: 5,
                                ),
                                fieldDecoration: FieldDecoration(
                                  hintText:  context
                                        .read<EditAreaCubit>()
                                        .areaUsersDetailsModel!
                                        .data!
                                        .users!
                                        .where((user) => user.role == 'Manager')
                                      .map((manager) => manager.userName)
                                      .join(', '),
                                  suffixIcon: Icon(IconBroken.arrowDown2),
                                  hintStyle: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColor.thirdColor),
                                  showClearIcon: false,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                dropdownDecoration: const DropdownDecoration(
                                  maxHeight: 200,
                                ),
                                dropdownItemDecoration: DropdownItemDecoration(
                                  selectedIcon: const Icon(Icons.check_box,
                                      color: Colors.blue),
                                ),
                                onSelectionChange: (selectedItems) {
                                  selectedManagersIds = selectedItems
                                      .map((item) => (item).id!)
                                      .toList();
                                },
                              ),
                        verticalSpace(10),
                        context
                                    .read<EditAreaCubit>()
                                    .areaUsersDetailsModel
                                    ?.data ==
                                null
                            ? SizedBox.shrink()
                            : RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Supervisors',
                                      style: TextStyles.font16BlackRegular,
                                    ),
                                    TextSpan(
                                      text: ' (Optional)',
                                      style: TextStyles.font14GreyRegular,
                                    ),
                                  ],
                                ),
                              ),
                        context
                                    .read<EditAreaCubit>()
                                    .areaUsersDetailsModel
                                    ?.data ==
                                null
                            ? SizedBox.shrink()
                            : MultiDropdown<Users>(
                                items:  context
                                        .read<EditAreaCubit>()
                                        .areaUsersDetailsModel!
                                        .data!
                                        .users!
                                        .where((user) => user.role == 'Supervisor').isEmpty
                                    ? [
                                        DropdownItem(
                                          label: 'No supervisors available',
                                          value: Users(
                                              id: null,
                                              userName:
                                                  'No supervisors available'),
                                        )
                                      ]
                                    :  context
                                        .read<EditAreaCubit>()
                                        .areaUsersDetailsModel!
                                        .data!
                                        .users!
                                        .where((user) => user.role == 'Supervisor')
                                        .map((supervisor) => DropdownItem(
                                              label: supervisor.userName!,
                                              value: supervisor,
                                            ))
                                        .toList(),
                                controller: context
                                    .read<EditAreaCubit>()
                                    .allSupervisorsController,
                                enabled: true,
                                chipDecoration: ChipDecoration(
                                  backgroundColor: Colors.grey[300],
                                  wrap: true,
                                  runSpacing: 5,
                                  spacing: 5,
                                ),
                                fieldDecoration: FieldDecoration(
                                  hintText:  context
                                        .read<EditAreaCubit>()
                                        .areaUsersDetailsModel!
                                        .data!
                                        .users!
                                        .where((user) => user.role == 'Supervisor')
                                      .map((supervisor) => supervisor.userName)
                                      .join(', '),
                                  suffixIcon: Icon(IconBroken.arrowDown2),
                                  hintStyle: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColor.thirdColor),
                                  showClearIcon: false,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                dropdownDecoration: const DropdownDecoration(
                                  maxHeight: 200,
                                ),
                                dropdownItemDecoration: DropdownItemDecoration(
                                  selectedIcon: const Icon(Icons.check_box,
                                      color: Colors.blue),
                                ),
                                onSelectionChange: (selectedItems) {
                                  selectedSupervisorsIds = selectedItems
                                      .map((item) => (item).id!)
                                      .toList();
                                },
                              ),
                        verticalSpace(10),
                        context
                                    .read<EditAreaCubit>()
                                    .areaUsersDetailsModel
                                    ?.data ==
                                null
                            ? SizedBox.shrink()
                            : RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Cleaners',
                                      style: TextStyles.font16BlackRegular,
                                    ),
                                    TextSpan(
                                      text: ' (Optional)',
                                      style: TextStyles.font14GreyRegular,
                                    ),
                                  ],
                                ),
                              ),
                        context
                                    .read<EditAreaCubit>()
                                    .areaUsersDetailsModel
                                    ?.data ==
                                null
                            ? SizedBox.shrink()
                            : MultiDropdown<Users>(
                                items: context
                                        .read<EditAreaCubit>()
                                        .areaUsersDetailsModel!
                                        .data!
                                        .users!
                                        .where((user) => user.role == 'Cleaner').isEmpty
                                    ? [
                                        DropdownItem(
                                          label: 'No cleaners available',
                                          value: Users(
                                              id: null,
                                              userName:
                                                  'No cleaners available'),
                                        )
                                      ]
                                    :  context
                                        .read<EditAreaCubit>()
                                        .areaUsersDetailsModel!
                                        .data!
                                        .users!
                                        .where((user) => user.role == 'Cleaner')
                                        .map((cleaner) => DropdownItem(
                                              label: cleaner.userName!,
                                              value: cleaner,
                                            ))
                                        .toList(),
                                controller: context
                                    .read<EditAreaCubit>()
                                    .allCleanersController,
                                enabled: true,
                                chipDecoration: ChipDecoration(
                                  backgroundColor: Colors.grey[300],
                                  wrap: true,
                                  runSpacing: 5,
                                  spacing: 5,
                                ),
                                fieldDecoration: FieldDecoration(
                                  hintText:  context
                                        .read<EditAreaCubit>()
                                        .areaUsersDetailsModel!
                                        .data!
                                        .users!
                                        .where((user) => user.role == 'Cleaner')
                                      .map((cleaner) => cleaner.userName)
                                      .join(', '),
                                  suffixIcon: Icon(IconBroken.arrowDown2),
                                  hintStyle: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColor.thirdColor),
                                  showClearIcon: false,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                dropdownDecoration: const DropdownDecoration(
                                  maxHeight: 200,
                                ),
                                dropdownItemDecoration: DropdownItemDecoration(
                                  selectedIcon: const Icon(Icons.check_box,
                                      color: Colors.blue),
                                ),
                                onSelectionChange: (selectedItems) {
                                  selectedCleanersIds = selectedItems
                                      .map((item) => (item).id!)
                                      .toList();
                                },
                              ),
                        verticalSpace(20),
                        state is EditAreaLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: AppColor.primaryColor),
                              )
                            : DefaultElevatedButton(
                                name: "Edit",
                                onPressed: () {
                                  if (context
                                      .read<EditAreaCubit>()
                                      .formKey
                                      .currentState!
                                      .validate()) {
                                    showCustomDialog(context,
                                        "Are you Sure you want save the edit of this area ?",
                                        () {
                                      context.read<EditAreaCubit>().editArea(
                                          widget.id,
                                          selectedManagersIds,
                                          selectedSupervisorsIds,
                                          selectedCleanersIds);
                                      context.pop();
                                    });
                                  }
                                },
                                color: AppColor.primaryColor,
                                height: 48.h,
                                width: double.infinity,
                                textStyles: TextStyles.font20Whitesemimedium,
                              ),
                      ],
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
