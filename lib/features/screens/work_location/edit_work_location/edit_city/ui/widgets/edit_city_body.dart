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
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_cleaners_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_managers_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/data/model/all_supervisors_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_city/logic/edit_city_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_city/logic/edit_city_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EditCityBody extends StatefulWidget {
  final int id;
  const EditCityBody({super.key, required this.id});

  @override
  State<EditCityBody> createState() => _EditCityBodyState();
}

class _EditCityBodyState extends State<EditCityBody> {
  List<int> selectedManagersIds = [];
  List<int> selectedSupervisorsIds = [];
  List<int> selectedCleanersIds = [];
  @override
  void initState() {
    context.read<EditCityCubit>().getCityDetailsInEdit(widget.id);
    context.read<EditCityCubit>().getCityManagersDetails(widget.id);
    context.read<EditCityCubit>()
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
        title: Text('Edit City'),
      ),
      body: SafeArea(
        child: BlocConsumer<EditCityCubit, EditCityState>(
          listener: (context, state) {
            if (state is EditCitySuccessState) {
              toast(text: state.editCityModel.message!, color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.workLocationScreen);
            }
            if (state is EditCityErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            final cubit = context.read<EditCityCubit>();
            if (cubit.cityDetailsInEditModel == null ||
                cubit.cityManagersDetailsModel == null) {
              return const Center(
                child: CircularProgressIndicator(color: AppColor.primaryColor),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: context.read<EditCityCubit>().formKey,
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
                            .read<EditCityCubit>()
                            .cityDetailsInEditModel!
                            .data!
                            .countryName!,
                        items: context
                                    .read<EditCityCubit>()
                                    .nationalityModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No country']
                            : context
                                    .read<EditCityCubit>()
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
                          return null;
                        },
                        onPressed: (value) {
                          context
                              .read<EditCityCubit>()
                              .nationalityController
                              .text = value;
                          context.read<EditCityCubit>().getArea(value);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditCityCubit>().nationalityController,
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
                            .read<EditCityCubit>()
                            .cityDetailsInEditModel!
                            .data!
                            .areaName!,
                        items: context
                                    .read<EditCityCubit>()
                                    .areaModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No areas']
                            : context
                                    .read<EditCityCubit>()
                                    .areaModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value == 'No areas') {
                            return "Area is required";
                          }
                          return null;
                        },
                        onPressed: (value) {
                          final selectedArea = context
                              .read<EditCityCubit>()
                              .areaModel
                              ?.data
                              ?.firstWhere((area) =>
                                  area.name ==
                                  context
                                      .read<EditCityCubit>()
                                      .areaController
                                      .text);

                          context
                              .read<EditCityCubit>()
                              .getCity(selectedArea!.id!);
                          context.read<EditCityCubit>().areaIdController.text =
                              selectedArea.id!.toString();
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditCityCubit>().areaController,
                        isRead: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        "Edit city",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomTextFormField(
                        hint: context
                            .read<EditCityCubit>()
                            .cityDetailsInEditModel!
                            .data!
                            .name!,
                        controller:
                            context.read<EditCityCubit>().cityController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "City is required";
                          }
                          return null;
                        },
                        onlyRead: false,
                      ),
                      verticalSpace(10),
                      context
                                  .read<EditCityCubit>()
                                  .cityManagersDetailsModel
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
                                  .read<EditCityCubit>()
                                  .cityManagersDetailsModel
                                  ?.data ==
                              null
                          ? SizedBox.shrink()
                          : MultiDropdown<ManagersData>(
                              items: context
                                          .read<EditCityCubit>()
                                          .allManagersModel
                                          ?.data ==
                                      null
                                  ? [
                                      DropdownItem(
                                        label: 'No managers available',
                                        value: ManagersData(
                                            id: null,
                                            userName: 'No managers available'),
                                      )
                                    ]
                                  : context
                                      .read<EditCityCubit>()
                                      .allManagersModel!
                                      .data!
                                      .map((manager) => DropdownItem(
                                            label: manager.userName!,
                                            value: manager,
                                          ))
                                      .toList(),
                              controller: context
                                  .read<EditCityCubit>()
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
                                    .read<EditCityCubit>()
                                    .cityManagersDetailsModel!
                                    .data!
                                    .managers!
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
                      context.read<EditCityCubit>().allSupervisorsModel?.data ==
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
                      context.read<EditCityCubit>().allSupervisorsModel?.data ==
                              null
                          ? SizedBox.shrink()
                          : MultiDropdown<SupervisorsData>(
                              items: context
                                          .read<EditCityCubit>()
                                          .allSupervisorsModel
                                          ?.data ==
                                      null
                                  ? [
                                      DropdownItem(
                                        label: 'No supervisors available',
                                        value: SupervisorsData(
                                            id: null,
                                            userName:
                                                'No supervisors available'),
                                      )
                                    ]
                                  : context
                                      .read<EditCityCubit>()
                                      .allSupervisorsModel!
                                      .data!
                                      .map((supervisor) => DropdownItem(
                                            label: supervisor.userName!,
                                            value: supervisor,
                                          ))
                                      .toList(),
                              controller: context
                                  .read<EditCityCubit>()
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
                                    .read<EditCityCubit>()
                                    .cityManagersDetailsModel!
                                    .data!
                                    .supervisors!
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
                                  .read<EditCityCubit>()
                                  .cityManagersDetailsModel
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
                                  .read<EditCityCubit>()
                                  .cityManagersDetailsModel
                                  ?.data ==
                              null
                          ? SizedBox.shrink()
                          : MultiDropdown<CleanersData>(
                              items: context
                                          .read<EditCityCubit>()
                                          .allCleanersModel
                                          ?.data ==
                                      null
                                  ? [
                                      DropdownItem(
                                        label: 'No cleaners available',
                                        value: CleanersData(
                                            id: null,
                                            userName: 'No cleaners available'),
                                      )
                                    ]
                                  : context
                                      .read<EditCityCubit>()
                                      .allCleanersModel!
                                      .data!
                                      .map((cleaner) => DropdownItem(
                                            label: cleaner.userName!,
                                            value: cleaner,
                                          ))
                                      .toList(),
                              controller: context
                                  .read<EditCityCubit>()
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
                                    .read<EditCityCubit>()
                                    .cityManagersDetailsModel!
                                    .data!
                                    .cleaners!
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
                      state is EditCityLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: AppColor.primaryColor),
                            )
                          : DefaultElevatedButton(
                              name: "Edit",
                              onPressed: () {
                                showCustomDialog(context,
                                    "Are you Sure you want save the edit of this city ?",
                                    () {
                                  context.read<EditCityCubit>().editCity(
                                      widget.id,
                                      selectedManagersIds,
                                      selectedSupervisorsIds,
                                      selectedCleanersIds);
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
