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
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/users_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/logic/add_work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/add_work_location/logic/add_work_location_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AddFloorScreen extends StatelessWidget {
  const AddFloorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddWorkLocationCubit>();
    return Scaffold(
      appBar: AppBar(
          leading: CustomBackButton(), title: Text(S.of(context).addFloor)),
      body: SingleChildScrollView(
          child: BlocConsumer<AddWorkLocationCubit, AddWorkLocationState>(
        listener: (context, state) {
          if (state is CreateFloorSuccessState) {
            toast(text: state.message, isSuccess: true);
            context.popWithTrueResult();
          }
          if (state is CreateFloorErrorState) {
            toast(text: state.error, isSuccess: false);
          }
        },
        builder: (context, state) {
          if (cubit.usersModel == null ||
              cubit.nationalityListModel == null ||
              cubit.shiftModel == null) {
            return Loading();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: cubit.formAddKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailsField(context, cubit),
                  verticalSpace(20),
                  _buildContinueButton(context, cubit, state),
                  verticalSpace(20),
                ],
              ),
            ),
          );
        },
      )),
    );
  }

  Widget _buildDetailsField(BuildContext context, AddWorkLocationCubit cubit) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(S.of(context).addUserText12,
              style: TextStyles.font16BlackRegular),
          CustomDropDownList(
            hint: S.of(context).selectCountry,
            items:
                cubit.nationalityData.map((e) => e.name ?? 'un known').toList(),
            onChanged: (value) {
              cubit.getArea();
            },
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  value == S.of(context).noCountry) {
                return S.of(context).validationNationality;
              }
              return null;
            },
            suffixIcon: IconBroken.arrowDown2,
            controller: cubit.nationalityController,
            isRead: false,
            keyboardType: TextInputType.text,
          ),
          verticalSpace(10),
          Text(S.of(context).areaName, style: TextStyles.font16BlackRegular),
          CustomDropDownList(
            hint: S.of(context).selectArea,
            controller: cubit.areaController,
            items: cubit.areaItem.map((e) => e.name ?? 'Unknown').toList(),
            onChanged: (value) {
              final selectedArea = cubit.areaListModel?.data?.data
                  ?.firstWhere((area) => area.name == cubit.areaController.text)
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
            S.of(context).cityName,
            style: TextStyles.font16BlackRegular,
          ),
          CustomDropDownList(
            hint: S.of(context).selectCity,
            controller: cubit.cityController,
            items: cubit.cityItem.map((e) => e.name ?? 'Unknown').toList(),
            onChanged: (value) {
              final selectedCity = cubit.cityModel?.data?.data
                  ?.firstWhere((city) => city.name == cubit.cityController.text)
                  .id
                  ?.toString();

              if (selectedCity != null) {
                cubit.cityIdController.text = selectedCity;
              }
              cubit.getOrganization();
            },
            suffixIcon: IconBroken.arrowDown2,
            keyboardType: TextInputType.text,
          ),
          verticalSpace(10),
          Text(
            S.of(context).Organization,
            style: TextStyles.font16BlackRegular,
          ),
          CustomDropDownList(
            hint: S.of(context).selectOrganization,
            controller: cubit.organizationController,
            items:
                cubit.organizationItem.map((e) => e.name ?? 'Unknown').toList(),
            onChanged: (value) {
              final selectedOrganization = cubit.organizationModel?.data?.data
                  ?.firstWhere(
                      (org) => org.name == cubit.organizationController.text)
                  .id
                  ?.toString();

              if (selectedOrganization != null) {
                cubit.organizationIdController.text = selectedOrganization;
              }
              cubit.getBuilding();
            },
            suffixIcon: IconBroken.arrowDown2,
            keyboardType: TextInputType.text,
          ),
          verticalSpace(10),
          Text(
            S.of(context).Building,
            style: TextStyles.font16BlackRegular,
          ),
          CustomDropDownList(
            hint: S.of(context).selectBuilding,
            controller: cubit.buildingController,
            items: cubit.buildingItem.map((e) => e.name ?? 'Unknown').toList(),
            onChanged: (value) {
              final selectedBuilding = cubit.buildingModel?.data?.data
                  ?.firstWhere(
                      (bld) => bld.name == cubit.buildingController.text)
                  .id
                  ?.toString();

              if (selectedBuilding != null) {
                cubit.buildingIdController.text = selectedBuilding;
              }
            },
            suffixIcon: IconBroken.arrowDown2,
            keyboardType: TextInputType.text,
          ),
          verticalSpace(10),
          Text(
            S.of(context).floorName,
            style: TextStyles.font16BlackRegular,
          ),
          CustomTextFormField(
            controller: cubit.addFloorController,
            onlyRead: false,
            hint: '',
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
          ),
          verticalSpace(10),
          Text(
            S.of(context).floorNumber,
            style: TextStyles.font16BlackRegular,
          ),
          CustomTextFormField(
            controller: cubit.floorNumberController,
            onlyRead: false,
            hint: '',
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).floorNumberRequired;
              } else if (value.length > 30) {
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
            controller: cubit.floorDiscriptionController,
            hint: S.of(context).descriptionHint,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).descriptionRequired;
              } else if (value.length < 3) {
                return S.of(context).descriptionTooShort;
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
                  text: S.of(context).managers,
                  style: TextStyles.font16BlackRegular,
                ),
                TextSpan(
                  text: S.of(context).labelOptional,
                  style: TextStyles.font14GreyRegular,
                ),
              ],
            ),
          ),
          MultiDropdown<UserItem>(
            items: cubit.usersModel!.data!.users!
                    .where((user) => user.role == 'Manager')
                    .isEmpty
                ? [
                    DropdownItem(
                      label: S.of(context).noManagers,
                      value: UserItem(
                          id: null, userName: S.of(context).noManagers),
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
              hintText: S.of(context).selectManagers,
              suffixIcon: Icon(IconBroken.arrowDown2),
              hintStyle: TextStyle(fontSize: 12.sp, color: AppColor.thirdColor),
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
              selectedIcon: const Icon(Icons.check_box, color: Colors.blue),
            ),
            onSelectionChange: (selectedItems) {
              cubit.selectedManagersIds =
                  selectedItems.map((item) => (item).id!).toList();
            },
          ),
          verticalSpace(10),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: S.of(context).supervisors,
                  style: TextStyles.font16BlackRegular,
                ),
                TextSpan(
                  text: S.of(context).labelOptional,
                  style: TextStyles.font14GreyRegular,
                ),
              ],
            ),
          ),
          MultiDropdown<UserItem>(
            items: cubit.usersModel!.data!.users!
                    .where((user) => user.role == 'Supervisor')
                    .isEmpty
                ? [
                    DropdownItem(
                      label: S.of(context).noSupervisors,
                      value: UserItem(
                          id: null, userName: S.of(context).noSupervisors),
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
              hintText: S.of(context).selectSupervisors,
              suffixIcon: Icon(IconBroken.arrowDown2),
              hintStyle: TextStyle(fontSize: 12.sp, color: AppColor.thirdColor),
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
              selectedIcon: const Icon(Icons.check_box, color: Colors.blue),
            ),
            onSelectionChange: (selectedItems) {
              cubit.selectedSupervisorsIds =
                  selectedItems.map((item) => (item).id!).toList();
            },
          ),
          verticalSpace(10),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: S.of(context).cleaners,
                  style: TextStyles.font16BlackRegular,
                ),
                TextSpan(
                  text: S.of(context).labelOptional,
                  style: TextStyles.font14GreyRegular,
                ),
              ],
            ),
          ),
          MultiDropdown<UserItem>(
            items: cubit.usersModel!.data!.users!
                    .where((user) => user.role == 'Cleaner')
                    .isEmpty
                ? [
                    DropdownItem(
                      label: S.of(context).noCleaners,
                      value: UserItem(
                          id: null, userName: S.of(context).noCleaners),
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
              hintText: S.of(context).selectCleaners,
              suffixIcon: Icon(IconBroken.arrowDown2),
              hintStyle: TextStyle(fontSize: 12.sp, color: AppColor.thirdColor),
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
              selectedIcon: const Icon(Icons.check_box, color: Colors.blue),
            ),
            onSelectionChange: (selectedItems) {
              cubit.selectedCleanersIds =
                  selectedItems.map((item) => (item).id!).toList();
            },
          ),
          verticalSpace(10),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: S.of(context).shiftBody,
                  style: TextStyles.font16BlackRegular,
                ),
                TextSpan(
                  text: S.of(context).labelOptional,
                  style: TextStyles.font14GreyRegular,
                ),
              ],
            ),
          ),
          MultiDropdown<ShiftItem>(
            items: cubit.shiftModel?.data?.data?.isEmpty ?? true
                ? [
                    DropdownItem(
                      label: S.of(context).noShiftsAvailable,
                      value: ShiftItem(
                          id: null, name: S.of(context).noShiftsAvailable),
                    )
                  ]
                : cubit.shiftModel!.data!.data!
                    .map((shift) => DropdownItem(
                          label: shift.name!,
                          value: shift,
                        ))
                    .toList(),
            controller: cubit.shiftController,
            enabled: true,
            chipDecoration: ChipDecoration(
              backgroundColor: Colors.grey[300],
              wrap: true,
              runSpacing: 5,
              spacing: 5,
            ),
            fieldDecoration: FieldDecoration(
              hintText: S.of(context).selectShift,
              suffixIcon: Icon(IconBroken.arrowDown2),
              hintStyle: TextStyle(fontSize: 12.sp, color: AppColor.thirdColor),
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
              selectedIcon: const Icon(Icons.check_box, color: Colors.blue),
            ),
            onSelectionChange: (selectedItems) {
              cubit.selectedShiftsIds =
                  selectedItems.map((item) => (item).id!).toList();
            },
          ),
          verticalSpace(10),
        ]);
  }

  Widget _buildContinueButton(BuildContext context, AddWorkLocationCubit cubit,
      AddWorkLocationState state) {
    return state is CreateCityLoadingState
        ? Loading()
        : DefaultElevatedButton(
            name: S.of(context).addButton,
            onPressed: () {
              if (cubit.formAddKey.currentState!.validate()) {
                cubit.createFloor();
              }
            },
            color: AppColor.primaryColor,

            textStyles: TextStyles.font20Whitesemimedium,
          );
  }
}
