import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
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
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddUserCubit>();
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
            cubit.getProviders();
          }
          if (state is AddProviderErrorState) {
            toast(text: state.error, color: Colors.red);
          }

          if (state is DeletedProviderSuccessState) {
            toast(text: state.message, color: Colors.blue);
            cubit.getProviders();
            cubit.getAllDeletedProviders();
          }
          if (state is DeletedProviderErrorState) {
            toast(text: state.error, color: Colors.red);
          }

          if (state is RestoreProviderSuccessState) {
            toast(text: state.message, color: Colors.blue);
            cubit.getAllDeletedProviders();
            cubit.getProviders();
          }
          if (state is RestoreProviderErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: cubit.formKey,
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
                                        imageProvider: cubit.image?.path == null
                                            ? AssetImage(
                                                'assets/images/person.png',
                                              )
                                            : FileImage(
                                                File(cubit.image!.path),
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
                                child: cubit.image?.path == null
                                    ? Image.asset(
                                        'assets/images/person.png',
                                        fit: BoxFit.fill,
                                      )
                                    : Image.file(
                                        File(cubit.image!.path),
                                        fit: BoxFit.fill,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            'assets/images/person.png',
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
                                cubit.galleryFile();
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
                                controller: cubit.firstNameController,
                                obscureText: false,
                                readOnly: false,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).validationFirstName;
                                  } else if (value.length > 55) {
                                    return S
                                        .of(context)
                                        .validationFirstNameTooLong;
                                  } else if (value.length < 3) {
                                    return S
                                        .of(context)
                                        .validationFirstNameTooShort;
                                  } else if (!RegExp(r"^[a-zA-Z\s]+$")
                                      .hasMatch(value)) {
                                    return S
                                        .of(context)
                                        .validationFirstNameOnlyLetters;
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
                                controller: cubit.lastNameController,
                                obscureText: false,
                                readOnly: false,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).validationLastName;
                                  } else if (value.length > 55) {
                                    return S
                                        .of(context)
                                        .validationLastNameTooLong;
                                  } else if (value.length < 3) {
                                    return S
                                        .of(context)
                                        .validationLastNameTooShort;
                                  } else if (!RegExp(r"^[a-zA-Z\s]+$")
                                      .hasMatch(value)) {
                                    return S
                                        .of(context)
                                        .validationLastNameOnlyLetters;
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
                      controller: cubit.userNameController,
                      obscureText: false,
                      readOnly: false,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).validationUserName;
                        } else if (value.length > 55) {
                          return S.of(context).validationUserNameTooLong;
                        } else if (value.length < 3) {
                          return S.of(context).validationUserNameTooShort;
                        }
                      },
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).addUserText3,
                      style: TextStyles.font16BlackRegular,
                    ),
                    AddUserTextFormField(
                      controller: cubit.emailController,
                      obscureText: false,
                      readOnly: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).validationAddEmail;
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return S.of(context).validationValidEmail;
                        }
                      },
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).addUserText10,
                      style: TextStyles.font16BlackRegular,
                    ),
                    AddUserTextFormField(
                      controller: cubit.phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).validationPhoneNumber;
                        } else if (!RegExp(r'(^(?:[+0])?[0-9]{9}$)')
                            .hasMatch(value)) {
                          return S.of(context).validationValidMobileNumber;
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
                      hint: S.of(context).hintPhoneNumber,
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
                                hint: S.of(context).hintSelectCountry,
                                controller: cubit.countryController,
                                items: cubit.countryData
                                    .map((e) => e.name)
                                    .toList(),
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text,
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
                                  final items = [
                                    S.of(context).genderMale,
                                    S.of(context).genderFemale
                                  ];
                                  final selectedIndex =
                                      items.indexOf(selectedValue);
                                  if (selectedIndex != -1) {
                                    cubit.genderIdController.text =
                                        selectedIndex.toString();
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).validationGender;
                                  }
                                  return null;
                                },
                                hint: S.of(context).hintSelectGender,
                                items: [
                                  S.of(context).genderMale,
                                  S.of(context).genderFemale
                                ],
                                controller: cubit.genderController,
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
                                hint: S.of(context).hintSelectNationality,
                                controller: cubit.nationalityController,
                                items: cubit.nationalityData
                                    .map((e) => e.name ?? 'un known')
                                    .toList(),
                                suffixIcon: IconBroken.arrowDown2,
                                keyboardType: TextInputType.text,
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
                                controller: cubit.birthController,
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
                                      cubit.birthController.text =
                                          formattedDate;
                                    });
                                  }
                                },
                                keyboardType: TextInputType.none,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S
                                        .of(context)
                                        .validationBirthDateRequired;
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
                      controller: cubit.idNumberController,
                      obscureText: false,
                      readOnly: false,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).validationIdNumber;
                        } else if (value.length > 20) {
                          return S.of(context).validationIdNumberTooLong;
                        } else if (value.length < 5) {
                          return S.of(context).validationIdNumberTooShort;
                        }
                      },
                    ),
                    verticalSpace(10),
                    Text(
                      S.of(context).addUserText6,
                      style: TextStyles.font16BlackRegular,
                    ),
                    AddUserTextFormField(
                      controller: cubit.passwordController,
                      readOnly: false,
                      keyboardType: TextInputType.text,
                      suffixIcon: cubit.suffixIcon,
                      suffixPressed: () {
                        cubit.changeSuffixIconVisiability();
                      },
                      onChanged: (value) {
                        if (value!.isNotEmpty) {
                          cubit.isShow = true;
                        } else {
                          cubit.isShow = false;
                        }
                        cubit.validatePassword(value);
                      },
                      obscureText: cubit.ispassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).validationAddPassword;
                        }
                        if (!RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                            .hasMatch(value)) {
                          return S.of(context).validationPassword;
                        }
                      },
                    ),
                    if (cubit.isShow == true) ...[
                      PasswordValidations(
                        hasLowerCase: cubit.hasLowercase,
                        hasUpperCase: cubit.hasUppercase,
                        hasSpecialCharacters: cubit.hasSpecialCharacters,
                        hasNumber: cubit.hasNumber,
                        hasMinLength: cubit.hasMinLength,
                      ),
                      verticalSpace(10)
                    ],
                    verticalSpace(10),
                    Text(
                      S.of(context).addUserText11,
                      style: TextStyles.font16BlackRegular,
                    ),
                    AddUserTextFormField(
                      controller: cubit.passwordConfirmationController,
                      suffixIcon: cubit.suffixIcon,
                      suffixPressed: () {
                        cubit.changeSuffixIconVisiability();
                      },
                      obscureText: cubit.ispassword,
                      readOnly: false,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value! != cubit.passwordController.text) {
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
                        final selectedRole = cubit.roleModel?.data
                            ?.firstWhere((role) => role.name == selectedValue);
                        cubit.managerController.clear();
                        int? managerId;
                        if (selectedRole!.id! == 1) {
                          managerId = 1;
                        } else {
                          managerId = selectedRole.id! - 1;
                        }
                        cubit.getAllUsers(managerId);
                      },
                      onPressed: (selectedValue) {
                        final selectedId = cubit.roleModel?.data
                            ?.firstWhere(
                              (role) => role.name == selectedValue,
                            )
                            .id
                            ?.toString();

                        if (selectedId != null) {
                          cubit.roleIdController.text = selectedId;
                        }
                      },
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value == S.of(context).noRolesAvailable) {
                          return S.of(context).validationRole;
                        }
                        return null;
                      },
                      hint: S.of(context).hintSelectRole,
                      items: cubit.providerItem
                          .map((e) => e.name ?? 'Unknown')
                          .toList(),
                      controller: cubit.roleController,
                      keyboardType: TextInputType.text,
                      suffixIcon: IconBroken.arrowDown2,
                    ),
                    verticalSpace(10),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: (cubit.roleIdController.text == '1' ||
                                    cubit.roleIdController.text == '2' ||
                                    cubit.roleIdController.text == '5')
                                ? S.of(context).roleAdmin
                                : (cubit.roleIdController.text == '3')
                                    ? S.of(context).roleManager
                                    : (cubit.roleIdController.text == '4')
                                        ? S.of(context).roleSupervisor
                                        : S.of(context).roleUsers,
                            style: TextStyles.font16BlackRegular,
                          ),
                          TextSpan(
                            text: S.of(context).labelOptional,
                            style: TextStyles.font14GreyRegular,
                          ),
                        ],
                      ),
                    ),
                    CustomDropDownList(
                      onPressed: (selectedValue) {
                        final selectedId = cubit.usersModel?.data?.users!
                            .firstWhere(
                                (manager) => manager.userName == selectedValue)
                            .id
                            ?.toString();

                        if (selectedId != null) {
                          cubit.managerIdController.text = selectedId;
                        }
                      },
                      controller: cubit.managerController,
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
                      items: cubit.usersModel?.data?.users!.isEmpty ?? true
                          ? [
                              if (cubit.roleIdController.text == '1' ||
                                  cubit.roleIdController.text == '2' ||
                                  cubit.roleIdController.text == '5')
                                S.of(context).noAdminsAvailable
                              else if (cubit.roleIdController.text == '3')
                                S.of(context).noManagersAvailable
                              else if (cubit.roleIdController.text == '4')
                                S.of(context).noSupervisorsAvailable
                              else
                                S.of(context).noUsersAvailable
                            ]
                          : cubit.usersModel?.data?.users!
                                  .map((e) =>
                                      e.userName ?? S.of(context).roleUsers)
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
                            text: S.of(context).labelOptional,
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
                            hint: S.of(context).hintSelectProvider,
                            controller: cubit.providerController,
                            items: cubit.providerItem
                                .map((e) => e.name ?? 'Unknown')
                                .toList(),
                            onChanged: (selectedValue) {
                              final selectedId = cubit
                                  .providersModel?.data?.providers
                                  ?.firstWhere((provider) =>
                                      provider.name == selectedValue)
                                  .id
                                  ?.toString();

                              if (selectedId != null) {
                                cubit.providerIdController.text = selectedId;
                              }
                            },
                            keyboardType: TextInputType.text,
                            suffixIcon: IconBroken.arrowDown2,
                          ),
                        ),
                        horizontalSpace(10),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              AddProviderBottomDialog()
                                  .showBottomDialog(context, cubit);
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
                                  if (cubit.formKey.currentState!.validate()) {
                                    cubit.addUser(
                                        image: cubit.image?.path,
                                        selectedShiftsIds:
                                            cubit.selectedShiftsIds);
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
          );
        },
      ),
    );
  }
}
