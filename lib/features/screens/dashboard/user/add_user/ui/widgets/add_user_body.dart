import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/Change_password_validations/password_validation.dart';
import 'package:smart_cleaning_application/core/widgets/custom_multi_dropdown/custom_multi_dropdown.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/core/widgets/custom_drop_down_list/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/custom_text_form_field.dart';
import 'package:smart_cleaning_application/core/widgets/custom_phone_number/phone_number.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/integrations/data/models/shift_model.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/add_user/logic/add_user_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/add_user/logic/add_user_state.dart';
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
          title: Text(S.of(context).addUserTitle), leading: CustomBackButton()),
      body: BlocConsumer<AddUserCubit, AddUserState>(
        listener: (context, state) {
          if (state is AddUserSuccessState) {
            toast(text: state.userCreateModel.message!, isSuccess: true);
            context.popWithTrueResult();
          }
          if (state is AddUserErrorState) {
            toast(text: state.error, isSuccess: false);
          }
        },
        builder: (context, state) {
          if (cubit.nationalityListModel == null ||
              cubit.roleModel == null ||
              cubit.providersModel == null ||
              cubit.areaListModel == null) {
            return Loading();
          }
          return SingleChildScrollView(
            child: SafeArea(
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
                                        leading: CustomBackButton(),
                                      ),
                                      body: Center(
                                        child: PhotoView(
                                          imageProvider: cubit.image?.path ==
                                                  null
                                              ? const AssetImage(
                                                  'assets/images/person.png')
                                              : FileImage(
                                                      File(cubit.image!.path))
                                                  as ImageProvider,
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
                                width: 100.r,
                                height: 100.r,
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
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          File(cubit.image!.path),
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/images/person.png',
                                              fit: BoxFit.cover,
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
                                  width: 22.r,
                                  height: 22.r,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.primaryColor,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                    size: 16.sp,
                                  ),
                                ),
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
                                CustomTextFormField(
                                  controller: cubit.firstNameController,
                                  obscureText: false,
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
                                    return null;
                                  },
                                  onlyRead: false,
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
                                CustomTextFormField(
                                  controller: cubit.lastNameController,
                                  obscureText: false,
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
                                    return null;
                                  },
                                  onlyRead: false,
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
                      CustomTextFormField(
                        controller: cubit.userNameController,
                        obscureText: false,
                        onlyRead: false,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).validationUserName;
                          } else if (value.length > 55) {
                            return S.of(context).validationUserNameTooLong;
                          } else if (value.length < 3) {
                            return S.of(context).validationUserNameTooShort;
                          }
                          return null;
                        },
                      ),
                      verticalSpace(10),
                      Text(
                        S.of(context).addUserText3,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomTextFormField(
                        controller: cubit.emailController,
                        obscureText: false,
                        onlyRead: false,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).validationAddEmail;
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                              .hasMatch(value)) {
                            return S.of(context).validationValidEmail;
                          }
                          return null;
                        },
                      ),
                      verticalSpace(10),
                      Text(
                        S.of(context).addUserText10,
                        style: TextStyles.font16BlackRegular,
                      ),
                      PhoneInputField(
                        controller: cubit.phoneController,
                        onChanged: (value) {
                          cubit.fullPhoneNumber = value;
                        },
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
                                CustomTextFormField(
                                  controller: cubit.birthController,
                                  obscureText: false,
                                  onlyRead: true,
                                  suffixIcon: Icons.calendar_today,
                                  suffixPressed: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now()
                                          .subtract(Duration(days: 18 * 365)),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now()
                                          .subtract(Duration(days: 18 * 365)),
                                      builder: (BuildContext context,
                                          Widget? child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                              dialogTheme: const DialogThemeData(
            backgroundColor: Colors.white,
          ),
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
                                    return null;
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
                      CustomTextFormField(
                        controller: cubit.idNumberController,
                        obscureText: false,
                        onlyRead: false,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).validationIdNumber;
                          } else if (value.length > 20) {
                            return S.of(context).validationIdNumberTooLong;
                          } else if (value.length < 5) {
                            return S.of(context).validationIdNumberTooShort;
                          }
                          return null;
                        },
                      ),
                      verticalSpace(10),
                      Text(
                        S.of(context).addUserText6,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomTextFormField(
                        controller: cubit.passwordController,
                        onlyRead: false,
                        keyboardType: TextInputType.text,
                        suffixIcon: cubit.suffixIcon,
                        suffixPressed: () {
                          cubit.changeSuffixIconVisiability();
                        },
                        onChanged: (value) {
                          if (value.isNotEmpty) {
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
                          return null;
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
                      CustomTextFormField(
                        controller: cubit.passwordConfirmationController,
                        suffixIcon: cubit.suffixIcon,
                        suffixPressed: () {
                          cubit.changeSuffixIconVisiability();
                        },
                        obscureText: cubit.ispassword,
                        onlyRead: false,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value! != cubit.passwordController.text) {
                            return S.of(context).validationRepeatPassword;
                          }
                          return null;
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
                              ?.firstWhere(
                                  (role) => role.name == selectedValue);
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
                        items: cubit.roleDataItem
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
                              .firstWhere((manager) =>
                                  manager.userName == selectedValue)
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
                      CustomDropDownList(
                        hint: S.of(context).hintSelectProvider,
                        controller: cubit.providerController,
                        items: cubit.providerItem
                            .map((e) => e.name ?? 'Unknown')
                            .toList(),
                        onChanged: (selectedValue) {
                          final selectedId = cubit.providersModel?.data?.data
                              ?.firstWhere(
                                  (provider) => provider.name == selectedValue)
                              .id
                              ?.toString();

                          if (selectedId != null) {
                            cubit.providerIdController.text = selectedId;
                          }
                        },
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(10),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: S.of(context).workLocation,
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
                          onChanged: (value) async {
                            final selectedArea = cubit.areaListModel?.data?.data
                                ?.firstWhere((area) =>
                                    area.name == cubit.areaController.text);

                            if (selectedArea != null) {
                              cubit.areaIdController.text =
                                  selectedArea.id!.toString();
                              if (cubit.selectedLevel == 'Area') {
                                await cubit.getShifts();
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
                          items: cubit.cityItem.map((e) => e.name!).toList(),
                          onChanged: (value) {
                            final selectedCity = cubit.cityModel?.data?.data
                                ?.firstWhere((city) =>
                                    city.name == cubit.cityController.text);

                            if (selectedCity != null) {
                              cubit.cityIdController.text =
                                  selectedCity.id!.toString();
                              if (cubit.selectedLevel == 'City') {
                                cubit.getShifts();
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
                        CustomDropDownList(
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
                                    cubit.organizationController.text);

                            if (selectedOrganization != null) {
                              cubit.organizationIdController.text =
                                  selectedOrganization.id!.toString();

                              if (cubit.selectedLevel == 'Organization') {
                                cubit.getShifts();
                                cubit.selectedLocation = 2;
                              }
                            }

                            cubit.getBuilding();
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          keyboardType: TextInputType.text,
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
                                    bld.name == cubit.buildingController.text);

                            if (selectedBuilding != null) {
                              cubit.buildingIdController.text =
                                  selectedBuilding.id!.toString();
                              if (cubit.selectedLevel == 'Building') {
                                cubit.getShifts();
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
                            final selectedFloor = cubit.floorModel?.data?.data
                                ?.firstWhere((floor) =>
                                    floor.name == cubit.floorController.text);

                            if (selectedFloor != null) {
                              cubit.floorIdController.text =
                                  selectedFloor.id!.toString();
                              if (cubit.selectedLevel == 'Floor') {
                                cubit.getShifts();
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
                                cubit.getShifts();
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
                            final selectedPoint = cubit.pointModel?.data?.data
                                ?.firstWhere((point) =>
                                    point.name == cubit.pointController.text);

                            if (selectedPoint != null) {
                              cubit.pointIdController.text =
                                  selectedPoint.id!.toString();
                              if (cubit.selectedLevel == 'Point') {
                                cubit.getShifts();
                                cubit.selectedLocation = 6;
                              }
                            }
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                      ],
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
                      CustomMultiDropdown(
                        items: cubit.shiftModel?.data?.data?.isEmpty ?? true
                            ? [
                                DropdownItem(
                                  label: S.of(context).noShiftsAvailable,
                                  value: ShiftItem(
                                      id: null,
                                      name: S.of(context).noShiftsAvailable),
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
                          cubit.selectedShiftsIds =
                              selectedItems.map((item) => (item).id!).toList();
                        },
                        hint: S.of(context).selectShift,
                      ),
                      verticalSpace(20),
                      state is AddUserLoadingState
                          ? Loading()
                          : Center(
                              child: DefaultElevatedButton(
                                  name: S.of(context).saveButtton,
                                  onPressed: () {
                                    if (cubit.formKey.currentState!
                                        .validate()) {
                                      cubit.addUser(
                                          image: cubit.image?.path,
                                          phone: cubit.fullPhoneNumber);
                                    }
                                  },
                                  color: AppColor.primaryColor,
                                  textStyles: TextStyles.font20Whitesemimedium),
                            ),
                      verticalSpace(30),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
