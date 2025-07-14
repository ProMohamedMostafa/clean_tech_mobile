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
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/logic/cubit/edit_work_location_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EditCityBody extends StatelessWidget {
  final int id;
  const EditCityBody({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditWorkLocationCubit>();
    return Scaffold(
      appBar: AppBar(
          leading: CustomBackButton(), title: Text(S.of(context).EditCity)),
      body: BlocConsumer<EditWorkLocationCubit, EditWorkLocationState>(
        listener: (context, state) {
          if (state is EditWorkLocationSuccessState) {
            toast(text: state.message, isSuccess: true);
            context.popWithTrueResult();
          }
          if (state is EditWorkLocationErrorState) {
            toast(text: state.error, isSuccess: false);
          }
        },
        builder: (context, state) {
          if (cubit.cityUsersDetailsModel == null ||
              cubit.nationalityListModel == null ||
              cubit.usersModel == null) {
            return Loading();
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: cubit.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).addUserText12,
                        style: TextStyles.font16BlackRegular),
                    CustomDropDownList(
                      hint: cubit.cityUsersDetailsModel!.data!.countryName!,
                      items: cubit.nationalityData
                          .map((e) => e.name ?? 'un known')
                          .toList(),
                      onChanged: (value) {
                        cubit.getArea();
                      },
                      suffixIcon: IconBroken.arrowDown2,
                      controller: cubit.nationalityController,
                      isRead: false,
                      keyboardType: TextInputType.text,
                    ),
                    verticalSpace(10),
                    Text(S.of(context).Area,
                        style: TextStyles.font16BlackRegular),
                    CustomDropDownList(
                      hint: cubit.cityUsersDetailsModel!.data!.areaName!,
                      controller: cubit.areaController,
                      items: cubit.areaItem
                          .map((e) => e.name ?? 'Unknown')
                          .toList(),
                      onChanged: (value) {
                        final selectedArea = cubit.areaListModel?.data?.data
                            ?.firstWhere((area) =>
                                area.name == cubit.areaController.text)
                            .id
                            ?.toString();

                        if (selectedArea != null) {
                          cubit.areaIdController.text = selectedArea;
                        }
                      },
                      suffixIcon: IconBroken.arrowDown2,
                      keyboardType: TextInputType.text,
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).cityName,
                      style: TextStyles.font16BlackRegular,
                    ),
                    CustomTextFormField(
                      hint: cubit.cityUsersDetailsModel!.data!.name!,
                      controller: cubit.cityController
                        ..text = cubit.cityUsersDetailsModel!.data!.name!,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).cityNameRequired;
                        } else if (value.length > 55) {
                          return S.of(context).cityNameTooLong;
                        } else if (value.length < 3) {
                          return S.of(context).cityNameTooShort;
                        }
                        return null;
                      },
                      onlyRead: false,
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).managers,
                      style: TextStyles.font16BlackRegular,
                    ),
                    MultiDropdown<UserItem>(
                      items: cubit.usersModel!.data!.users!
                              .where((user) => user.role == 'Manager')
                              .isEmpty
                          ? [
                              DropdownItem(
                                label: S.of(context).noManagers,
                                value: UserItem(
                                    id: null,
                                    userName: S.of(context).noManagers),
                              )
                            ]
                          : cubit.usersModel!.data!.users!
                              .where((user) => user.role == 'Manager')
                              .map((manager) => DropdownItem(
                                    label: manager.userName!,
                                    value: manager,
                                  ))
                              .toList(),
                      controller: cubit.allmanagersController,
                      enabled: true,
                      chipDecoration: ChipDecoration(
                        backgroundColor: Colors.grey[300],
                        wrap: true,
                        runSpacing: 5,
                        spacing: 5,
                      ),
                      fieldDecoration: FieldDecoration(
                        hintText: cubit.cityUsersDetailsModel!.data!.users!
                            .where((user) => user.role == 'Manager')
                            .map((manager) => manager.userName)
                            .join(', '),
                        suffixIcon: Icon(IconBroken.arrowDown2),
                        hintStyle: TextStyle(
                            fontSize: 12.sp, color: AppColor.thirdColor),
                        showClearIcon: false,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: AppColor.primaryColor,
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
                        selectedIcon:
                            const Icon(Icons.check_box, color: Colors.blue),
                      ),
                      onSelectionChange: (selectedItems) {
                        cubit.selectedManagersIds =
                            selectedItems.map((item) => (item).id!).toList();
                      },
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).supervisors,
                      style: TextStyles.font16BlackRegular,
                    ),
                    MultiDropdown<UserItem>(
                      items: cubit.usersModel!.data!.users!
                              .where((user) => user.role == 'Supervisor')
                              .isEmpty
                          ? [
                              DropdownItem(
                                label: S.of(context).noSupervisors,
                                value: UserItem(
                                    id: null,
                                    userName: S.of(context).noSupervisors),
                              )
                            ]
                          : cubit.usersModel!.data!.users!
                              .where((user) => user.role == 'Supervisor')
                              .map((supervisor) => DropdownItem(
                                    label: supervisor.userName!,
                                    value: supervisor,
                                  ))
                              .toList(),
                      controller: cubit.allSupervisorsController,
                      enabled: true,
                      chipDecoration: ChipDecoration(
                        backgroundColor: Colors.grey[300],
                        wrap: true,
                        runSpacing: 5,
                        spacing: 5,
                      ),
                      fieldDecoration: FieldDecoration(
                        hintText: cubit.cityUsersDetailsModel!.data!.users!
                            .where((user) => user.role == 'Supervisor')
                            .map((supervisor) => supervisor.userName)
                            .join(', '),
                        suffixIcon: Icon(IconBroken.arrowDown2),
                        hintStyle: TextStyle(
                            fontSize: 12.sp, color: AppColor.thirdColor),
                        showClearIcon: false,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: AppColor.primaryColor,
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
                        selectedIcon:
                            const Icon(Icons.check_box, color: Colors.blue),
                      ),
                      onSelectionChange: (selectedItems) {
                        cubit.selectedSupervisorsIds =
                            selectedItems.map((item) => (item).id!).toList();
                      },
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).cleaners,
                      style: TextStyles.font16BlackRegular,
                    ),
                    MultiDropdown<UserItem>(
                      items: cubit.usersModel!.data!.users!
                              .where((user) => user.role == 'Cleaner')
                              .isEmpty
                          ? [
                              DropdownItem(
                                label: S.of(context).noCleaners,
                                value: UserItem(
                                    id: null,
                                    userName: S.of(context).noCleaners),
                              )
                            ]
                          : cubit.usersModel!.data!.users!
                              .where((user) => user.role == 'Cleaner')
                              .map((cleaner) => DropdownItem(
                                    label: cleaner.userName!,
                                    value: cleaner,
                                  ))
                              .toList(),
                      controller: cubit.allCleanersController,
                      enabled: true,
                      chipDecoration: ChipDecoration(
                        backgroundColor: Colors.grey[300],
                        wrap: true,
                        runSpacing: 5,
                        spacing: 5,
                      ),
                      fieldDecoration: FieldDecoration(
                        hintText: cubit.cityUsersDetailsModel!.data!.users!
                            .where((user) => user.role == 'Cleaner')
                            .map((cleaner) => cleaner.userName)
                            .join(', '),
                        suffixIcon: Icon(IconBroken.arrowDown2),
                        hintStyle: TextStyle(
                            fontSize: 12.sp, color: AppColor.thirdColor),
                        showClearIcon: false,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: AppColor.primaryColor,
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
                        selectedIcon:
                            const Icon(Icons.check_box, color: Colors.blue),
                      ),
                      onSelectionChange: (selectedItems) {
                        cubit.selectedCleanersIds =
                            selectedItems.map((item) => (item).id!).toList();
                      },
                    ),
                    verticalSpace(20),
                    state is EditWorkLocationLoadingState
                        ? Loading()
                        : DefaultElevatedButton(
                            name: S.of(context).editButton,
                            onPressed: () {
                              if (cubit.formKey.currentState!.validate()) {
                                showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return PopUpMessage(
                                          title: S.of(context).TitleEdit,
                                          body: S.of(context).cityBody,
                                          onPressed: () {
                                            cubit.editCity(id);
                                          });
                                    });
                              }
                            },
                            color: AppColor.primaryColor,

                            textStyles: TextStyles.font20Whitesemimedium,
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
