import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/integration_buttons/integrations_buttons.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/assign/logic/assign_cubit.dart';
import 'package:smart_cleaning_application/features/screens/assign/logic/assign_state.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/data/model/all_shifts_model.dart';

import 'package:smart_cleaning_application/generated/l10n.dart';

class AssignBody extends StatelessWidget {
  const AssignBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AssignCubit>();
    return Scaffold(
        appBar: AppBar(
            leading: CustomBackButton(), title: Text(S.of(context).integ3)),
        body:
            BlocConsumer<AssignCubit, AssignStates>(listener: (context, state) {
          if (state is AssignSuccessState) {
            toast(text: state.assignModel.message!, isSuccess: true);
          }
          if (state is AssignErrorState) {
            toast(text: state.error, isSuccess: false);
          }
        }, builder: (context, state) {
          if (cubit.shiftsModel == null || cubit.roleModel == null) {
            return Loading();
          }

          return CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            integrationsButtons(
                                selectedIndex: cubit.selecteIndex,
                                onTap: (index) {
                                  cubit.selecteIndex = index;
                                  cubit.clearAllControllers();
                                  cubit.fetchAppropriateOrganizations();
                                },
                                firstLabel: S.of(context).user,
                                secondLabel: S.of(context).shiftBody,
                                thirdLabel: S.of(context).workLocation),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Divider(
                                      height: 20.h,
                                      color: AppColor.primaryColor),
                                ),
                                horizontalSpace(10),
                                Text(
                                  "+",
                                  style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontSize: 16),
                                ),
                                horizontalSpace(10),
                                Expanded(
                                  child: Divider(
                                      height: 20.h,
                                      color: AppColor.primaryColor),
                                ),
                              ],
                            ),
                            integrationsButtons(
                              selectedIndex: cubit.selecteSecendIndex,
                              onTap: (index) {
                                cubit.selecteSecendIndex = index;
                                cubit.clearAllControllers();
                                cubit.fetchAppropriateOrganizations();
                              },
                              firstLabel:
                                  cubit.getFirstLabel(cubit.selecteIndex),
                              secondLabel:
                                  cubit.getSecondLabel(cubit.selecteIndex),
                            ),
                            verticalSpace(10),
                            if ((cubit.selecteIndex == 0 &&
                                    cubit.selecteSecendIndex == 0) ||
                                (cubit.selecteIndex == 1 &&
                                    cubit.selecteSecendIndex == 0)) ...[
                              Text(
                                S.of(context).addUserText13,
                                style: TextStyles.font16BlackRegular,
                              ),
                              CustomDropDownList(
                                  color: AppColor.primaryColor,
                                  isRead: true,
                                  onChanged: (selectedValue) {
                                    final selectedRole = cubit.roleModel?.data
                                        ?.firstWhere((role) =>
                                            role.name == selectedValue)
                                        .id;
                                    cubit.getUsers(roleId: selectedRole!);
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return S.of(context).validationRole;
                                    }
                                    return null;
                                  },
                                  hint: S.of(context).select_role,
                                  items: cubit.roleDataItem
                                      .map((e) => e.name ?? 'Unknown')
                                      .toList(),
                                  controller: cubit.roleController,
                                  suffixIcon: IconBroken.arrowDown2,
                                  keyboardType: TextInputType.text),
                              verticalSpace(10),
                              if (cubit.roleController.text.isNotEmpty) ...[
                                Text(
                                  cubit.roleController.text,
                                  style: TextStyles.font16BlackRegular,
                                ),
                                CustomDropDownList(
                                  onPressed: (selectedValue) {
                                    final selectedId = cubit
                                        .usersModel?.data?.users!
                                        .firstWhere((manager) =>
                                            manager.userName == selectedValue)
                                        .id
                                        ?.toString();

                                    if (selectedId != null) {
                                      cubit.userIdController.text = selectedId;
                                    }
                                  },
                                  controller: cubit.userController,
                                  keyboardType: TextInputType.text,
                                  suffixIcon: IconBroken.arrowDown2,
                                  hint: (cubit.roleIdController.text == '1' ||
                                          cubit.roleIdController.text == '2' ||
                                          cubit.roleIdController.text == '5')
                                      ? S.of(context).roleAdmin
                                      : (cubit.roleIdController.text == '3')
                                          ? S.of(context).roleManager
                                          : (cubit.roleIdController.text == '4')
                                              ? S.of(context).roleSupervisor
                                              : S.of(context).roleUsers,
                                  items: cubit.usersModel?.data?.users!
                                              .isEmpty ??
                                          true
                                      ? [
                                          if (cubit.roleIdController.text == '1' ||
                                              cubit.roleIdController.text ==
                                                  '2' ||
                                              cubit.roleIdController.text ==
                                                  '5')
                                            S.of(context).noAdminsAvailable
                                          else if (cubit
                                                  .roleIdController.text ==
                                              '3')
                                            S.of(context).noManagersAvailable
                                          else if (cubit
                                                  .roleIdController.text ==
                                              '4')
                                            S.of(context).noSupervisorsAvailable
                                          else
                                            S.of(context).noUsersAvailable
                                        ]
                                      : cubit.usersModel?.data?.users!
                                              .map((e) =>
                                                  e.userName ??
                                                  S.of(context).roleUsers)
                                              .toList() ??
                                          [],
                                ),
                                verticalSpace(10),
                              ]
                            ],
                            if ((cubit.selecteIndex == 0 &&
                                    cubit.selecteSecendIndex == 1) ||
                                (cubit.selecteIndex == 2 &&
                                    cubit.selecteSecendIndex == 0)) ...[
                              Text(
                                S.of(context).addUserText13,
                                style: TextStyles.font16BlackRegular,
                              ),
                              CustomDropDownList(
                                  color: AppColor.primaryColor,
                                  isRead: true,
                                  onChanged: (selectedValue) {
                                    final selectedRole = cubit.roleModel?.data
                                        ?.firstWhere((role) =>
                                            role.name == selectedValue);

                                    cubit.roleController.text =
                                        selectedRole?.name ?? '';
                                    cubit.roleIdController.text =
                                        selectedRole?.id?.toString() ?? '';

                                    // VERY IMPORTANT
                                    cubit.usersController
                                        .clearAll(); // clear selected users
                                    cubit.getUsers(roleId: selectedRole!.id);
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return S.of(context).validationRole;
                                    }
                                    return null;
                                  },
                                  hint: S.of(context).select_role,
                                  items: cubit.roleDataItem
                                      .map((e) => e.name ?? 'Unknown')
                                      .toList(),
                                  controller: cubit.roleController,
                                  suffixIcon: IconBroken.arrowDown2,
                                  keyboardType: TextInputType.text),
                              verticalSpace(10),
                              if (cubit.roleController.text.isNotEmpty) ...[
                                Text(
                                  cubit.roleController.text.isEmpty
                                      ? S.of(context).user
                                      : cubit.roleController.text,
                                  style: TextStyles.font16BlackRegular,
                                ),
                                state is AllUsersLoadingState
                                    ? Loading()
                                    : BlocBuilder<AssignCubit, AssignStates>(
                                        buildWhen: (prev, curr) =>
                                            curr is AllUsersSuccessState ||
                                            curr is UpdateUsersDropdownState,
                                        builder: (context, state) {
                                          final users =
                                              cubit.usersModel?.data?.users ??
                                                  [];
                                          return MultiDropdown<UserItem>(
                                            key: cubit.userDropdownKey,
                                            items: users.isEmpty
                                                ? [
                                                    DropdownItem(
                                                        label: S
                                                            .of(context)
                                                            .noUsersAvailable,
                                                        value: UserItem(
                                                            id: null,
                                                            userName: ''))
                                                  ]
                                                : users
                                                    .map((user) =>
                                                        DropdownItem<UserItem>(
                                                          label: user
                                                                  .userName ??
                                                              'Unknown User',
                                                          value: user,
                                                        ))
                                                    .toList(),
                                            controller: cubit.usersController,
                                            onSelectionChange: (selectedItems) {
                                              cubit.selectedUsersIds =
                                                  selectedItems
                                                      .where((item) =>
                                                          item.id != null)
                                                      .map((item) => item.id!)
                                                      .toList();
                                            },
                                            enabled: true,
                                            chipDecoration: ChipDecoration(
                                              backgroundColor: Colors.grey[300],
                                              wrap: true,
                                              runSpacing: 5,
                                              spacing: 5,
                                            ),
                                            fieldDecoration: FieldDecoration(
                                              hintText:
                                                  cubit.roleController.text,
                                              hintStyle: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: AppColor.thirdColor),
                                              showClearIcon: false,
                                              suffixIcon: Padding(
                                                padding:
                                                    EdgeInsets.only(right: 10),
                                                child:
                                                    Icon(IconBroken.arrowDown2),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: BorderSide(
                                                    color: Colors.grey[300]!),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: const BorderSide(
                                                    color:
                                                        AppColor.primaryColor),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                            ),
                                            dropdownDecoration:
                                                const DropdownDecoration(
                                                    maxHeight: 200),
                                            dropdownItemDecoration:
                                                DropdownItemDecoration(
                                              selectedIcon: const Icon(
                                                  Icons.check_box,
                                                  color: Colors.blue),
                                            ),
                                          );
                                        },
                                      ),
                                verticalSpace(10),
                              ],
                            ],
                            if ((cubit.selecteIndex == 0 &&
                                    cubit.selecteSecendIndex == 0) ||
                                (cubit.selecteIndex == 1 &&
                                    cubit.selecteSecendIndex == 0) ||
                                (cubit.selecteIndex == 1 &&
                                    cubit.selecteSecendIndex == 1) ||
                                (cubit.selecteIndex == 2 &&
                                    cubit.selecteSecendIndex == 1)) ...[
                              Text(
                                S.of(context).shiftBody,
                                style: TextStyles.font16BlackRegular,
                              ),
                              MultiDropdown<ShiftData>(
                                items: cubit.shiftsModel!.data?.shifts
                                            ?.isEmpty ??
                                        true
                                    ? [
                                        DropdownItem(
                                          label:
                                              S.of(context).noShiftsAvailable,
                                          value: ShiftData(
                                              id: null,
                                              name: S.of(context).selectUnit),
                                        )
                                      ]
                                    : cubit.shiftsModel!.data!.shifts!
                                        .map((role) => DropdownItem(
                                              label: role.name!,
                                              value: role,
                                            ))
                                        .toList(),
                                controller: cubit.shiftsController,
                                enabled: true,
                                chipDecoration: ChipDecoration(
                                  backgroundColor: Colors.grey[300],
                                  wrap: true,
                                  runSpacing: 5,
                                  spacing: 5,
                                ),
                                fieldDecoration: FieldDecoration(
                                  hintText: S.of(context).selectShift,
                                  hintStyle: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColor.thirdColor),
                                  showClearIcon: false,
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Icon(IconBroken.arrowDown2),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]!),
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
                                dropdownDecoration:
                                    const DropdownDecoration(maxHeight: 200),
                                dropdownItemDecoration: DropdownItemDecoration(
                                  selectedIcon: const Icon(Icons.check_box,
                                      color: Colors.blue),
                                ),
                                onSelectionChange: (selectedItems) {
                                  cubit.selectedShiftsIds = selectedItems
                                      .map((item) => (item).id!)
                                      .toList();
                                },
                              ),
                              verticalSpace(10),
                            ],
                            if ((cubit.selecteIndex == 0 &&
                                    cubit.selecteSecendIndex == 1) ||
                                (cubit.selecteIndex == 1 &&
                                    cubit.selecteSecendIndex == 1) ||
                                (cubit.selecteIndex == 2 &&
                                    cubit.selecteSecendIndex == 0) ||
                                (cubit.selecteIndex == 2 &&
                                    cubit.selecteSecendIndex == 1)) ...[
                              Text(
                                S.of(context).workLocation,
                                style: TextStyles.font16BlackRegular,
                              ),
                              CustomDropDownList(
                                hint: S.of(context).select_work_location,
                                controller: cubit.levelController,
                                color: AppColor.primaryColor,
                                items: cubit.levelOrder,
                                onChanged: (value) {
                                  if (value != null) {
                                    cubit.setSelectedLevel(value);
                                  }
                                },
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text,
                              ),
                              verticalSpace(10),
                              if (cubit.shouldShow('Area')) ...[
                                Text(S.of(context).Area,
                                    style: TextStyles.font16BlackRegular),
                                CustomDropDownList(
                                  hint: S.of(context).selectArea,
                                  controller: cubit.areaController,
                                  items: cubit.areaItem
                                      .map((e) => e.name ?? 'Unknown')
                                      .toList(),
                                  onChanged: (value) {
                                    final selectedArea = cubit
                                        .areaListModel?.data?.data
                                        ?.firstWhere((area) =>
                                            area.name ==
                                            cubit.areaController.text)
                                        .id
                                        ?.toString();

                                    if (selectedArea != null) {
                                      cubit.areaIdController.text =
                                          selectedArea;
                                    }
                                    cubit.getCity();
                                  },
                                  suffixIcon: IconBroken.arrowDown2,
                                  keyboardType: TextInputType.text,
                                ),
                                verticalSpace(10),
                              ],
                              if (cubit.shouldShow('City')) ...[
                                Text(S.of(context).City,
                                    style: TextStyles.font16BlackRegular),
                                CustomDropDownList(
                                  hint: S.of(context).selectCity,
                                  controller: cubit.cityController,
                                  items: cubit.cityItem
                                      .map((e) => e.name ?? 'Unknown')
                                      .toList(),
                                  onChanged: (value) {
                                    final selectedCity = cubit
                                        .cityModel?.data?.data
                                        ?.firstWhere((city) =>
                                            city.name ==
                                            cubit.cityController.text)
                                        .id
                                        ?.toString();

                                    if (selectedCity != null) {
                                      cubit.cityIdController.text =
                                          selectedCity;
                                    }
                                    cubit.getOrganization();
                                  },
                                  suffixIcon: IconBroken.arrowDown2,
                                  keyboardType: TextInputType.text,
                                ),
                                verticalSpace(10),
                              ],
                              if (cubit.shouldShow('Organization')) ...[
                                Text(
                                  S.of(context).Organization,
                                  style: TextStyles.font16BlackRegular,
                                ),
                                BlocBuilder<AssignCubit, AssignStates>(
                                  buildWhen: (previous, current) =>
                                      current is GetOrganizationSuccessState ||
                                      current is AllOrganizationSuccessState,
                                  builder: (context, state) {
                                    return CustomDropDownList(
                                      hint: S.of(context).selectOrganization,
                                      controller: cubit.organizationController,
                                      items: cubit.organizationItem
                                          .map((e) => e.name ?? 'Unknown')
                                          .toList(),
                                      onChanged: (value) {
                                        final selectedOrganization = cubit
                                            .organizationModel?.data?.data
                                            ?.firstWhere((org) =>
                                                org.name ==
                                                cubit.organizationController
                                                    .text)
                                            .id
                                            ?.toString();

                                        if (selectedOrganization != null) {
                                          cubit.organizationIdController.text =
                                              selectedOrganization;
                                        }
                                        cubit.getBuilding();
                                      },
                                      suffixIcon: IconBroken.arrowDown2,
                                      keyboardType: TextInputType.text,
                                    );
                                  },
                                ),
                                verticalSpace(10),
                              ],
                              if (cubit.shouldShow('Building')) ...[
                                Text(S.of(context).Building,
                                    style: TextStyles.font16BlackRegular),
                                CustomDropDownList(
                                  hint: S.of(context).selectBuilding,
                                  controller: cubit.buildingController,
                                  items: cubit.buildingItem
                                      .map((e) => e.name ?? 'Unknown')
                                      .toList(),
                                  onChanged: (value) {
                                    final selectedBuilding = cubit
                                        .buildingModel?.data?.data
                                        ?.firstWhere((bld) =>
                                            bld.name ==
                                            cubit.buildingController.text)
                                        .id
                                        ?.toString();

                                    if (selectedBuilding != null) {
                                      cubit.buildingIdController.text =
                                          selectedBuilding;
                                    }
                                    cubit.getFloor();
                                  },
                                  suffixIcon: IconBroken.arrowDown2,
                                  keyboardType: TextInputType.text,
                                ),
                                verticalSpace(10),
                              ],
                              if (cubit.shouldShow('Floor')) ...[
                                Text(S.of(context).Floor,
                                    style: TextStyles.font16BlackRegular),
                                CustomDropDownList(
                                  hint: S.of(context).selectFloor,
                                  controller: cubit.floorController,
                                  items: cubit.floorItem
                                      .map((e) => e.name ?? 'Unknown')
                                      .toList(),
                                  onChanged: (value) {
                                    final selectedFloor = cubit
                                        .floorModel?.data?.data
                                        ?.firstWhere((floor) =>
                                            floor.name ==
                                            cubit.floorController.text)
                                        .id
                                        ?.toString();

                                    if (selectedFloor != null) {
                                      cubit.floorIdController.text =
                                          selectedFloor;
                                    }
                                    cubit.getSection();
                                  },
                                  suffixIcon: IconBroken.arrowDown2,
                                  keyboardType: TextInputType.text,
                                ),
                                verticalSpace(10),
                              ],
                              if (cubit.shouldShow('Section')) ...[
                                Text(S.of(context).Section,
                                    style: TextStyles.font16BlackRegular),
                                CustomDropDownList(
                                  hint: S.of(context).selectSection,
                                  controller: cubit.sectionController,
                                  items: cubit.sectionItem
                                      .map((e) => e.name ?? 'Unknown')
                                      .toList(),
                                  onChanged: (value) {
                                    final selectedSection = cubit
                                        .sectionModel?.data?.data
                                        ?.firstWhere((section) =>
                                            section.name ==
                                            cubit.sectionController.text)
                                        .id
                                        ?.toString();

                                    if (selectedSection != null) {
                                      cubit.sectionIdController.text =
                                          selectedSection;
                                    }
                                    cubit.getPoint();
                                  },
                                  suffixIcon: IconBroken.arrowDown2,
                                  keyboardType: TextInputType.text,
                                ),
                                verticalSpace(10),
                              ],
                              if (cubit.shouldShow('Point')) ...[
                                Text(S.of(context).Point,
                                    style: TextStyles.font16BlackRegular),
                                CustomDropDownList(
                                  hint: S.of(context).select_point,
                                  controller: cubit.pointController,
                                  items: cubit.pointItem
                                      .map((e) => e.name ?? 'Unknown')
                                      .toList(),
                                  onChanged: (value) {
                                    final selectedPoint = cubit
                                        .pointModel?.data?.data
                                        ?.firstWhere((point) =>
                                            point.name ==
                                            cubit.pointController.text)
                                        .id
                                        ?.toString();

                                    if (selectedPoint != null) {
                                      cubit.pointIdController.text =
                                          selectedPoint;
                                    }
                                  },
                                  suffixIcon: IconBroken.arrowDown2,
                                  keyboardType: TextInputType.text,
                                ),
                                verticalSpace(10),
                              ],
                            ],
                          ],
                        ),
                      ),
                      verticalSpace(20),
                      state is AssignLoadingState
                          ? Loading()
                          : Center(
                              child: DefaultElevatedButton(
                                  name: S.of(context).assignButton,
                                  onPressed: () {
                                    if ((cubit.selecteIndex == 0 &&
                                            cubit.selecteSecendIndex == 0) ||
                                        (cubit.selecteIndex == 1 &&
                                            cubit.selecteSecendIndex == 0)) {
                                      cubit.assignUserShift();
                                    }
                                    if ((cubit.selecteIndex == 0 &&
                                            cubit.selecteSecendIndex == 1) ||
                                        (cubit.selecteIndex == 2 &&
                                            cubit.selecteSecendIndex == 0)) {
                                      cubit.selectedLocation == 0
                                          ? cubit.assignArea()
                                          : cubit.selectedLocation == 1
                                              ? cubit.assignCity()
                                              : cubit.selectedLocation == 2
                                                  ? cubit.assignOrganization()
                                                  : cubit.selectedLocation == 3
                                                      ? cubit.assignBuilding()
                                                      : cubit.selectedLocation ==
                                                              4
                                                          ? cubit.assignFloor()
                                                          : cubit.selectedLocation ==
                                                                  5
                                                              ? cubit
                                                                  .assignSection()
                                                              : cubit
                                                                  .assignPoint();
                                    }
                                    if ((cubit.selecteIndex == 1 &&
                                            cubit.selecteSecendIndex == 1) ||
                                        (cubit.selecteIndex == 2 &&
                                            cubit.selecteSecendIndex == 1)) {
                                      cubit.selectedLocation == 2
                                          ? cubit.assignOrganizationShift()
                                          : cubit.selectedLocation == 3
                                              ? cubit.assignBuildingShift()
                                              : cubit.selectedLocation == 4
                                                  ? cubit.assignFloorShift()
                                                  : cubit.selectedLocation == 5
                                                      ? cubit
                                                          .assignSectionShift()
                                                      : null;
                                    }
                                  },
                                  color: AppColor.primaryColor,
                                  textStyles: TextStyles.font16WhiteSemiBold),
                            ),
                      verticalSpace(20),
                    ],
                  ),
                ),
              )
            ],
          );
        }));
  }
}
