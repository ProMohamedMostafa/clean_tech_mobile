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
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_cleaners_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_managers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_supervisors_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/logic/add_organization_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/logic/add_organization_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AddFloorScreen extends StatefulWidget {
  const AddFloorScreen({super.key});

  @override
  State<AddFloorScreen> createState() => _AddFloorScreenState();
}

class _AddFloorScreenState extends State<AddFloorScreen> {
  List<int> selectedManagersIds = [];
  List<int> selectedSupervisorsIds = [];
  List<int> selectedCleanersIds = [];
  List<int> selectedShiftsIds = [];
  int? buildingId;
  @override
  void initState() {
    context.read<AddOrganizationCubit>()
      ..getNationality()
      ..getManagers()
      ..getSupervisors()
      ..getCleaners()
      ..getShifts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text('Add Floor', style: TextStyles.font16BlackSemiBold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: BlocConsumer<AddOrganizationCubit, AddOrganizationState>(
          listener: (context, state) {
            if (state is CreateFloorSuccessState) {
              toast(text: state.message, color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.workLocationScreen,
                  arguments: 4);
            }
            if (state is CreateFloorErrorState) {
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
                    verticalSpace(20),
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
        CustomDropDownList(
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
          onChanged: (value) {
            context.read<AddOrganizationCubit>().nationalityController.text =
                value!;
            context.read<AddOrganizationCubit>().getArea(value);
          },
          validator: (value) {
            if (value == null || value.isEmpty || value == 'No country') {
              return S.of(context).validationNationality;
            }
            return null;
          },
          suffixIcon: IconBroken.arrowDown2,
          controller:
              context.read<AddOrganizationCubit>().nationalityController,
          isRead: false,
          keyboardType: TextInputType.text,
        ),
        verticalSpace(10),
        Text(
          "Area",
          style: TextStyles.font16BlackRegular,
        ),
        CustomDropDownList(
          hint: "Select area",
          items:
              context.read<AddOrganizationCubit>().areaModel?.data?.isEmpty ??
                      true
                  ? ['No area']
                  : context
                          .read<AddOrganizationCubit>()
                          .areaModel
                          ?.data
                          ?.map((e) => e.name ?? 'Unknown')
                          .toList() ??
                      [],
          validator: (value) {
            if (value == null || value.isEmpty || value == "No area") {
              return "Area is required";
            }
            return null;
          },
          onPressed: (value) {
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
          isRead: false,
          keyboardType: TextInputType.text,
        ),
        verticalSpace(10),
        Text(
          "City",
          style: TextStyles.font16BlackRegular,
        ),
        CustomDropDownList(
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
            return null;
          },
          onPressed: (value) {
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
          isRead: false,
          keyboardType: TextInputType.text,
        ),
        verticalSpace(10),
        Text(
          "Organization",
          style: TextStyles.font16BlackRegular,
        ),
        CustomDropDownList(
          hint: "Select organizations",
          items: context
                      .read<AddOrganizationCubit>()
                      .organizationModel
                      ?.data
                      ?.isEmpty ??
                  true
              ? ['No organizations']
              : context
                      .read<AddOrganizationCubit>()
                      .organizationModel
                      ?.data
                      ?.map((e) => e.name ?? 'Unknown')
                      .toList() ??
                  [],
          validator: (value) {
            if (value == null || value.isEmpty || value == 'No organizations') {
              return "Organizations is required";
            }
            return null;
          },
          onPressed: (value) {
            final selectedOrganization = context
                .read<AddOrganizationCubit>()
                .organizationModel
                ?.data
                ?.firstWhere((organization) =>
                    organization.name ==
                    context
                        .read<AddOrganizationCubit>()
                        .organizationController
                        .text);
            context
                .read<AddOrganizationCubit>()
                .getBuilding(selectedOrganization!.id!);
          },
          suffixIcon: IconBroken.arrowDown2,
          controller:
              context.read<AddOrganizationCubit>().organizationController,
          isRead: false,
          keyboardType: TextInputType.text,
        ),
        verticalSpace(10),
        Text(
          "Building",
          style: TextStyles.font16BlackRegular,
        ),
        CustomDropDownList(
          hint: "Select building",
          items: context
                      .read<AddOrganizationCubit>()
                      .buildingModel
                      ?.data
                      ?.isEmpty ??
                  true
              ? ['No building']
              : context
                      .read<AddOrganizationCubit>()
                      .buildingModel
                      ?.data
                      ?.map((e) => e.name ?? 'Unknown')
                      .toList() ??
                  [],
          validator: (value) {
            if (value == null || value.isEmpty || value == 'No building') {
              return "Building is required";
            }
            return null;
          },
          onPressed: (value) {
            final selectedBuilding = context
                .read<AddOrganizationCubit>()
                .buildingModel
                ?.data
                ?.firstWhere((building) =>
                    building.name ==
                    context
                        .read<AddOrganizationCubit>()
                        .buildingController
                        .text);

            buildingId = selectedBuilding!.id!;
          },
          suffixIcon: IconBroken.arrowDown2,
          controller: context.read<AddOrganizationCubit>().buildingController,
          isRead: false,
          keyboardType: TextInputType.text,
        ),
        verticalSpace(10),
        Text(
          "Floor Name",
          style: TextStyles.font16BlackRegular,
        ),
        CustomTextFormField(
          controller: context.read<AddOrganizationCubit>().addFloorController,
          onlyRead: false,
          hint: '',
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
        ),
        verticalSpace(10),
        Text(
          "Floor Number",
          style: TextStyles.font16BlackRegular,
        ),
        CustomTextFormField(
          controller:
              context.read<AddOrganizationCubit>().floorNumberController,
          onlyRead: false,
          hint: '',
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Floor number is required";
            } else if (value.length > 55) {
              return 'Floor number too long';
            } else if (value.length < 3) {
              return 'Floor number too short';
            }
            return null;
          },
        ),
        verticalSpace(10),
        Text(
          "Floor Description",
          style: TextStyles.font16BlackRegular,
        ),
        CustomDescriptionTextFormField(
          controller:
              context.read<AddOrganizationCubit>().floorDiscriptionController,
          hint: 'discription...',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "description is required";
            } else if (value.length < 3) {
              return 'description too short';
            }
            return null;
          },
        ),
        verticalSpace(10),
        context.read<AddOrganizationCubit>().allManagersModel?.data == null
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
        context.read<AddOrganizationCubit>().allManagersModel?.data == null
            ? SizedBox.shrink()
            : MultiDropdown<ManagersData>(
                items: context
                            .read<AddOrganizationCubit>()
                            .allManagersModel
                            ?.data ==
                        null
                    ? [
                        DropdownItem(
                          label: 'No managers available',
                          value: ManagersData(
                              id: null, userName: 'No managers available'),
                        )
                      ]
                    : context
                        .read<AddOrganizationCubit>()
                        .allManagersModel!
                        .data!
                        .map((manager) => DropdownItem(
                              label: manager.userName!,
                              value: manager,
                            ))
                        .toList(),
                controller:
                    context.read<AddOrganizationCubit>().allmanagersController,
                enabled: true,
                chipDecoration: ChipDecoration(
                  backgroundColor: Colors.grey[300],
                  wrap: true,
                  runSpacing: 5,
                  spacing: 5,
                ),
                fieldDecoration: FieldDecoration(
                  hintText: 'Select managers',
                  suffixIcon: Icon(IconBroken.arrowDown2),
                  hintStyle:
                      TextStyle(fontSize: 12.sp, color: AppColor.thirdColor),
                  showClearIcon: false,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Colors.grey),
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
                  selectedIcon: const Icon(Icons.check_box, color: Colors.blue),
                ),
                onSelectionChange: (selectedItems) {
                  selectedManagersIds =
                      selectedItems.map((item) => (item).id!).toList();
                },
              ),
        verticalSpace(10),
        context.read<AddOrganizationCubit>().allSupervisorsModel?.data == null
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
        context.read<AddOrganizationCubit>().allSupervisorsModel?.data == null
            ? SizedBox.shrink()
            : MultiDropdown<SupervisorsData>(
                items: context
                            .read<AddOrganizationCubit>()
                            .allSupervisorsModel
                            ?.data ==
                        null
                    ? [
                        DropdownItem(
                          label: 'No supervisors available',
                          value: SupervisorsData(
                              id: null, userName: 'No supervisors available'),
                        )
                      ]
                    : context
                        .read<AddOrganizationCubit>()
                        .allSupervisorsModel!
                        .data!
                        .map((supervisor) => DropdownItem(
                              label: supervisor.userName!,
                              value: supervisor,
                            ))
                        .toList(),
                controller: context
                    .read<AddOrganizationCubit>()
                    .allSupervisorsController,
                enabled: true,
                chipDecoration: ChipDecoration(
                  backgroundColor: Colors.grey[300],
                  wrap: true,
                  runSpacing: 5,
                  spacing: 5,
                ),
                fieldDecoration: FieldDecoration(
                  hintText: 'Select supervisors',
                  suffixIcon: Icon(IconBroken.arrowDown2),
                  hintStyle:
                      TextStyle(fontSize: 12.sp, color: AppColor.thirdColor),
                  showClearIcon: false,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Colors.grey),
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
                  selectedIcon: const Icon(Icons.check_box, color: Colors.blue),
                ),
                onSelectionChange: (selectedItems) {
                  selectedSupervisorsIds =
                      selectedItems.map((item) => (item).id!).toList();
                },
              ),
        verticalSpace(10),
        context.read<AddOrganizationCubit>().allCleanersModel?.data == null
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
        context.read<AddOrganizationCubit>().allCleanersModel?.data == null
            ? SizedBox.shrink()
            : MultiDropdown<CleanersData>(
                items: context
                            .read<AddOrganizationCubit>()
                            .allCleanersModel
                            ?.data ==
                        null
                    ? [
                        DropdownItem(
                          label: 'No cleaners available',
                          value: CleanersData(
                              id: null, userName: 'No cleaners available'),
                        )
                      ]
                    : context
                        .read<AddOrganizationCubit>()
                        .allCleanersModel!
                        .data!
                        .map((cleaner) => DropdownItem(
                              label: cleaner.userName!,
                              value: cleaner,
                            ))
                        .toList(),
                controller:
                    context.read<AddOrganizationCubit>().allCleanersController,
                enabled: true,
                chipDecoration: ChipDecoration(
                  backgroundColor: Colors.grey[300],
                  wrap: true,
                  runSpacing: 5,
                  spacing: 5,
                ),
                fieldDecoration: FieldDecoration(
                  hintText: 'Select cleaners',
                  suffixIcon: Icon(IconBroken.arrowDown2),
                  hintStyle:
                      TextStyle(fontSize: 12.sp, color: AppColor.thirdColor),
                  showClearIcon: false,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Colors.grey),
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
                  selectedIcon: const Icon(Icons.check_box, color: Colors.blue),
                ),
                onSelectionChange: (selectedItems) {
                  selectedCleanersIds =
                      selectedItems.map((item) => (item).id!).toList();
                },
              ),
        verticalSpace(10),
        context.read<AddOrganizationCubit>().shiftModel?.data == null
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
        context.read<AddOrganizationCubit>().shiftModel?.data == null
            ? SizedBox.shrink()
            : MultiDropdown<ShiftDetails>(
                items: context
                            .read<AddOrganizationCubit>()
                            .shiftModel
                            ?.data
                            ?.data
                            ?.isEmpty ??
                        true
                    ? [
                        DropdownItem(
                          label: 'No shifts available',
                          value: ShiftDetails(
                              id: null, name: 'No shifts available'),
                        )
                      ]
                    : context
                        .read<AddOrganizationCubit>()
                        .shiftModel!
                        .data!
                        .data!
                        .map((shift) => DropdownItem(
                              label: shift.name!,
                              value: shift,
                            ))
                        .toList(),
                controller:
                    context.read<AddOrganizationCubit>().shiftController,
                enabled: true,
                chipDecoration: ChipDecoration(
                  backgroundColor: Colors.grey[300],
                  wrap: true,
                  runSpacing: 5,
                  spacing: 5,
                ),
                fieldDecoration: FieldDecoration(
                  hintText: 'Select shift',
                  suffixIcon: Icon(IconBroken.arrowDown2),
                  hintStyle:
                      TextStyle(fontSize: 12.sp, color: AppColor.thirdColor),
                  showClearIcon: false,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Colors.grey),
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
                  selectedIcon: const Icon(Icons.check_box, color: Colors.blue),
                ),
                onSelectionChange: (selectedItems) {
                  selectedShiftsIds =
                      selectedItems.map((item) => (item).id!).toList();
                },
              ),
        verticalSpace(10),
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
                context.read<AddOrganizationCubit>().createFloor(
                    buildingId!,
                    selectedManagersIds,
                    selectedSupervisorsIds,
                    selectedCleanersIds,
                    selectedShiftsIds);
              }
            },
            color: AppColor.primaryColor,
            height: 47.h,
            width: double.infinity,
            textStyles: TextStyles.font20Whitesemimedium,
          );
  }
}
