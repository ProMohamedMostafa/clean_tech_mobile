import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/layout/main_layout/logic/bottom_navbar_cubit.dart';
import 'package:smart_cleaning_application/features/screens/edit_profile/logic/edit_profile_cubit.dart';
import 'package:smart_cleaning_application/features/screens/edit_profile/logic/edit_profile_state.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/user/edit_user/ui/widgets/edit_user_text_form_field/edit_user_text_form_field.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EditProfileBody extends StatefulWidget {
  const EditProfileBody({super.key});

  @override
  State<EditProfileBody> createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<EditProfileBody> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).editUserTitle,
          style: TextStyles.font16BlackSemiBold,
        ),
        centerTitle: true,
        leading: CustomBackButton(),
      ),
      body: BlocConsumer<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
        if (state is EditProfileSuccessState) {
          toast(text: state.editProfileModel.message!, color: Colors.blue);
          context
              .read<BottomNavbarCubit>()
              .changeBottomNavbarWithRoute(context, 3);
        }
        if (state is EditProfileErrorState) {
          toast(text: state.error, color: Colors.red);
        }
      }, builder: (context, state) {
        if (context.read<EditProfileCubit>().profileModel?.data! == null) {
          return Loading();
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: cubit.formKey,
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
                                          ? FileImage(
                                              File(cubit.image!.path),
                                            )
                                          : NetworkImage(
                                              '${ApiConstants.apiBaseUrlImage}${cubit.profileModel!.data!.image}',
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
                              child: (cubit.image != null &&
                                      cubit.image!.path.isNotEmpty)
                                  ? Image.file(
                                      File(cubit.image!.path),
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
                                      '${ApiConstants.apiBaseUrlImage}${cubit.profileModel!.data!.image}',
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
                  verticalSpace(35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: EditUserTextField(
                          controller: cubit.firstNameController
                            ..text = cubit.profileModel!.data!.firstName!,
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
                          },
                          hint: cubit.profileModel!.data!.firstName!,
                        ),
                      ),
                      horizontalSpace(10),
                      Expanded(
                        child: EditUserTextField(
                          controller: cubit.lastNameController
                            ..text = cubit.profileModel!.data!.lastName!,
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
                          },
                          hint: cubit.profileModel!.data!.lastName!,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(15),
                  EditUserTextField(
                    controller: cubit.userNameController
                      ..text = cubit.profileModel!.data!.userName!,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    label: S.of(context).addUserText5,
                    validator: (value) {
                      if (value!.length > 55) {
                        return S.of(context).validationUserNameTooLong;
                      } else if (value.length < 3) {
                        return S.of(context).validationUserNameTooShort;
                      }
                    },
                    hint: cubit.profileModel!.data!.userName!,
                  ),
                  verticalSpace(15),
                  EditUserTextField(
                    controller: cubit.emailController
                      ..text = cubit.profileModel!.data!.email!,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    label: S.of(context).addUserText3,
                    validator: (value) {
                      if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!)) {
                        return S.of(context).validationValidEmail;
                      }
                    },
                    hint: cubit.profileModel!.data!.email!,
                  ),
                  verticalSpace(15),
                  EditUserTextField(
                    controller: cubit.phoneController
                      ..text = cubit.profileModel!.data!.phoneNumber!
                          .replaceFirst('+966', ''),
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                    label: S.of(context).addUserText10,
                    validator: (value) {
                      if (!RegExp(r'^(?:[+0])?[0-9]{9}$').hasMatch(value!)) {
                        return S.of(context).validationValidMobileNumber;
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
                    hint: cubit.profileModel!.data!.phoneNumber!,
                  ),
                  verticalSpace(15),
                  EditUserTextField(
                    controller: cubit.idNumberController
                      ..text = cubit.profileModel!.data!.idNumber!,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    label: S.of(context).addUserText7,
                    validator: (value) {
                      if (value!.length > 20) {
                        return S.of(context).validationIdNumberTooLong;
                      } else if (value.length < 5) {
                        return S.of(context).validationIdNumberTooShort;
                      }
                    },
                    hint: cubit.profileModel!.data!.idNumber!,
                  ),
                  verticalSpace(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomDropDownList(
                          label: S.of(context).addUserText12,
                          hint: cubit.profileModel!.data!.countryName!,
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
                          hint: cubit.profileModel!.data!.gender!,
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
                          hint: cubit.profileModel!.data!.nationalityName!,
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
                        child: EditUserTextField(
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
                          hint: cubit.profileModel!.data!.birthdate!,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(20),
                  state is EditProfileLoadingState
                      ? Loading()
                      : Center(
                          child: DefaultElevatedButton(
                              name: S.of(context).saveButtton,
                              onPressed: () {
                                if (cubit.formKey.currentState!.validate()) {
                                  showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return PopUpMeassage(
                                            title: 'edit',
                                            body: 'profile',
                                            onPressed: () {
                                              context
                                                  .read<EditProfileCubit>()
                                                  .editProfile(context
                                                      .read<EditProfileCubit>()
                                                      .image
                                                      ?.path);
                                            });
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
        );
      }),
    );
  }
}
