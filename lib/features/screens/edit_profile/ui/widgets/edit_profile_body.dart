import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/edit_profile/logic/edit_profile_cubit.dart';
import 'package:smart_cleaning_application/features/screens/edit_profile/logic/edit_profile_state.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/user/edit_user/ui/widgets/edit_user_text_form_field/edit_user_text_form_field.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EditProfileBody extends StatefulWidget {
  final int id;
  const EditProfileBody({super.key, required this.id});

  @override
  State<EditProfileBody> createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<EditProfileBody> {
  List<int> selectedShiftsIds = [];

  @override
  void initState() {
    context.read<EditProfileCubit>().getUserProfileDetails();

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
      body: BlocConsumer<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
        if (state is EditProfileSuccessState) {
          toast(text: state.editProfileModel.message!, color: Colors.blue);
          context.pushNamedAndRemoveLastTwo(Routes.settingsScreen);
        }
        if (state is EditProfileErrorState) {
          toast(text: state.error, color: Colors.red);
        }
      }, builder: (context, state) {
        if (context.read<EditProfileCubit>().profileModel?.data! == null) {
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
                                                    .read<EditProfileCubit>()
                                                    .image !=
                                                null &&
                                            context
                                                .read<EditProfileCubit>()
                                                .image!
                                                .path
                                                .isNotEmpty)
                                        ? FileImage(
                                            File(context
                                                .read<EditProfileCubit>()
                                                .image!
                                                .path),
                                          )
                                        : NetworkImage(
                                            '${ApiConstants.apiBaseUrl}${context.read<EditProfileCubit>().profileModel!.data!.image}',
                                          ),
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/noImage.png',
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
                            child: context.read<EditProfileCubit>().image !=
                                        null &&
                                    context
                                        .read<EditProfileCubit>()
                                        .image!
                                        .path
                                        .isNotEmpty
                                ? Image.file(
                                    File(context
                                        .read<EditProfileCubit>()
                                        .image!
                                        .path),
                                    fit: BoxFit.fill,
                                  )
                                : Image.network(
                                    '${ApiConstants.apiBaseUrl}${context.read<EditProfileCubit>().profileModel!.data!.image}',
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error, stackTrace) {
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
                            context.read<EditProfileCubit>().galleryFile();
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
                        controller: context
                            .read<EditProfileCubit>()
                            .firstNameController,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        label: S.of(context).addUserText1,
                        hint: context
                            .read<EditProfileCubit>()
                            .profileModel!
                            .data!
                            .firstName!,
                      ),
                    ),
                    horizontalSpace(10),
                    Expanded(
                      child: EditUserTextField(
                        controller:
                            context.read<EditProfileCubit>().lastNameController,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        label: S.of(context).addUserText2,
                        hint: context
                            .read<EditProfileCubit>()
                            .profileModel!
                            .data!
                            .lastName!,
                      ),
                    ),
                  ],
                ),
                verticalSpace(15),
                EditUserTextField(
                  controller:
                      context.read<EditProfileCubit>().userNameController,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  label: S.of(context).addUserText5,
                  hint: context
                      .read<EditProfileCubit>()
                      .profileModel!
                      .data!
                      .userName!,
                ),
                verticalSpace(15),
                EditUserTextField(
                  controller: context.read<EditProfileCubit>().emailController,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  label: S.of(context).addUserText3,
                  hint: context
                      .read<EditProfileCubit>()
                      .profileModel!
                      .data!
                      .email!,
                ),
                verticalSpace(15),
                EditUserTextField(
                  controller: context.read<EditProfileCubit>().phoneController,
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                  label: S.of(context).addUserText10,
                  hint: context
                      .read<EditProfileCubit>()
                      .profileModel!
                      .data!
                      .phoneNumber!,
                ),
                verticalSpace(15),
                CustomDropDownList(
                  label: 'Gender',
                  onPressed: (selectedValue) {
                    final items = ['Male', 'Female'];
                    final selectedIndex = items.indexOf(selectedValue);
                    if (selectedIndex != -1) {
                      context.read<EditProfileCubit>().genderIdController.text =
                          selectedIndex.toString();
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).validationGender;
                    }
                    return null;
                  },
                  hint: context
                      .read<EditProfileCubit>()
                      .profileModel!
                      .data!
                      .gender!,
                  items: ['Male', 'Female'],
                  controller: context.read<EditProfileCubit>().genderController,
                  keyboardType: TextInputType.text,
                  suffixIcon: IconBroken.arrowDown2,
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
                            .read<EditProfileCubit>()
                            .profileModel!
                            .data!
                            .nationalityName!,
                        items: context
                                    .read<EditProfileCubit>()
                                    .nationalityModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No nationalities']
                            : context
                                    .read<EditProfileCubit>()
                                    .nationalityModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        controller: context
                            .read<EditProfileCubit>()
                            .nationalityController,
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                    ),
                    horizontalSpace(15),
                    Expanded(
                      child: EditUserTextField(
                        controller:
                            context.read<EditProfileCubit>().birthController,
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
                                  .read<EditProfileCubit>()
                                  .birthController
                                  .text = formattedDate;
                            });
                          }
                        },
                        keyboardType: TextInputType.none,
                        label: S.of(context).addUserText4,
                        hint: context
                            .read<EditProfileCubit>()
                            .profileModel!
                            .data!
                            .birthdate!,
                      ),
                    ),
                  ],
                ),
                verticalSpace(15),
                EditUserTextField(
                  controller:
                      context.read<EditProfileCubit>().idNumberController,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  label: S.of(context).addUserText7,
                  hint: context
                      .read<EditProfileCubit>()
                      .profileModel!
                      .data!
                      .idNumber!,
                ),
                verticalSpace(20),
                state is EditProfileLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: AppColor.primaryColor),
                      )
                    : Center(
                        child: DefaultElevatedButton(
                            name: S.of(context).saveButtton,
                            onPressed: () {
                              showCustomDialog(context,
                                  "Are you Sure you want save the edit your profile ?",
                                  () {
                                context.read<EditProfileCubit>().editProfile(
                                    context
                                        .read<EditProfileCubit>()
                                        .image
                                        ?.path);
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
