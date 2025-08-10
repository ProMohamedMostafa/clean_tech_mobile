import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/custom_multi_dropdown/custom_multi_dropdown.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/assign/logic/assign_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/assign/logic/assign_state.dart';
import 'package:smart_cleaning_application/core/widgets/custom_drop_down_list/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/users_model.dart';

import 'package:smart_cleaning_application/generated/l10n.dart';

class AssignBody extends StatelessWidget {
  final int index;
  const AssignBody({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AssignCubit>();
    cubit.index = index;

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
          if (index == 0) {
            if (cubit.shiftModel == null || cubit.roleModel == null) {
              return Loading();
            }
          }
          if (index == 1) {
            if (cubit.organizationModel == null || cubit.shiftModel == null) {
              return Loading();
            }
          }
          if (index == 2) {
            if (cubit.areaListModel == null || cubit.usersModel == null) {
              return Loading();
            }
          }

          return CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // work location
                              if (index == 1 || index == 2) ...[
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
                                      cubit.clearAllControllers();
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
                                              cubit.areaController.text);

                                      if (selectedArea != null) {
                                        cubit.areaIdController.text =
                                            selectedArea.id!.toString();
                                        if (cubit.selectedLevel == 'Area') {
                                          cubit.getAreaUsersDetails(
                                              selectedArea.id!);
                                          cubit.selectedLocation = 0;
                                        }
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
                                        .map((e) => e.name!)
                                        .toList(),
                                    onChanged: (value) {
                                      final selectedCity = cubit
                                          .cityModel?.data?.data
                                          ?.firstWhere((city) =>
                                              city.name ==
                                              cubit.cityController.text);

                                      if (selectedCity != null) {
                                        cubit.cityIdController.text =
                                            selectedCity.id!.toString();
                                        if (cubit.selectedLevel == 'City') {
                                          cubit.getCityUsersDetails(
                                              selectedCity.id!);
                                          cubit.selectedLocation = 1;
                                        }
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
                                        current
                                            is GetOrganizationSuccessState ||
                                        current is AllOrganizationSuccessState,
                                    builder: (context, state) {
                                      return CustomDropDownList(
                                        hint: S.of(context).selectOrganization,
                                        controller:
                                            cubit.organizationController,
                                        items: cubit.organizationItem
                                            .map((e) => e.name ?? 'Unknown')
                                            .toList(),
                                        onChanged: (value) {
                                          final selectedOrganization = cubit
                                              .organizationModel?.data?.data
                                              ?.firstWhere((org) =>
                                                  org.name ==
                                                  cubit.organizationController
                                                      .text);

                                          if (selectedOrganization != null) {
                                            cubit.organizationIdController
                                                    .text =
                                                selectedOrganization.id!
                                                    .toString();

                                            if (cubit.selectedLevel ==
                                                'Organization') {
                                              cubit
                                                  .getOrganizationManagersDetails(
                                                      selectedOrganization.id!);
                                              cubit.selectedLocation = 2;
                                            }
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
                                              cubit.buildingController.text);

                                      if (selectedBuilding != null) {
                                        cubit.buildingIdController.text =
                                            selectedBuilding.id!.toString();
                                        if (cubit.selectedLevel == 'Building') {
                                          cubit.getBuildingManagersDetails(
                                              selectedBuilding.id!);
                                          cubit.selectedLocation = 3;
                                        }
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
                                              cubit.floorController.text);

                                      if (selectedFloor != null) {
                                        cubit.floorIdController.text =
                                            selectedFloor.id!.toString();
                                        if (cubit.selectedLevel == 'Floor') {
                                          cubit.getFloorManagersDetails(
                                              selectedFloor.id!);
                                          cubit.selectedLocation = 4;
                                        }
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
                                              cubit.sectionController.text);

                                      if (selectedSection != null) {
                                        cubit.sectionIdController.text =
                                            selectedSection.id!.toString();
                                        if (cubit.selectedLevel == 'Section') {
                                          cubit.getSectionManagersDetails(
                                              selectedSection.id!);
                                          cubit.selectedLocation = 5;
                                        }
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
                                              cubit.pointController.text);

                                      if (selectedPoint != null) {
                                        cubit.pointIdController.text =
                                            selectedPoint.id!.toString();
                                        if (cubit.selectedLevel == 'Point') {
                                          cubit.getPointUsersDetails(
                                              selectedPoint.id!);
                                          cubit.selectedLocation = 6;
                                        }
                                      }
                                    },
                                    suffixIcon: IconBroken.arrowDown2,
                                    keyboardType: TextInputType.text,
                                  ),
                                  verticalSpace(10),
                                ],
                              ],

                              // role + multi users
                              if (index == 2) ...[
                                Text(
                                  S.of(context).managers,
                                  style: TextStyles.font16BlackRegular,
                                ),
                                CustomMultiDropdown(
                                  items: cubit.usersModel!.data!.users!
                                          .where(
                                              (user) => user.role == 'Manager')
                                          .isEmpty
                                      ? [
                                          DropdownItem(
                                            label: S.of(context).noManagers,
                                            value: UserItem(
                                                id: null,
                                                userName:
                                                    S.of(context).noManagers),
                                          )
                                        ]
                                      : cubit.usersModel!.data!.users!
                                          .where(
                                              (user) => user.role == 'Manager')
                                          .map((manager) => DropdownItem(
                                                label: manager.userName!,
                                                value: manager,
                                              ))
                                          .toList(),
                                  controller: cubit.allManagersController,
                                  onSelectionChange: (selectedItems) {
                                    cubit.selectedManagersIds = selectedItems
                                        .map((item) => (item).id!)
                                        .toList();
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
                                          .where((user) =>
                                              user.role == 'Supervisor')
                                          .isEmpty
                                      ? [
                                          DropdownItem(
                                            label: S.of(context).noSupervisors,
                                            value: UserItem(
                                                id: null,
                                                userName: S
                                                    .of(context)
                                                    .noSupervisors),
                                          )
                                        ]
                                      : cubit.usersModel!.data!.users!
                                          .where((user) =>
                                              user.role == 'Supervisor')
                                          .map((supervisor) => DropdownItem(
                                                label: supervisor.userName!,
                                                value: supervisor,
                                              ))
                                          .toList(),
                                  controller: cubit.allSupervisorsController,
                                  onSelectionChange: (selectedItems) {
                                    cubit.selectedSupervisorsIds = selectedItems
                                        .map((item) => (item).id!)
                                        .toList();
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
                                          .where(
                                              (user) => user.role == 'Cleaner')
                                          .isEmpty
                                      ? [
                                          DropdownItem(
                                            label: S.of(context).noCleaners,
                                            value: UserItem(
                                                id: null,
                                                userName:
                                                    S.of(context).noCleaners),
                                          )
                                        ]
                                      : cubit.usersModel!.data!.users!
                                          .where(
                                              (user) => user.role == 'Cleaner')
                                          .map((cleaner) => DropdownItem(
                                                label: cleaner.userName!,
                                                value: cleaner,
                                              ))
                                          .toList(),
                                  controller: cubit.allCleanersController,
                                  onSelectionChange: (selectedItems) {
                                    cubit.selectedCleanersIds = selectedItems
                                        .map((item) => (item).id!)
                                        .toList();
                                  },
                                  hint: S.of(context).selectCleaners,
                                ),
                              ],

                              // role + single users
                              if (index == 0) ...[
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
                                      if (selectedRole != null) {
                                        cubit.userController.clear();
                                        cubit.userIdController.clear();
                                        cubit.allShiftsController.clearAll();

                                        cubit.getUsers(
                                            roleId: selectedRole.id!);
                                      }
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
                                      final selectedUser = cubit
                                          .userShiftModel?.data
                                          ?.firstWhere((user) =>
                                              user.userName == selectedValue);

                                      if (selectedUser != null &&
                                          selectedUser.id != null) {
                                        cubit.userIdController.text =
                                            selectedUser.id!.toString();

                                        cubit.initializeControllers(
                                            selectedUser.id!);
                                      }
                                    },
                                    controller: cubit.userController,
                                    keyboardType: TextInputType.text,
                                    suffixIcon: IconBroken.arrowDown2,
                                    hint: (cubit.roleIdController.text == '1' ||
                                            cubit.roleIdController.text ==
                                                '2' ||
                                            cubit.roleIdController.text == '5')
                                        ? S.of(context).roleAdmin
                                        : (cubit.roleIdController.text == '3')
                                            ? S.of(context).roleManager
                                            : (cubit.roleIdController.text ==
                                                    '4')
                                                ? S.of(context).roleSupervisor
                                                : S.of(context).roleUsers,
                                    items: cubit.userShiftModel?.data!
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
                                              S
                                                  .of(context)
                                                  .noSupervisorsAvailable
                                            else
                                              S.of(context).noUsersAvailable
                                          ]
                                        : cubit.userShiftModel?.data!
                                                .map((e) =>
                                                    e.userName ??
                                                    S.of(context).roleUsers)
                                                .toList() ??
                                            [],
                                  ),
                                  verticalSpace(10),
                                ]
                              ],

                              //  multi shifts
                              if (index == 0 || index == 1) ...[
                                Text(
                                  S.of(context).shiftBody,
                                  style: TextStyles.font16BlackRegular,
                                ),
                                CustomMultiDropdown(
                                  items: cubit.shiftModel?.data?.data
                                              ?.isEmpty ??
                                          true
                                      ? [
                                          DropdownItem(
                                            label:
                                                S.of(context).noShiftsAvailable,
                                            value: ShiftItem(
                                                id: null,
                                                name: S
                                                    .of(context)
                                                    .noShiftsAvailable),
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
                                    cubit.selectedShiftsIds = selectedItems
                                        .map((item) => (item).id!)
                                        .toList();
                                  },
                                  hint: S.of(context).selectShift,
                                ),
                                verticalSpace(10),
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
                                      if (index == 0) {
                                        cubit.assignUserShift();
                                      } else if (index == 1) {
                                        switch (cubit.selectedLocation) {
                                          case 2:
                                            cubit.assignOrganizationShift();
                                            break;
                                          case 3:
                                            cubit.assignBuildingShift();
                                            break;
                                          case 4:
                                            cubit.assignFloorShift();
                                            break;
                                          default:
                                            cubit.assignSectionShift();
                                            break;
                                        }
                                      } else if (index == 2) {
                                        switch (cubit.selectedLocation) {
                                          case 0:
                                            cubit.assignArea();
                                            break;
                                          case 1:
                                            cubit.assignCity();
                                            break;
                                          case 2:
                                            cubit.assignOrganization();
                                            break;
                                          case 3:
                                            cubit.assignBuilding();
                                            break;
                                          case 4:
                                            cubit.assignFloor();
                                            break;
                                          case 5:
                                            cubit.assignSection();
                                            break;
                                          default:
                                            cubit.assignPoint();
                                            break;
                                        }
                                      }
                                    },
                                    color: AppColor.primaryColor,
                                    textStyles: TextStyles.font16WhiteSemiBold),
                              ),
                        verticalSpace(20),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }));
  }
}
