import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/features/screens/edit_user/logic/edit_user_cubit.dart';
import 'package:smart_cleaning_application/features/screens/edit_user/logic/edit_user_state.dart';
import 'package:smart_cleaning_application/features/screens/edit_user/ui/widgets/edit_user_text_form_field/edit_user_text_form_field.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class EditUserBody extends StatelessWidget {
  const EditUserBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).editUserTitle,
          style: TextStyles.font24PrimsemiBold,
        ),
        centerTitle: true,
        leading: customBackButton(context),
      ),
      body: BlocListener<EditUserCubit, EditUserState>(
        listener: (context, state) {},
        child: SafeArea(
            child: SingleChildScrollView(
          child: Form(
            key: context.read<EditUserCubit>().formKey,
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
                            'assets/images/profile.png',
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
                  EditUserTextField(
                    controller:
                        context.read<EditUserCubit>().userNameController,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).validationUserName;
                      }
                    },
                    label: S.of(context).addUserText5,
                    hint: "mosad11",
                  ),
                  verticalSpace(15),
                  EditUserTextField(
                    controller:
                        context.read<EditUserCubit>().firstNameController,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).validationEmailAndUser;
                      }
                    },
                    label: S.of(context).addUserText1,
                    hint: "mossad",
                  ),
                  verticalSpace(15),
                  EditUserTextField(
                      controller:
                          context.read<EditUserCubit>().lastNameController,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).validationEmailAndUser;
                        }
                      },
                      label: S.of(context).addUserText2,
                      hint: "selim"),
                  verticalSpace(15),
                  EditUserTextField(
                    controller: context.read<EditUserCubit>().emailController,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).validationEmailAndUser;
                      }
                    },
                    label: S.of(context).addUserText3,
                    hint: "mossad.selim11@gmail.com",
                  ),
                  verticalSpace(15),
                  EditUserTextField(
                    controller: context.read<EditUserCubit>().phoneController,
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).validationEmailAndUser;
                      }
                    },
                    label: S.of(context).addUserText10,
                    hint: "01060056199",
                  ),
                  verticalSpace(15),
                  EditUserTextField(
                    controller: context.read<EditUserCubit>().birthController,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).validationEmailAndUser;
                      }
                    },
                    label: S.of(context).addUserText4,
                    hint: "6-6-1994",
                  ),
                  verticalSpace(10),
                  EditUserTextField(
                    controller:
                        context.read<EditUserCubit>().idNumberController,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).validationEmailAndUser;
                      }
                    },
                    label: S.of(context).addUserText7,
                    hint: "(684) 555-0102",
                  ),
                  verticalSpace(10),
                  EditUserTextField(
                    controller:
                        context.read<EditUserCubit>().nationalityController,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).validationEmailAndUser;
                      }
                    },
                    label: S.of(context).addUserText8,
                    hint: "Egyption",
                  ),
                  verticalSpace(10),
                  EditUserTextField(
                    controller: context.read<EditUserCubit>().genderController,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).validationEmailAndUser;
                      }
                    },
                    label: S.of(context).addUserText9,
                    hint: "male",
                  ),
                  verticalSpace(35),
                  Center(
                    child: DefaultElevatedButton(
                        name: S.of(context).saveButtton,
                        onPressed: () {},
                        color: AppColor.primaryColor,
                        height: 52,
                        width: 158,
                        textStyles: TextStyles.font20Whitesemimedium),
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
