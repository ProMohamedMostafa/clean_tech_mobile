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
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/logic/cubit/edit_work_location_cubit.dart';

import 'package:smart_cleaning_application/generated/l10n.dart';

class EditPointBody extends StatelessWidget {
  final int id;
  const EditPointBody({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditWorkLocationCubit>();
    return Scaffold(
      appBar: AppBar(
          leading: CustomBackButton(), title: Text(S.of(context).EditPoint)),
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
          if (cubit.pointUsersDetailsModel == null ||
              cubit.nationalityListModel == null ||
              cubit.sensorModel == null ||
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
                      hint: cubit.pointUsersDetailsModel!.data!.countryName!,
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
                      hint: cubit.pointUsersDetailsModel!.data!.areaName!,
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
                      hint: cubit.pointUsersDetailsModel!.data!.cityName!,
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
                      hint:
                          cubit.pointUsersDetailsModel!.data!.organizationName!,
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
                      hint: cubit.pointUsersDetailsModel!.data!.buildingName!,
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
                      hint: cubit.pointUsersDetailsModel!.data!.floorName!,
                      items: cubit.floorItem
                          .map((e) => e.name ?? 'Unknown')
                          .toList(),
                      onPressed: (value) {
                        final selectedFloor = cubit.floorModel?.data?.data!
                            .firstWhere((floor) =>
                                floor.name == cubit.floorController.text);

                        cubit.floorIdController.text =
                            selectedFloor!.id!.toString();
                        cubit.getSection();
                      },
                      suffixIcon: IconBroken.arrowDown2,
                      controller: cubit.floorController,
                      isRead: false,
                      keyboardType: TextInputType.text,
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).Section,
                      style: TextStyles.font16BlackRegular,
                    ),
                    CustomDropDownList(
                      hint: cubit.pointUsersDetailsModel!.data!.sectionName!,
                      items: cubit.sectionItem
                          .map((e) => e.name ?? 'Unknown')
                          .toList(),
                      onPressed: (value) {
                        final selectedSection = cubit.sectionModel?.data?.data!
                            .firstWhere((section) =>
                                section.name == cubit.sectionController.text);

                        cubit.sectionIdController.text =
                            selectedSection!.id!.toString();
                      },
                      suffixIcon: IconBroken.arrowDown2,
                      controller: cubit.sectionController,
                      isRead: false,
                      keyboardType: TextInputType.text,
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).pointName,
                      style: TextStyles.font16BlackRegular,
                    ),
                    CustomTextFormField(
                      hint: cubit.pointUsersDetailsModel!.data!.name!,
                      controller: cubit.pointController
                        ..text = cubit.pointUsersDetailsModel!.data!.name!,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).pointNameRequired;
                        } else if (value.length > 55) {
                          return S.of(context).pointNameTooLong;
                        } else if (value.length < 3) {
                          return S.of(context).pointNameTooShort;
                        }
                        return null;
                      },
                      onlyRead: false,
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).pointNumber,
                      style: TextStyles.font16BlackRegular,
                    ),
                    CustomTextFormField(
                      hint: cubit.pointUsersDetailsModel!.data!.number!,
                      controller: cubit.pointNumberController
                        ..text = cubit.pointUsersDetailsModel!.data!.number!,
                      onlyRead: false,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).pointNumberRequired;
                        } else if (value.length > 55) {
                          return S.of(context).pointNumberTooLong;
                        }
                        return null;
                      },
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).pointDescription,
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
                      controller: cubit.pointDescriptionController
                        ..text =
                            cubit.pointUsersDetailsModel!.data!.description!,
                      hint: cubit.pointUsersDetailsModel!.data!.description!,
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).sensor,
                      style: TextStyles.font16BlackRegular,
                    ),
                    CustomDropDownList(
                      hint: S.of(context).selectSensor,
                      controller: cubit.sensorController,
                      items: cubit.sensorItem
                          .map((e) => e.name ?? 'Unknown')
                          .toList(),
                      onChanged: (value) {
                        final selectedsensor = cubit.sensorModel?.data?.data
                            ?.firstWhere((sensor) =>
                                sensor.name == cubit.sensorController.text)
                            .id
                            ?.toString();

                        if (selectedsensor != null) {
                          cubit.sensorIdController.text = selectedsensor;
                        }
                      },
                      suffixIcon: IconBroken.arrowDown2,
                      keyboardType: TextInputType.text,
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
                        hintText: cubit.pointUsersDetailsModel!.data!.users!
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
                        hintText: cubit.pointUsersDetailsModel!.data!.users!
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
                        hintText: cubit.pointUsersDetailsModel!.data!.users!
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
                    verticalSpace(10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).isCountable,
                          style: TextStyles.font16BlackRegular,
                        ),
                        horizontalSpace(10),
                        Row(
                          children: [
                            Radio<bool>(
                              value: true,
                              groupValue: cubit.isCountable ??
                                  cubit.pointUsersDetailsModel?.data
                                      ?.isCountable,
                              activeColor: AppColor.primaryColor,
                              onChanged: (value) {
                                cubit.changeIsCountable(value!);
                              },
                            ),
                            Text(S.of(context).yes),
                          ],
                        ),
                        horizontalSpace(10),
                        Row(
                          children: [
                            Radio<bool>(
                              value: false,
                              groupValue: cubit.isCountable ??
                                  cubit.pointUsersDetailsModel?.data
                                      ?.isCountable,
                              activeColor: AppColor.primaryColor,
                              onChanged: (value) {
                                cubit.changeIsCountable(value!);
                              },
                            ),
                            Text(S.of(context).no),
                          ],
                        ),
                      ],
                    ),
                    if ((cubit.isCountable ??
                            cubit.pointUsersDetailsModel?.data?.isCountable) ==
                        true) ...[
                      Text(
                        S.of(context).capacity,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomTextFormField(
                        onlyRead: false,
                        hint: S.of(context).writeCapacity,
                        controller: cubit.capacityController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          cubit.capacityController.text = value;
                        },
                      ),
                      verticalSpace(10),
                      Text(
                        S.of(context).unitTitle,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        onPressed: (selectedValue) {
                          final items = [
                            S.of(context).ml,
                            S.of(context).l,
                            S.of(context).kg,
                            S.of(context).g,
                            S.of(context).m,
                            S.of(context).cm,
                            S.of(context).pieces
                          ];
                          final selectedIndex = items.indexOf(selectedValue);
                          if (selectedIndex != -1) {
                            cubit.unitIdController.text =
                                selectedIndex.toString();
                          }
                        },
                        hint: cubit.pointUsersDetailsModel!.data!.unit ??
                            S.of(context).selectUnit,
                        items: [
                          S.of(context).ml,
                          S.of(context).l,
                          S.of(context).kg,
                          S.of(context).g,
                          S.of(context).m,
                          S.of(context).cm,
                          S.of(context).pieces
                        ],
                        controller: cubit.unitController,
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(10)
                    ],
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
                                          body: S.of(context).pointBody,
                                          onPressed: () {
                                            cubit.editPoint(id);
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
          );
        },
      ),
    );
  }
}
