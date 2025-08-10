import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/custom_multi_dropdown/custom_multi_dropdown.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/core/widgets/custom_description_text_form_field/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/core/widgets/custom_drop_down_list/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/edit_work_location/logic/cubit/edit_work_location_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EditFloorBody extends StatelessWidget {
  final int id;
  const EditFloorBody({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditWorkLocationCubit>();

    return Scaffold(
      appBar: AppBar(
          leading: CustomBackButton(), title: Text(S.of(context).EditFloor)),
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
          if (cubit.floorUsersShiftsDetailsModel == null ||
              cubit.nationalityListModel == null ||
              cubit.shiftModel == null ||
              cubit.usersModel == null) {
            return Loading();
          }
// Initialize controllers when data is ready
          WidgetsBinding.instance.addPostFrameCallback((_) {
            cubit.initializeFloorControllers();
          });
          return SafeArea(
            child: Padding(
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
                        hint: cubit
                            .floorUsersShiftsDetailsModel!.data!.countryName!,
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
                        hint: cubit.floorUsersShiftsDetailsModel!.data!.areaName!,
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
                          cubit.getCity();
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        S.of(context).City,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: cubit.floorUsersShiftsDetailsModel!.data!.cityName!,
                        items: cubit.cityItem
                            .map((e) => e.name ?? 'Unknown')
                            .toList(),
                        onPressed: (value) {
                          final selectedCity = cubit.cityModel?.data?.data
                              ?.firstWhere((city) =>
                                  city.name == cubit.cityController.text);
            
                          cubit.cityIdController.text =
                              selectedCity!.id!.toString();
                          cubit.getOrganization();
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: cubit.cityController,
                        isRead: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        S.of(context).Organization,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: cubit.floorUsersShiftsDetailsModel!.data!
                            .organizationName!,
                        items: cubit.organizationItem
                            .map((e) => e.name ?? 'Unknown')
                            .toList(),
                        onPressed: (value) {
                          final selectedOrganization = cubit
                              .organizationModel?.data?.data!
                              .firstWhere((organization) =>
                                  organization.name ==
                                  cubit.organizationController.text);
            
                          cubit.organizationIdController.text =
                              selectedOrganization!.id!.toString();
                          cubit.getBuilding();
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: cubit.organizationController,
                        isRead: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        S.of(context).Building,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: cubit
                            .floorUsersShiftsDetailsModel!.data!.buildingName!,
                        items: cubit.buildingItem
                            .map((e) => e.name ?? 'Unknown')
                            .toList(),
                        onPressed: (value) {
                          final selectedBuilding = cubit
                              .buildingModel?.data?.data!
                              .firstWhere((building) =>
                                  building.name == cubit.buildingController.text);
            
                          cubit.buildingIdController.text =
                              selectedBuilding!.id!.toString();
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: cubit.buildingController,
                        isRead: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        S.of(context).floorName,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomTextFormField(
                        hint: cubit.floorUsersShiftsDetailsModel!.data!.name!,
                        controller: cubit.floorController
                          ..text =
                              cubit.floorUsersShiftsDetailsModel!.data!.name!,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).floorNameRequired;
                          } else if (value.length > 55) {
                            return S.of(context).floorNameTooLong;
                          } else if (value.length < 3) {
                            return S.of(context).floorNameTooShort;
                          }
                          return null;
                        },
                        onlyRead: false,
                      ),
                      verticalSpace(10),
                      Text(
                        S.of(context).floorNumber,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomTextFormField(
                        hint: cubit.floorUsersShiftsDetailsModel!.data!.number!,
                        controller: cubit.floorNumberController
                          ..text =
                              cubit.floorUsersShiftsDetailsModel!.data!.number!,
                        onlyRead: false,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).floorNumberRequired;
                          } else if (value.length > 55) {
                            return S.of(context).floorNumberTooLong;
                          }
                          return null;
                        },
                      ),
                      verticalSpace(10),
                      Text(
                        S.of(context).floorDescription,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDescriptionTextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).descriptionRequired;
                            } else if (value.length < 3) {
                              return S.of(context).descriptionTooShort;
                            }
                            return null;
                          },
                          controller: cubit.floorDescriptionController
                            ..text = cubit
                                .floorUsersShiftsDetailsModel!.data!.description!,
                          hint: cubit
                              .floorUsersShiftsDetailsModel!.data!.description!),
                      verticalSpace(10),
                      Text(
                        S.of(context).managers,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomMultiDropdown(
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
                        controller: cubit.allManagersController,
                        onSelectionChange: (selectedItems) {
                          cubit.selectedManagersIds =
                              selectedItems.map((item) => (item).id!).toList();
                        },
                        hint: S.of(context).selectManagers,
                      ),
                      verticalSpace(10),
                      Text(
                        S.of(context).supervisors,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomMultiDropdown(
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
                        onSelectionChange: (selectedItems) {
                          cubit.selectedSupervisorsIds =
                              selectedItems.map((item) => (item).id!).toList();
                        },
                        hint: S.of(context).selectSupervisors,
                      ),
                      verticalSpace(10),
                      Text(
                        S.of(context).cleaners,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomMultiDropdown(
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
                        onSelectionChange: (selectedItems) {
                          cubit.selectedCleanersIds =
                              selectedItems.map((item) => (item).id!).toList();
                        },
                        hint: S.of(context).selectCleaners,
                      ),
                      verticalSpace(10),
                      Text(
                        S.of(context).shiftBody,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomMultiDropdown(
                        items: cubit.shiftModel?.data?.data?.isEmpty ?? true
                            ? [
                                DropdownItem(
                                  label: S.of(context).noShiftsAvailable,
                                  value: ShiftItem(
                                      id: null,
                                      name: S.of(context).noShiftsAvailable),
                                )
                              ]
                            : cubit.shiftModel!.data!.data!
                                .map((shift) => DropdownItem(
                                      label: shift.name!,
                                      value: shift,
                                    ))
                                .toList(),
                        controller: cubit.allShiftsController,
                        onSelectionChange: (selectedItems) {
                          cubit.selectedShiftsIds =
                              selectedItems.map((item) => (item).id!).toList();
                        },
                        hint: S.of(context).selectShift,
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
                                            body: S.of(context).floorBody,
                                            onPressed: () {
                                              cubit.editFloor(id);
                                            });
                                      });
                                }
                              },
                              color: AppColor.primaryColor,
                              textStyles: TextStyles.font20Whitesemimedium,
                            ),
                      verticalSpace(20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
