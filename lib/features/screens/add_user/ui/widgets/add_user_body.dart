import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/features/screens/add_user/logic/add_user_cubit.dart';
import 'package:smart_cleaning_application/features/screens/add_user/logic/add_user_state.dart';
import 'package:smart_cleaning_application/features/screens/add_user/ui/widgets/add_user_text_form_field.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AddUserBody extends StatelessWidget {
  const AddUserBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).addUserTitle,
          style: TextStyles.font24PrimsemiBold,
        ),
        centerTitle: true,
        leading: customBackButton(context),
      ),
      body: BlocListener<AddUserCubit, AddUserState>(
        listener: (context, state) {},
        child: SafeArea(
            child: SingleChildScrollView(
          child: Form(
            key: context.read<AddUserCubit>().formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(15),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // color: Colors.white,
                              border: Border.all(
                                  color: AppColor.primaryColor, width: 3.w)),
                          child: ClipOval(
                              child: Image.asset(
                            'assets/images/noImage.png',
                            fit: BoxFit.fill,
                          )),
                        ),
                        Positioned(
                          bottom: 1,
                          right: 10,
                          child: InkWell(
                            onTap: () {},
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
                  Text(
                    S.of(context).addUserText1,
                    style: TextStyles.font16BlackRegular,
                  ),
                  AddUserTextFormField(
                    controller:
                        context.read<AddUserCubit>().firstNameController,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).validationEmailAndUser;
                      }
                    },
                  ),
                  verticalSpace(15),
                  Text(
                    S.of(context).addUserText2,
                    style: TextStyles.font16BlackRegular,
                  ),
                  AddUserTextFormField(
                    controller: context.read<AddUserCubit>().lastNameController,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).validationEmailAndUser;
                      }
                    },
                  ),
                  verticalSpace(15),
                  Text(
                    S.of(context).addUserText3,
                    style: TextStyles.font16BlackRegular,
                  ),
                  AddUserTextFormField(
                    controller: context.read<AddUserCubit>().emailController,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).validationEmailAndUser;
                      }
                    },
                  ),
                  verticalSpace(15),
                  Text(
                    S.of(context).addUserText10,
                    style: TextStyles.font16BlackRegular,
                  ),
                  AddUserTextFormField(
                    controller: context.read<AddUserCubit>().phoneController,
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).validationEmailAndUser;
                      }
                    },
                  ),
                  verticalSpace(15),
                  Text(
                    S.of(context).addUserText4,
                    style: TextStyles.font16BlackRegular,
                  ),
                  AddUserTextFormField(
                    controller: context.read<AddUserCubit>().birthController,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).validationEmailAndUser;
                      }
                    },
                  ),
                  verticalSpace(10),
                  Text(
                    S.of(context).addUserText5,
                    style: TextStyles.font16BlackRegular,
                  ),
                  AddUserTextFormField(
                    controller: context.read<AddUserCubit>().userNameController,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).validationEmailAndUser;
                      }
                    },
                  ),
                  verticalSpace(10),
                  Text(
                    S.of(context).addUserText6,
                    style: TextStyles.font16BlackRegular,
                  ),
                  AddUserTextFormField(
                    controller: context.read<AddUserCubit>().passwordController,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).validationEmailAndUser;
                      }
                    },
                  ),
                  verticalSpace(10),
                  Text(
                    S.of(context).addUserText7,
                    style: TextStyles.font16BlackRegular,
                  ),
                  AddUserTextFormField(
                    controller: context.read<AddUserCubit>().idNumberController,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).validationEmailAndUser;
                      }
                    },
                  ),
                  verticalSpace(10),
                  Text(
                    S.of(context).addUserText8,
                    style: TextStyles.font16BlackRegular,
                  ),
                  AddUserTextFormField(
                    controller:
                        context.read<AddUserCubit>().nationalityController,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).validationEmailAndUser;
                      }
                    },
                  ),
                  verticalSpace(10),
                  Text(
                    S.of(context).addUserText9,
                    style: TextStyles.font16BlackRegular,
                  ),
                  AddUserTextFormField(
                    controller: context.read<AddUserCubit>().genderController,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).validationEmailAndUser;
                      }
                    },
                  ),
                  verticalSpace(35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultElevatedButton(
                          name: S.of(context).addAnotherButton,
                          onPressed: () {},
                          color: AppColor.thirdColor,
                          height: 52,
                          width: 158,
                          textStyles: TextStyles.font20Whitesemimedium),
                      DefaultElevatedButton(
                          name: S.of(context).saveButtton,
                          onPressed: () {},
                          color: AppColor.primaryColor,
                          height: 52,
                          width: 158,
                          textStyles: TextStyles.font20Whitesemimedium),
                    ],
                  ),
                  verticalSpace(30),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
