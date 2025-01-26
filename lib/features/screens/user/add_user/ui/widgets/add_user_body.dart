import 'dart:io';

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
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/logic/add_user_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/logic/add_user_state.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/ui/widgets/add_provider_dialog.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/ui/widgets/add_user_text_form_field.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';
import '../../../../integrations/data/models/shift_model.dart';

class AddUserBody extends StatefulWidget {
  const AddUserBody({super.key});

  @override
  State<AddUserBody> createState() => _AddUserBodyState();
}

class _AddUserBodyState extends State<AddUserBody> {
  List<int> selectedShiftsIds = [];
  @override
  void initState() {
    context.read<AddUserCubit>()
      ..getNationality()
      ..getRole()
      ..getProviders()
      ..getAllDeletedProviders()
      ..getShifts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).addUserTitle,
        ),
        leading: customBackButton(context),
      ),
      body: BlocConsumer<AddUserCubit, AddUserState>(
        listener: (context, state) {
          if (state is AddUserSuccessState) {
            toast(text: state.userCreateModel.message!, color: Colors.blue);
            context.pushNamedAndRemoveLastTwo(Routes.userManagmentScreen);
          }
          if (state is AddUserErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is AddProviderSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.read<AddUserCubit>().getProviders();
          }
          if (state is AddProviderErrorState) {
            toast(text: state.error, color: Colors.red);
          }

          if (state is DeletedProviderSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.read<AddUserCubit>().getProviders();
            context.read<AddUserCubit>().getAllDeletedProviders();
          }
          if (state is DeletedProviderErrorState) {
            toast(text: state.error, color: Colors.red);
          }

          if (state is RestoreProviderSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.read<AddUserCubit>().getAllDeletedProviders();
            context.read<AddUserCubit>().getProviders();
          }
          if (state is RestoreProviderErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          return SafeArea(
              child: SingleChildScrollView(
            child: Form(
              key: context.read<AddUserCubit>().formKey,
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
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColor.primaryColor,
                                width: 3.w,
                              ),
                            ),
                            child: ClipOval(
                              child: context.read<AddUserCubit>().image?.path ==
                                      null
                                  ? Image.asset(
                                      'assets/images/noImage.png',
                                      fit: BoxFit.fill,
                                    )
                                  : Image.file(
                                      File(context
                                          .read<AddUserCubit>()
                                          .image!
                                          .path),
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/noImage.png',
                                          fit: BoxFit.fill,
                                        );
                                      },
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: 1,
                            right: 10,
                            child: InkWell(
                              onTap: () {
                                context.read<AddUserCubit>().galleryFile();
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).addUserText1,
                                style: TextStyles.font16BlackRegular,
                              ),
                              AddUserTextFormField(
                                controller: context
                                    .read<AddUserCubit>()
                                    .firstNameController,
                                obscureText: false,
                                readOnly: false,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).validationFirstName;
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        horizontalSpace(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).addUserText2,
                                style: TextStyles.font16BlackRegular,
                              ),
                              AddUserTextFormField(
                                controller: context
                                    .read<AddUserCubit>()
                                    .lastNameController,
                                obscureText: false,
                                readOnly: false,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).validationLastName;
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).addUserText5,
                      style: TextStyles.font16BlackRegular,
                    ),
                    AddUserTextFormField(
                      controller:
                          context.read<AddUserCubit>().userNameController,
                      obscureText: false,
                      readOnly: false,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).validationUserName;
                        }
                      },
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).addUserText3,
                      style: TextStyles.font16BlackRegular,
                    ),
                    AddUserTextFormField(
                      controller: context.read<AddUserCubit>().emailController,
                      obscureText: false,
                      readOnly: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).validationAddEmail;
                        }
                      },
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).addUserText10,
                      style: TextStyles.font16BlackRegular,
                    ),
                    AddUserTextFormField(
                      controller: context.read<AddUserCubit>().phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).validationPhoneNumber;
                        }
                        return null;
                      },
                      prefixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 13, 5, 13),
                        child: Text(
                          '+966 |',
                          style:
                              TextStyle(color: Colors.black, fontSize: 14.sp),
                        ),
                      ),
                      hint: '123456789',
                      obscureText: false,
                      readOnly: false,
                    ),
                    verticalSpace(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).addUserText12,
                                style: TextStyles.font16BlackRegular,
                              ),
                              CustomDropDownList(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).validationCountry;
                                  }
                                  return null;
                                },
                                hint: 'Select Country',
                                items: context
                                            .read<AddUserCubit>()
                                            .nationalityModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No countries']
                                    : context
                                            .read<AddUserCubit>()
                                            .nationalityModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller: context
                                    .read<AddUserCubit>()
                                    .countryController,
                                keyboardType: TextInputType.text,
                                suffixIcon: IconBroken.arrowDown2,
                              ),
                            ],
                          ),
                        ),
                        horizontalSpace(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).addUserText9,
                                style: TextStyles.font16BlackRegular,
                              ),
                              CustomDropDownList(
                                onPressed: (selectedValue) {
                                  final items = ['Male', 'Female'];
                                  final selectedIndex =
                                      items.indexOf(selectedValue);
                                  if (selectedIndex != -1) {
                                    context
                                        .read<AddUserCubit>()
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
                                hint: 'Gender',
                                items: ['Male', 'Female'],
                                controller: context
                                    .read<AddUserCubit>()
                                    .genderController,
                                keyboardType: TextInputType.text,
                                suffixIcon: IconBroken.arrowDown2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).addUserText8,
                                style: TextStyles.font16BlackRegular,
                              ),
                              CustomDropDownList(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).validationNationality;
                                  }
                                  return null;
                                },
                                hint: 'Select Nationality',
                                items: context
                                            .read<AddUserCubit>()
                                            .nationalityModel
                                            ?.data
                                            ?.isEmpty ??
                                        true
                                    ? ['No nationalities']
                                    : context
                                            .read<AddUserCubit>()
                                            .nationalityModel
                                            ?.data
                                            ?.map((e) => e.name ?? 'Unknown')
                                            .toList() ??
                                        [],
                                controller: context
                                    .read<AddUserCubit>()
                                    .nationalityController,
                                keyboardType: TextInputType.text,
                                suffixIcon: IconBroken.arrowDown2,
                              ),
                            ],
                          ),
                        ),
                        horizontalSpace(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).addUserText4,
                                style: TextStyles.font16BlackRegular,
                              ),
                              AddUserTextFormField(
                                controller: context
                                    .read<AddUserCubit>()
                                    .birthController,
                                obscureText: false,
                                readOnly: true,
                                suffixIcon: Icons.calendar_today,
                                suffixPressed: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(3025),
                                    builder:
                                        (BuildContext context, Widget? child) {
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
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                    setState(() {
                                      context
                                          .read<AddUserCubit>()
                                          .birthController
                                          .text = formattedDate;
                                    });
                                  }
                                },
                                keyboardType: TextInputType.none,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).validationBirthdate;
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).addUserText7,
                      style: TextStyles.font16BlackRegular,
                    ),
                    AddUserTextFormField(
                      controller:
                          context.read<AddUserCubit>().idNumberController,
                      obscureText: false,
                      readOnly: false,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).validationIdNumber;
                        }
                      },
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).addUserText6,
                      style: TextStyles.font16BlackRegular,
                    ),
                    AddUserTextFormField(
                      controller:
                          context.read<AddUserCubit>().passwordController,
                      readOnly: false,
                      keyboardType: TextInputType.text,
                      suffixIcon: context.read<AddUserCubit>().suffixIcon,
                      suffixPressed: () {
                        context
                            .read<AddUserCubit>()
                            .changeSuffixIconVisiability();
                      },
                      obscureText: context.read<AddUserCubit>().ispassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).validationAddPassword;
                        }
                      },
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).addUserText11,
                      style: TextStyles.font16BlackRegular,
                    ),
                    AddUserTextFormField(
                      controller: context
                          .read<AddUserCubit>()
                          .passwordConfirmationController,
                      suffixIcon: context.read<AddUserCubit>().suffixIcon,
                      suffixPressed: () {
                        context
                            .read<AddUserCubit>()
                            .changeSuffixIconVisiability();
                      },
                      obscureText: context.read<AddUserCubit>().ispassword,
                      readOnly: false,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S
                              .of(context)
                              .validationAddPasswordConfirmation;
                        }
                      },
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).addUserText13,
                      style: TextStyles.font16BlackRegular,
                    ),
                    CustomDropDownList(
                      onChanged: (selectedValue) {
                        final selectedRole = context
                            .read<AddUserCubit>()
                            .roleModel
                            ?.data
                            ?.firstWhere((role) => role.name == selectedValue);
                        context.read<AddUserCubit>().managerController.clear();
                        int? managerId;
                        if (selectedRole!.id! == 1) {
                          managerId = 1;
                        } else if (selectedRole.id! == 5) {
                          managerId = 1;
                        } else {
                          managerId = selectedRole.id! - 1;
                        }
                        context.read<AddUserCubit>().getRoleUser(managerId);
                      },
                      onPressed: (selectedValue) {
                        final selectedId = context
                            .read<AddUserCubit>()
                            .roleModel
                            ?.data
                            ?.firstWhere(
                              (role) => role.name == selectedValue,
                            )
                            .id
                            ?.toString();

                        if (selectedId != null) {
                          context.read<AddUserCubit>().roleIdController.text =
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
                      hint: 'Select Role',
                      items: context
                                  .read<AddUserCubit>()
                                  .roleModel
                                  ?.data
                                  ?.isEmpty ??
                              true
                          ? ['No roles available']
                          : context
                                  .read<AddUserCubit>()
                                  .roleModel
                                  ?.data
                                  ?.map((e) => e.name ?? 'Unknown')
                                  .toList() ??
                              [],
                      controller: context.read<AddUserCubit>().roleController,
                      keyboardType: TextInputType.text,
                      suffixIcon: IconBroken.arrowDown2,
                    ),
                    verticalSpace(10),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: (context
                                            .read<AddUserCubit>()
                                            .roleIdController
                                            .text ==
                                        '1' ||
                                    context
                                            .read<AddUserCubit>()
                                            .roleIdController
                                            .text ==
                                        '2' ||
                                    context
                                            .read<AddUserCubit>()
                                            .roleIdController
                                            .text ==
                                        '5')
                                ? 'Admin'
                                : (context
                                            .read<AddUserCubit>()
                                            .roleIdController
                                            .text ==
                                        '3')
                                    ? 'Manager'
                                    : (context
                                                .read<AddUserCubit>()
                                                .roleIdController
                                                .text ==
                                            '4')
                                        ? 'Supervisor'
                                        : 'Users',
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
                      onPressed: (selectedValue) {
                        final selectedId = context
                            .read<AddUserCubit>()
                            .roleUserModel
                            ?.data!
                            .firstWhere(
                                (manager) => manager.userName == selectedValue)
                            .id
                            ?.toString();

                        if (selectedId != null) {
                          context
                              .read<AddUserCubit>()
                              .managerIdController
                              .text = selectedId;
                        }
                      },
                      controller:
                          context.read<AddUserCubit>().managerController,
                      keyboardType: TextInputType.text,
                      suffixIcon: IconBroken.arrowDown2,
                      hint: (context
                                      .read<AddUserCubit>()
                                      .roleIdController
                                      .text ==
                                  '1' ||
                              context
                                      .read<AddUserCubit>()
                                      .roleIdController
                                      .text ==
                                  '2' ||
                              context
                                      .read<AddUserCubit>()
                                      .roleIdController
                                      .text ==
                                  '5')
                          ? 'Admin'
                          : (context
                                      .read<AddUserCubit>()
                                      .roleIdController
                                      .text ==
                                  '3')
                              ? 'Manager'
                              : (context
                                          .read<AddUserCubit>()
                                          .roleIdController
                                          .text ==
                                      '4')
                                  ? 'Supervisor'
                                  : 'Users',
                      items: context
                                  .read<AddUserCubit>()
                                  .roleUserModel
                                  ?.data!
                                  .isEmpty ??
                              true
                          ? [
                              if (context
                                          .read<AddUserCubit>()
                                          .roleIdController
                                          .text ==
                                      '1' ||
                                  context
                                          .read<AddUserCubit>()
                                          .roleIdController
                                          .text ==
                                      '2' ||
                                  context
                                          .read<AddUserCubit>()
                                          .roleIdController
                                          .text ==
                                      '5')
                                'No Admins available'
                              else if (context
                                      .read<AddUserCubit>()
                                      .roleIdController
                                      .text ==
                                  '3')
                                'No Managers available'
                              else if (context
                                      .read<AddUserCubit>()
                                      .roleIdController
                                      .text ==
                                  '4')
                                'No Supervisors available'
                              else
                                'No Users available'
                            ]
                          : context
                                  .read<AddUserCubit>()
                                  .roleUserModel
                                  ?.data!
                                  .map((e) => e.userName ?? 'Unknown')
                                  .toList() ??
                              [],
                    ),
                    verticalSpace(10),
                    context.read<AddUserCubit>().shiftModel?.data == null
                        ? SizedBox.shrink()
                        : RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Shift',
                                  style: TextStyles.font16BlackRegular,
                                ),
                                TextSpan(
                                  text: ' (Optional)',
                                  style: TextStyles.font14GreyRegular,
                                ),
                              ],
                            ),
                          ),
                    context.read<AddUserCubit>().shiftModel?.data == null
                        ? SizedBox.shrink()
                        : MultiDropdown<ShiftDetails>(
                            items: context
                                        .read<AddUserCubit>()
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
                                    .read<AddUserCubit>()
                                    .shiftModel!
                                    .data!
                                    .data!
                                    .map((shift) => DropdownItem(
                                          label: shift.name!,
                                          value: shift,
                                        ))
                                    .toList(),
                            controller:
                                context.read<AddUserCubit>().shiftController,
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
                              selectedShiftsIds = selectedItems
                                  .map((item) => (item).id!)
                                  .toList();
                            },
                          ),
                    verticalSpace(10),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: S.of(context).addUserText15,
                            style: TextStyles.font16BlackRegular,
                          ),
                          TextSpan(
                            text: ' (Optional)',
                            style: TextStyles.font14GreyRegular,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: CustomDropDownList(
                            hint: 'Select provider',
                            onPressed: (selectedValue) {
                              final selectedId = context
                                  .read<AddUserCubit>()
                                  .providersModel
                                  ?.data
                                  ?.data
                                  ?.firstWhere(
                                    (provider) =>
                                        provider.name == selectedValue,
                                  )
                                  .id
                                  ?.toString();

                              if (selectedId != null) {
                                context
                                    .read<AddUserCubit>()
                                    .providerIdController
                                    .text = selectedId;
                              }
                            },
                            items: context
                                        .read<AddUserCubit>()
                                        .providersModel
                                        ?.data
                                        ?.data
                                        ?.isEmpty ??
                                    true
                                ? ['No Providers available']
                                : context
                                        .read<AddUserCubit>()
                                        .providersModel
                                        ?.data
                                        ?.data
                                        ?.map((e) => e.name ?? 'Unknown')
                                        .toList() ??
                                    [],
                            controller:
                                context.read<AddUserCubit>().providerController,
                            keyboardType: TextInputType.text,
                            suffixIcon: IconBroken.arrowDown2,
                          ),
                        ),
                        horizontalSpace(10),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              AddProviderBottomDialog().showBottomDialog(
                                  context, context.read<AddUserCubit>());
                            },
                            child: Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Icon(
                                Icons.settings,
                                color: Colors.white,
                                size: 25.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(20),
                    state is AddUserLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                                color: AppColor.primaryColor),
                          )
                        : Center(
                            child: DefaultElevatedButton(
                                name: S.of(context).saveButtton,
                                onPressed: () {
                                  if (context
                                      .read<AddUserCubit>()
                                      .formKey
                                      .currentState!
                                      .validate()) {
                                    context.read<AddUserCubit>().addUser(
                                        image: context
                                            .read<AddUserCubit>()
                                            .image
                                            ?.path,
                                        selectedShiftsIds: selectedShiftsIds);
                                  }
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
            ),
          ));
        },
      ),
    );
  }
}
