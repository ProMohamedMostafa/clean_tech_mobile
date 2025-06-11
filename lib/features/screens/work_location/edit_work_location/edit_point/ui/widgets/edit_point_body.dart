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
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/data/models/point_users_details_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_point/logic/edit_point_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/edit_work_location/edit_point/logic/edit_point_state.dart';

import 'package:smart_cleaning_application/generated/l10n.dart';

class EditPointBody extends StatefulWidget {
  final int id;
  const EditPointBody({super.key, required this.id});

  @override
  State<EditPointBody> createState() => _EditPointBodyState();
}

class _EditPointBodyState extends State<EditPointBody> {
  List<int> selectedManagersIds = [];
  List<int> selectedSupervisorsIds = [];
  List<int> selectedCleanersIds = [];
  double? capacity;
  int? unit;
  @override
  void initState() {
    context.read<EditPointCubit>().getPointManagersDetails(widget.id);
    context.read<EditPointCubit>().getNationality();
    context.read<EditPointCubit>().getSensorsData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(leading: customBackButton(context), title: Text('Edit Point')),
      body: SafeArea(
        child: BlocConsumer<EditPointCubit, EditPointState>(
          listener: (context, state) {
            if (state is EditPointSuccessState) {
              toast(text: state.pointEditModel.message!, color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.workLocationScreen,
                  arguments: 5);
            }
            if (state is EditPointErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            final cubit = context.read<EditPointCubit>();
            if (cubit.pointUsersDetailsModel == null) {
             return Loading();
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: context.read<EditPointCubit>().formKey,
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
                            .read<EditPointCubit>()
                            .pointUsersDetailsModel!
                            .data!
                            .countryName!,
                        items: context
                                    .read<EditPointCubit>()
                                    .nationalityModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No country']
                            : context
                                    .read<EditPointCubit>()
                                    .nationalityModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          context.read<EditPointCubit>().getAreas(value);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<EditPointCubit>()
                            .nationalityController,
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
                            .read<EditPointCubit>()
                            .pointUsersDetailsModel!
                            .data!
                            .areaName!,
                        items: context
                                    .read<EditPointCubit>()
                                    .areasModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No areas']
                            : context
                                    .read<EditPointCubit>()
                                    .areasModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedArea = context
                              .read<EditPointCubit>()
                              .areasModel
                              ?.data
                              ?.data
                              ?.firstWhere((area) =>
                                  area.name ==
                                  context
                                      .read<EditPointCubit>()
                                      .areaController
                                      .text);

                          context
                              .read<EditPointCubit>()
                              .getCityy(selectedArea!.id!);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditPointCubit>().areaController,
                        isRead: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        "City",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: context
                            .read<EditPointCubit>()
                            .pointUsersDetailsModel!
                            .data!
                            .cityName!,
                        items: context
                                    .read<EditPointCubit>()
                                    .cityyModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No cities']
                            : context
                                    .read<EditPointCubit>()
                                    .cityyModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedCity = context
                              .read<EditPointCubit>()
                              .cityyModel
                              ?.data
                              ?.data
                              ?.firstWhere((city) =>
                                  city.name ==
                                  context
                                      .read<EditPointCubit>()
                                      .cityController
                                      .text);

                          context
                              .read<EditPointCubit>()
                              .getOrganizations(selectedCity!.id!);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditPointCubit>().cityController,
                        isRead: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        "Organization",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: context
                            .read<EditPointCubit>()
                            .pointUsersDetailsModel!
                            .data!
                            .organizationName!,
                        items: context
                                    .read<EditPointCubit>()
                                    .organizationsModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No organization']
                            : context
                                    .read<EditPointCubit>()
                                    .organizationsModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedOrganization = context
                              .read<EditPointCubit>()
                              .organizationsModel
                              ?.data
                              ?.data!
                              .firstWhere((organization) =>
                                  organization.name ==
                                  context
                                      .read<EditPointCubit>()
                                      .organizationController
                                      .text);

                          context
                              .read<EditPointCubit>()
                              .getBuildings(selectedOrganization!.id!);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<EditPointCubit>()
                            .organizationController,
                        isRead: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        "Building",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: context
                            .read<EditPointCubit>()
                            .pointUsersDetailsModel!
                            .data!
                            .buildingName!,
                        items: context
                                    .read<EditPointCubit>()
                                    .buildingsModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No building']
                            : context
                                    .read<EditPointCubit>()
                                    .buildingsModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedBuilding = context
                              .read<EditPointCubit>()
                              .buildingsModel
                              ?.data
                              ?.data!
                              .firstWhere((building) =>
                                  building.name ==
                                  context
                                      .read<EditPointCubit>()
                                      .buildingController
                                      .text);
                          context
                              .read<EditPointCubit>()
                              .getFloors(selectedBuilding!.id!);
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditPointCubit>().buildingController,
                        isRead: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        "Floor",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: context
                            .read<EditPointCubit>()
                            .pointUsersDetailsModel!
                            .data!
                            .floorName!,
                        items: context
                                    .read<EditPointCubit>()
                                    .floorsModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No floor']
                            : context
                                    .read<EditPointCubit>()
                                    .floorsModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedFloor = context
                              .read<EditPointCubit>()
                              .floorsModel
                              ?.data
                              ?.data!
                              .firstWhere((floor) =>
                                  floor.name ==
                                  context
                                      .read<EditPointCubit>()
                                      .floorController
                                      .text);
                          context
                              .read<EditPointCubit>()
                              .floorIdController
                              .text = selectedFloor!.id!.toString();
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<EditPointCubit>().buildingController,
                        isRead: false,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        "Point Name",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomTextFormField(
                        hint: context
                            .read<EditPointCubit>()
                            .pointUsersDetailsModel!
                            .data!
                            .name!,
                        controller:
                            context.read<EditPointCubit>().pointController
                              ..text = context
                                  .read<EditPointCubit>()
                                  .pointUsersDetailsModel!
                                  .data!
                                  .name!,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Point name is required";
                          } else if (value.length > 55) {
                            return 'Point name too long';
                          } else if (value.length < 3) {
                            return 'Point name too short';
                          }
                          return null;
                        },
                        onlyRead: false,
                      ),
                      verticalSpace(10),
                      Text(
                        "Point Number",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomTextFormField(
                        hint: context
                            .read<EditPointCubit>()
                            .pointUsersDetailsModel!
                            .data!
                            .number!,
                        controller:
                            context.read<EditPointCubit>().pointNumberController
                              ..text = context
                                  .read<EditPointCubit>()
                                  .pointUsersDetailsModel!
                                  .data!
                                  .number!,
                        onlyRead: false,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Point number is required";
                          } else if (value.length > 55) {
                            return 'Point number too long';
                          }
                          return null;
                        },
                      ),
                      verticalSpace(10),
                      Text(
                        "Point description",
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDescriptionTextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Description is Required";
                          } else if (value.length < 3) {
                            return 'Description too short';
                          }
                          return null;
                        },
                        controller: context
                            .read<EditPointCubit>()
                            .pointDescriptionController
                          ..text = context
                              .read<EditPointCubit>()
                              .pointUsersDetailsModel!
                              .data!
                              .description!,
                        hint: context
                            .read<EditPointCubit>()
                            .pointUsersDetailsModel!
                            .data!
                            .description!,
                      ),
                      verticalSpace(10),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Sensor',
                              style: TextStyles.font16BlackRegular,
                            ),
                            TextSpan(
                              text: ' (Optional)',
                              style: TextStyles.font14GreyRegular,
                            ),
                          ],
                        ),
                      ),
                      CustomDropDownList(
                        hint: 'Select sensor',
                        controller:
                            context.read<EditPointCubit>().sensorController,
                        items: context
                            .read<EditPointCubit>()
                            .sensorItem
                            .map((e) => e.name ?? 'Unknown')
                            .toList(),
                        onChanged: (value) {
                          final selectedsensor = context
                              .read<EditPointCubit>()
                              .sensorModel
                              ?.data
                              ?.data
                              ?.firstWhere((sensor) =>
                                  sensor.name ==
                                  context
                                      .read<EditPointCubit>()
                                      .sensorController
                                      .text)
                              .id
                              ?.toString();

                          if (selectedsensor != null) {
                            context
                                .read<EditPointCubit>()
                                .sensorIdController
                                .text = selectedsensor;
                          }
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      context
                                  .read<EditPointCubit>()
                                  .pointUsersDetailsModel
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
                                  .read<EditPointCubit>()
                                  .pointUsersDetailsModel
                                  ?.data ==
                              null
                          ? SizedBox.shrink()
                          : MultiDropdown<Users>(
                              items: context
                                      .read<EditPointCubit>()
                                      .pointUsersDetailsModel!
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
                                      .read<EditPointCubit>()
                                      .pointUsersDetailsModel!
                                      .data!
                                      .users!
                                      .where((user) => user.role == 'Manager')
                                      .map((manager) => DropdownItem(
                                            label: manager.userName!,
                                            value: manager,
                                          ))
                                      .toList(),
                              controller: context
                                  .read<EditPointCubit>()
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
                                    .read<EditPointCubit>()
                                    .pointUsersDetailsModel!
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
                                  .read<EditPointCubit>()
                                  .pointUsersDetailsModel
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
                                  .read<EditPointCubit>()
                                  .pointUsersDetailsModel
                                  ?.data ==
                              null
                          ? SizedBox.shrink()
                          : MultiDropdown<Users>(
                              items: context
                                      .read<EditPointCubit>()
                                      .pointUsersDetailsModel!
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
                                      .read<EditPointCubit>()
                                      .pointUsersDetailsModel!
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
                                  .read<EditPointCubit>()
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
                                    .read<EditPointCubit>()
                                    .pointUsersDetailsModel!
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
                                  .read<EditPointCubit>()
                                  .pointUsersDetailsModel
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
                                  .read<EditPointCubit>()
                                  .pointUsersDetailsModel
                                  ?.data ==
                              null
                          ? SizedBox.shrink()
                          : MultiDropdown<Users>(
                              items: context
                                      .read<EditPointCubit>()
                                      .pointUsersDetailsModel!
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
                                      .read<EditPointCubit>()
                                      .pointUsersDetailsModel!
                                      .data!
                                      .users!
                                      .where((user) => user.role == 'Cleaner')
                                      .map((cleaner) => DropdownItem(
                                            label: cleaner.userName!,
                                            value: cleaner,
                                          ))
                                      .toList(),
                              controller: context
                                  .read<EditPointCubit>()
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
                                    .read<EditPointCubit>()
                                    .pointUsersDetailsModel!
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Is Countable:",
                            style: TextStyles.font16BlackRegular,
                          ),
                          horizontalSpace(10),
                          Row(
                            children: [
                              Radio<bool>(
                                value: true,
                                groupValue: context
                                    .read<EditPointCubit>()
                                    .pointUsersDetailsModel!
                                    .data!
                                    .isCountable,
                                activeColor: AppColor.primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    context
                                        .read<EditPointCubit>()
                                        .pointUsersDetailsModel!
                                        .data!
                                        .isCountable = value;
                                  });
                                },
                              ),
                              const Text("Yes"),
                            ],
                          ),
                          horizontalSpace(10),
                          Row(
                            children: [
                              Radio<bool>(
                                value: false,
                                groupValue: context
                                    .read<EditPointCubit>()
                                    .pointUsersDetailsModel!
                                    .data!
                                    .isCountable,
                                activeColor: AppColor.primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    context
                                        .read<EditPointCubit>()
                                        .pointUsersDetailsModel!
                                        .data!
                                        .isCountable = value;
                                  });
                                },
                              ),
                              const Text("No"),
                            ],
                          ),
                        ],
                      ),
                      if (context
                              .read<EditPointCubit>()
                              .pointUsersDetailsModel!
                              .data!
                              .isCountable ==
                          true) ...[
                        Text(
                          "Capacity",
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomTextFormField(
                          onlyRead: false,
                          hint: context
                                  .read<EditPointCubit>()
                                  .pointUsersDetailsModel
                                  ?.data
                                  ?.capacity
                                  ?.toString() ??
                              'Write capacity',
                          controller:
                              context.read<EditPointCubit>().capacityController
                                ..text = context
                                        .read<EditPointCubit>()
                                        .pointUsersDetailsModel
                                        ?.data
                                        ?.capacity
                                        ?.toString() ??
                                    '',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "capacity is Required";
                            } else if (value.length > 30) {
                              return 'capacity too long';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            capacity = double.parse(value);
                          },
                        ),
                        verticalSpace(10),
                        Text(
                          'Unit',
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          onPressed: (selectedValue) {
                            final items = [
                              'Ml',
                              'L',
                              'Kg',
                              'G',
                              'M',
                              'Cm',
                              'Pieces'
                            ];
                            final selectedIndex = items.indexOf(selectedValue);
                            if (selectedIndex != -1) {
                              unit = selectedIndex;
                            }
                          },
                          hint: context
                                  .read<EditPointCubit>()
                                  .pointUsersDetailsModel!
                                  .data!
                                  .unit ??
                              'Select',
                          items: ['Ml', 'L', 'Kg', 'G', 'M', 'Cm', 'Pieces'],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Unit is Required";
                            }
                            return null;
                          },
                          controller:
                              context.read<EditPointCubit>().unitController,
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                        verticalSpace(10)
                      ],
                      verticalSpace(20),
                      state is EditPointLoadingState
                          ? Loading()
                          : DefaultElevatedButton(
                              name: "Edit",
                              onPressed: () {
                                if (context
                                    .read<EditPointCubit>()
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  showCustomDialog(context,
                                      "Are you Sure you want save the edit of this Point ?",
                                      () {
                                    context.read<EditPointCubit>().editPoint(
                                        widget.id,
                                        selectedManagersIds,
                                        selectedSupervisorsIds,
                                        selectedCleanersIds,
                                        capacity,
                                        unit);
                                    context.pop();
                                  });
                                }
                              },
                              color: AppColor.primaryColor,
                              height: 48.h,
                              width: double.infinity,
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
      ),
    );
  }
}
