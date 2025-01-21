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
import 'package:smart_cleaning_application/features/screens/assign/data/role_user_model.dart';
import 'package:smart_cleaning_application/features/screens/assign/logic/assign_cubit.dart';
import 'package:smart_cleaning_application/features/screens/assign/logic/assign_state.dart';
import 'package:smart_cleaning_application/features/screens/assign/ui/widget/assign_custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AssignBody extends StatefulWidget {
  const AssignBody({super.key});

  @override
  State<AssignBody> createState() => _AssignBodyState();
}

class _AssignBodyState extends State<AssignBody> {
  int? selectedIndex;
  int? selectedLocation;
  int? selectedlocationId;
  int? selectedRoleUserId;
  List<int> selectedUsersIds = [];
  List<int> selectedShiftsIds = [];

  @override
  void initState() {
    context.read<AssignCubit>().getShifts();
    context.read<AssignCubit>().getRole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text('Assign Management', style: TextStyles.font16BlackSemiBold),
        centerTitle: true,
      ),
      body: BlocConsumer<AssignCubit, AssignStates>(
        listener: (context, state) {
          if (state is AssignSuccessState) {
            toast(text: state.assignModel.message!, color: Colors.blue);
            // context.pushNamedAndRemoveLastTwo(Routes.taskManagementScreen);
          }
          if (state is AssignErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double containerWidth =
                              (constraints.maxWidth - 21) / 3;

                          return ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            separatorBuilder: (context, index) {
                              return horizontalSpace(10);
                            },
                            itemBuilder: (context, index) {
                              bool isSelected = selectedIndex == index;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (selectedIndex != index) {
                                      selectedIndex = index;

                                      // Clear the controllers and reset variables when the index changes
                                      context
                                          .read<AssignCubit>()
                                          .locationController
                                          .clear();
                                      context
                                          .read<AssignCubit>()
                                          .roleController
                                          .clear();
                                      context
                                          .read<AssignCubit>()
                                          .shiftController
                                          .clearAll();
                                      context
                                          .read<AssignCubit>()
                                          .userController
                                          .clearAll();

                                      selectedLocation = null;
                                      selectedlocationId = null;
                                      selectedRoleUserId = null;
                                      selectedUsersIds.clear();
                                      selectedShiftsIds.clear();
                                    }
                                  });
                                },
                                child: Container(
                                  width: containerWidth,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColor.primaryColor
                                        : Colors.white,
                                    border: Border.all(
                                        color: AppColor.secondaryColor),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 2,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      index == 0
                                          ? 'User\n&\nLocation'
                                          : index == 1
                                              ? 'User\n&\nShift'
                                              : 'Location\n&\nShift',
                                      textAlign: TextAlign.center,
                                      style: TextStyles.font16BlackSemiBold
                                          .copyWith(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    verticalSpace(10),
                    if (selectedIndex == 0)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Location',
                            style: TextStyles.font16BlackRegular,
                          ),
                          AssignCustomDropDownList(
                            onChanged: (selectedValue) {
                              final items = [
                                'Area',
                                'City',
                                'Organization',
                                'Building',
                                'Floor',
                                'Point'
                              ];

                              selectedLocation = items.indexOf(selectedValue!);
                              context.read<AssignCubit>().getArea();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Location is Required";
                              }
                              return null;
                            },
                            hint: 'Select location',
                            items: [
                              'Area',
                              'City',
                              'Organization',
                              'Building',
                              'Floor',
                              'Point'
                            ],
                            suffixIcon: IconBroken.arrowDown2,
                            keyboardType: TextInputType.text,
                            controller:
                                context.read<AssignCubit>().locationController,
                          ),
                          verticalSpace(10),
                          if (selectedLocation == 0) ...[
                            Text(
                              'Area',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedArea = context
                                      .read<AssignCubit>()
                                      .areaModel
                                      ?.data
                                      ?.firstWhere(
                                          (area) => area.name == selectedValue);

                                  selectedlocationId = selectedArea!.id;
                                },
                                hint: 'Select Area',
                                items: context
                                            .read<AssignCubit>()
                                            .areaModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No area available']
                                    : context
                                            .read<AssignCubit>()
                                            .areaModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().areaController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                          ],
                          if (selectedLocation == 1) ...[
                            Text(
                              'Area',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedArea = context
                                      .read<AssignCubit>()
                                      .areaModel
                                      ?.data
                                      ?.firstWhere(
                                          (area) => area.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getCity(selectedArea!.id!);
                                },
                                hint: 'Select Area',
                                items: context
                                            .read<AssignCubit>()
                                            .areaModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No area available']
                                    : context
                                            .read<AssignCubit>()
                                            .areaModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().areaController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'City',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedCity = context
                                      .read<AssignCubit>()
                                      .cityModel
                                      ?.data
                                      ?.firstWhere(
                                          (city) => city.name == selectedValue);

                                  selectedlocationId = selectedCity!.id;
                                },
                                hint: 'Select City',
                                items: context
                                            .read<AssignCubit>()
                                            .cityModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No city available']
                                    : context
                                            .read<AssignCubit>()
                                            .cityModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().cityController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                          ],
                          if (selectedLocation == 2) ...[
                            Text(
                              'Area',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedArea = context
                                      .read<AssignCubit>()
                                      .areaModel
                                      ?.data
                                      ?.firstWhere(
                                          (area) => area.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getCity(selectedArea!.id!);
                                },
                                hint: 'Select Area',
                                items: context
                                            .read<AssignCubit>()
                                            .areaModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No area available']
                                    : context
                                            .read<AssignCubit>()
                                            .areaModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().areaController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'City',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedCity = context
                                      .read<AssignCubit>()
                                      .cityModel
                                      ?.data
                                      ?.firstWhere(
                                          (city) => city.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getOrganization(selectedCity!.id!);
                                },
                                hint: 'Select City',
                                items: context
                                            .read<AssignCubit>()
                                            .cityModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No city available']
                                    : context
                                            .read<AssignCubit>()
                                            .cityModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().cityController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'Organization',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedOrganization = context
                                      .read<AssignCubit>()
                                      .organizationModel
                                      ?.data
                                      ?.firstWhere((organization) =>
                                          organization.name == selectedValue);

                                  selectedlocationId = selectedOrganization!.id;
                                },
                                hint: 'Select Organization',
                                items: context
                                            .read<AssignCubit>()
                                            .organizationModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No organization available']
                                    : context
                                            .read<AssignCubit>()
                                            .organizationModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller: context
                                    .read<AssignCubit>()
                                    .organizationController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                          ],
                          if (selectedLocation == 3) ...[
                            Text(
                              'Area',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedArea = context
                                      .read<AssignCubit>()
                                      .areaModel
                                      ?.data
                                      ?.firstWhere(
                                          (area) => area.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getCity(selectedArea!.id!);
                                },
                                hint: 'Select Area',
                                items: context
                                            .read<AssignCubit>()
                                            .areaModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No area available']
                                    : context
                                            .read<AssignCubit>()
                                            .areaModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().areaController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'City',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedCity = context
                                      .read<AssignCubit>()
                                      .cityModel
                                      ?.data
                                      ?.firstWhere(
                                          (city) => city.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getOrganization(selectedCity!.id!);
                                },
                                hint: 'Select City',
                                items: context
                                            .read<AssignCubit>()
                                            .cityModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No city available']
                                    : context
                                            .read<AssignCubit>()
                                            .cityModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().cityController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'Organization',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedOrganization = context
                                      .read<AssignCubit>()
                                      .organizationModel
                                      ?.data
                                      ?.firstWhere((organization) =>
                                          organization.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getBuilding(selectedOrganization!.id!);
                                },
                                hint: 'Select Organization',
                                items: context
                                            .read<AssignCubit>()
                                            .organizationModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No organization available']
                                    : context
                                            .read<AssignCubit>()
                                            .organizationModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller: context
                                    .read<AssignCubit>()
                                    .organizationController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'Building',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedBuilding = context
                                      .read<AssignCubit>()
                                      .buildingModel
                                      ?.data
                                      ?.firstWhere((building) =>
                                          building.name == selectedValue);

                                  selectedlocationId = selectedBuilding!.id;
                                },
                                hint: 'Select Building',
                                items: context
                                            .read<AssignCubit>()
                                            .buildingModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No building available']
                                    : context
                                            .read<AssignCubit>()
                                            .buildingModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller: context
                                    .read<AssignCubit>()
                                    .buildingController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                          ],
                          if (selectedLocation == 4) ...[
                            Text(
                              'Area',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedArea = context
                                      .read<AssignCubit>()
                                      .areaModel
                                      ?.data
                                      ?.firstWhere(
                                          (area) => area.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getCity(selectedArea!.id!);
                                },
                                hint: 'Select Area',
                                items: context
                                            .read<AssignCubit>()
                                            .areaModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No area available']
                                    : context
                                            .read<AssignCubit>()
                                            .areaModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().areaController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'City',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedCity = context
                                      .read<AssignCubit>()
                                      .cityModel
                                      ?.data
                                      ?.firstWhere(
                                          (city) => city.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getOrganization(selectedCity!.id!);
                                },
                                hint: 'Select City',
                                items: context
                                            .read<AssignCubit>()
                                            .cityModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No city available']
                                    : context
                                            .read<AssignCubit>()
                                            .cityModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().cityController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'Organization',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedOrganization = context
                                      .read<AssignCubit>()
                                      .organizationModel
                                      ?.data
                                      ?.firstWhere((organization) =>
                                          organization.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getBuilding(selectedOrganization!.id!);
                                },
                                hint: 'Select Organization',
                                items: context
                                            .read<AssignCubit>()
                                            .organizationModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No organization available']
                                    : context
                                            .read<AssignCubit>()
                                            .organizationModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller: context
                                    .read<AssignCubit>()
                                    .organizationController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'Building',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedBuilding = context
                                      .read<AssignCubit>()
                                      .buildingModel
                                      ?.data
                                      ?.firstWhere((building) =>
                                          building.name == selectedValue);
                                  context
                                      .read<AssignCubit>()
                                      .getFloor(selectedBuilding!.id!);
                                },
                                hint: 'Select Building',
                                items: context
                                            .read<AssignCubit>()
                                            .buildingModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No building available']
                                    : context
                                            .read<AssignCubit>()
                                            .buildingModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller: context
                                    .read<AssignCubit>()
                                    .buildingController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'Floor',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedFloor = context
                                      .read<AssignCubit>()
                                      .floorModel
                                      ?.data
                                      ?.firstWhere((floor) =>
                                          floor.name == selectedValue);

                                  selectedlocationId = selectedFloor!.id;
                                },
                                hint: 'Select Floor',
                                items: context
                                            .read<AssignCubit>()
                                            .floorModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No floor available']
                                    : context
                                            .read<AssignCubit>()
                                            .floorModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().floorController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                          ],
                          if (selectedLocation == 5) ...[
                            Text(
                              'Area',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedArea = context
                                      .read<AssignCubit>()
                                      .areaModel
                                      ?.data
                                      ?.firstWhere(
                                          (area) => area.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getCity(selectedArea!.id!);
                                },
                                hint: 'Select Area',
                                items: context
                                            .read<AssignCubit>()
                                            .areaModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No area available']
                                    : context
                                            .read<AssignCubit>()
                                            .areaModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().areaController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'City',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedCity = context
                                      .read<AssignCubit>()
                                      .cityModel
                                      ?.data
                                      ?.firstWhere(
                                          (city) => city.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getOrganization(selectedCity!.id!);
                                },
                                hint: 'Select City',
                                items: context
                                            .read<AssignCubit>()
                                            .cityModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No city available']
                                    : context
                                            .read<AssignCubit>()
                                            .cityModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().cityController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'Organization',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedOrganization = context
                                      .read<AssignCubit>()
                                      .organizationModel
                                      ?.data
                                      ?.firstWhere((organization) =>
                                          organization.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getBuilding(selectedOrganization!.id!);
                                },
                                hint: 'Select Organization',
                                items: context
                                            .read<AssignCubit>()
                                            .organizationModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No organization available']
                                    : context
                                            .read<AssignCubit>()
                                            .organizationModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller: context
                                    .read<AssignCubit>()
                                    .organizationController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'Building',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedBuilding = context
                                      .read<AssignCubit>()
                                      .buildingModel
                                      ?.data
                                      ?.firstWhere((building) =>
                                          building.name == selectedValue);
                                  context
                                      .read<AssignCubit>()
                                      .getFloor(selectedBuilding!.id!);
                                },
                                hint: 'Select Building',
                                items: context
                                            .read<AssignCubit>()
                                            .buildingModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No building available']
                                    : context
                                            .read<AssignCubit>()
                                            .buildingModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller: context
                                    .read<AssignCubit>()
                                    .buildingController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'Floor',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedFloor = context
                                      .read<AssignCubit>()
                                      .floorModel
                                      ?.data
                                      ?.firstWhere((floor) =>
                                          floor.name == selectedValue);
                                  context
                                      .read<AssignCubit>()
                                      .getPoints(selectedFloor!.id!);
                                },
                                hint: 'Select Floor',
                                items: context
                                            .read<AssignCubit>()
                                            .floorModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No floor available']
                                    : context
                                            .read<AssignCubit>()
                                            .floorModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().floorController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'Point',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedPoint = context
                                      .read<AssignCubit>()
                                      .pointsModel
                                      ?.data
                                      ?.firstWhere((point) =>
                                          point.name == selectedValue);

                                  selectedlocationId = selectedPoint!.id;
                                },
                                hint: 'Select Point',
                                items: context
                                            .read<AssignCubit>()
                                            .pointsModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No point available']
                                    : context
                                            .read<AssignCubit>()
                                            .pointsModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().pointController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                          ],
                          Divider(),
                          verticalSpace(10),
                          Text(
                            S.of(context).addUserText13,
                            style: TextStyles.font16BlackRegular,
                          ),
                          AssignCustomDropDownList(
                              isRead: true,
                              onChanged: (selectedValue) {
                                final selectedRole = context
                                    .read<AssignCubit>()
                                    .roleModel
                                    ?.data
                                    ?.firstWhere(
                                        (role) => role.name == selectedValue);
                                context
                                    .read<AssignCubit>()
                                    .userController
                                    .clearAll();

                                context
                                    .read<AssignCubit>()
                                    .getRoleUser(selectedRole!.id!);
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Role is Required";
                                }
                                return null;
                              },
                              hint: 'Select Role',
                              items: context
                                          .read<AssignCubit>()
                                          .roleModel
                                          ?.data
                                          ?.isEmpty ??
                                      true
                                  ? ['No roles available']
                                  : context
                                          .read<AssignCubit>()
                                          .roleModel
                                          ?.data
                                          ?.map((e) => e.name ?? 'Unknown')
                                          .toList() ??
                                      [],
                              controller:
                                  context.read<AssignCubit>().roleController,
                              suffixIcon: IconBroken.arrowDown2,
                              keyboardType: TextInputType.text),
                          verticalSpace(10),
                          context
                                  .read<AssignCubit>()
                                  .roleController
                                  .text
                                  .isEmpty
                              ? SizedBox.shrink()
                              : Text(
                                  context
                                          .read<AssignCubit>()
                                          .roleController
                                          .text
                                          .isEmpty
                                      ? 'User'
                                      : context
                                          .read<AssignCubit>()
                                          .roleController
                                          .text,
                                  style: TextStyles.font16BlackRegular,
                                ),
                          (context.read<AssignCubit>().roleUserModel?.data ==
                                  null)
                              ? SizedBox.shrink()
                              : MultiDropdown<DataRoleUser>(
                                  items: context
                                              .read<AssignCubit>()
                                              .roleUserModel!
                                              .data
                                              ?.isEmpty ??
                                          true
                                      ? [
                                          DropdownItem(
                                            label: 'No users available',
                                            value: DataRoleUser(
                                                id: null,
                                                userName: 'No users available'),
                                          )
                                        ]
                                      : context
                                          .read<AssignCubit>()
                                          .roleUserModel!
                                          .data!
                                          .map((role) => DropdownItem(
                                                label: role.userName!,
                                                value: role,
                                              ))
                                          .toList(),
                                  controller: context
                                      .read<AssignCubit>()
                                      .userController,
                                  enabled: true,
                                  chipDecoration: ChipDecoration(
                                    backgroundColor: Colors.grey[300],
                                    wrap: true,
                                    runSpacing: 5,
                                    spacing: 5,
                                  ),
                                  fieldDecoration: FieldDecoration(
                                    hintText:
                                        'Select ${context.read<AssignCubit>().roleController.text.isEmpty ? 'User' : context.read<AssignCubit>().roleController.text}',
                                    hintStyle: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColor.thirdColor),
                                    showClearIcon: false,
                                    suffixIcon: Icon(IconBroken.arrowDown2),
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
                                  dropdownDecoration:
                                      const DropdownDecoration(maxHeight: 200),
                                  dropdownItemDecoration:
                                      DropdownItemDecoration(
                                    selectedIcon: const Icon(Icons.check_box,
                                        color: Colors.blue),
                                  ),
                                  onSelectionChange: (selectedItems) {
                                    selectedUsersIds = selectedItems
                                        .map((item) => (item).id!)
                                        .toList();
                                  },
                                ),
                          verticalSpace(20),
                          state is AssignLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(
                                      color: AppColor.primaryColor),
                                )
                              : Center(
                                  child: DefaultElevatedButton(
                                      name: "Assign",
                                      onPressed: () {
                                        selectedLocation == 0
                                            ? context
                                                .read<AssignCubit>()
                                                .assignArea(selectedlocationId,
                                                    selectedUsersIds)
                                            : selectedLocation == 1
                                                ? context
                                                    .read<AssignCubit>()
                                                    .assignCity(
                                                        selectedlocationId,
                                                        selectedUsersIds)
                                                : selectedLocation == 2
                                                    ? context
                                                        .read<AssignCubit>()
                                                        .assignOrganization(
                                                            selectedlocationId,
                                                            selectedUsersIds)
                                                    : selectedLocation == 3
                                                        ? context
                                                            .read<AssignCubit>()
                                                            .assignBuilding(
                                                                selectedlocationId,
                                                                selectedUsersIds)
                                                        : selectedLocation == 4
                                                            ? context.read<AssignCubit>().assignFloor(
                                                                selectedlocationId,
                                                                selectedUsersIds)
                                                            : context.read<AssignCubit>().assignPoint(
                                                                selectedlocationId,
                                                                selectedUsersIds);
                                      },
                                      color: AppColor.primaryColor,
                                      height: 47,
                                      width: double.infinity,
                                      textStyles:
                                          TextStyles.font20Whitesemimedium),
                                ),
                        ],
                      ),
                    if (selectedIndex == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          context.read<AssignCubit>().shiftModel?.data == null
                              ? SizedBox.shrink()
                              : Text(
                                  'Shift',
                                  style: TextStyles.font16BlackRegular,
                                ),
                          context.read<AssignCubit>().shiftModel?.data == null
                              ? SizedBox.shrink()
                              : MultiDropdown<ShiftDetails>(
                                  items: context
                                              .read<AssignCubit>()
                                              .shiftModel
                                              ?.data
                                              ?.data
                                              ?.isEmpty ??
                                          true
                                      ? [
                                          DropdownItem(
                                            label: 'No users available',
                                            value: ShiftDetails(
                                                id: null,
                                                name: 'No users available'),
                                          )
                                        ]
                                      : context
                                          .read<AssignCubit>()
                                          .shiftModel!
                                          .data!
                                          .data!
                                          .map((role) => DropdownItem(
                                                label: role.name!,
                                                value: role,
                                              ))
                                          .toList(),
                                  controller: context
                                      .read<AssignCubit>()
                                      .shiftController,
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
                                  dropdownDecoration:
                                      const DropdownDecoration(maxHeight: 200),
                                  dropdownItemDecoration:
                                      DropdownItemDecoration(
                                    selectedIcon: const Icon(Icons.check_box,
                                        color: Colors.blue),
                                  ),
                                  onSelectionChange: (selectedItems) {
                                    selectedShiftsIds = selectedItems
                                        .map((item) => (item).id!)
                                        .toList();
                                  },
                                ),
                          verticalSpace(10),
                          Divider(),
                          verticalSpace(10),
                          Text(
                            S.of(context).addUserText13,
                            style: TextStyles.font16BlackRegular,
                          ),
                          AssignCustomDropDownList(
                              onChanged: (selectedValue) {
                                final selectedRole = context
                                    .read<AssignCubit>()
                                    .roleModel
                                    ?.data
                                    ?.firstWhere(
                                        (role) => role.name == selectedValue);

                                context
                                    .read<AssignCubit>()
                                    .getRoleUser(selectedRole!.id!);
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Role is Required";
                                }
                                return null;
                              },
                              hint: 'Select Role',
                              items: context
                                          .read<AssignCubit>()
                                          .roleModel
                                          ?.data
                                          ?.isEmpty ??
                                      true
                                  ? ['No roles available']
                                  : context
                                          .read<AssignCubit>()
                                          .roleModel
                                          ?.data
                                          ?.map((e) => e.name ?? 'Unknown')
                                          .toList() ??
                                      [],
                              controller:
                                  context.read<AssignCubit>().roleController,
                              suffixIcon: IconBroken.arrowDown2,
                              keyboardType: TextInputType.text),
                          verticalSpace(10),
                          context
                                  .read<AssignCubit>()
                                  .roleController
                                  .text
                                  .isEmpty
                              ? SizedBox.shrink()
                              : Text(
                                  context
                                          .read<AssignCubit>()
                                          .roleController
                                          .text
                                          .isEmpty
                                      ? 'User'
                                      : context
                                          .read<AssignCubit>()
                                          .roleController
                                          .text,
                                  style: TextStyles.font16BlackRegular,
                                ),
                          (context
                                      .read<AssignCubit>()
                                      .roleController
                                      .text
                                      .isEmpty ||
                                  context
                                          .read<AssignCubit>()
                                          .roleUserModel
                                          ?.data ==
                                      null)
                              ? SizedBox.shrink()
                              : MultiDropdown<DataRoleUser>(
                                  items: context
                                              .read<AssignCubit>()
                                              .roleUserModel
                                              ?.data
                                              ?.isEmpty ??
                                          true
                                      ? [
                                          DropdownItem(
                                            label: 'No users available',
                                            value: DataRoleUser(
                                                id: null,
                                                userName: 'No users available'),
                                          )
                                        ]
                                      : context
                                          .read<AssignCubit>()
                                          .roleUserModel!
                                          .data!
                                          .map((role) => DropdownItem(
                                                label: role.userName!,
                                                value: role,
                                              ))
                                          .toList(),
                                  controller: context
                                      .read<AssignCubit>()
                                      .userController,
                                  enabled: true,
                                  chipDecoration: ChipDecoration(
                                    backgroundColor: Colors.grey[300],
                                    wrap: true,
                                    runSpacing: 5,
                                    spacing: 5,
                                  ),
                                  fieldDecoration: FieldDecoration(
                                    hintText:
                                        'Select ${context.read<AssignCubit>().roleController.text.isEmpty ? 'User' : context.read<AssignCubit>().roleController.text}',
                                    hintStyle: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColor.thirdColor),
                                    suffixIcon: Icon(IconBroken.arrowDown2),
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
                                  dropdownDecoration:
                                      const DropdownDecoration(maxHeight: 200),
                                  dropdownItemDecoration:
                                      DropdownItemDecoration(
                                    selectedIcon: const Icon(Icons.check_box,
                                        color: Colors.blue),
                                  ),
                                  onSelectionChange: (selectedItems) {
                                    selectedUsersIds = selectedItems
                                        .map((item) => (item).id!)
                                        .toList();
                                  },
                                ),
                          verticalSpace(20),
                          state is AssignLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(
                                      color: AppColor.primaryColor),
                                )
                              : Center(
                                  child: DefaultElevatedButton(
                                      name: "Assign",
                                      onPressed: () {
                                        context.read<AssignCubit>().assignShift(
                                            selectedShiftsIds,
                                            selectedUsersIds);
                                      },
                                      color: AppColor.primaryColor,
                                      height: 47,
                                      width: double.infinity,
                                      textStyles:
                                          TextStyles.font20Whitesemimedium),
                                ),
                        ],
                      ),
                    if (selectedIndex == 2)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          context.read<AssignCubit>().shiftModel?.data == null
                              ? SizedBox.shrink()
                              : Text(
                                  'Shift',
                                  style: TextStyles.font16BlackRegular,
                                ),
                          context.read<AssignCubit>().shiftModel?.data == null
                              ? SizedBox.shrink()
                              : MultiDropdown<ShiftDetails>(
                                  items: context
                                              .read<AssignCubit>()
                                              .shiftModel
                                              ?.data
                                              ?.data
                                              ?.isEmpty ??
                                          true
                                      ? [
                                          DropdownItem(
                                            label: 'No users available',
                                            value: ShiftDetails(
                                                id: null,
                                                name: 'No users available'),
                                          )
                                        ]
                                      : context
                                          .read<AssignCubit>()
                                          .shiftModel!
                                          .data!
                                          .data!
                                          .map((role) => DropdownItem(
                                                label: role.name!,
                                                value: role,
                                              ))
                                          .toList(),
                                  controller: context
                                      .read<AssignCubit>()
                                      .shiftController,
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
                                  dropdownDecoration:
                                      const DropdownDecoration(maxHeight: 200),
                                  dropdownItemDecoration:
                                      DropdownItemDecoration(
                                    selectedIcon: const Icon(Icons.check_box,
                                        color: Colors.blue),
                                  ),
                                  onSelectionChange: (selectedItems) {
                                    selectedShiftsIds = selectedItems
                                        .map((item) => (item).id!)
                                        .toList();
                                  },
                                ),
                          verticalSpace(10),
                          Divider(),
                          verticalSpace(10),
                          Text(
                            'Location',
                            style: TextStyles.font16BlackRegular,
                          ),
                          AssignCustomDropDownList(
                            onChanged: (selectedValue) {
                              final items = [
                                'Organization',
                                'Building',
                                'Floor',
                                'Point'
                              ];
                              selectedLocation = items.indexOf(selectedValue!);
                              context.read<AssignCubit>().getArea();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Location is Required";
                              }
                              return null;
                            },
                            hint: 'Select location',
                            items: [
                              'Organization',
                              'Building',
                              'Floor',
                              'Point'
                            ],
                            suffixIcon: IconBroken.arrowDown2,
                            keyboardType: TextInputType.text,
                            controller:
                                context.read<AssignCubit>().locationController,
                          ),
                          verticalSpace(10),
                          if (selectedLocation == 0) ...[
                            Text(
                              'Area',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedArea = context
                                      .read<AssignCubit>()
                                      .areaModel
                                      ?.data
                                      ?.firstWhere(
                                          (area) => area.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getCity(selectedArea!.id!);
                                },
                                hint: 'Select Area',
                                items: context
                                            .read<AssignCubit>()
                                            .areaModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No area available']
                                    : context
                                            .read<AssignCubit>()
                                            .areaModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().areaController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'City',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedCity = context
                                      .read<AssignCubit>()
                                      .cityModel
                                      ?.data
                                      ?.firstWhere(
                                          (city) => city.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getOrganization(selectedCity!.id!);
                                },
                                hint: 'Select City',
                                items: context
                                            .read<AssignCubit>()
                                            .cityModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No city available']
                                    : context
                                            .read<AssignCubit>()
                                            .cityModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().cityController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'Organization',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedOrganization = context
                                      .read<AssignCubit>()
                                      .organizationModel
                                      ?.data
                                      ?.firstWhere((organization) =>
                                          organization.name == selectedValue);

                                  selectedlocationId = selectedOrganization!.id;
                                },
                                hint: 'Select Organization',
                                items: context
                                            .read<AssignCubit>()
                                            .organizationModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No organization available']
                                    : context
                                            .read<AssignCubit>()
                                            .organizationModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller: context
                                    .read<AssignCubit>()
                                    .organizationController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                          ],
                          if (selectedLocation == 1) ...[
                            Text(
                              'Area',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedArea = context
                                      .read<AssignCubit>()
                                      .areaModel
                                      ?.data
                                      ?.firstWhere(
                                          (area) => area.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getCity(selectedArea!.id!);
                                },
                                hint: 'Select Area',
                                items: context
                                            .read<AssignCubit>()
                                            .areaModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No area available']
                                    : context
                                            .read<AssignCubit>()
                                            .areaModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().areaController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'City',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedCity = context
                                      .read<AssignCubit>()
                                      .cityModel
                                      ?.data
                                      ?.firstWhere(
                                          (city) => city.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getOrganization(selectedCity!.id!);
                                },
                                hint: 'Select City',
                                items: context
                                            .read<AssignCubit>()
                                            .cityModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No city available']
                                    : context
                                            .read<AssignCubit>()
                                            .cityModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().cityController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'Organization',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedOrganization = context
                                      .read<AssignCubit>()
                                      .organizationModel
                                      ?.data
                                      ?.firstWhere((organization) =>
                                          organization.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getBuilding(selectedOrganization!.id!);
                                },
                                hint: 'Select Organization',
                                items: context
                                            .read<AssignCubit>()
                                            .organizationModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No organization available']
                                    : context
                                            .read<AssignCubit>()
                                            .organizationModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller: context
                                    .read<AssignCubit>()
                                    .organizationController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'Building',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedBuilding = context
                                      .read<AssignCubit>()
                                      .buildingModel
                                      ?.data
                                      ?.firstWhere((building) =>
                                          building.name == selectedValue);

                                  selectedlocationId = selectedBuilding!.id;
                                },
                                hint: 'Select Building',
                                items: context
                                            .read<AssignCubit>()
                                            .buildingModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No building available']
                                    : context
                                            .read<AssignCubit>()
                                            .buildingModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller: context
                                    .read<AssignCubit>()
                                    .buildingController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                          ],
                          if (selectedLocation == 2) ...[
                            Text(
                              'Area',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedArea = context
                                      .read<AssignCubit>()
                                      .areaModel
                                      ?.data
                                      ?.firstWhere(
                                          (area) => area.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getCity(selectedArea!.id!);
                                },
                                hint: 'Select Area',
                                items: context
                                            .read<AssignCubit>()
                                            .areaModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No area available']
                                    : context
                                            .read<AssignCubit>()
                                            .areaModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().areaController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'City',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedCity = context
                                      .read<AssignCubit>()
                                      .cityModel
                                      ?.data
                                      ?.firstWhere(
                                          (city) => city.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getOrganization(selectedCity!.id!);
                                },
                                hint: 'Select City',
                                items: context
                                            .read<AssignCubit>()
                                            .cityModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No city available']
                                    : context
                                            .read<AssignCubit>()
                                            .cityModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().cityController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'Organization',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedOrganization = context
                                      .read<AssignCubit>()
                                      .organizationModel
                                      ?.data
                                      ?.firstWhere((organization) =>
                                          organization.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getBuilding(selectedOrganization!.id!);
                                },
                                hint: 'Select Organization',
                                items: context
                                            .read<AssignCubit>()
                                            .organizationModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No organization available']
                                    : context
                                            .read<AssignCubit>()
                                            .organizationModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller: context
                                    .read<AssignCubit>()
                                    .organizationController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'Building',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedBuilding = context
                                      .read<AssignCubit>()
                                      .buildingModel
                                      ?.data
                                      ?.firstWhere((building) =>
                                          building.name == selectedValue);
                                  context
                                      .read<AssignCubit>()
                                      .getFloor(selectedBuilding!.id!);
                                },
                                hint: 'Select Building',
                                items: context
                                            .read<AssignCubit>()
                                            .buildingModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No building available']
                                    : context
                                            .read<AssignCubit>()
                                            .buildingModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller: context
                                    .read<AssignCubit>()
                                    .buildingController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'Floor',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedFloor = context
                                      .read<AssignCubit>()
                                      .floorModel
                                      ?.data
                                      ?.firstWhere((floor) =>
                                          floor.name == selectedValue);

                                  selectedlocationId = selectedFloor!.id;
                                },
                                hint: 'Select Floor',
                                items: context
                                            .read<AssignCubit>()
                                            .floorModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No floor available']
                                    : context
                                            .read<AssignCubit>()
                                            .floorModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().floorController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                          ],
                          if (selectedLocation == 3) ...[
                            Text(
                              'Area',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedArea = context
                                      .read<AssignCubit>()
                                      .areaModel
                                      ?.data
                                      ?.firstWhere(
                                          (area) => area.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getCity(selectedArea!.id!);
                                },
                                hint: 'Select Area',
                                items: context
                                            .read<AssignCubit>()
                                            .areaModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No area available']
                                    : context
                                            .read<AssignCubit>()
                                            .areaModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().areaController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'City',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedCity = context
                                      .read<AssignCubit>()
                                      .cityModel
                                      ?.data
                                      ?.firstWhere(
                                          (city) => city.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getOrganization(selectedCity!.id!);
                                },
                                hint: 'Select City',
                                items: context
                                            .read<AssignCubit>()
                                            .cityModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No city available']
                                    : context
                                            .read<AssignCubit>()
                                            .cityModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().cityController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'Organization',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedOrganization = context
                                      .read<AssignCubit>()
                                      .organizationModel
                                      ?.data
                                      ?.firstWhere((organization) =>
                                          organization.name == selectedValue);

                                  context
                                      .read<AssignCubit>()
                                      .getBuilding(selectedOrganization!.id!);
                                },
                                hint: 'Select Organization',
                                items: context
                                            .read<AssignCubit>()
                                            .organizationModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No organization available']
                                    : context
                                            .read<AssignCubit>()
                                            .organizationModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller: context
                                    .read<AssignCubit>()
                                    .organizationController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'Building',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedBuilding = context
                                      .read<AssignCubit>()
                                      .buildingModel
                                      ?.data
                                      ?.firstWhere((building) =>
                                          building.name == selectedValue);
                                  context
                                      .read<AssignCubit>()
                                      .getFloor(selectedBuilding!.id!);
                                },
                                hint: 'Select Building',
                                items: context
                                            .read<AssignCubit>()
                                            .buildingModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No building available']
                                    : context
                                            .read<AssignCubit>()
                                            .buildingModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller: context
                                    .read<AssignCubit>()
                                    .buildingController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'Floor',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedFloor = context
                                      .read<AssignCubit>()
                                      .floorModel
                                      ?.data
                                      ?.firstWhere((floor) =>
                                          floor.name == selectedValue);
                                  context
                                      .read<AssignCubit>()
                                      .getPoints(selectedFloor!.id!);
                                },
                                hint: 'Select Floor',
                                items: context
                                            .read<AssignCubit>()
                                            .floorModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No floor available']
                                    : context
                                            .read<AssignCubit>()
                                            .floorModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().floorController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                            verticalSpace(10),
                            Text(
                              'Point',
                              style: TextStyles.font16BlackRegular,
                            ),
                            CustomDropDownList(
                                onChanged: (selectedValue) {
                                  final selectedPoint = context
                                      .read<AssignCubit>()
                                      .pointsModel
                                      ?.data
                                      ?.firstWhere((point) =>
                                          point.name == selectedValue);

                                  selectedlocationId = selectedPoint!.id;
                                },
                                hint: 'Select Point',
                                items: context
                                            .read<AssignCubit>()
                                            .pointsModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No point available']
                                    : context
                                            .read<AssignCubit>()
                                            .pointsModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller:
                                    context.read<AssignCubit>().pointController,
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text),
                          ],
                          verticalSpace(20),
                          state is AssignLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(
                                      color: AppColor.primaryColor),
                                )
                              : Center(
                                  child: DefaultElevatedButton(
                                      name: "Assign",
                                      onPressed: () {
                                        selectedLocation == 0
                                            ? context
                                                .read<AssignCubit>()
                                                .assignOrganizationShift(
                                                    selectedlocationId,
                                                    selectedShiftsIds)
                                            : selectedLocation == 1
                                                ? context
                                                    .read<AssignCubit>()
                                                    .assignBuildingShift(
                                                        selectedlocationId,
                                                        selectedShiftsIds)
                                                : selectedLocation == 2
                                                    ? context
                                                        .read<AssignCubit>()
                                                        .assignFloorShift(
                                                            selectedlocationId,
                                                            selectedShiftsIds)
                                                    : context
                                                        .read<AssignCubit>()
                                                        .assignPointShift(
                                                            selectedlocationId,
                                                            selectedShiftsIds);
                                      },
                                      color: AppColor.primaryColor,
                                      height: 47,
                                      width: double.infinity,
                                      textStyles:
                                          TextStyles.font20Whitesemimedium),
                                ),
                        ],
                      )
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
