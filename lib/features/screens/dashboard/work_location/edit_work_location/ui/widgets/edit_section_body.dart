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

class EditSectionBody extends StatelessWidget {
  final int id;
  const EditSectionBody({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditWorkLocationCubit>();
    return Scaffold(
      appBar: AppBar(
          leading: CustomBackButton(), title: Text(S.of(context).EditSection)),
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
          if (cubit.sectionUsersShiftsDetailsModel == null ||
              cubit.nationalityListModel == null ||
              cubit.shiftModel == null ||
              cubit.usersModel == null) {
            return Loading();
          }
// Initialize controllers when data is ready
          WidgetsBinding.instance.addPostFrameCallback((_) {
            cubit.initializeSectionControllers();
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
                            .sectionUsersShiftsDetailsModel!.data!.countryName!,
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
                        hint:
                            cubit.sectionUsersShiftsDetailsModel!.data!.areaName!,
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
                        hint:
                            cubit.sectionUsersShiftsDetailsModel!.data!.cityName!,
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
                        hint: cubit.sectionUsersShiftsDetailsModel!.data!
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
                            .sectionUsersShiftsDetailsModel!.data!.buildingName!,
                        items: cubit.buildingItem
                            .map((e) => e.name ?? 'Unknown')
                            .toList(),
                        onPressed: (value) {
                          final selectedBuilding = cubit
                              .buildingModel?.data?.data!
                              .firstWhere((building) =>
                                  building.name == cubit.buildingController.text);
            
                          cubit.floorIdController.text =
                              selectedBuilding!.id!.toString();
                          cubit.getFloor();
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: cubit.buildingController,
                        isRead: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        S.of(context).Floor,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: cubit
                            .sectionUsersShiftsDetailsModel!.data!.floorName!,
                        items: cubit.floorItem
                            .map((e) => e.name ?? 'Unknown')
                            .toList(),
                        onPressed: (value) {
                          final selectedFloor = cubit.floorModel?.data?.data!
                              .firstWhere((floor) =>
                                  floor.name == cubit.floorController.text);
            
                          cubit.floorIdController.text =
                              selectedFloor!.id!.toString();
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: cubit.floorController,
                        isRead: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        S.of(context).sectionName,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomTextFormField(
                        hint: cubit.sectionUsersShiftsDetailsModel!.data!.name!,
                        controller: cubit.sectionController
                          ..text =
                              cubit.sectionUsersShiftsDetailsModel!.data!.name!,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).sectionNameRequired;
                          } else if (value.length > 55) {
                            return S.of(context).sectionNameTooLong;
                          } else if (value.length < 3) {
                            return S.of(context).sectionNameTooShort;
                          }
                          return null;
                        },
                        onlyRead: false,
                      ),
                      verticalSpace(10),
                      Text(
                        S.of(context).sectionNumber,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomTextFormField(
                        hint: cubit.sectionUsersShiftsDetailsModel!.data!.number!,
                        controller: cubit.sectionNumberController
                          ..text =
                              cubit.sectionUsersShiftsDetailsModel!.data!.number!,
                        onlyRead: false,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).sectionNumberRequired;
                          } else if (value.length > 55) {
                            return S.of(context).sectionNumberTooLong;
                          }
                          return null;
                        },
                      ),
                      verticalSpace(10),
                      Text(
                        S.of(context).sectionDescription,
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
                          controller: cubit.sectionDescriptionController
                            ..text = cubit.sectionUsersShiftsDetailsModel!.data!
                                .description!,
                          hint: cubit.sectionUsersShiftsDetailsModel!.data!
                              .description!),
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
                                            body: S.of(context).sectionBody,
                                            onPressed: () {
                                              cubit.editSection(id);
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
