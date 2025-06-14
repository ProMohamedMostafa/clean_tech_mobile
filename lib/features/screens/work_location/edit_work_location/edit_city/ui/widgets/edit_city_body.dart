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
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/city_users_details_model.dart';
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
    context.read<EditCityCubit>().getNationality();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text('Edit City'),
      ),
      body: SafeArea(
        child: BlocConsumer<EditCityCubit, EditCityState>(
          listener: (context, state) {
            if (state is EditCitySuccessState) {
              toast(text: state.editCityModel.message!, color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.workLocationScreen,
                  arguments: 1);
            }
            if (state is EditCityErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            final cubit = context.read<EditCityCubit>();
            if (cubit.cityDetailsInEditModel == null) {
              return Loading();
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
                        onPressed: (value) {
                          context
                              .read<EditCityCubit>()
                              .nationalityController
                              .text = value;
                          context.read<EditCityCubit>().getAreas(value);
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
                                    .areasModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No areas']
                            : context
                                    .read<EditCityCubit>()
                                    .areasModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedArea = context
                              .read<EditCityCubit>()
                              .areasModel
                              ?.data
                              ?.data
                              ?.firstWhere((area) =>
                                  area.name ==
                                  context
                                      .read<EditCityCubit>()
                                      .areaController
                                      .text);

                          context
                              .read<EditCityCubit>()
                              .getCityy(selectedArea!.id!);
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
                        "City Name",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomTextFormField(
                        hint: context
                            .read<EditCityCubit>()
                            .cityDetailsInEditModel!
                            .data!
                            .name!,
                        controller: context.read<EditCityCubit>().cityController
                          ..text = context
                              .read<EditCityCubit>()
                              .cityDetailsInEditModel!
                              .data!
                              .name!,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "City name is required";
                          } else if (value.length > 55) {
                            return 'City name too long';
                          } else if (value.length < 3) {
                            return 'City name too short';
                          }
                          return null;
                        },
                        onlyRead: false,
                      ),
                      verticalSpace(10),
                      context
                                  .read<EditCityCubit>()
                                  .cityUsersDetailsModel
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
                                  .cityUsersDetailsModel
                                  ?.data ==
                              null
                          ? SizedBox.shrink()
                          : MultiDropdown<Users>(
                              items: context
                                      .read<EditCityCubit>()
                                      .cityUsersDetailsModel!
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
                                      .read<EditCityCubit>()
                                      .cityUsersDetailsModel!
                                      .data!
                                      .users!
                                      .where((user) => user.role == 'Manager')
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
                                    .cityUsersDetailsModel!
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
                                  .read<EditCityCubit>()
                                  .cityUsersDetailsModel
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
                                  .read<EditCityCubit>()
                                  .cityUsersDetailsModel
                                  ?.data ==
                              null
                          ? SizedBox.shrink()
                          : MultiDropdown<Users>(
                              items: context
                                      .read<EditCityCubit>()
                                      .cityUsersDetailsModel!
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
                                      .read<EditCityCubit>()
                                      .cityUsersDetailsModel!
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
                                    .cityUsersDetailsModel!
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
                                  .read<EditCityCubit>()
                                  .cityUsersDetailsModel
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
                                  .cityUsersDetailsModel
                                  ?.data ==
                              null
                          ? SizedBox.shrink()
                          : MultiDropdown<Users>(
                              items: context
                                      .read<EditCityCubit>()
                                      .cityUsersDetailsModel!
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
                                      .read<EditCityCubit>()
                                      .cityUsersDetailsModel!
                                      .data!
                                      .users!
                                      .where((user) => user.role == 'Cleaner')
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
                                    .cityUsersDetailsModel!
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
                      state is EditCityLoadingState
                          ? Loading()
                          : DefaultElevatedButton(
                              name: "Edit",
                              onPressed: () {
                                if (context
                                    .read<EditCityCubit>()
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return PopUpMeassage(
                                            title: 'edit',
                                            body: 'city',
                                            onPressed: () {
                                              context
                                                  .read<EditCityCubit>()
                                                  .editCity(
                                                      widget.id,
                                                      selectedManagersIds,
                                                      selectedSupervisorsIds,
                                                      selectedCleanersIds);
                                            
                                            });
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
