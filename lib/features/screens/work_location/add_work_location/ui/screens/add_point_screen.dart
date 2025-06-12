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
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/logic/add_work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/logic/add_work_location_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AddPointScreen extends StatefulWidget {
  const AddPointScreen({super.key});

  @override
  State<AddPointScreen> createState() => _AddPointScreenState();
}

class _AddPointScreenState extends State<AddPointScreen> {
  List<int> selectedManagersIds = [];
  List<int> selectedSupervisorsIds = [];
  List<int> selectedCleanersIds = [];
  int? sectionId;
  bool? isCountable = true;
  double? capacity;
  int? unit;
  @override
  void initState() {
    context.read<AddWorkLocationCubit>()
      ..getNationality(userUsedOnly: false, areaUsedOnly: true)
      ..getAllUsers()
      ..getSensorsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text('Add Point'),
       
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: BlocConsumer<AddWorkLocationCubit, AddWorkLocationState>(
          listener: (context, state) {
            if (state is CreatePointSuccessState) {
              toast(text: state.message, color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.workLocationScreen,
                  arguments: 6);
            }
            if (state is CreatePointErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            if (context.read<AddWorkLocationCubit>().usersModel == null ||
                context.read<AddWorkLocationCubit>().nationalityModel == null) {
             return Loading();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: context.read<AddWorkLocationCubit>().formAddKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(20),
                    _buildDetailsField(),
                    verticalSpace(20),
                    _buildContinueButton(state),
                    verticalSpace(20),
                  ],
                ),
              ),
            );
          },
        )),
      ),
    );
  }

  Widget _buildDetailsField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).addUserText12,
          style: TextStyles.font16BlackRegular,
        ),
        CustomDropDownList(
          hint: "Select country",
          items: context
                      .read<AddWorkLocationCubit>()
                      .nationalityModel
                      ?.data
                      ?.isEmpty ??
                  true
              ? ['No country']
              : context
                      .read<AddWorkLocationCubit>()
                      .nationalityModel
                      ?.data
                      ?.map((e) => e.name ?? 'Unknown')
                      .toList() ??
                  [],
          onChanged: (value) {
            context.read<AddWorkLocationCubit>().nationalityController.text =
                value!;
            context.read<AddWorkLocationCubit>().getArea(value);
          },
          validator: (value) {
            if (value == null || value.isEmpty || value == 'No country') {
              return S.of(context).validationNationality;
            }
            return null;
          },
          suffixIcon: IconBroken.arrowDown2,
          controller:
              context.read<AddWorkLocationCubit>().nationalityController,
          isRead: false,
          keyboardType: TextInputType.text,
        ),
        verticalSpace(10),
        Text(
          "Area",
          style: TextStyles.font16BlackRegular,
        ),
        CustomDropDownList(
          hint: "Select area",
          items: context
                      .read<AddWorkLocationCubit>()
                      .areaModel
                      ?.data
                      ?.data
                      ?.isEmpty ??
                  true
              ? ['No area']
              : context
                      .read<AddWorkLocationCubit>()
                      .areaModel
                      ?.data
                      ?.data
                      ?.map((e) => e.name ?? 'Unknown')
                      .toList() ??
                  [],
          validator: (value) {
            if (value == null || value.isEmpty || value == "No area") {
              return "Area is required";
            }
            return null;
          },
          onPressed: (value) {
            final selectedArea = context
                .read<AddWorkLocationCubit>()
                .areaModel
                ?.data
                ?.data
                ?.firstWhere((area) =>
                    area.name ==
                    context.read<AddWorkLocationCubit>().areaController.text);
            context.read<AddWorkLocationCubit>().getCity(selectedArea!.id!);
          },
          suffixIcon: IconBroken.arrowDown2,
          controller: context.read<AddWorkLocationCubit>().areaController,
          isRead: false,
          keyboardType: TextInputType.text,
        ),
        verticalSpace(10),
        Text(
          "City",
          style: TextStyles.font16BlackRegular,
        ),
        CustomDropDownList(
          hint: "Select city",
          items: context
                      .read<AddWorkLocationCubit>()
                      .cityModel
                      ?.data
                      ?.data
                      ?.isEmpty ??
                  true
              ? ['No cities']
              : context
                      .read<AddWorkLocationCubit>()
                      .cityModel
                      ?.data
                      ?.data
                      ?.map((e) => e.name ?? 'Unknown')
                      .toList() ??
                  [],
          validator: (value) {
            if (value == null || value.isEmpty || value == 'No cities') {
              return "City is required";
            }
            return null;
          },
          onPressed: (value) {
            final selectedCity = context
                .read<AddWorkLocationCubit>()
                .cityModel
                ?.data
                ?.data
                ?.firstWhere((city) =>
                    city.name ==
                    context.read<AddWorkLocationCubit>().cityController.text);
            context
                .read<AddWorkLocationCubit>()
                .getOrganization(selectedCity!.id!);
          },
          suffixIcon: IconBroken.arrowDown2,
          controller: context.read<AddWorkLocationCubit>().cityController,
          isRead: false,
          keyboardType: TextInputType.text,
        ),
        verticalSpace(10),
        Text(
          "Organization",
          style: TextStyles.font16BlackRegular,
        ),
        CustomDropDownList(
          hint: "Select organizations",
          items: context
                      .read<AddWorkLocationCubit>()
                      .organizationModel
                      ?.data
                      ?.data
                      ?.isEmpty ??
                  true
              ? ['No organizations']
              : context
                      .read<AddWorkLocationCubit>()
                      .organizationModel
                      ?.data
                      ?.data
                      ?.map((e) => e.name ?? 'Unknown')
                      .toList() ??
                  [],
          validator: (value) {
            if (value == null || value.isEmpty || value == 'No organizations') {
              return "Organizations is required";
            }
            return null;
          },
          onPressed: (value) {
            final selectedOrganization = context
                .read<AddWorkLocationCubit>()
                .organizationModel
                ?.data
                ?.data
                ?.firstWhere((organization) =>
                    organization.name ==
                    context
                        .read<AddWorkLocationCubit>()
                        .organizationController
                        .text);
            context
                .read<AddWorkLocationCubit>()
                .getBuilding(selectedOrganization!.id!);
          },
          suffixIcon: IconBroken.arrowDown2,
          controller:
              context.read<AddWorkLocationCubit>().organizationController,
          isRead: false,
          keyboardType: TextInputType.text,
        ),
        verticalSpace(10),
        Text(
          "Building",
          style: TextStyles.font16BlackRegular,
        ),
        CustomDropDownList(
          hint: "Select building",
          items: context
                      .read<AddWorkLocationCubit>()
                      .buildingModel
                      ?.data
                      ?.data
                      ?.isEmpty ??
                  true
              ? ['No building']
              : context
                      .read<AddWorkLocationCubit>()
                      .buildingModel
                      ?.data
                      ?.data
                      ?.map((e) => e.name ?? 'Unknown')
                      .toList() ??
                  [],
          validator: (value) {
            if (value == null || value.isEmpty || value == 'No building') {
              return "Building is required";
            }
            return null;
          },
          onPressed: (value) {
            final selectedBuilding = context
                .read<AddWorkLocationCubit>()
                .buildingModel
                ?.data
                ?.data
                ?.firstWhere((building) =>
                    building.name ==
                    context
                        .read<AddWorkLocationCubit>()
                        .buildingController
                        .text);
            context
                .read<AddWorkLocationCubit>()
                .getFloor(selectedBuilding!.id!);
          },
          suffixIcon: IconBroken.arrowDown2,
          controller: context.read<AddWorkLocationCubit>().buildingController,
          isRead: false,
          keyboardType: TextInputType.text,
        ),
        verticalSpace(10),
        Text(
          "Floor",
          style: TextStyles.font16BlackRegular,
        ),
        CustomDropDownList(
          hint: "Select floor",
          items: context
                      .read<AddWorkLocationCubit>()
                      .floorModel
                      ?.data
                      ?.data
                      ?.isEmpty ??
                  true
              ? ['No floors']
              : context
                      .read<AddWorkLocationCubit>()
                      .floorModel
                      ?.data
                      ?.data
                      ?.map((e) => e.name ?? 'Unknown')
                      .toList() ??
                  [],
          validator: (value) {
            if (value == null || value.isEmpty || value == 'No floors') {
              return "Floor is required";
            }
            return null;
          },
          onPressed: (value) {
            final selectedFloor = context
                .read<AddWorkLocationCubit>()
                .floorModel
                ?.data
                ?.data
                ?.firstWhere((floor) =>
                    floor.name ==
                    context.read<AddWorkLocationCubit>().floorController.text);

            context.read<AddWorkLocationCubit>().getSection(selectedFloor!.id!);
          },
          suffixIcon: IconBroken.arrowDown2,
          controller: context.read<AddWorkLocationCubit>().floorController,
          isRead: false,
          keyboardType: TextInputType.text,
        ),
        verticalSpace(10),
        Text(
          "Section",
          style: TextStyles.font16BlackRegular,
        ),
        CustomDropDownList(
          hint: "Select section",
          items: context
                      .read<AddWorkLocationCubit>()
                      .sectionModel
                      ?.data
                      ?.data
                      ?.isEmpty ??
                  true
              ? ['No sections']
              : context
                      .read<AddWorkLocationCubit>()
                      .sectionModel
                      ?.data
                      ?.data
                      ?.map((e) => e.name ?? 'Unknown')
                      .toList() ??
                  [],
          validator: (value) {
            if (value == null || value.isEmpty || value == 'No sections') {
              return "Section is required";
            }
            return null;
          },
          onPressed: (value) {
            final selectedSection = context
                .read<AddWorkLocationCubit>()
                .sectionModel
                ?.data
                ?.data
                ?.firstWhere((section) =>
                    section.name ==
                    context
                        .read<AddWorkLocationCubit>()
                        .sectionController
                        .text);

            sectionId = selectedSection!.id!;
          },
          suffixIcon: IconBroken.arrowDown2,
          controller: context.read<AddWorkLocationCubit>().sectionController,
          isRead: false,
          keyboardType: TextInputType.text,
        ),
        verticalSpace(10),
        Text(
          "Point Name",
          style: TextStyles.font16BlackRegular,
        ),
        CustomTextFormField(
          controller: context.read<AddWorkLocationCubit>().addPointController,
          onlyRead: false,
          hint: '',
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
        ),
        verticalSpace(10),
        Text(
          "Point Number",
          style: TextStyles.font16BlackRegular,
        ),
        CustomTextFormField(
          controller:
              context.read<AddWorkLocationCubit>().pointNumberController,
          keyboardType: TextInputType.text,
          onlyRead: false,
          hint: '',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Point number is required";
            } else if (value.length > 30) {
              return 'Point number too long';
            }
            return null;
          },
        ),
        verticalSpace(10),
        Text(
          "Point Description",
          style: TextStyles.font16BlackRegular,
        ),
        verticalSpace(10),
        CustomDescriptionTextFormField(
          controller:
              context.read<AddWorkLocationCubit>().pointDiscriptionController,
          hint: 'discription...',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "description is required";
            } else if (value.length < 3) {
              return 'description too short';
            }
            return null;
          },
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
          controller: context.read<AddWorkLocationCubit>().sensorController,
          items: context
              .read<AddWorkLocationCubit>()
              .sensorItem
              .map((e) => e.name ?? 'Unknown')
              .toList(),
          onChanged: (value) {
            final selectedsensor = context
                .read<AddWorkLocationCubit>()
                .sensorModel
                ?.data
                ?.data
                ?.firstWhere((sensor) =>
                    sensor.name ==
                    context.read<AddWorkLocationCubit>().sensorController.text)
                .id
                ?.toString();

            if (selectedsensor != null) {
              context.read<AddWorkLocationCubit>().sensorIdController.text =
                  selectedsensor;
            }
          },
          suffixIcon: IconBroken.arrowDown2,
          keyboardType: TextInputType.text,
        ),
        verticalSpace(10),
        context.read<AddWorkLocationCubit>().usersModel!.data == null
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
        context.read<AddWorkLocationCubit>().usersModel!.data == null
            ? SizedBox.shrink()
            : MultiDropdown<UserItem>(
                items: context
                        .read<AddWorkLocationCubit>()
                        .usersModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Manager')
                        .isEmpty
                    ? [
                        DropdownItem(
                          label: 'No managers available',
                          value: UserItem(
                              id: null, userName: 'No managers available'),
                        )
                      ]
                    : context
                        .read<AddWorkLocationCubit>()
                        .usersModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Manager')
                        .map((manager) => DropdownItem(
                              label: manager.userName!,
                              value: manager,
                            ))
                        .toList(),
                controller:
                    context.read<AddWorkLocationCubit>().allmanagersController,
                enabled: true,
                chipDecoration: ChipDecoration(
                  backgroundColor: Colors.grey[300],
                  wrap: true,
                  runSpacing: 5,
                  spacing: 5,
                ),
                fieldDecoration: FieldDecoration(
                  hintText: 'Select managers',
                  suffixIcon: Icon(IconBroken.arrowDown2),
                  hintStyle:
                      TextStyle(fontSize: 12.sp, color: AppColor.thirdColor),
                  showClearIcon: false,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Colors.grey),
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
                  selectedIcon: const Icon(Icons.check_box, color: Colors.blue),
                ),
                onSelectionChange: (selectedItems) {
                  selectedManagersIds =
                      selectedItems.map((item) => (item).id!).toList();
                },
              ),
        verticalSpace(10),
        context.read<AddWorkLocationCubit>().usersModel!.data == null
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
        context.read<AddWorkLocationCubit>().usersModel!.data == null
            ? SizedBox.shrink()
            : MultiDropdown<UserItem>(
                items: context
                        .read<AddWorkLocationCubit>()
                        .usersModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Supervisor')
                        .isEmpty
                    ? [
                        DropdownItem(
                          label: 'No supervisors available',
                          value: UserItem(
                              id: null, userName: 'No supervisors available'),
                        )
                      ]
                    : context
                        .read<AddWorkLocationCubit>()
                        .usersModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Supervisor')
                        .map((supervisor) => DropdownItem(
                              label: supervisor.userName!,
                              value: supervisor,
                            ))
                        .toList(),
                controller: context
                    .read<AddWorkLocationCubit>()
                    .allSupervisorsController,
                enabled: true,
                chipDecoration: ChipDecoration(
                  backgroundColor: Colors.grey[300],
                  wrap: true,
                  runSpacing: 5,
                  spacing: 5,
                ),
                fieldDecoration: FieldDecoration(
                  hintText: 'Select supervisors',
                  suffixIcon: Icon(IconBroken.arrowDown2),
                  hintStyle:
                      TextStyle(fontSize: 12.sp, color: AppColor.thirdColor),
                  showClearIcon: false,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Colors.grey),
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
                  selectedIcon: const Icon(Icons.check_box, color: Colors.blue),
                ),
                onSelectionChange: (selectedItems) {
                  selectedSupervisorsIds =
                      selectedItems.map((item) => (item).id!).toList();
                },
              ),
        verticalSpace(10),
        context.read<AddWorkLocationCubit>().usersModel!.data == null
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
        context.read<AddWorkLocationCubit>().usersModel!.data == null
            ? SizedBox.shrink()
            : MultiDropdown<UserItem>(
                items: context
                        .read<AddWorkLocationCubit>()
                        .usersModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Cleaner')
                        .isEmpty
                    ? [
                        DropdownItem(
                          label: 'No cleaners available',
                          value: UserItem(
                              id: null, userName: 'No cleaners available'),
                        )
                      ]
                    : context
                        .read<AddWorkLocationCubit>()
                        .usersModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Cleaner')
                        .map((cleaner) => DropdownItem(
                              label: cleaner.userName!,
                              value: cleaner,
                            ))
                        .toList(),
                controller:
                    context.read<AddWorkLocationCubit>().allCleanersController,
                enabled: true,
                chipDecoration: ChipDecoration(
                  backgroundColor: Colors.grey[300],
                  wrap: true,
                  runSpacing: 5,
                  spacing: 5,
                ),
                fieldDecoration: FieldDecoration(
                  hintText: 'Select cleaners',
                  suffixIcon: Icon(IconBroken.arrowDown2),
                  hintStyle:
                      TextStyle(fontSize: 12.sp, color: AppColor.thirdColor),
                  showClearIcon: false,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Colors.grey),
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
                  selectedIcon: const Icon(Icons.check_box, color: Colors.blue),
                ),
                onSelectionChange: (selectedItems) {
                  selectedCleanersIds =
                      selectedItems.map((item) => (item).id!).toList();
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
                  groupValue: isCountable,
                  activeColor: AppColor.primaryColor,
                  onChanged: (value) {
                    setState(() {
                      isCountable = value;
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
                  groupValue: isCountable,
                  activeColor: AppColor.primaryColor,
                  onChanged: (value) {
                    setState(() {
                      isCountable = value;
                    });
                  },
                ),
                const Text("No"),
              ],
            ),
          ],
        ),
        if (isCountable == true) ...[
          Text(
            "Capacity",
            style: TextStyles.font16BlackRegular,
          ),
          CustomTextFormField(
            onlyRead: false,
            hint: "Write capacity",
            controller: context.read<AddWorkLocationCubit>().capacityController,
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
              final items = ['Ml', 'L', 'Kg', 'G', 'M', 'Cm', 'Pieces'];
              final selectedIndex = items.indexOf(selectedValue);
              if (selectedIndex != -1) {
                unit = selectedIndex;
              }
            },
            hint: 'Select',
            items: ['Ml', 'L', 'Kg', 'G', 'M', 'Cm', 'Pieces'],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Unit is Required";
              }
              return null;
            },
            controller: context.read<AddWorkLocationCubit>().unitController,
            keyboardType: TextInputType.text,
            suffixIcon: IconBroken.arrowDown2,
          ),
          verticalSpace(10)
        ],
      ],
    );
  }

  Widget _buildContinueButton(state) {
    return state is CreateCityLoadingState
        ? Loading()
        : DefaultElevatedButton(
            name: "Add",
            onPressed: () {
              if (context
                  .read<AddWorkLocationCubit>()
                  .formAddKey
                  .currentState!
                  .validate()) {
                context.read<AddWorkLocationCubit>().createPoint(
                    sectionId!,
                    selectedManagersIds,
                    selectedSupervisorsIds,
                    selectedCleanersIds,
                    isCountable,
                    capacity,
                    unit);
              }
            },
            color: AppColor.primaryColor,
            height: 47.h,
            width: double.infinity,
            textStyles: TextStyles.font20Whitesemimedium,
          );
  }
}
