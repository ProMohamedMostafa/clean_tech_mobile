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
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/floor_users_shifts_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_floor/logic/edit_floor_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_floor/logic/edit_floor_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EditFloorBody extends StatefulWidget {
  final int id;
  const EditFloorBody({super.key, required this.id});

  @override
  State<EditFloorBody> createState() => _EditFloorBodyState();
}

class _EditFloorBodyState extends State<EditFloorBody> {
  List<int> selectedManagersIds = [];
  List<int> selectedSupervisorsIds = [];
  List<int> selectedCleanersIds = [];
  List<int> selectedShiftsIds = [];
  @override
  void initState() {
    context.read<EditFloorCubit>().getFloorDetailsInEdit(widget.id);
    context.read<EditFloorCubit>().getFloorManagersDetails(widget.id);
    context.read<EditFloorCubit>()
      ..getNationality()
      ..getShifts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: CustomBackButton(), title: Text('Edit Floor')),
      body: SafeArea(
        child: BlocConsumer<EditFloorCubit, EditFloorState>(
          listener: (context, state) {
            if (state is EditFloorSuccessState) {
              toast(text: state.floorEditModel.message!, color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.workLocationScreen,
                  arguments: 4);
            }
            if (state is EditFloorErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            final cubit = context.read<EditFloorCubit>();
            if (cubit.floorDetailsInEditModel == null) {
              return Loading();
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: context.read<EditFloorCubit>().formKey,
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
                            .read<EditFloorCubit>()
                            .floorDetailsInEditModel!
                            .data!
                            .countryName!,
                        items: context
                                    .read<EditFloorCubit>()
                                    .nationalityModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No country']
                            : context
                                    .read<EditFloorCubit>()
                                    .nationalityModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          context.read<EditFloorCubit>().getAreas(value);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<EditFloorCubit>()
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
                            .read<EditFloorCubit>()
                            .floorDetailsInEditModel!
                            .data!
                            .areaName!,
                        items: context
                                    .read<EditFloorCubit>()
                                    .areasModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No areas']
                            : context
                                    .read<EditFloorCubit>()
                                    .areasModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedArea = context
                              .read<EditFloorCubit>()
                              .areasModel
                              ?.data
                              ?.data
                              ?.firstWhere((area) =>
                                  area.name ==
                                  context
                                      .read<EditFloorCubit>()
                                      .areaController
                                      .text);

                          context
                              .read<EditFloorCubit>()
                              .getCityy(selectedArea!.id!);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditFloorCubit>().areaController,
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
                            .read<EditFloorCubit>()
                            .floorDetailsInEditModel!
                            .data!
                            .cityName!,
                        items: context
                                    .read<EditFloorCubit>()
                                    .cityyModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No cities']
                            : context
                                    .read<EditFloorCubit>()
                                    .cityyModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedCity = context
                              .read<EditFloorCubit>()
                              .cityyModel
                              ?.data
                              ?.data
                              ?.firstWhere((city) =>
                                  city.name ==
                                  context
                                      .read<EditFloorCubit>()
                                      .cityController
                                      .text);

                          context
                              .read<EditFloorCubit>()
                              .getOrganizations(selectedCity!.id!);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditFloorCubit>().cityController,
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
                            .read<EditFloorCubit>()
                            .floorDetailsInEditModel!
                            .data!
                            .organizationName!,
                        items: context
                                    .read<EditFloorCubit>()
                                    .organizationsModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No organization']
                            : context
                                    .read<EditFloorCubit>()
                                    .organizationsModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedOrganization = context
                              .read<EditFloorCubit>()
                              .organizationsModel
                              ?.data
                              ?.data!
                              .firstWhere((organization) =>
                                  organization.name ==
                                  context
                                      .read<EditFloorCubit>()
                                      .organizationController
                                      .text);

                          context
                              .read<EditFloorCubit>()
                              .getBuildings(selectedOrganization!.id!);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<EditFloorCubit>()
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
                            .read<EditFloorCubit>()
                            .floorDetailsInEditModel!
                            .data!
                            .buildingName!,
                        items: context
                                    .read<EditFloorCubit>()
                                    .buildingsModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No building']
                            : context
                                    .read<EditFloorCubit>()
                                    .buildingsModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedBuilding = context
                              .read<EditFloorCubit>()
                              .buildingsModel
                              ?.data
                              ?.data!
                              .firstWhere((building) =>
                                  building.name ==
                                  context
                                      .read<EditFloorCubit>()
                                      .buildingController
                                      .text);

                          context
                              .read<EditFloorCubit>()
                              .buildingIdController
                              .text = selectedBuilding!.id!.toString();
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditFloorCubit>().buildingController,
                        isRead: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        "Floor Name",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomTextFormField(
                        hint: context
                            .read<EditFloorCubit>()
                            .floorDetailsInEditModel!
                            .data!
                            .name!,
                        controller:
                            context.read<EditFloorCubit>().floorController
                              ..text = context
                                  .read<EditFloorCubit>()
                                  .floorDetailsInEditModel!
                                  .data!
                                  .name!,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Floor name is required";
                          } else if (value.length > 55) {
                            return 'Floor name too long';
                          } else if (value.length < 3) {
                            return 'Floor name too short';
                          }
                          return null;
                        },
                        onlyRead: false,
                      ),
                      verticalSpace(10),
                      Text(
                        "Floor Number",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomTextFormField(
                        hint: context
                            .read<EditFloorCubit>()
                            .floorDetailsInEditModel!
                            .data!
                            .number!,
                        controller:
                            context.read<EditFloorCubit>().floorNumberController
                              ..text = context
                                  .read<EditFloorCubit>()
                                  .floorDetailsInEditModel!
                                  .data!
                                  .number!,
                        onlyRead: false,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Floor number is required";
                          } else if (value.length > 55) {
                            return 'Floor number too long';
                          }
                          return null;
                        },
                      ),
                      verticalSpace(10),
                      Text(
                        "Floor description",
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
                              .read<EditFloorCubit>()
                              .floorDescriptionController
                            ..text = context
                                .read<EditFloorCubit>()
                                .floorDetailsInEditModel!
                                .data!
                                .description!,
                          hint: context
                              .read<EditFloorCubit>()
                              .floorDetailsInEditModel!
                              .data!
                              .description!),
                      verticalSpace(10),
                      context
                                  .read<EditFloorCubit>()
                                  .floorUsersShiftsDetailsModel
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
                                  .read<EditFloorCubit>()
                                  .floorUsersShiftsDetailsModel
                                  ?.data ==
                              null
                          ? SizedBox.shrink()
                          : MultiDropdown<Users>(
                              items: context
                                      .read<EditFloorCubit>()
                                      .floorUsersShiftsDetailsModel!
                                      .data!
                                      .users!
                                      .where((user) => user.role == 'Manger')
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
                                      .read<EditFloorCubit>()
                                      .floorUsersShiftsDetailsModel!
                                      .data!
                                      .users!
                                      .where((user) => user.role == 'Manger')
                                      .map((manager) => DropdownItem(
                                            label: manager.userName!,
                                            value: manager,
                                          ))
                                      .toList(),
                              controller: context
                                  .read<EditFloorCubit>()
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
                                    .read<EditFloorCubit>()
                                    .floorUsersShiftsDetailsModel!
                                    .data!
                                    .users!
                                    .where((user) => user.role == 'Cleaner')
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
                                  .read<EditFloorCubit>()
                                  .floorUsersShiftsDetailsModel
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
                                  .read<EditFloorCubit>()
                                  .floorUsersShiftsDetailsModel
                                  ?.data ==
                              null
                          ? SizedBox.shrink()
                          : MultiDropdown<Users>(
                              items: context
                                      .read<EditFloorCubit>()
                                      .floorUsersShiftsDetailsModel!
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
                                      .read<EditFloorCubit>()
                                      .floorUsersShiftsDetailsModel!
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
                                  .read<EditFloorCubit>()
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
                                    .read<EditFloorCubit>()
                                    .floorUsersShiftsDetailsModel!
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
                                  .read<EditFloorCubit>()
                                  .floorUsersShiftsDetailsModel
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
                                  .read<EditFloorCubit>()
                                  .floorUsersShiftsDetailsModel
                                  ?.data ==
                              null
                          ? SizedBox.shrink()
                          : MultiDropdown<Users>(
                              items: context
                                      .read<EditFloorCubit>()
                                      .floorUsersShiftsDetailsModel!
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
                                      .read<EditFloorCubit>()
                                      .floorUsersShiftsDetailsModel!
                                      .data!
                                      .users!
                                      .where((user) => user.role == 'Cleaner')
                                      .map((cleaner) => DropdownItem(
                                            label: cleaner.userName!,
                                            value: cleaner,
                                          ))
                                      .toList(),
                              controller: context
                                  .read<EditFloorCubit>()
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
                                    .read<EditFloorCubit>()
                                    .floorUsersShiftsDetailsModel!
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
                      context.read<EditFloorCubit>().shiftModel?.data == null
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
                      context.read<EditFloorCubit>().shiftModel?.data == null
                          ? SizedBox.shrink()
                          : MultiDropdown<ShiftItem>(
                              items: context
                                          .read<EditFloorCubit>()
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
                                      .read<EditFloorCubit>()
                                      .shiftModel!
                                      .data!
                                      .data!
                                      .map((shift) => DropdownItem(
                                            label: shift.name!,
                                            value: shift,
                                          ))
                                      .toList(),
                              controller: context
                                  .read<EditFloorCubit>()
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
                                    .read<EditFloorCubit>()
                                    .floorUsersShiftsDetailsModel!
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
                          ? Loading()
                          : DefaultElevatedButton(
                              name: "Edit",
                              onPressed: () {
                                if (context
                                    .read<EditFloorCubit>()
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return PopUpMeassage(
                                            title: 'edit',
                                            body: 'floor',
                                            onPressed: () {
                                              context
                                                  .read<EditFloorCubit>()
                                                  .editFloor(
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
