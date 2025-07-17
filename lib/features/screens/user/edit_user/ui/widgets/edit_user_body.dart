import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/Change_password_validations/password_validation.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/user/edit_user/logic/edit_user_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/edit_user/logic/edit_user_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

import '../../../../../../core/widgets/default_toast/default_toast.dart';

class EditUserBody extends StatefulWidget {
  final int id;
  const EditUserBody({super.key, required this.id});

  @override
  State<EditUserBody> createState() => _EditUserBodyState();
}

class _EditUserBodyState extends State<EditUserBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(S.of(context).editUserTitle),
          leading: CustomBackButton()),
      body: BlocConsumer<EditUserCubit, EditUserState>(
          listener: (context, state) {
        if (state is EditUserSuccessState) {
          toast(text: state.editModel.message!, isSuccess: true);
          context.popWithTrueResult();
        }
        if (state is EditUserErrorState) {
          toast(text: state.error, isSuccess: false);
        }
      }, builder: (context, state) {
        final cubit = context.read<EditUserCubit>();
        if (cubit.userDetailsModel?.data! == null) {
          return Loading();
        }
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
                                    leading: CustomBackButton(),
                                  ),
                                  body: Center(
                                    child: PhotoView(
                                      imageProvider: (cubit.image != null &&
                                              cubit.image!.path.isNotEmpty)
                                          ? FileImage(File(cubit.image!.path))
                                          : (cubit.userDetailsModel!.data!.image
                                                      ?.isNotEmpty ??
                                                  false)
                                              ? NetworkImage(cubit
                                                  .userDetailsModel!
                                                  .data!
                                                  .image!) as ImageProvider
                                              : const AssetImage(
                                                  'assets/images/person.png'),
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
                            width: 90.r,
                            height: 90.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColor.primaryColor,
                                width: 2.w,
                              ),
                            ),
                            child: ClipOval(
                              child: (cubit.image != null &&
                                      cubit.image!.path.isNotEmpty)
                                  ? Image.file(
                                      File(cubit.image!.path),
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/person.png',
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    )
                                  : Image.network(
                                      '${cubit.userDetailsModel!.data!.image}',
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
                                size: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: cubit.firstNameController
                            ..text = cubit.userDetailsModel!.data!.firstName!,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          label: S.of(context).addUserText1,
                          validator: (value) {
                            if (value!.length > 55) {
                              return S.of(context).validationFirstNameTooLong;
                            } else if (value.length < 3) {
                              return S.of(context).validationFirstNameTooShort;
                            } else if (!RegExp(r"^[a-zA-Z\s]+$")
                                .hasMatch(value)) {
                              return S
                                  .of(context)
                                  .validationFirstNameOnlyLetters;
                            }
                            return null;
                          },
                          hint: cubit.userDetailsModel!.data!.firstName!,
                          onlyRead: false,
                        ),
                      ),
                      horizontalSpace(10),
                      Expanded(
                        child: CustomTextFormField(
                          controller: cubit.lastNameController
                            ..text = cubit.userDetailsModel!.data!.lastName!,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          label: S.of(context).addUserText2,
                          validator: (value) {
                            if (value!.length > 55) {
                              return S.of(context).validationLastNameTooLong;
                            } else if (value.length < 3) {
                              return S.of(context).validationLastNameTooShort;
                            } else if (!RegExp(r"^[a-zA-Z\s]+$")
                                .hasMatch(value)) {
                              return S
                                  .of(context)
                                  .validationLastNameOnlyLetters;
                            }
                            return null;
                          },
                          hint: cubit.userDetailsModel!.data!.lastName!,
                          onlyRead: false,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(15),
                  CustomTextFormField(
                    controller: cubit.userNameController
                      ..text = cubit.userDetailsModel!.data!.userName!,
                    keyboardType: TextInputType.text,
                    label: S.of(context).addUserText5,
                    validator: (value) {
                      if (value!.length > 55) {
                        return S.of(context).validationUserNameTooLong;
                      } else if (value.length < 3) {
                        return S.of(context).validationUserNameTooShort;
                      }
                      return null;
                    },
                    hint: cubit.userDetailsModel!.data!.userName!,
                    onlyRead: false,
                  ),
                  verticalSpace(15),
                  CustomTextFormField(
                    controller: cubit.emailController
                      ..text = cubit.userDetailsModel!.data!.email!,
                    keyboardType: TextInputType.emailAddress,
                    label: S.of(context).addUserText3,
                    validator: (value) {
                      if (!RegExp(
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                          .hasMatch(value!)) {
                        return S.of(context).validationValidEmail;
                      }
                      return null;
                    },
                    hint: cubit.userDetailsModel!.data!.email!,
                    onlyRead: false,
                  ),
                  verticalSpace(15),
                  CustomTextFormField(
                    controller: cubit.phoneController
                      ..text = cubit.userDetailsModel!.data!.phoneNumber!
                          .replaceFirst('+966', ''),
                    keyboardType: TextInputType.phone,
                    label: S.of(context).addUserText10,
                    validator: (value) {
                      if (!RegExp(r'^(?:[+0])?[0-9]{9}$').hasMatch(value!)) {
                        return S.of(context).validationValidMobileNumber;
                      }
                      return null;
                    },
                    perfixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 13, 5, 13),
                      child: Text(
                        '+966 |',
                        style: TextStyle(color: Colors.black, fontSize: 14.sp),
                      ),
                    ),
                    hint: cubit.userDetailsModel!.data!.phoneNumber!,
                    onlyRead: false,
                  ),
                  verticalSpace(15),
                  CustomTextFormField(
                    controller: cubit.idNumberController
                      ..text = cubit.userDetailsModel!.data!.idNumber!,
                    keyboardType: TextInputType.number,
                    label: S.of(context).addUserText7,
                    validator: (value) {
                      if (value!.length > 20) {
                        return S.of(context).validationIdNumberTooLong;
                      } else if (value.length < 5) {
                        return S.of(context).validationIdNumberTooShort;
                      }
                      return null;
                    },
                    hint: cubit.userDetailsModel!.data!.idNumber!,
                    onlyRead: false,
                  ),
                  verticalSpace(15),
                  CustomTextFormField(
                    controller: cubit.passwordController,
                    suffixIcon: cubit.suffixIcon,
                    suffixPressed: () {
                      cubit.changeSuffixIconVisiability();
                    },
                    onChanged: (value) {
                      cubit.validatePassword(value);
                    },
                    obscureText: cubit.ispassword,
                    keyboardType: TextInputType.text,
                    label: S.of(context).addUserText6,
                    hint: '',
                    onlyRead: false,
                  ),
                  verticalSpace(15),
                  if (cubit.isShow == true) ...[
                    PasswordValidations(
                      hasLowerCase: cubit.hasLowercase,
                      hasUpperCase: cubit.hasUppercase,
                      hasSpecialCharacters: cubit.hasSpecialCharacters,
                      hasNumber: cubit.hasNumber,
                      hasMinLength: cubit.hasMinLength,
                    ),
                    verticalSpace(15)
                  ],
                  CustomTextFormField(
                    controller: cubit.passwordConfirmationController,
                    keyboardType: TextInputType.text,
                    suffixIcon: cubit.suffixIcon,
                    suffixPressed: () {
                      cubit.changeSuffixIconVisiability();
                    },
                    validator: (value) {
                      if (value != cubit.passwordController.text) {
                        return S.of(context).validationRepeatPassword;
                      }
                      return null;
                    },
                    obscureText: cubit.ispassword,
                    label: S.of(context).addUserText11,
                    hint: '',
                    onlyRead: false,
                  ),
                  verticalSpace(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomDropDownList(
                          label: S.of(context).addUserText12,
                          hint: cubit.userDetailsModel!.data!.countryName!,
                          items: cubit.countryData.map((e) => e.name).toList(),
                          controller: cubit.countryController,
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                      ),
                      horizontalSpace(10),
                      Expanded(
                        child: CustomDropDownList(
                          label: S.of(context).addUserText9,
                          onPressed: (selectedValue) {
                            final items = [
                              S.of(context).genderMale,
                              S.of(context).genderFemale
                            ];
                            final selectedIndex = items.indexOf(selectedValue);
                            if (selectedIndex != -1) {
                              cubit.genderIdController.text =
                                  selectedIndex.toString();
                            }
                          },
                          hint: cubit.userDetailsModel!.data!.gender!,
                          items: [
                            S.of(context).genderMale,
                            S.of(context).genderFemale
                          ],
                          controller: cubit.genderController,
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
                          label: S.of(context).addUserText8,
                          hint: cubit.userDetailsModel!.data!.nationalityName!,
                          items: cubit.nationalityData
                              .map((e) => e.name ?? 'un known')
                              .toList(),
                          controller: cubit.nationalityController,
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                      ),
                      horizontalSpace(15),
                      Expanded(
                        child: CustomTextFormField(
                          controller: cubit.birthController,
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
                                cubit.birthController.text = formattedDate;
                              });
                            }
                          },
                          keyboardType: TextInputType.none,
                          label: S.of(context).addUserText4,
                          hint: cubit.userDetailsModel!.data!.birthdate!,
                          onlyRead: false,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(15),
                  CustomDropDownList(
                    label: S.of(context).addUserText13,
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
                    hint: cubit.userDetailsModel!.data!.role!,
                    items: cubit.roleDataItem
                        .map((e) => e.name ?? 'Unknown')
                        .toList(),
                    controller: cubit.roleController,
                    keyboardType: TextInputType.text,
                    suffixIcon: IconBroken.arrowDown2,
                  ),
                  verticalSpace(15),
                  CustomDropDownList(
                    label: (int.tryParse(cubit.roleIdController.text) == 1 ||
                            cubit.userDetailsModel!.data!.roleId == 1 ||
                            int.tryParse(cubit.roleIdController.text) == 2 ||
                            cubit.userDetailsModel!.data!.roleId == 2 ||
                            int.tryParse(cubit.roleIdController.text) == 5 ||
                            cubit.userDetailsModel!.data!.roleId == 5)
                        ? S.of(context).roleAdmin
                        : (int.tryParse(cubit.roleIdController.text) == 3 ||
                                cubit.userDetailsModel!.data!.roleId == 3)
                            ? S.of(context).roleManager
                            : S.of(context).roleSupervisor,
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
                                : cubit.userDetailsModel!.data!.managerName ??
                                    S.of(context).roleUsers,
                    items: cubit.usersModel?.data?.users?.isEmpty ?? true
                        ? [
                            if (['1', '2', '5']
                                .contains(cubit.roleIdController.text))
                              S.of(context).noAdminsAvailable
                            else if (cubit.roleIdController.text == '3')
                              S.of(context).noManagersAvailable
                            else if (cubit.roleIdController.text == '4')
                              S.of(context).noSupervisorsAvailable
                            else
                              S.of(context).noUsersAvailable
                          ]
                        : cubit.usersModel!.data!.users!
                            .map((e) => e.userName ?? 'Unknown')
                            .toList(),
                  ),
                  verticalSpace(15),
                  CustomDropDownList(
                    label: S.of(context).addUserText15,
                    hint: cubit.userDetailsModel!.data!.providerName ?? '',
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
                    items: cubit.providerItem
                        .map((e) => e.name ?? 'Unknown')
                        .toList(),
                    controller: cubit.providerController,
                    keyboardType: TextInputType.text,
                    suffixIcon: IconBroken.arrowDown2,
                  ),
                  verticalSpace(20),
                  state is EditUserLoadingState
                      ? Loading()
                      : Center(
                          child: DefaultElevatedButton(
                              name: S.of(context).saveButtton,
                              onPressed: () {
                                if (cubit.formKey.currentState!.validate()) {
                                  showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return PopUpMessage(
                                            title: 'edit',
                                            body: 'user',
                                            onPressed: () {
                                              cubit.editUser(widget.id);
                                            });
                                      });
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
        );
      }),
    );
  }
}
