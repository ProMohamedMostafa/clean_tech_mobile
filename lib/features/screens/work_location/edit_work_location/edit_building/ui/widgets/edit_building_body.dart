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
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/building_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_building/logic/edit_building_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_building/logic/edit_building_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EditBuildingBody extends StatefulWidget {
  final int id;
  const EditBuildingBody({super.key, required this.id});

  @override
  State<EditBuildingBody> createState() => _EditBuildingBodyState();
}

class _EditBuildingBodyState extends State<EditBuildingBody> {
  List<int> selectedManagersIds = [];
  List<int> selectedSupervisorsIds = [];
  List<int> selectedCleanersIds = [];
  List<int> selectedShiftsIds = [];
  @override
  void initState() {
    context.read<EditBuildingCubit>().getBuildingDetailsInEdit(widget.id);
    context.read<EditBuildingCubit>().getBuildingManagersDetails(widget.id);
    context.read<EditBuildingCubit>()
      ..getNationality()
      ..getShifts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text('Edit Building'),
      ),
      body: SafeArea(
        child: BlocConsumer<EditBuildingCubit, EditBuildingState>(
          listener: (context, state) {
            if (state is EditBuildingSuccessState) {
              toast(text: state.buildingEditModel.message!, color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.workLocationScreen,
                  arguments: 3);
            }
            if (state is EditBuildingErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            final cubit = context.read<EditBuildingCubit>();
            if (cubit.buildingDetailsInEditModel == null) {
              return Loading();
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
                      Text(
                        S.of(context).addUserText12,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
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
                        onPressed: (value) {
                          context.read<EditBuildingCubit>().getAreas(value);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<EditBuildingCubit>()
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
                            .read<EditBuildingCubit>()
                            .buildingDetailsInEditModel!
                            .data!
                            .areaName!,
                        items: context
                                    .read<EditBuildingCubit>()
                                    .areasModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No areas']
                            : context
                                    .read<EditBuildingCubit>()
                                    .areasModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedArea = context
                              .read<EditBuildingCubit>()
                              .areasModel
                              ?.data
                              ?.data
                              ?.firstWhere((area) =>
                                  area.name ==
                                  context
                                      .read<EditBuildingCubit>()
                                      .areaController
                                      .text);

                          context
                              .read<EditBuildingCubit>()
                              .getCityy(selectedArea!.id!);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditBuildingCubit>().areaController,
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
                            .read<EditBuildingCubit>()
                            .buildingDetailsInEditModel!
                            .data!
                            .cityName!,
                        items: context
                                    .read<EditBuildingCubit>()
                                    .cityyModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No cities']
                            : context
                                    .read<EditBuildingCubit>()
                                    .cityyModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedCity = context
                              .read<EditBuildingCubit>()
                              .cityyModel
                              ?.data
                              ?.data
                              ?.firstWhere((city) =>
                                  city.name ==
                                  context
                                      .read<EditBuildingCubit>()
                                      .cityController
                                      .text);

                          context
                              .read<EditBuildingCubit>()
                              .getOrganizations(selectedCity!.id!);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditBuildingCubit>().cityController,
                        isRead: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        "Organization",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: context
                            .read<EditBuildingCubit>()
                            .buildingDetailsInEditModel!
                            .data!
                            .organizationName!,
                        items: context
                                    .read<EditBuildingCubit>()
                                    .organizationsModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No organization']
                            : context
                                    .read<EditBuildingCubit>()
                                    .organizationsModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedOrganization = context
                              .read<EditBuildingCubit>()
                              .organizationsModel
                              ?.data
                              ?.data!
                              .firstWhere((organization) =>
                                  organization.name ==
                                  context
                                      .read<EditBuildingCubit>()
                                      .organizationController
                                      .text);

                          context
                              .read<EditBuildingCubit>()
                              .organizationIdController
                              .text = selectedOrganization!.id!.toString();
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<EditBuildingCubit>()
                            .organizationController,
                        isRead: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        "Building Name",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomTextFormField(
                        hint: context
                            .read<EditBuildingCubit>()
                            .buildingDetailsInEditModel!
                            .data!
                            .name!,
                        controller:
                            context.read<EditBuildingCubit>().buildingController
                              ..text = context
                                  .read<EditBuildingCubit>()
                                  .buildingDetailsInEditModel!
                                  .data!
                                  .name!,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Building name is required";
                          } else if (value.length > 55) {
                            return 'Building name too long';
                          } else if (value.length < 3) {
                            return 'Building name too short';
                          }
                          return null;
                        },
                        onlyRead: false,
                      ),
                      verticalSpace(10),
                      Text(
                        "Building Number",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomTextFormField(
                        hint: context
                            .read<EditBuildingCubit>()
                            .buildingDetailsInEditModel!
                            .data!
                            .number!,
                        controller: context
                            .read<EditBuildingCubit>()
                            .buildingNumberController
                          ..text = context
                              .read<EditBuildingCubit>()
                              .buildingDetailsInEditModel!
                              .data!
                              .number!,
                        onlyRead: false,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Building number is required";
                          } else if (value.length > 55) {
                            return 'Building number too long';
                          }

                          return null;
                        },
                      ),
                      verticalSpace(10),
                      Text(
                        "Building description",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDescriptionTextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Description is required";
                            } else if (value.length < 3) {
                              return 'Description too short';
                            }
                            return null;
                          },
                          controller: context
                              .read<EditBuildingCubit>()
                              .buildingDescriptionController
                            ..text = context
                                .read<EditBuildingCubit>()
                                .buildingDetailsInEditModel!
                                .data!
                                .description!,
                          hint: context
                              .read<EditBuildingCubit>()
                              .buildingDetailsInEditModel!
                              .data!
                              .description!),
                      verticalSpace(10),
                      context
                                  .read<EditBuildingCubit>()
                                  .buildingUsersShiftsDetailsModel
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
                                  .read<EditBuildingCubit>()
                                  .buildingUsersShiftsDetailsModel
                                  ?.data ==
                              null
                          ? SizedBox.shrink()
                          : MultiDropdown<Users>(
                              items: context
                                      .read<EditBuildingCubit>()
                                      .buildingUsersShiftsDetailsModel!
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
                                      .read<EditBuildingCubit>()
                                      .buildingUsersShiftsDetailsModel!
                                      .data!
                                      .users!
                                      .where((user) => user.role == 'Manager')
                                      .map((manager) => DropdownItem(
                                            label: manager.userName!,
                                            value: manager,
                                          ))
                                      .toList(),
                              controller: context
                                  .read<EditBuildingCubit>()
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
                                    .read<EditBuildingCubit>()
                                    .buildingUsersShiftsDetailsModel!
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
                                  .read<EditBuildingCubit>()
                                  .buildingUsersShiftsDetailsModel
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
                                  .read<EditBuildingCubit>()
                                  .buildingUsersShiftsDetailsModel
                                  ?.data ==
                              null
                          ? SizedBox.shrink()
                          : MultiDropdown<Users>(
                              items: context
                                      .read<EditBuildingCubit>()
                                      .buildingUsersShiftsDetailsModel!
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
                                      .read<EditBuildingCubit>()
                                      .buildingUsersShiftsDetailsModel!
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
                                  .read<EditBuildingCubit>()
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
                                    .read<EditBuildingCubit>()
                                    .buildingUsersShiftsDetailsModel!
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
                                  .read<EditBuildingCubit>()
                                  .buildingUsersShiftsDetailsModel
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
                                  .read<EditBuildingCubit>()
                                  .buildingUsersShiftsDetailsModel
                                  ?.data ==
                              null
                          ? SizedBox.shrink()
                          : MultiDropdown<Users>(
                              items: context
                                      .read<EditBuildingCubit>()
                                      .buildingUsersShiftsDetailsModel!
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
                                      .read<EditBuildingCubit>()
                                      .buildingUsersShiftsDetailsModel!
                                      .data!
                                      .users!
                                      .where((user) => user.role == 'Cleaner')
                                      .map((cleaner) => DropdownItem(
                                            label: cleaner.userName!,
                                            value: cleaner,
                                          ))
                                      .toList(),
                              controller: context
                                  .read<EditBuildingCubit>()
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
                                    .read<EditBuildingCubit>()
                                    .buildingUsersShiftsDetailsModel!
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
                      context.read<EditBuildingCubit>().shiftModel?.data == null
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
                      context.read<EditBuildingCubit>().shiftModel?.data == null
                          ? SizedBox.shrink()
                          : MultiDropdown<ShiftItem>(
                              items: context
                                          .read<EditBuildingCubit>()
                                          .shiftModel
                                          ?.data
                                          ?.data
                                          ?.isEmpty ??
                                      true
                                  ? [
                                      DropdownItem(
                                        label: 'No shifts available',
                                        value: ShiftItem(
                                            id: null,
                                            name: 'No shifts available'),
                                      )
                                    ]
                                  : context
                                      .read<EditBuildingCubit>()
                                      .shiftModel!
                                      .data!
                                      .data!
                                      .map((shift) => DropdownItem(
                                            label: shift.name!,
                                            value: shift,
                                          ))
                                      .toList(),
                              controller: context
                                  .read<EditBuildingCubit>()
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
                                    .read<EditBuildingCubit>()
                                    .buildingUsersShiftsDetailsModel!
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
                      state is EditBuildingLoadingState
                          ? Loading()
                          : DefaultElevatedButton(
                              name: "Edit",
                              onPressed: () {
                                if (context
                                    .read<EditBuildingCubit>()
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return PopUpMeassage(
                                            title: 'edit',
                                            body: 'building',
                                            onPressed: () {
                                              context
                                                  .read<EditBuildingCubit>()
                                                  .editBuilding(
                                                      widget.id,
                                                      selectedManagersIds,
                                                      selectedSupervisorsIds,
                                                      selectedCleanersIds,
                                                      selectedShiftsIds);
                                            
                                            });
                                      });
                                }
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
