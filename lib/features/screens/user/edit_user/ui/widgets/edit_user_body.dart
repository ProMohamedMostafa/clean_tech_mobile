import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/regx_validations/regx_validations.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/auth/set_password/ui/widgets/password_validation.dart';
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
  bool isShow = false;
  bool isObscureText = true;
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;
  @override
  void initState() {
    context.read<EditUserCubit>().getUserDetailsInEdit(widget.id);
    context.read<EditUserCubit>().getUserShiftDetails(widget.id);
    context.read<EditUserCubit>().getAllUsers(widget.id);
    context.read<EditUserCubit>()
      ..getNationality()
      ..getRole()
      ..getProviders();
    setupPasswordControllerListener();
    super.initState();
  }

  void setupPasswordControllerListener() {
    context.read<EditUserCubit>().passwordController.addListener(() {
      setState(() {
        hasLowercase = AppRegex.hasLowerCase(
            context.read<EditUserCubit>().passwordController.text);
        hasUppercase = AppRegex.hasUpperCase(
            context.read<EditUserCubit>().passwordController.text);
        hasSpecialCharacters = AppRegex.hasSpecialCharacter(
            context.read<EditUserCubit>().passwordController.text);
        hasNumber = AppRegex.hasNumber(
            context.read<EditUserCubit>().passwordController.text);
        hasMinLength = AppRegex.hasMinLength(
            context.read<EditUserCubit>().passwordController.text);
      });
    });
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
            child: Form(
              key: context.read<EditUserCubit>().formKey,
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
                                      imageProvider: (context
                                                      .read<EditUserCubit>()
                                                      .image !=
                                                  null &&
                                              context
                                                  .read<EditUserCubit>()
                                                  .image!
                                                  .path
                                                  .isNotEmpty)
                                          ? FileImage(
                                              File(context
                                                  .read<EditUserCubit>()
                                                  .image!
                                                  .path),
                                            )
                                          : NetworkImage(
                                              '${ApiConstants.apiBaseUrlImage}${context.read<EditUserCubit>().userDetailsModel!.data!.image}',
                                            ),
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/person.png',
                                          fit: BoxFit.fill,
                                        );
                                      },
                                      backgroundDecoration: const BoxDecoration(
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
                              child: (context.read<EditUserCubit>().image !=
                                          null &&
                                      context
                                          .read<EditUserCubit>()
                                          .image!
                                          .path
                                          .isNotEmpty)
                                  ? Image.file(
                                      File(context
                                          .read<EditUserCubit>()
                                          .image!
                                          .path),
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/person.png',
                                          fit: BoxFit.fill,
                                        );
                                      },
                                    )
                                  : Image.network(
                                      '${ApiConstants.apiBaseUrlImage}${context.read<EditUserCubit>().userDetailsModel!.data!.image}',
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
                              context.read<EditUserCubit>().firstNameController
                                ..text = context
                                    .read<EditUserCubit>()
                                    .userDetailsModel!
                                    .data!
                                    .firstName!,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          label: S.of(context).addUserText1,
                          validator: (value) {
                            if (value!.length > 55) {
                              return 'First name too long';
                            } else if (value.length < 3) {
                              return 'First name too short';
                            } else if (!RegExp(r"^[a-zA-Z\s]+$")
                                .hasMatch(value)) {
                              return 'Only letters';
                            }
                          },
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
                              context.read<EditUserCubit>().lastNameController
                                ..text = context
                                    .read<EditUserCubit>()
                                    .userDetailsModel!
                                    .data!
                                    .lastName!,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          label: S.of(context).addUserText2,
                          validator: (value) {
                            if (value!.length > 55) {
                              return 'Last name too long';
                            } else if (value.length < 3) {
                              return 'Last name too short';
                            } else if (!RegExp(r"^[a-zA-Z\s]+$")
                                .hasMatch(value)) {
                              return 'Only letters';
                            }
                          },
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
                    controller: context.read<EditUserCubit>().userNameController
                      ..text = context
                          .read<EditUserCubit>()
                          .userDetailsModel!
                          .data!
                          .userName!,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    label: S.of(context).addUserText5,
                    validator: (value) {
                      if (value!.length > 55) {
                        return 'User name too long';
                      } else if (value.length < 3) {
                        return 'User name too short';
                      }
                    },
                    hint: context
                        .read<EditUserCubit>()
                        .userDetailsModel!
                        .data!
                        .userName!,
                  ),
                  verticalSpace(15),
                  EditUserTextField(
                    controller: context.read<EditUserCubit>().emailController
                      ..text = context
                          .read<EditUserCubit>()
                          .userDetailsModel!
                          .data!
                          .email!,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    label: S.of(context).addUserText3,
                    validator: (value) {
                      if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!)) {
                        return 'Enter valid email';
                      }
                    },
                    hint: context
                        .read<EditUserCubit>()
                        .userDetailsModel!
                        .data!
                        .email!,
                  ),
                  verticalSpace(15),
                  EditUserTextField(
                    controller: context.read<EditUserCubit>().phoneController
                      ..text = context
                          .read<EditUserCubit>()
                          .userDetailsModel!
                          .data!
                          .phoneNumber!
                          .replaceFirst('+966', ''),
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                    label: S.of(context).addUserText10,
                    validator: (value) {
                      if (!RegExp(r'^(?:[+0])?[0-9]{9}$').hasMatch(value!)) {
                        return 'Please enter a valid mobile number';
                      }
                      return null;
                    },
                    prefixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 13, 5, 13),
                      child: Text(
                        '+966 |',
                        style: TextStyle(color: Colors.black, fontSize: 14.sp),
                      ),
                    ),
                    hint: context
                        .read<EditUserCubit>()
                        .userDetailsModel!
                        .data!
                        .phoneNumber!,
                  ),
                  verticalSpace(15),
                  EditUserTextField(
                    controller: context.read<EditUserCubit>().idNumberController
                      ..text = context
                          .read<EditUserCubit>()
                          .userDetailsModel!
                          .data!
                          .idNumber!,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    label: S.of(context).addUserText7,
                    validator: (value) {
                      if (value!.length > 20) {
                        return 'ID Number too long';
                      } else if (value.length < 5) {
                        return 'ID Number too short';
                      }
                    },
                    hint: context
                        .read<EditUserCubit>()
                        .userDetailsModel!
                        .data!
                        .idNumber!,
                  ),
                  verticalSpace(15),
                  EditUserTextField(
                    controller:
                        context.read<EditUserCubit>().passwordController,
                    suffixIcon: context.read<EditUserCubit>().suffixIcon,
                    suffixPressed: () {
                      context
                          .read<EditUserCubit>()
                          .changeSuffixIconVisiability();
                    },
                    onChanged: (value) {
                      if (value!.isNotEmpty) {
                        isShow = true;
                      } else {
                        isShow = false;
                      }
                    },
                    obscureText: context.read<EditUserCubit>().ispassword,
                    keyboardType: TextInputType.text,
                    label: 'Password',
                    hint: '',
                  ),
                  verticalSpace(15),
                  if (isShow == true) ...[
                    PasswordValidations(
                      hasLowerCase: hasLowercase,
                      hasUpperCase: hasUppercase,
                      hasSpecialCharacters: hasSpecialCharacters,
                      hasNumber: hasNumber,
                      hasMinLength: hasMinLength,
                    ),
                    verticalSpace(15),
                  ],
                  EditUserTextField(
                    controller: context
                        .read<EditUserCubit>()
                        .passwordConfirmationController,
                    keyboardType: TextInputType.text,
                    suffixIcon: context.read<EditUserCubit>().suffixIcon,
                    suffixPressed: () {
                      context
                          .read<EditUserCubit>()
                          .changeSuffixIconVisiability();
                    },
                    validator: (value) {
                      if (value !=
                          context
                              .read<EditUserCubit>()
                              .passwordController
                              .text) {
                        return S.of(context).validationRepeatPassword;
                      }
                      return null;
                    },
                    obscureText: context.read<EditUserCubit>().ispassword,
                    label: 'Password Confirm',
                    hint: '',
                  ),
                  verticalSpace(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomDropDownList(
                          label: 'Country',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomDropDownList(
                          label: 'Nationality',
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
                          controller: context
                              .read<EditUserCubit>()
                              .nationalityController,
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
                              initialDate: DateTime.now()
                                  .subtract(Duration(days: 12 * 365)),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now()
                                  .subtract(Duration(days: 12 * 365)),
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
                      } else {
                        managerId = selectedRole.id! - 1;
                      }
                      context.read<EditUserCubit>().getAllUsers(managerId);
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
                    hint: context
                        .read<EditUserCubit>()
                        .userDetailsModel!
                        .data!
                        .role!,
                    items: context
                                .read<EditUserCubit>()
                                .roleModel
                                ?.data
                                ?.isEmpty ??
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
                    label:
                        (context.read<EditUserCubit>().roleIdController.text ==
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
                            ? 'Admin'
                            : (context
                                        .read<EditUserCubit>()
                                        .roleIdController
                                        .text ==
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
                                            .managerName ??
                                        'User',
                    onPressed: (selectedValue) {
                      final selectedId = context
                          .read<EditUserCubit>()
                          .usersModel
                          ?.data
                          ?.users!
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
                    hint:
                        (context.read<EditUserCubit>().roleIdController.text ==
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
                            ? 'Admin'
                            : (context
                                        .read<EditUserCubit>()
                                        .roleIdController
                                        .text ==
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
                                            .managerName ??
                                        'user',
                    items: context
                                .read<EditUserCubit>()
                                .usersModel
                                ?.data
                                ?.users!
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
                                .usersModel
                                ?.data
                                ?.users!
                                .map((e) => e.userName ?? 'Unknown')
                                .toList() ??
                            [],
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
                        context
                            .read<EditUserCubit>()
                            .providerIdController
                            .text = selectedId;
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
                    controller:
                        context.read<EditUserCubit>().providerController,
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
                                if (context
                                    .read<EditUserCubit>()
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  showCustomDialog(context,
                                      "Are you Sure you want save the edit of this user ?",
                                      () {
                                    context.read<EditUserCubit>().editUser(
                                        widget.id,
                                        context
                                            .read<EditUserCubit>()
                                            .image
                                            ?.path,
                                        selectedShiftsIds);
                                    context.pop();
                                  });
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
      }),
    );
  }
}
