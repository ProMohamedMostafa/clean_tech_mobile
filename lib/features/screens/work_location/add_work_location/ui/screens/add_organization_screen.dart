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
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/logic/add_work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/logic/add_work_location_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AddOrganizationDetailsScreen extends StatefulWidget {
  const AddOrganizationDetailsScreen({super.key});

  @override
  State<AddOrganizationDetailsScreen> createState() =>
      _AddOrganizationDetailsScreenState();
}

class _AddOrganizationDetailsScreenState
    extends State<AddOrganizationDetailsScreen> {
  List<int> selectedManagersIds = [];
  List<int> selectedSupervisorsIds = [];
  List<int> selectedCleanersIds = [];
  List<int> selectedShiftsIds = [];
  int? cityId;
  @override
  void initState() {
    context.read<AddWorkLocationCubit>()
      ..getNationality(userUsedOnly: false, areaUsedOnly: true)
      ..getAllUsers()
      ..getShifts();
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
            child: BlocConsumer<AddWorkLocationCubit, AddWorkLocationState>(
          listener: (context, state) {
            if (state is CreateOrganizationSuccessState) {
              toast(text: state.message, color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.workLocationScreen,
                  arguments: 2);
            }
            if (state is CreateOrganizationErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            if (context.read<AddWorkLocationCubit>().usersModel == null ||
                context.read<AddWorkLocationCubit>().nationalityModel == null ||
                context.read<AddWorkLocationCubit>().shiftModel == null) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              );
            }
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
                    verticalSpace(20),
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
          items: context
                      .read<AddWorkLocationCubit>()
                      .areaModel
                      ?.data
                      ?.areas
                      ?.isEmpty ??
                  true
              ? ['No area']
              : context
                      .read<AddWorkLocationCubit>()
                      .areaModel
                      ?.data
                      ?.areas
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
                ?.areas
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
          items: context
                      .read<AddWorkLocationCubit>()
                      .cityModel
                      ?.data
                      ?.data
                      ?.isEmpty ??
                  true
              ? ['No cities']
              : context
                      .read<AddWorkLocationCubit>()
                      .cityModel
                      ?.data
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
                ?.data
                ?.firstWhere((city) =>
                    city.name ==
                    context.read<AddWorkLocationCubit>().cityController.text);
            cityId = selectedCity!.id!;
          },
          suffixIcon: IconBroken.arrowDown2,
          controller: context.read<AddWorkLocationCubit>().cityController,
          isRead: false,
          keyboardType: TextInputType.text,
        ),
        verticalSpace(10),
        Text(
          "Organization Name",
          style: TextStyles.font16BlackRegular,
        ),
        CustomTextFormField(
          controller:
              context.read<AddWorkLocationCubit>().addOrganizationController,
          onlyRead: false,
          hint: '',
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
        ),
        verticalSpace(10),
        context.read<AddWorkLocationCubit>().usersModel!.data == null
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
        context.read<AddWorkLocationCubit>().usersModel!.data == null
            ? SizedBox.shrink()
            : MultiDropdown<User>(
                items: context
                        .read<AddWorkLocationCubit>()
                        .usersModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Manager')
                        .isEmpty
                    ? [
                        DropdownItem(
                          label: 'No managers available',
                          value:
                              User(id: null, userName: 'No managers available'),
                        )
                      ]
                    : context
                        .read<AddWorkLocationCubit>()
                        .usersModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Manager')
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
        context.read<AddWorkLocationCubit>().usersModel!.data == null
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
        context.read<AddWorkLocationCubit>().usersModel!.data == null
            ? SizedBox.shrink()
            : MultiDropdown<User>(
                items: context
                        .read<AddWorkLocationCubit>()
                        .usersModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Supervisor')
                        .isEmpty
                    ? [
                        DropdownItem(
                          label: 'No supervisors available',
                          value: User(
                              id: null, userName: 'No supervisors available'),
                        )
                      ]
                    : context
                        .read<AddWorkLocationCubit>()
                        .usersModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Supervisor')
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
        context.read<AddWorkLocationCubit>().usersModel!.data == null
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
        context.read<AddWorkLocationCubit>().usersModel!.data == null
            ? SizedBox.shrink()
            : MultiDropdown<User>(
                items: context
                        .read<AddWorkLocationCubit>()
                        .usersModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Cleaner')
                        .isEmpty
                    ? [
                        DropdownItem(
                          label: 'No cleaners available',
                          value:
                              User(id: null, userName: 'No cleaners available'),
                        )
                      ]
                    : context
                        .read<AddWorkLocationCubit>()
                        .usersModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Cleaner')
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
              if (context
                  .read<AddWorkLocationCubit>()
                  .formAddKey
                  .currentState!
                  .validate()) {
                context.read<AddWorkLocationCubit>().createOrganization(
                    cityId!,
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
