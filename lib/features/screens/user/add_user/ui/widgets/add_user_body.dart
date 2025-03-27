import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/regx_validations/regx_validations.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/auth/set_password/ui/widgets/password_validation.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/logic/add_user_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/logic/add_user_state.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/ui/widgets/add_provider_dialog.dart';
import 'package:smart_cleaning_application/features/screens/user/add_user/ui/widgets/add_user_text_form_field.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AddUserBody extends StatefulWidget {
  const AddUserBody({super.key});

  @override
  State<AddUserBody> createState() => _AddUserBodyState();
}

class _AddUserBodyState extends State<AddUserBody> {
  List<int> selectedShiftsIds = [];

  bool isShow = false;
  bool isObscureText = true;
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  @override
  void initState() {
    context.read<AddUserCubit>()
      ..getNationality()
      ..getRole()
      ..getProviders()
      ..getAllDeletedProviders();
    setupPasswordControllerListener();
    super.initState();
  }

  void setupPasswordControllerListener() {
    context.read<AddUserCubit>().passwordController.addListener(() {
      setState(() {
        hasLowercase = AppRegex.hasLowerCase(
            context.read<AddUserCubit>().passwordController.text);
        hasUppercase = AppRegex.hasUpperCase(
            context.read<AddUserCubit>().passwordController.text);
        hasSpecialCharacters = AppRegex.hasSpecialCharacter(
            context.read<AddUserCubit>().passwordController.text);
        hasNumber = AppRegex.hasNumber(
            context.read<AddUserCubit>().passwordController.text);
        hasMinLength = AppRegex.hasMinLength(
            context.read<AddUserCubit>().passwordController.text);
      });
    });
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (contextt) => Scaffold(
                                    appBar: AppBar(
                                      leading: customBackButton(context),
                                    ),
                                    body: Center(
                                      child: PhotoView(
                                        imageProvider: context
                                                    .read<AddUserCubit>()
                                                    .image
                                                    ?.path ==
                                                null
                                            ? AssetImage(
                                                'assets/images/noImage.png',
                                              )
                                            : FileImage(
                                                File(context
                                                    .read<AddUserCubit>()
                                                    .image!
                                                    .path),
                                              ),
                                        backgroundDecoration:
                                            const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 100.w,
                              height: 100.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColor.primaryColor,
                                  width: 2.w,
                                ),
                              ),
                              child: ClipOval(
                                child:
                                    context.read<AddUserCubit>().image?.path ==
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
                    verticalSpace(20),
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
                                  } else if (value.length > 55) {
                                    return 'First name too long';
                                  } else if (value.length < 3) {
                                    return 'First name too short';
                                  } else if (!RegExp(r"^[a-zA-Z\s]+$")
                                      .hasMatch(value)) {
                                    return 'Only letters';
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
                                  } else if (value.length > 55) {
                                    return 'Last name too long';
                                  } else if (value.length < 3) {
                                    return 'Last name too short';
                                  } else if (!RegExp(r"^[a-zA-Z\s]+$")
                                      .hasMatch(value)) {
                                    return 'Only letters';
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
                        } else if (value.length > 55) {
                          return 'User name too long';
                        } else if (value.length < 3) {
                          return 'User name too short';
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
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Enter valid email';
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
                        } else if (!RegExp(r'(^(?:[+0])?[0-9]{9}$)')
                            .hasMatch(value)) {
                          return 'Please enter valid mobile number';
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
                                    initialDate: DateTime.now()
                                        .subtract(Duration(days: 18 * 365)),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now()
                                        .subtract(Duration(days: 18 * 365)),
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
                                    return 'Birth Date is required';
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
                        } else if (value.length > 20) {
                          return 'ID Number too long';
                        } else if (value.length < 5) {
                          return 'ID Number too short';
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
                        onChanged: (value) {
                          if (value!.isNotEmpty) {
                            isShow = true;
                          } else {
                            isShow = false;
                          }
                        },
                        obscureText: context.read<AddUserCubit>().ispassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).validationAddPassword;
                          }
                          if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                              .hasMatch(value)) {
                            return S.of(context).validationPassword;
                          }
                        }),
                    verticalSpace(10),
                    if (isShow == true)
                      PasswordValidations(
                        hasLowerCase: hasLowercase,
                        hasUpperCase: hasUppercase,
                        hasSpecialCharacters: hasSpecialCharacters,
                        hasNumber: hasNumber,
                        hasMinLength: hasMinLength,
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
                        if (value! !=
                            context
                                .read<AddUserCubit>()
                                .passwordController
                                .text) {
                          return S.of(context).validationRepeatPassword;
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
                        } else {
                          managerId = selectedRole.id! - 1;
                        }
                        context.read<AddUserCubit>().getAllUsers(managerId);
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
                            .usersModel
                            ?.data?.users!
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
                                  .usersModel
                            ?.data?.users!
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
                                .usersModel
                            ?.data?.users!
                                  .map((e) => e.userName ?? 'Unknown')
                                  .toList() ??
                              [],
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
