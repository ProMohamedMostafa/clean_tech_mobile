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
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/section_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_floor/logic/edit_floor_state.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_section/logic/edit_section_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_section/logic/edit_section_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EditSectionBody extends StatefulWidget {
  final int id;
  const EditSectionBody({super.key, required this.id});

  @override
  State<EditSectionBody> createState() => _EditSectionBodyState();
}

class _EditSectionBodyState extends State<EditSectionBody> {
  List<int> selectedManagersIds = [];
  List<int> selectedSupervisorsIds = [];
  List<int> selectedCleanersIds = [];
  List<int> selectedShiftsIds = [];
  @override
  void initState() {
    context.read<EditSectionCubit>().getSectionDetailsInEdit(widget.id);
    context.read<EditSectionCubit>().getSectionManagersDetails(widget.id);
    context.read<EditSectionCubit>()
      ..getNationality()
      ..getShifts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text('Edit Section'),
      ),
      body: SafeArea(
        child: BlocConsumer<EditSectionCubit, EditSectionState>(
          listener: (context, state) {
            if (state is EditSectionSuccessState) {
              toast(text: state.sectionEditModel.message!, color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.workLocationScreen,
                  arguments: 4);
            }
            if (state is EditSectionErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            final cubit = context.read<EditSectionCubit>();
            if (cubit.sectionDetailsInEditModel == null) {
              return const Center(
                child: CircularProgressIndicator(color: AppColor.primaryColor),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: context.read<EditSectionCubit>().formKey,
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
                            .read<EditSectionCubit>()
                            .sectionDetailsInEditModel!
                            .data!
                            .countryName!,
                        items: context
                                    .read<EditSectionCubit>()
                                    .nationalityModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No country']
                            : context
                                    .read<EditSectionCubit>()
                                    .nationalityModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          context.read<EditSectionCubit>().getAreas(value);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<EditSectionCubit>()
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
                            .read<EditSectionCubit>()
                            .sectionDetailsInEditModel!
                            .data!
                            .areaName!,
                        items: context
                                    .read<EditSectionCubit>()
                                    .areasModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No areas']
                            : context
                                    .read<EditSectionCubit>()
                                    .areasModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedArea = context
                              .read<EditSectionCubit>()
                              .areasModel
                              ?.data
                              ?.data
                              ?.firstWhere((area) =>
                                  area.name ==
                                  context
                                      .read<EditSectionCubit>()
                                      .areaController
                                      .text);

                          context
                              .read<EditSectionCubit>()
                              .getCityy(selectedArea!.id!);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditSectionCubit>().areaController,
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
                            .read<EditSectionCubit>()
                            .sectionDetailsInEditModel!
                            .data!
                            .cityName!,
                        items: context
                                    .read<EditSectionCubit>()
                                    .cityyModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No cities']
                            : context
                                    .read<EditSectionCubit>()
                                    .cityyModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedCity = context
                              .read<EditSectionCubit>()
                              .cityyModel
                              ?.data
                              ?.data
                              ?.firstWhere((city) =>
                                  city.name ==
                                  context
                                      .read<EditSectionCubit>()
                                      .cityController
                                      .text);

                          context
                              .read<EditSectionCubit>()
                              .getOrganizations(selectedCity!.id!);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditSectionCubit>().cityController,
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
                            .read<EditSectionCubit>()
                            .sectionDetailsInEditModel!
                            .data!
                            .organizationName!,
                        items: context
                                    .read<EditSectionCubit>()
                                    .organizationsModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No organization']
                            : context
                                    .read<EditSectionCubit>()
                                    .organizationsModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedOrganization = context
                              .read<EditSectionCubit>()
                              .organizationsModel
                              ?.data
                              ?.data!
                              .firstWhere((organization) =>
                                  organization.name ==
                                  context
                                      .read<EditSectionCubit>()
                                      .organizationController
                                      .text);

                          context
                              .read<EditSectionCubit>()
                              .getBuildings(selectedOrganization!.id!);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<EditSectionCubit>()
                            .organizationController,
                        isRead: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        "Building",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: context
                            .read<EditSectionCubit>()
                            .sectionDetailsInEditModel!
                            .data!
                            .buildingName!,
                        items: context
                                    .read<EditSectionCubit>()
                                    .buildingsModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No building']
                            : context
                                    .read<EditSectionCubit>()
                                    .buildingsModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedBuilding = context
                              .read<EditSectionCubit>()
                              .buildingsModel
                              ?.data
                              ?.data!
                              .firstWhere((building) =>
                                  building.name ==
                                  context
                                      .read<EditSectionCubit>()
                                      .buildingController
                                      .text);

                          context
                              .read<EditSectionCubit>()
                              .getFloors(selectedBuilding!.id!);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditSectionCubit>().buildingController,
                        isRead: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        "Floor",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: context
                            .read<EditSectionCubit>()
                            .sectionDetailsInEditModel!
                            .data!
                            .floorName!,
                        items: context
                                    .read<EditSectionCubit>()
                                    .floorsModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No floor']
                            : context
                                    .read<EditSectionCubit>()
                                    .floorsModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedFloor = context
                              .read<EditSectionCubit>()
                              .floorsModel
                              ?.data
                              ?.data!
                              .firstWhere((floor) =>
                                  floor.name ==
                                  context
                                      .read<EditSectionCubit>()
                                      .floorController
                                      .text);

                          context
                              .read<EditSectionCubit>()
                              .floorIdController
                              .text = selectedFloor!.id!.toString();
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditSectionCubit>().buildingController,
                        isRead: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        "Section Name",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomTextFormField(
                        hint: context
                            .read<EditSectionCubit>()
                            .sectionDetailsInEditModel!
                            .data!
                            .name!,
                        controller:
                            context.read<EditSectionCubit>().sectionController
                              ..text = context
                                  .read<EditSectionCubit>()
                                  .sectionDetailsInEditModel!
                                  .data!
                                  .name!,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Section name is required";
                          } else if (value.length > 55) {
                            return 'Section name too long';
                          } else if (value.length < 3) {
                            return 'Section name too short';
                          }
                          return null;
                        },
                        onlyRead: false,
                      ),
                      verticalSpace(10),
                      Text(
                        "Section Number",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomTextFormField(
                        hint: context
                            .read<EditSectionCubit>()
                            .sectionDetailsInEditModel!
                            .data!
                            .number!,
                        controller: context
                            .read<EditSectionCubit>()
                            .sectionNumberController
                          ..text = context
                              .read<EditSectionCubit>()
                              .sectionDetailsInEditModel!
                              .data!
                              .number!,
                        onlyRead: false,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Section number is required";
                          } else if (value.length > 55) {
                            return 'Section number too long';
                          }
                          return null;
                        },
                      ),
                      verticalSpace(10),
                      Text(
                        "Section description",
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
                              .read<EditSectionCubit>()
                              .sectionDescriptionController
                            ..text = context
                                .read<EditSectionCubit>()
                                .sectionDetailsInEditModel!
                                .data!
                                .description!,
                          hint: context
                              .read<EditSectionCubit>()
                              .sectionDetailsInEditModel!
                              .data!
                              .description!),
                      verticalSpace(10),
                      context
                                  .read<EditSectionCubit>()
                                  .sectionUsersShiftsDetailsModel
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
                                  .read<EditSectionCubit>()
                                  .sectionUsersShiftsDetailsModel
                                  ?.data ==
                              null
                          ? SizedBox.shrink()
                          : MultiDropdown<Users>(
                              items: context
                                      .read<EditSectionCubit>()
                                      .sectionUsersShiftsDetailsModel!
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
                                      .read<EditSectionCubit>()
                                      .sectionUsersShiftsDetailsModel!
                                      .data!
                                      .users!
                                      .where((user) => user.role == 'Manager')
                                      .map((manager) => DropdownItem(
                                            label: manager.userName!,
                                            value: manager,
                                          ))
                                      .toList(),
                              controller: context
                                  .read<EditSectionCubit>()
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
                                    .read<EditSectionCubit>()
                                    .sectionUsersShiftsDetailsModel!
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
                                  .read<EditSectionCubit>()
                                  .sectionUsersShiftsDetailsModel
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
                                  .read<EditSectionCubit>()
                                  .sectionUsersShiftsDetailsModel
                                  ?.data ==
                              null
                          ? SizedBox.shrink()
                          : MultiDropdown<Users>(
                              items: context
                                      .read<EditSectionCubit>()
                                      .sectionUsersShiftsDetailsModel!
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
                                      .read<EditSectionCubit>()
                                      .sectionUsersShiftsDetailsModel!
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
                                  .read<EditSectionCubit>()
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
                                    .read<EditSectionCubit>()
                                    .sectionUsersShiftsDetailsModel!
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
                                  .read<EditSectionCubit>()
                                  .sectionUsersShiftsDetailsModel
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
                                  .read<EditSectionCubit>()
                                  .sectionUsersShiftsDetailsModel
                                  ?.data ==
                              null
                          ? SizedBox.shrink()
                          : MultiDropdown<Users>(
                              items: context
                                      .read<EditSectionCubit>()
                                      .sectionUsersShiftsDetailsModel!
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
                                      .read<EditSectionCubit>()
                                      .sectionUsersShiftsDetailsModel!
                                      .data!
                                      .users!
                                      .where((user) => user.role == 'Cleaner')
                                      .map((cleaner) => DropdownItem(
                                            label: cleaner.userName!,
                                            value: cleaner,
                                          ))
                                      .toList(),
                              controller: context
                                  .read<EditSectionCubit>()
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
                                    .read<EditSectionCubit>()
                                    .sectionUsersShiftsDetailsModel!
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
                      context.read<EditSectionCubit>().shiftModel?.data == null
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
                      context.read<EditSectionCubit>().shiftModel?.data == null
                          ? SizedBox.shrink()
                          : MultiDropdown<ShiftItem>(
                              items: context
                                          .read<EditSectionCubit>()
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
                                      .read<EditSectionCubit>()
                                      .shiftModel!
                                      .data!
                                      .data!
                                      .map((shift) => DropdownItem(
                                            label: shift.name!,
                                            value: shift,
                                          ))
                                      .toList(),
                              controller: context
                                  .read<EditSectionCubit>()
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
                                    .read<EditSectionCubit>()
                                    .sectionUsersShiftsDetailsModel!
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
                      state is EditFloorLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: AppColor.primaryColor),
                            )
                          : DefaultElevatedButton(
                              name: "Edit",
                              onPressed: () {
                                if (context
                                    .read<EditSectionCubit>()
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  showCustomDialog(context,
                                      "Are you Sure you want save the edit of this Floor ?",
                                      () {
                                    context.read<EditSectionCubit>().editSection(
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
