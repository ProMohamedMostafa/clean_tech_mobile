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
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/logic/add_work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/logic/add_work_location_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AddSectionScreen extends StatefulWidget {
  const AddSectionScreen({super.key});

  @override
  State<AddSectionScreen> createState() => _AddSectionScreenState();
}

class _AddSectionScreenState extends State<AddSectionScreen> {
  List<int> selectedManagersIds = [];
  List<int> selectedSupervisorsIds = [];
  List<int> selectedCleanersIds = [];
  List<int> selectedShiftsIds = [];
  int? buildingId;
  @override
  void initState() {
    context.read<AddWorkLocationCubit>()
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
        title: Text('Add Section', style: TextStyles.font16BlackSemiBold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: BlocConsumer<AddWorkLocationCubit, AddWorkLocationState>(
          listener: (context, state) {
            // if (state is CreateSectionSuccessState) {
            //   toast(text: state.message, color: Colors.blue);
            //   context.pushNamedAndRemoveLastTwo(Routes.workLocationScreen,
            //       arguments: 4);
            // }
            // if (state is CreateSectionErrorState) {
            //   toast(text: state.error, color: Colors.red);
            // }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: context.read<AddWorkLocationCubit>().formAddKey,
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
                      .read<AddWorkLocationCubit>()
                      .nationalityModel
                      ?.data
                      ?.isEmpty ??
                  true
              ? ['No country']
              : context
                      .read<AddWorkLocationCubit>()
                      .nationalityModel
                      ?.data
                      ?.map((e) => e.name ?? 'Unknown')
                      .toList() ??
                  [],
          onChanged: (value) {
            context.read<AddWorkLocationCubit>().nationalityController.text =
                value!;
            context.read<AddWorkLocationCubit>().getArea(value);
          },
          validator: (value) {
            if (value == null || value.isEmpty || value == 'No country') {
              return S.of(context).validationNationality;
            }
            return null;
          },
          suffixIcon: IconBroken.arrowDown2,
          controller:
              context.read<AddWorkLocationCubit>().nationalityController,
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
              context.read<AddWorkLocationCubit>().areaModel?.data?.isEmpty ??
                      true
                  ? ['No area']
                  : context
                          .read<AddWorkLocationCubit>()
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
                .read<AddWorkLocationCubit>()
                .areaModel
                ?.data
                ?.firstWhere((area) =>
                    area.name ==
                    context.read<AddWorkLocationCubit>().areaController.text);
            context.read<AddWorkLocationCubit>().getCity(selectedArea!.id!);
          },
          suffixIcon: IconBroken.arrowDown2,
          controller: context.read<AddWorkLocationCubit>().areaController,
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
              context.read<AddWorkLocationCubit>().cityModel?.data?.isEmpty ??
                      true
                  ? ['No cities']
                  : context
                          .read<AddWorkLocationCubit>()
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
                .read<AddWorkLocationCubit>()
                .cityModel
                ?.data
                ?.firstWhere((city) =>
                    city.name ==
                    context.read<AddWorkLocationCubit>().cityController.text);
            context
                .read<AddWorkLocationCubit>()
                .getOrganization(selectedCity!.id!);
          },
          suffixIcon: IconBroken.arrowDown2,
          controller: context.read<AddWorkLocationCubit>().cityController,
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
                      .read<AddWorkLocationCubit>()
                      .organizationModel
                      ?.data
                      ?.isEmpty ??
                  true
              ? ['No organizations']
              : context
                      .read<AddWorkLocationCubit>()
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
                .read<AddWorkLocationCubit>()
                .organizationModel
                ?.data
                ?.firstWhere((organization) =>
                    organization.name ==
                    context
                        .read<AddWorkLocationCubit>()
                        .organizationController
                        .text);
            context
                .read<AddWorkLocationCubit>()
                .getBuilding(selectedOrganization!.id!);
          },
          suffixIcon: IconBroken.arrowDown2,
          controller:
              context.read<AddWorkLocationCubit>().organizationController,
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
                      .read<AddWorkLocationCubit>()
                      .buildingModel
                      ?.data
                      ?.isEmpty ??
                  true
              ? ['No building']
              : context
                      .read<AddWorkLocationCubit>()
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
                .read<AddWorkLocationCubit>()
                .buildingModel
                ?.data
                ?.firstWhere((building) =>
                    building.name ==
                    context
                        .read<AddWorkLocationCubit>()
                        .buildingController
                        .text);

            buildingId = selectedBuilding!.id!;
          },
          suffixIcon: IconBroken.arrowDown2,
          controller: context.read<AddWorkLocationCubit>().buildingController,
          isRead: false,
          keyboardType: TextInputType.text,
        ),
        verticalSpace(10),
        Text(
          "Section Name",
          style: TextStyles.font16BlackRegular,
        ),
        CustomTextFormField(
          controller: context.read<AddWorkLocationCubit>().addSectionController,
          onlyRead: false,
          hint: '',
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
        ),
        verticalSpace(10),
        Text(
          "Section Number",
          style: TextStyles.font16BlackRegular,
        ),
        CustomTextFormField(
          controller:
              context.read<AddWorkLocationCubit>().sectionNumberController,
          onlyRead: false,
          hint: '',
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Section number is required";
            } else if (value.length > 55) {
              return 'Section number too long';
            } else if (value.length < 3) {
              return 'Section number too short';
            }
            return null;
          },
        ),
        verticalSpace(10),
        Text(
          "Section Description",
          style: TextStyles.font16BlackRegular,
        ),
        CustomDescriptionTextFormField(
          controller:
              context.read<AddWorkLocationCubit>().sectionDiscriptionController,
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
        context.read<AddWorkLocationCubit>().allManagersModel?.data == null
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
        context.read<AddWorkLocationCubit>().allManagersModel?.data == null
            ? SizedBox.shrink()
            : MultiDropdown<ManagersData>(
                items: context
                            .read<AddWorkLocationCubit>()
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
                        .read<AddWorkLocationCubit>()
                        .allManagersModel!
                        .data!
                        .map((manager) => DropdownItem(
                              label: manager.userName!,
                              value: manager,
                            ))
                        .toList(),
                controller:
                    context.read<AddWorkLocationCubit>().allmanagersController,
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
        context.read<AddWorkLocationCubit>().allSupervisorsModel?.data == null
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
        context.read<AddWorkLocationCubit>().allSupervisorsModel?.data == null
            ? SizedBox.shrink()
            : MultiDropdown<SupervisorsData>(
                items: context
                            .read<AddWorkLocationCubit>()
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
                        .read<AddWorkLocationCubit>()
                        .allSupervisorsModel!
                        .data!
                        .map((supervisor) => DropdownItem(
                              label: supervisor.userName!,
                              value: supervisor,
                            ))
                        .toList(),
                controller: context
                    .read<AddWorkLocationCubit>()
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
        context.read<AddWorkLocationCubit>().allCleanersModel?.data == null
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
        context.read<AddWorkLocationCubit>().allCleanersModel?.data == null
            ? SizedBox.shrink()
            : MultiDropdown<CleanersData>(
                items: context
                            .read<AddWorkLocationCubit>()
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
                        .read<AddWorkLocationCubit>()
                        .allCleanersModel!
                        .data!
                        .map((cleaner) => DropdownItem(
                              label: cleaner.userName!,
                              value: cleaner,
                            ))
                        .toList(),
                controller:
                    context.read<AddWorkLocationCubit>().allCleanersController,
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
        context.read<AddWorkLocationCubit>().shiftModel?.data == null
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
        context.read<AddWorkLocationCubit>().shiftModel?.data == null
            ? SizedBox.shrink()
            : MultiDropdown<ShiftDetails>(
                items: context
                            .read<AddWorkLocationCubit>()
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
                        .read<AddWorkLocationCubit>()
                        .shiftModel!
                        .data!
                        .data!
                        .map((shift) => DropdownItem(
                              label: shift.name!,
                              value: shift,
                            ))
                        .toList(),
                controller:
                    context.read<AddWorkLocationCubit>().shiftController,
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
              // if (context
              //     .read<AddWorkLocationCubit>()
              //     .formAddKey
              //     .currentState!
              //     .validate()) {
              //   context.read<AddWorkLocationCubit>().createSection(
              //       buildingId!,
              //       selectedManagersIds,
              //       selectedSupervisorsIds,
              //       selectedCleanersIds,
              //       selectedShiftsIds);
              // }
            },
            color: AppColor.primaryColor,
            height: 47.h,
            width: double.infinity,
            textStyles: TextStyles.font20Whitesemimedium,
          );
  }
}
