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
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/organization_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_organization/logic/edit_organization_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_organization/logic/edit_organization_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EditOrganizationBody extends StatefulWidget {
  final int id;
  const EditOrganizationBody({super.key, required this.id});

  @override
  State<EditOrganizationBody> createState() => _EditOrganizationBodyState();
}

class _EditOrganizationBodyState extends State<EditOrganizationBody> {
  List<int> selectedManagersIds = [];
  List<int> selectedSupervisorsIds = [];
  List<int> selectedCleanersIds = [];
  List<int> selectedShiftsIds = [];
  @override
  void initState() {
    context
        .read<EditOrganizationCubit>()
        .getOrganizationDetailsInEdit(widget.id);
    context
        .read<EditOrganizationCubit>()
        .getOrganizationManagersDetails(widget.id);
    context.read<EditOrganizationCubit>()
      ..getNationality()
      ..getShifts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text('Edit Organization'),
      ),
      body: SafeArea(
        child: BlocConsumer<EditOrganizationCubit, EditOrganizationState>(
          listener: (context, state) {
            if (state is EditOrganizationSuccessState) {
              toast(
                  text: state.editOrganizationModel.message!,
                  color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.workLocationScreen,
                  arguments: 2);
            }
            if (state is EditOrganizationErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            final cubit = context.read<EditOrganizationCubit>();
            if (cubit.organizationDetailsInEditModel == null) {
              return const Center(
                child: CircularProgressIndicator(color: AppColor.primaryColor),
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
                      Text(
                        S.of(context).addUserText12,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
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
                        onPressed: (value) {
                          context.read<EditOrganizationCubit>().getAreas(value);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<EditOrganizationCubit>()
                            .nationalityController,
                        isRead: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        "Area",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: context
                            .read<EditOrganizationCubit>()
                            .organizationDetailsInEditModel!
                            .data!
                            .areaName!,
                        items: context
                                    .read<EditOrganizationCubit>()
                                    .areasModel
                                    ?.data
                                    ?.areas
                                    ?.isEmpty ??
                                true
                            ? ['No areas']
                            : context
                                    .read<EditOrganizationCubit>()
                                    .areasModel
                                    ?.data
                                    ?.areas
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedArea = context
                              .read<EditOrganizationCubit>()
                              .areasModel
                              ?.data
                              ?.areas
                              ?.firstWhere((area) =>
                                  area.name ==
                                  context
                                      .read<EditOrganizationCubit>()
                                      .areaController
                                      .text);

                          context
                              .read<EditOrganizationCubit>()
                              .getCityy(selectedArea!.id!);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<EditOrganizationCubit>()
                            .areaController,
                        isRead: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        "City",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: context
                            .read<EditOrganizationCubit>()
                            .organizationDetailsInEditModel!
                            .data!
                            .cityName!,
                        items: context
                                    .read<EditOrganizationCubit>()
                                    .cityyModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No cities']
                            : context
                                    .read<EditOrganizationCubit>()
                                    .cityyModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedCity = context
                              .read<EditOrganizationCubit>()
                              .cityyModel
                              ?.data
                              ?.data
                              ?.firstWhere((city) =>
                                  city.name ==
                                  context
                                      .read<EditOrganizationCubit>()
                                      .cityController
                                      .text);

                          context
                              .read<EditOrganizationCubit>()
                              .cityIdController
                              .text = selectedCity!.id!.toString();
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<EditOrganizationCubit>()
                            .cityController,
                        isRead: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        "Organization Name",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomTextFormField(
                        hint: context
                            .read<EditOrganizationCubit>()
                            .organizationDetailsInEditModel!
                            .data!
                            .name!,
                        controller: context
                            .read<EditOrganizationCubit>()
                            .organizationController
                          ..text = context
                              .read<EditOrganizationCubit>()
                              .organizationDetailsInEditModel!
                              .data!
                              .name!,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Organization name is required";
                          } else if (value.length > 55) {
                            return 'Organization name too long';
                          } else if (value.length < 3) {
                            return 'Organization name too short';
                          }
                          return null;
                        },
                        onlyRead: false,
                      ),
                      verticalSpace(10),
                      context
                                  .read<EditOrganizationCubit>()
                                  .organizationUsersShiftsDetailsModel
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
                                  .read<EditOrganizationCubit>()
                                  .organizationUsersShiftsDetailsModel
                                  ?.data ==
                              null
                          ? SizedBox.shrink()
                          : MultiDropdown<Users>(
                              items: context
                                      .read<EditOrganizationCubit>()
                                      .organizationUsersShiftsDetailsModel!
                                      .data!
                                      .users!
                                      .where((user) => user.role == 'Manager')
                                      .isEmpty
                                  ? [
                                      DropdownItem(
                                        label: 'No managers available',
                                        value: Users(
                                            id: null,
                                            userName: 'No managers available'),
                                      )
                                    ]
                                  : context
                                      .read<EditOrganizationCubit>()
                                      .organizationUsersShiftsDetailsModel!
                                      .data!
                                      .users!
                                      .where((user) => user.role == 'Manager')
                                      .map((manager) => DropdownItem(
                                            label: manager.userName!,
                                            value: manager,
                                          ))
                                      .toList(),
                              controller: context
                                  .read<EditOrganizationCubit>()
                                  .allmanagersController,
                              enabled: true,
                              chipDecoration: ChipDecoration(
                                backgroundColor: Colors.grey[300],
                                wrap: true,
                                runSpacing: 5,
                                spacing: 5,
                              ),
                              fieldDecoration: FieldDecoration(
                                hintText: context
                                    .read<EditOrganizationCubit>()
                                    .organizationUsersShiftsDetailsModel!
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
                                  .read<EditOrganizationCubit>()
                                  .organizationUsersShiftsDetailsModel
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
                                  .read<EditOrganizationCubit>()
                                  .organizationUsersShiftsDetailsModel
                                  ?.data ==
                              null
                          ? SizedBox.shrink()
                          : MultiDropdown<Users>(
                              items: context
                                      .read<EditOrganizationCubit>()
                                      .organizationUsersShiftsDetailsModel!
                                      .data!
                                      .users!
                                      .where(
                                          (user) => user.role == 'Supervisor')
                                      .isEmpty
                                  ? [
                                      DropdownItem(
                                        label: 'No supervisors available',
                                        value: Users(
                                            id: null,
                                            userName:
                                                'No supervisors available'),
                                      )
                                    ]
                                  : context
                                      .read<EditOrganizationCubit>()
                                      .organizationUsersShiftsDetailsModel!
                                      .data!
                                      .users!
                                      .where(
                                          (user) => user.role == 'Supervisor')
                                      .map((supervisor) => DropdownItem(
                                            label: supervisor.userName!,
                                            value: supervisor,
                                          ))
                                      .toList(),
                              controller: context
                                  .read<EditOrganizationCubit>()
                                  .allSupervisorsController,
                              enabled: true,
                              chipDecoration: ChipDecoration(
                                backgroundColor: Colors.grey[300],
                                wrap: true,
                                runSpacing: 5,
                                spacing: 5,
                              ),
                              fieldDecoration: FieldDecoration(
                                hintText: context
                                    .read<EditOrganizationCubit>()
                                    .organizationUsersShiftsDetailsModel!
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
                                  .read<EditOrganizationCubit>()
                                  .organizationUsersShiftsDetailsModel
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
                                  .read<EditOrganizationCubit>()
                                  .organizationUsersShiftsDetailsModel
                                  ?.data ==
                              null
                          ? SizedBox.shrink()
                          : MultiDropdown<Users>(
                              items: context
                                      .read<EditOrganizationCubit>()
                                      .organizationUsersShiftsDetailsModel!
                                      .data!
                                      .users!
                                      .where((user) => user.role == 'Cleaner')
                                      .isEmpty
                                  ? [
                                      DropdownItem(
                                        label: 'No cleaners available',
                                        value: Users(
                                            id: null,
                                            userName: 'No cleaners available'),
                                      )
                                    ]
                                  : context
                                      .read<EditOrganizationCubit>()
                                      .organizationUsersShiftsDetailsModel!
                                      .data!
                                      .users!
                                      .where((user) => user.role == 'Cleaner')
                                      .map((cleaner) => DropdownItem(
                                            label: cleaner.userName!,
                                            value: cleaner,
                                          ))
                                      .toList(),
                              controller: context
                                  .read<EditOrganizationCubit>()
                                  .allCleanersController,
                              enabled: true,
                              chipDecoration: ChipDecoration(
                                backgroundColor: Colors.grey[300],
                                wrap: true,
                                runSpacing: 5,
                                spacing: 5,
                              ),
                              fieldDecoration: FieldDecoration(
                                hintText: context
                                    .read<EditOrganizationCubit>()
                                    .organizationUsersShiftsDetailsModel!
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
                      verticalSpace(10),
                      context.read<EditOrganizationCubit>().shiftModel?.data ==
                              null
                          ? SizedBox.shrink()
                          : RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Shifts',
                                    style: TextStyles.font16BlackRegular,
                                  ),
                                  TextSpan(
                                    text: ' (Optional)',
                                    style: TextStyles.font14GreyRegular,
                                  ),
                                ],
                              ),
                            ),
                      context.read<EditOrganizationCubit>().shiftModel?.data ==
                              null
                          ? SizedBox.shrink()
                          : MultiDropdown<ShiftDetails>(
                              items: context
                                          .read<EditOrganizationCubit>()
                                          .shiftModel
                                          ?.data
                                          ?.data
                                          ?.isEmpty ??
                                      true
                                  ? [
                                      DropdownItem(
                                        label: 'No shifts available',
                                        value: ShiftDetails(
                                            id: null,
                                            name: 'No shifts available'),
                                      )
                                    ]
                                  : context
                                      .read<EditOrganizationCubit>()
                                      .shiftModel!
                                      .data!
                                      .data!
                                      .map((shift) => DropdownItem(
                                            label: shift.name!,
                                            value: shift,
                                          ))
                                      .toList(),
                              controller: context
                                  .read<EditOrganizationCubit>()
                                  .shiftController,
                              enabled: true,
                              chipDecoration: ChipDecoration(
                                backgroundColor: Colors.grey[300],
                                wrap: true,
                                runSpacing: 5,
                                spacing: 5,
                              ),
                              fieldDecoration: FieldDecoration(
                                hintText: context
                                    .read<EditOrganizationCubit>()
                                    .organizationUsersShiftsDetailsModel!
                                    .data!
                                    .shifts!
                                    .map((shift) => shift.name)
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
                                selectedShiftsIds = selectedItems
                                    .map((item) => (item).id!)
                                    .toList();
                              },
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
                                if (context
                                    .read<EditOrganizationCubit>()
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  showCustomDialog(context,
                                      "Are you Sure you want save the edit of this organization ?",
                                      () {
                                    context
                                        .read<EditOrganizationCubit>()
                                        .editOrganization(
                                            widget.id,
                                            selectedManagersIds,
                                            selectedSupervisorsIds,
                                            selectedCleanersIds,
                                            selectedShiftsIds);
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
