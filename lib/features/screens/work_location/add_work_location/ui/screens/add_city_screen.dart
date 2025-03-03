import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_cleaners_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_managers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_supervisors_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/logic/add_organization_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/logic/add_organization_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AddCityScreen extends StatefulWidget {
  const AddCityScreen({super.key});

  @override
  State<AddCityScreen> createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {
  List<int> selectedManagersIds = [];
  List<int> selectedSupervisorsIds = [];
  List<int> selectedCleanersIds = [];
  int? areaId;
  @override
  void initState() {
    context.read<AddOrganizationCubit>()
      ..getNationality()
      ..getManagers()
      ..getSupervisors()
      ..getCleaners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text('Add City', style: TextStyles.font16BlackSemiBold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: BlocConsumer<AddOrganizationCubit, AddOrganizationState>(
          listener: (context, state) {
            if (state is CreateCitySuccessState) {
              toast(text: state.message, color: Colors.blue);
              context.pop();
            }
            if (state is CreateCityErrorState) {
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
            areaId = selectedArea!.id!;
          },
          suffixIcon: IconBroken.arrowDown2,
          controller: context.read<AddOrganizationCubit>().areaController,
          isRead: false,
          keyboardType: TextInputType.text,
        ),
        verticalSpace(10),
        Text(
          "Add city",
          style: TextStyles.font16BlackRegular,
        ),
        CustomTextFormField(
          controller: context.read<AddOrganizationCubit>().addCityController,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "City is required";
            } else if (value.length > 55) {
              return 'User name too long';
            } else if (value.length < 3) {
              return 'User name too short';
            }
            return null;
          },
          hint: '',
          onlyRead: false,
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
                context.read<AddOrganizationCubit>().createCity(
                    areaId!,
                    selectedManagersIds,
                    selectedSupervisorsIds,
                    selectedCleanersIds);
              }
            },
            color: AppColor.primaryColor,
            height: 47.h,
            width: double.infinity,
            textStyles: TextStyles.font20Whitesemimedium,
          );
  }
}
