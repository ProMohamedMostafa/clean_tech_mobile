import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/user/edit_user/logic/edit_user_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/edit_user/logic/edit_user_state.dart';
import 'package:smart_cleaning_application/features/screens/user/edit_user/ui/widgets/edit_user_text_form_field/edit_user_text_form_field.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

import '../../../../../../core/widgets/default_toast/default_toast.dart';

class EditUserBody extends StatefulWidget {
  final int id;
  const EditUserBody({super.key, required this.id});

  @override
  State<EditUserBody> createState() => _EditUserBodyState();
}

class _EditUserBodyState extends State<EditUserBody> {
  List<int> selectedShiftsIds = [];

  @override
  void initState() {
    context.read<EditUserCubit>().getUserDetailsInEdit(widget.id);
    context.read<EditUserCubit>().getUserShiftDetails(widget.id);
    context.read<EditUserCubit>().getRoleUser(2);
    context.read<EditUserCubit>()
      ..getNationality()
      ..getRole()
      ..getProviders()
      ..getShifts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).editUserTitle,
          style: TextStyles.font16BlackSemiBold,
        ),
        centerTitle: true,
        leading: customBackButton(context),
      ),
      body: BlocConsumer<EditUserCubit, EditUserState>(
          listener: (context, state) {
        if (state is EditUserSuccessState) {
          toast(text: state.editModel.message!, color: Colors.blue);
          context.pushNamedAndRemoveLastTwo(Routes.userManagmentScreen);
        }
        if (state is EditUserErrorState) {
          toast(text: state.error, color: Colors.red);
        }
      }, builder: (context, state) {
        if (context.read<EditUserCubit>().userDetailsModel?.data! == null) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColor.primaryColor,
            ),
          );
        }
        return SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 100.w,
                        height: 100.h,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColor.primaryColor,
                            width: 3.w,
                          ),
                        ),
                        // child:
                        // ClipOval(
                        //   child: context
                        //               .read<EditUserCubit>()
                        //               .userDetailsModel
                        //               ?.data!
                        //               .image !=
                        //           null
                        //       ? Image.network(
                        //           context
                        //               .read<EditUserCubit>()
                        //               .userDetailsModel!
                        //               .data!
                        //               .image!,
                        //           fit: BoxFit.fill,
                        //         )
                        //       : Image.file(
                        //           File(context
                        //               .read<EditUserCubit>()
                        //               .image!
                        //               .path),
                        //           fit: BoxFit.fill,
                        //           errorBuilder: (context, error, stackTrace) {
                        //             return Image.asset(
                        //               'assets/images/noImage.png',
                        //               fit: BoxFit.fill,
                        //             );
                        //           },
                        //         ),
                        // ),
                      ),
                      Positioned(
                        bottom: 1,
                        right: 10,
                        child: InkWell(
                          onTap: () {
                            context.read<EditUserCubit>().galleryFile();
                          },
                          child: Container(
                              width: 22.w,
                              height: 22.h,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.primaryColor),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: 20.sp,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                verticalSpace(35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: EditUserTextField(
                        controller:
                            context.read<EditUserCubit>().firstNameController,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        label: S.of(context).addUserText1,
                        hint: context
                            .read<EditUserCubit>()
                            .userDetailsModel!
                            .data!
                            .firstName!,
                      ),
                    ),
                    horizontalSpace(10),
                    Expanded(
                      child: EditUserTextField(
                        controller:
                            context.read<EditUserCubit>().lastNameController,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        label: S.of(context).addUserText2,
                        hint: context
                            .read<EditUserCubit>()
                            .userDetailsModel!
                            .data!
                            .lastName!,
                      ),
                    ),
                  ],
                ),
                verticalSpace(15),
                EditUserTextField(
                  controller: context.read<EditUserCubit>().userNameController,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  label: S.of(context).addUserText5,
                  hint: context
                      .read<EditUserCubit>()
                      .userDetailsModel!
                      .data!
                      .userName!,
                ),
                verticalSpace(15),
                EditUserTextField(
                  controller: context.read<EditUserCubit>().emailController,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  label: S.of(context).addUserText3,
                  hint: context
                      .read<EditUserCubit>()
                      .userDetailsModel!
                      .data!
                      .email!,
                ),
                verticalSpace(15),
                EditUserTextField(
                  controller: context.read<EditUserCubit>().phoneController,
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                  label: S.of(context).addUserText10,
                  hint: context
                      .read<EditUserCubit>()
                      .userDetailsModel!
                      .data!
                      .phoneNumber!,
                ),
                verticalSpace(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomDropDownList(
                        label: 'Country',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).validationCountry;
                          }
                          return null;
                        },
                        hint: context
                            .read<EditUserCubit>()
                            .userDetailsModel!
                            .data!
                            .countryName!,
                        items: context
                                    .read<EditUserCubit>()
                                    .nationalityModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No countries']
                            : context
                                    .read<EditUserCubit>()
                                    .nationalityModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        controller:
                            context.read<EditUserCubit>().countryController,
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),

                      // EditDropdownList(
                      //     title: 'Country',
                      //     index: context
                      //         .read<EditUserCubit>()
                      //         .userDetailsModel!
                      //         .data!
                      //         .countryName!,
                      //     items: context
                      //                 .read<EditUserCubit>()
                      //                 .nationalityModel
                      //                 ?.data
                      //                 ?.isEmpty ??
                      //             true
                      //         ? ['No countries']
                      //         : context
                      //                 .read<EditUserCubit>()
                      //                 .nationalityModel
                      //                 ?.data
                      //                 ?.map((e) => e.name ?? 'Unknown')
                      //                 .toList() ??
                      //             [],
                      //     onPressed: (value) {
                      //       context
                      //           .read<EditUserCubit>()
                      //           .countryController
                      //           .text = value;
                      //     }),
                    ),
                    horizontalSpace(10),
                    Expanded(
                      child: CustomDropDownList(
                        label: 'Gender',
                        onPressed: (selectedValue) {
                          final items = ['Male', 'Female'];
                          final selectedIndex = items.indexOf(selectedValue);
                          if (selectedIndex != -1) {
                            context
                                .read<EditUserCubit>()
                                .genderIdController
                                .text = selectedIndex.toString();
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).validationGender;
                          }
                          return null;
                        },
                        hint: context
                            .read<EditUserCubit>()
                            .userDetailsModel!
                            .data!
                            .gender!,
                        items: ['Male', 'Female'],
                        controller:
                            context.read<EditUserCubit>().genderController,
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                    ),
                  ],
                ),
                verticalSpace(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomDropDownList(
                        label: 'Nationality',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).validationNationality;
                          }
                          return null;
                        },
                        hint: context
                            .read<EditUserCubit>()
                            .userDetailsModel!
                            .data!
                            .nationalityName!,
                        items: context
                                    .read<EditUserCubit>()
                                    .nationalityModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No nationalities']
                            : context
                                    .read<EditUserCubit>()
                                    .nationalityModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        controller:
                            context.read<EditUserCubit>().nationalityController,
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                    ),
                    horizontalSpace(15),
                    Expanded(
                      child: EditUserTextField(
                        controller:
                            context.read<EditUserCubit>().birthController,
                        obscureText: false,
                        suffixIcon: Icons.calendar_today,
                        suffixPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(3025),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  dialogBackgroundColor: Colors.white,
                                  colorScheme: ColorScheme.light(
                                    primary: AppColor.primaryColor,
                                    onPrimary: Colors.white,
                                    onSurface: Colors.black,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              context
                                  .read<EditUserCubit>()
                                  .birthController
                                  .text = formattedDate;
                            });
                          }
                        },
                        keyboardType: TextInputType.none,
                        label: S.of(context).addUserText4,
                        hint: context
                            .read<EditUserCubit>()
                            .userDetailsModel!
                            .data!
                            .birthdate!,
                      ),
                    ),
                  ],
                ),
                verticalSpace(15),
                EditUserTextField(
                  controller: context.read<EditUserCubit>().idNumberController,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  label: S.of(context).addUserText7,
                  hint: context
                      .read<EditUserCubit>()
                      .userDetailsModel!
                      .data!
                      .idNumber!,
                ),
                verticalSpace(15),
                CustomDropDownList(
                  label: S.of(context).addUserText13,
                  onChanged: (selectedValue) {
                    final selectedRole = context
                        .read<EditUserCubit>()
                        .roleModel
                        ?.data
                        ?.firstWhere((role) => role.name == selectedValue);
                    context.read<EditUserCubit>().managerController.clear();
                    int? managerId;
                    if (selectedRole!.id! == 1) {
                      managerId = 1;
                    } else if (selectedRole.id! == 5) {
                      managerId = 1;
                    } else {
                      managerId = selectedRole.id! - 1;
                    }
                    context.read<EditUserCubit>().getRoleUser(managerId);
                  },
                  onPressed: (selectedValue) {
                    final selectedId = context
                        .read<EditUserCubit>()
                        .roleModel
                        ?.data
                        ?.firstWhere(
                          (role) => role.name == selectedValue,
                        )
                        .id
                        ?.toString();

                    if (selectedId != null) {
                      context.read<EditUserCubit>().roleIdController.text =
                          selectedId;
                    }
                  },
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value == 'No roles available') {
                      return S.of(context).validationRole;
                    }
                    return null;
                  },
                  hint: context
                      .read<EditUserCubit>()
                      .userDetailsModel!
                      .data!
                      .role!,
                  items:
                      context.read<EditUserCubit>().roleModel?.data?.isEmpty ??
                              true
                          ? ['No roles available']
                          : context
                                  .read<EditUserCubit>()
                                  .roleModel
                                  ?.data
                                  ?.map((e) => e.name ?? 'Unknown')
                                  .toList() ??
                              [],
                  controller: context.read<EditUserCubit>().roleController,
                  keyboardType: TextInputType.text,
                  suffixIcon: IconBroken.arrowDown2,
                ),
                verticalSpace(15),
                CustomDropDownList(
                  label: (context
                                  .read<EditUserCubit>()
                                  .roleIdController
                                  .text ==
                              '1' ||
                          context.read<EditUserCubit>().roleIdController.text ==
                              '2' ||
                          context.read<EditUserCubit>().roleIdController.text ==
                              '5')
                      ? 'Admin'
                      : (context.read<EditUserCubit>().roleIdController.text ==
                              '3')
                          ? 'Manager'
                          : (context
                                      .read<EditUserCubit>()
                                      .roleIdController
                                      .text ==
                                  '4')
                              ? 'Supervisor'
                              : context
                                  .read<EditUserCubit>()
                                  .userDetailsModel!
                                  .data!
                                  .managerName!,
                  onPressed: (selectedValue) {
                    final selectedId = context
                        .read<EditUserCubit>()
                        .roleUserModel
                        ?.data!
                        .firstWhere(
                            (manager) => manager.userName == selectedValue)
                        .id
                        ?.toString();

                    if (selectedId != null) {
                      context.read<EditUserCubit>().managerIdController.text =
                          selectedId;
                    }
                  },
                  controller: context.read<EditUserCubit>().managerController,
                  keyboardType: TextInputType.text,
                  suffixIcon: IconBroken.arrowDown2,
                  hint: (context.read<EditUserCubit>().roleIdController.text ==
                              '1' ||
                          context.read<EditUserCubit>().roleIdController.text ==
                              '2' ||
                          context.read<EditUserCubit>().roleIdController.text ==
                              '5')
                      ? 'Admin'
                      : (context.read<EditUserCubit>().roleIdController.text ==
                              '3')
                          ? 'Manager'
                          : (context
                                      .read<EditUserCubit>()
                                      .roleIdController
                                      .text ==
                                  '4')
                              ? 'Supervisor'
                              : context
                                  .read<EditUserCubit>()
                                  .userDetailsModel!
                                  .data!
                                  .managerName!,
                  items: context
                              .read<EditUserCubit>()
                              .roleUserModel
                              ?.data!
                              .isEmpty ??
                          true
                      ? [
                          if (context
                                      .read<EditUserCubit>()
                                      .roleIdController
                                      .text ==
                                  '1' ||
                              context
                                      .read<EditUserCubit>()
                                      .roleIdController
                                      .text ==
                                  '2' ||
                              context
                                      .read<EditUserCubit>()
                                      .roleIdController
                                      .text ==
                                  '5')
                            'No Admins available'
                          else if (context
                                  .read<EditUserCubit>()
                                  .roleIdController
                                  .text ==
                              '3')
                            'No Managers available'
                          else if (context
                                  .read<EditUserCubit>()
                                  .roleIdController
                                  .text ==
                              '4')
                            'No Supervisors available'
                          else
                            'No Users available'
                        ]
                      : context
                              .read<EditUserCubit>()
                              .roleUserModel
                              ?.data!
                              .map((e) => e.userName ?? 'Unknown')
                              .toList() ??
                          [],
                ),
                verticalSpace(15),
                context.read<EditUserCubit>().shiftModel?.data == null
                    ? SizedBox.shrink()
                    : Stack(
                        clipBehavior: Clip.none,
                        children: [
                          MultiDropdown<ShiftDetails>(
                            items: context
                                        .read<EditUserCubit>()
                                        .shiftModel
                                        ?.data
                                        ?.data
                                        ?.isEmpty ??
                                    true
                                ? [
                                    DropdownItem(
                                      label: 'No shifts available',
                                      value: ShiftDetails(
                                          id: null,
                                          name: 'No shifts available'),
                                    )
                                  ]
                                : context
                                    .read<EditUserCubit>()
                                    .shiftModel!
                                    .data!
                                    .data!
                                    .map((shift) => DropdownItem(
                                          label: shift.name!,
                                          value: shift,
                                        ))
                                    .toList(),
                            controller:
                                context.read<EditUserCubit>().shiftController,
                            enabled: true,
                            chipDecoration: ChipDecoration(
                              backgroundColor: Colors.grey[300],
                              wrap: true,
                              runSpacing: 5,
                              spacing: 5,
                            ),
                            fieldDecoration: FieldDecoration(
                              hintText: context
                                  .read<EditUserCubit>()
                                  .userShiftDetailsModel!
                                  .data!
                                  .shifts!
                                  .map((shift) => shift.name)
                                  .join(', '),
                              suffixIcon: Icon(IconBroken.arrowDown2),
                              hintStyle: TextStyle(
                                  fontSize: 12.sp, color: AppColor.thirdColor),
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
                              // Update selected shifts IDs
                              selectedShiftsIds = selectedItems
                                  .map((item) => (item).id!)
                                  .toList();
                            },
                          ),
                          Positioned(
                            top: -7,
                            left: 9,
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                'Shifts',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                verticalSpace(15),
                CustomDropDownList(
                  label: S.of(context).addUserText15,
                  hint: context
                          .read<EditUserCubit>()
                          .userDetailsModel!
                          .data!
                          .providerName ??
                      '',
                  onPressed: (selectedValue) {
                    final selectedId = context
                        .read<EditUserCubit>()
                        .providersModel
                        ?.data
                        ?.data
                        ?.firstWhere(
                          (provider) => provider.name == selectedValue,
                        )
                        .id
                        ?.toString();

                    if (selectedId != null) {
                      context.read<EditUserCubit>().providerIdController.text =
                          selectedId;
                    }
                  },
                  items: context
                              .read<EditUserCubit>()
                              .providersModel
                              ?.data
                              ?.data
                              ?.isEmpty ??
                          true
                      ? ['No Providers available']
                      : context
                              .read<EditUserCubit>()
                              .providersModel
                              ?.data
                              ?.data
                              ?.map((e) => e.name ?? 'Unknown')
                              .toList() ??
                          [],
                  controller: context.read<EditUserCubit>().providerController,
                  keyboardType: TextInputType.text,
                  suffixIcon: IconBroken.arrowDown2,
                ),
                verticalSpace(20),
                state is EditUserLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: AppColor.primaryColor),
                      )
                    : Center(
                        child: DefaultElevatedButton(
                            name: S.of(context).saveButtton,
                            onPressed: () {
                              showCustomDialog(context,
                                  "Are you Sure you want save the edit of this user ?",
                                  () {
                                context.read<EditUserCubit>().editUser(
                                    widget.id,
                                    context.read<EditUserCubit>().image?.path,
                                    selectedShiftsIds);
                                context.pop();
                              });
                            },
                            color: AppColor.primaryColor,
                            height: 47,
                            width: double.infinity,
                            textStyles: TextStyles.font20Whitesemimedium),
                      ),
                verticalSpace(30),
              ],
            ),
          ),
        ));
      }),
    );
  }
}
